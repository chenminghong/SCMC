//
//  OrderStatus160Controller.m
//  pairearch_WLY
//
//  Created by Jean on 2017/12/8.
//  Copyright © 2017年 Leo. All rights reserved.
//

#import "OrderStatus160Controller.h"

#import "NestedSelectModel.h"
#import "OrderStatus160Cell.h"
#import "OrderListController.h"

@interface OrderStatus160Controller ()<UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) UITableView *tableView;

@property (nonatomic, assign) BOOL failFlag;    //拍照上传是否请求失败

@end

@implementation OrderStatus160Controller

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.view.backgroundColor = TOP_NAVIBAR_COLOR;
    self.tableView.backgroundColor = TOP_NAVIBAR_COLOR;
    [self.view addSubview:self.tableView];
    self.failFlag = NO;
}

- (UITableView *)tableView {
    if (!_tableView) {
        self.tableView = [UITableView new];
        [self.view addSubview:self.tableView];
        [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(self.view);
        }];
        self.tableView.showsVerticalScrollIndicator = NO;
        self.tableView.delegate = self;
        self.tableView.dataSource = self;
        self.tableView.estimatedRowHeight = 700;
        self.tableView.backgroundColor = UIColorFromRGB(0xfdf6de);
        self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        self.tableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 10)];
        self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 10)];
    }
    return _tableView;
}

- (void)setSelectedModel:(NestedSelectModel *)selectedModel {
    [super setSelectedModel:selectedModel];
    [self.tableView reloadData];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    OrderStatus160Cell *cell = [OrderStatus160Cell getCellWithTable:tableView indexPath:indexPath];
    cell.selectedModel = self.selectedModel;
    [cell.tuNumberButton addTarget:self action:@selector(tunumberButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [cell.photoImgButton addTarget:self action:@selector(photoEndLoadButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [cell.takeRegistrationBtn addTarget:self action:@selector(endLoadButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    
    if (self.failFlag) {
        cell.takeRegistrationBtn.hidden = NO;
        cell.failBtnTopConstant.constant = 20.0;
        cell.failBtnHeightConstant.constant = 40.0;
        cell.statusDescriptionLabel.text = @"如照片上传失败，可直接点击“收货签到”并将照片传给承运商客服";
    } else {
        cell.takeRegistrationBtn.hidden = YES;
        cell.failBtnTopConstant.constant = 0.0;
        cell.failBtnHeightConstant.constant = 0.0;
        cell.statusDescriptionLabel.text = @"到达收货地时，请点击“收货签到拍照”开始卸货";
    }
    return cell;
}

- (void)tunumberButtonAction:(UIButton *)sender {
    NSString *tuCode = sender.currentTitle;
    [OrderListController enterTulistDetailViewControllerWithTarget:self tuCode:tuCode status:[self.selectedModel.processList[0] integerValue]];
}

- (void)photoEndLoadButtonAction:(CustomVerticalButton *)sender {
    if (self.selectedModel.processList.count <= 0) {
        return;
    }
    NSString *statusStr = self.selectedModel.processList[0];
    NSDictionary *paraDict = @{@"tuCode":self.selectedModel.tuCode,
                               @"process":statusStr,
                               @"driverTel":[LoginModel shareLoginModel].phone,
                               UPLOAD_FILE_KEY:UPLOAD_FILE_VALUE,
                               OPERATION_KEY:PROCESSNODE_OPERATION_API,
                               WHETHER_NEED_LOCATION_KRY:@(1)
                               };
    [MyImagePickerManager presentPhotoTakeControllerInTarget:self finishPickingBlock:nil postUrlStr:PAIREACH_NETWORK_UPLOAD_URL paraDict:paraDict endResultBlock:^(NSURLSessionDataTask *task, id responseObject, NSError *error) {
        if (!error) {
            //流程处理结束，返回服务器处理信息供主界面处理界面切换操作
            MBProgressHUD *hud = [ProgressHUD bwm_showTitle:@"图片上传成功，开始卸货！" toView:self.view hideAfter:HUD_HIDE_TIMEINTERVAL];
            [hud setCompletionBlock:^{
                if (self.processEndBlock) {
                    self.processEndBlock(responseObject);
                }
            }];
        } else {
            self.failFlag = YES;
            [self.tableView reloadData];
        }
    }];
}

- (void)endLoadButtonAction:(UIButton *)sender {
    if (self.selectedModel.processList.count <= 0) {
        return;
    }
    NSString *statusStr = self.selectedModel.processList[0];
    NSDictionary *paraDict = @{@"tuCode":self.selectedModel.tuCode,
                               @"process":statusStr,
                               @"driverTel":[LoginModel shareLoginModel].phone,
                               UPLOAD_FILE_KEY:UPLOAD_FILE_VALUE,
                               OPERATION_KEY:PROCESSNODE_OPERATION_API,
                               WHETHER_NEED_LOCATION_KRY:@(1)
                               };
    [NetworkHelper POST:PAIREACH_NETWORK_UPLOAD_URL parameters:paraDict hudTarget:self.view progress:nil endResult:^(NSURLSessionDataTask *task, id responseObject, NSError *error) {
        if (!error) {
            //流程处理结束，返回服务器处理信息供主界面处理界面切换操作
            MBProgressHUD *hud = [ProgressHUD bwm_showTitle:@"签到成功，开始卸货！" toView:self.view hideAfter:HUD_HIDE_TIMEINTERVAL];
            [hud setCompletionBlock:^{
                if (self.processEndBlock) {
                    self.processEndBlock(responseObject);
                }
            }];
        }
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
