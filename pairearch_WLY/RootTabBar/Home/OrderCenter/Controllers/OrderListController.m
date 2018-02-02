//
//  OrderListController.m
//  pairearch_WLY
//
//  Created by Jean on 2017/8/16.
//  Copyright © 2017年 Leo. All rights reserved.
//

#import "OrderListController.h"

#import "OrderListTableCell.h"
#import "OrderListCell.h"
#import "OrderListTableFooter.h"
#import "OrdersListModel.h"
#import "NestedSelectStateController.h"

@interface OrderListController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, assign) NSInteger status;  //当前的订单状态

@property (strong, nonatomic) UITableView *tableView;

@property (nonatomic, strong) OrderListTableFooter *footerView;

@property (nonatomic, strong) OrdersListModel *orderListModel;

@end

@implementation OrderListController

#pragma mark -- LazyLoading

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
        self.tableView.backgroundColor = UIColorFromRGB(0xfdf6de);
        self.tableView.tableFooterView = [UITableView new];
        self.tableView.separatorColor = TABLE_SEPARATOR_COLOR;
        self.tableView.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
        self.tableView.estimatedRowHeight = 40.0;
    }
    return _tableView;
}

- (OrderListTableFooter *)footerView {
    if (!_footerView) {
        self.footerView = [OrderListTableFooter getFooterView];
        self.footerView.frame = CGRectMake(0, 0, kScreenWidth, 100);
        [self.footerView.getOrderButton addTarget:self action:@selector(getOrderButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _footerView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.tableView];
}

//根据TU单查询当前的TU单订单详情数据
+ (instancetype)enterTulistDetailViewControllerWithTarget:(UIViewController *)target tuCode:(NSString *)tuCode status:(NSInteger)status {
    OrderListController *orderListVC = [OrderListController new];
    orderListVC.tuCode = tuCode;
    orderListVC.status = status;
    [target.navigationController pushViewController:orderListVC animated:YES];
    return orderListVC;
}

//加载网络数据
- (void)loadData {
    NSDictionary *paraDict = @{@"tuCode":self.tuCode,
                               OPERATION_KEY:GET_TU_DETAIL_API};
    [OrdersListModel getDataWithUrl:PAIREACH_NETWORK_URL parameters:paraDict endBlock:^(NSURLSessionDataTask *task, id responseObject, NSError *error) {
        if (!error) {
            self.orderListModel = responseObject;
        }
        NSLog(@"%@", self.orderListModel.modelListArr);
        [self.tableView reloadData];
    }];
}

- (void)setTuCode:(NSString *)tuCode {
    _tuCode = tuCode;
    [self loadData];
}

#pragma mark -- UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 1;
    }
    return self.orderListModel.modelListArr.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return 0.0;
    }
    return 15.0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    if (section == 0 || self.status > ORDER_STATUS_100) {
        return CGFLOAT_MIN;
    }
    return 100;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    if (self.status > ORDER_STATUS_100) {
        return nil;
    }
    if (section == 0) {
        return nil;
    }
    return self.footerView;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return nil;
    }
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 15)];
    headerView.backgroundColor = [UIColor clearColor];
    return headerView;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        OrderListTableCell *cell = [OrderListTableCell getListCellWithTable:tableView indexPath:indexPath];
        cell.tuNumberLabel.text = self.tuCode;
        cell.orderCountLabel.text = [NSString stringWithFormat:@"运单数量：%ld", self.orderListModel.modelListArr.count];
        return cell;
    }
    OrderListCell *cell = [OrderListCell getListCellWithTable:tableView indexPath:indexPath];
    cell.orderListModel = self.orderListModel.modelListArr[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 1) {
//        OrdersListModel *model = self.orderListModel.modelListArr[indexPath.row];
        
    }
}

#pragma mark -- ButtonAction

//接收订单操作
- (void)getOrderButtonAction:(UIButton *)sender {
    if (!self.tuCode) {
        [ProgressHUD bwm_showTitle:@"数据错误！" toView:self.view hideAfter:HUD_HIDE_TIMEINTERVAL];
        return;
    }
    NSDictionary *paraDict = @{@"tuCode":self.tuCode,
                               @"driverTel":[LoginModel shareLoginModel].phone,
                               OPERATION_KEY:RECEIVE_ORDER_API};
    [NetworkHelper POST:PAIREACH_NETWORK_URL parameters:paraDict hudTarget:self.view progress:nil endResult:^(NSURLSessionDataTask *task, id responseObject, NSError *error) {
        if (!error) {
            MBProgressHUD *hud = [ProgressHUD bwm_showTitle:@"接单成功！" toView:self.view hideAfter:HUD_HIDE_TIMEINTERVAL];
            [hud setCompletionBlock:^{
                NestedSelectStateController *selectedVC = [NestedSelectStateController new];
                [self.navigationController pushViewController:selectedVC animated:YES];
            }];
        } else {
            [MBProgressHUD bwm_showTitle:error.userInfo[ERROR_MSG] toView:self.view hideAfter:HUD_HIDE_TIMEINTERVAL];
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
