//
//  BiddingDetailController.m
//  pairearch_WLY
//
//  Created by Jean on 2017/5/23.
//  Copyright © 2017年 Leo. All rights reserved.
//

#import "BiddingDetailController.h"

#import "BidddingDetailModel.h"
#import "BidDetailCell.h"
#import "BiddingFooterView.h"
#import "BidPickerView.h"

@interface BiddingDetailController ()<UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) BidddingDetailModel *biddingModel;  //数据源

@property (nonatomic, strong) BiddingFooterView *footerView;      //页脚视图

@property (nonatomic, copy) NSString *supplierCode;   //选中的承运商编号

@property (nonatomic, copy) NSString *plateNumber;    //选中的司机车牌号

@end

@implementation BiddingDetailController

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
        self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _tableView;
}

- (BiddingFooterView *)footerView {
    if (!_footerView) {
        self.footerView = [BiddingFooterView getFooterView];
        self.footerView.frame = CGRectMake(0, 0, kScreenWidth, 175.0);
    }
    return _footerView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.title = @"竞价中运单详情";
    self.supplierCode = @"";
    self.plateNumber = @"";
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

- (void)setBidCode:(NSString *)bidCode {
    _bidCode = bidCode;
    [self getDataFromNet];
}

- (void)getDataFromNet {
    [BidddingDetailModel getDataWithParameters:@{@"phoneNumber":[LoginModel shareLoginModel].tel, @"bidCode":self.bidCode} endBlock:^(id model, NSError *error) {
        if (!error) {
            self.biddingModel = model;
        } else {
            [ProgressHUD bwm_showTitle:error.userInfo[ERROR_MSG] toView:self.view hideAfter:HUD_HIDE_TIMEINTERVAL];
        }
        [self.tableView reloadData];
    }];
}

#pragma mark -- UITableViewDelegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.biddingModel.scorderbidArr.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 150.0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 150.0;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    BidddingDetailModel *model = self.biddingModel.supplieArr[0];
    [self.footerView.supplierButton setTitle:model.supplierName forState:UIControlStateNormal];
    self.supplierCode = model.supplierCode;
    model = self.biddingModel.driverArr[0];
    [self.footerView.plateNumberBotton setTitle:model.truckNumber forState:UIControlStateNormal];
    self.plateNumber = model.truckNumber;
    [self.footerView.supplierButton addTarget:self action:@selector(sipplierButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.footerView.plateNumberBotton addTarget:self action:@selector(plateNumberButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.footerView.rapButton addTarget:self action:@selector(rapButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    self.footerView.biddingTf.delegate = self;
    return self.footerView;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    BidDetailCell *cell = [BidDetailCell getCellWithTable:tableView];
    cell.detailModel = self.biddingModel.scorderbidArr[indexPath.row];
    return cell;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    // 当前输入的字符是'.'
    if ([string isEqualToString:@"."]) {
        // 已输入的字符串中已经包含了'.'或者""
        if ([textField.text rangeOfString:@"."].location != NSNotFound || [textField.text isEqualToString:@""]) {
            return NO;
        } else {
            return YES;
        }
    } else {// 当前输入的不是'.'
        // 第一个字符是0时, 第二个不能再输入0
        if (textField.text.length == 1) {
            unichar str = [textField.text characterAtIndex:0];
            if (str == '0' && [string isEqualToString:@"0"]) {
                return NO;
            }
            if (str != '0' && str != '1') {// 1xx或0xx
                return YES;
            } else {
                if (str == '1') {
                    return YES;
                } else {
                    if ([string isEqualToString:@""]) {
                        return YES;
                    } else {
                        return NO;
                    }
                }
            }
        }
        // 已输入的字符串中包含'.'
        if ([textField.text rangeOfString:@"."].location != NSNotFound) {
            NSMutableString *str = [[NSMutableString alloc] initWithString:textField.text];
            [str insertString:string atIndex:range.location];
            if (str.length > [str rangeOfString:@"."].location + 4) {
                return NO;
            }
            NSLog(@"str.length = %ld, str = %@, string.location = %ld", str.length, string, range.location);
        }
//        else {
//            if (textField.text.length > 5) {
//                return range.location < 6;
//            }
//        }
    }
    return YES;
}

#pragma mark -- 按钮点击事件


/**
 选择承运商

 @param sender 选择按钮
 */
- (void)sipplierButtonAction:(UIButton *)sender {
    [self.view endEditing:YES];
    
    __weak typeof(self) weakSelf = self;
    [BidPickerView showTimeSelectViewWithTitle:@"请选择运营商" dataArr:self.biddingModel.supplieArr selectBlock:^(id model) {
        BidddingDetailModel *detailModel = model;
        [weakSelf.footerView.supplierButton setTitle:detailModel.supplierName forState:UIControlStateNormal];
        self.supplierCode = detailModel.supplierCode;
        BidddingDetailModel *tempModel = self.biddingModel.scorderbidArr[0];
        [[NetworkHelper shareClientBidd] GET:GET_DRIVER_API parameters:@{@"phoneNumber":[LoginModel shareLoginModel].tel, @"bidCode":tempModel.bidCode, @"supplierCode":detailModel.supplierCode} progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            responseObject = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
            weakSelf.biddingModel.driverArr = [NSMutableArray arrayWithArray:[BidddingDetailModel getModelsWithDicts:responseObject[@"driver"]]];
            BidddingDetailModel *tempModel2 = self.biddingModel.driverArr[0];
            [weakSelf.footerView.plateNumberBotton setTitle:tempModel2.truckNumber forState:UIControlStateNormal];
        } failure:nil];
    }];
}


/**
 选择司机车牌号

 @param sender 选择按钮
 */
- (void)plateNumberButtonAction:(UIButton *)sender {
    [self.view endEditing:YES];
    __weak typeof(self) weakSelf = self;
    [BidPickerView showTimeSelectViewWithTitle:@"请选择车牌号" dataArr:self.biddingModel.driverArr selectBlock:^(id model) {
        BidddingDetailModel *detailModel = model;
        [weakSelf.footerView.plateNumberBotton setTitle:detailModel.truckNumber forState:UIControlStateNormal];
        self.plateNumber = detailModel.truckNumber;
    }];
}



/**
 抢单操作

 @param sender 抢单按钮
 */
- (void)rapButtonAction:(UIButton *)sender {
    
    /*
     phoneNumber	手机号码
     bidCode	单号
     amount	价格
     supplierCod	承运商编码
     carno	车牌号*/
    
    if ([self.footerView.biddingTf.text stringByReplacingOccurrencesOfString:@" " withString:@""].length <= 0) {
        [MBProgressHUD bwm_showTitle:@"请输入价格" toView:self.view hideAfter:HUD_HIDE_TIMEINTERVAL];
        return;
    }
    BidddingDetailModel *model = self.biddingModel.scorderbidArr[0];
    NSDictionary *paraDict = @{@"phoneNumber":[LoginModel shareLoginModel].tel,
                               @"bidCode":model.bidCode,
                               @"amount":self.footerView.biddingTf.text,
                               @"supplierCod":self.supplierCode,
                               @"carno":self.plateNumber};
    [[NetworkHelper shareClientBidd] POST:SCRATCH_ORDER_API parameters:paraDict progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        responseObject = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
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
