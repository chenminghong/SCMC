//
//  OrdersViewController.m
//  pairearch_WLY
//
//  Created by Jean on 2017/4/24.
//  Copyright © 2017年 Leo. All rights reserved.
//

#import "OrdersViewController.h"

#import "OrderListTableCell.h"
#import "HomePageModel.h"

#import "OrderStatus212Controller.h"
#import "Mistake212Controller.h"

@interface OrdersViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) HomePageModel *homeModel;

@end

@implementation OrdersViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"运单中心";
    
    [self.view addSubview:self.tableView];
    
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [MJRefreshUtil begainRefresh:self.tableView];
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
        self.tableView.tableFooterView = [UITableView new];
        self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [MJRefreshUtil pullDownRefresh:self andScrollView:self.tableView andAction:@selector(getOrderListData)];
    }
    return _tableView;
}

//获取订单列表Data数据
- (void)getOrderListData {
    [HomePageModel getDataWithUrl:ORDER_LIST_API parameters:@{@"driverTel":[LoginModel shareLoginModel].tel? [LoginModel shareLoginModel].tel:@""} endBlock:^(id model, NSError *error) {
        if (!error) {
            self.homeModel = model;
            if (self.homeModel.orderModelList.count <= 0) {
                [MBProgressHUD bwm_showTitle:@"暂无订单" toView:self.view hideAfter:HUD_HIDE_TIMEINTERVAL];
            }
        } else {
            [MBProgressHUD bwm_showTitle:error.userInfo[ERROR_MSG] toView:self.view hideAfter:HUD_HIDE_TIMEINTERVAL];
        }
        [self.tableView reloadData];
        [MJRefreshUtil endRefresh:self.tableView];
    }];
}

#pragma mark -- TableViewDelegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.homeModel.orderModelList.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    HomePageModel *model = self.homeModel.orderModelList[indexPath.row];
    CGFloat startNameConstant = [BaseModel heightForTextString:model.sourceName width:(kScreenWidth - 85.0)  fontSize:16.0];
    CGFloat startAddConstant = [BaseModel heightForTextString:model.sourceAddr width:(kScreenWidth - 85.0)  fontSize:16.0];
    CGFloat endDcNameConstant = [BaseModel heightForTextString:model.dcName width:(kScreenWidth - 85.0)  fontSize:13.0];
    CGFloat endDcAddConstant = [BaseModel heightForTextString:model.dcAddress width:(kScreenWidth - 85.0)  fontSize:13.0];
    CGFloat height = startNameConstant + startAddConstant + endDcNameConstant + endDcAddConstant + 50.0 + 20 + 30;
    return height < 130.0? 130.0:height;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    OrderListTableCell *cell = [OrderListTableCell getCellWithTable:tableView];
    cell.orderModel = self.homeModel.orderModelList[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    HomePageModel *model = self.homeModel.orderModelList[indexPath.row];
    [self jumpToControllerWithStatus:model.status.integerValue paraDict:model];
}

//KA界面跳转逻辑
- (void)jumpToControllerWithStatus:(NSInteger)status paraDict:(HomePageModel *)model {
    NSLog(@"status:%ld", status);
    switch (status) {
        case ORDER_STATUS_212:
        {
            OrderStatus212Controller *orderVC = [OrderStatus212Controller new];
            orderVC.homePageModel = model;
            [self.navigationController pushViewController:orderVC animated:YES];
        }
            break;
            
        case ORDER_STATUS_220:
        {
            Mistake212Controller *mistake = [Mistake212Controller new];
            mistake.homePageModel = model;
            [self.navigationController pushViewController:mistake animated:YES];
        }
            break;
            
        default:
            break;
    }
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
