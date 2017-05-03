//
//  Mistake212Controller.m
//  pairearch_WLY
//
//  Created by Jean on 2017/4/26.
//  Copyright © 2017年 Leo. All rights reserved.
//

#import "Mistake212Controller.h"

#import "Mistake212Header.h"
#import "Mistake212Footer.h"
#import "HomePageModel.h"
#import "HomeTableCell.h"

#define HEIGHT_FOR_HEADER  50.0
#define HEIGHT_FOR_FOOTER  80.0

@interface Mistake212Controller ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) Mistake212Header *headerView;

@property (nonatomic, strong) Mistake212Footer *footerView;

@property (nonatomic, strong) HomePageModel *homePageModel;

@end

@implementation Mistake212Controller

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.leftBarButtonItem = [NavigationController getNavigationBackItemWithTarget:self SEL:@selector(popBackAction:)];
    [self.view addSubview:self.tableView];
}

- (void)setStatus:(NSString *)status {
    _status = status;
    [self getDataFromNet];
}

- (Mistake212Header *)headerView {
    if (!_headerView) {
        self.headerView = [Mistake212Header getHeaderView];
        self.headerView.frame = CGRectMake(0, 0, kScreenWidth, 20);
    }
    return _headerView;
}

- (Mistake212Footer *)footerView {
    if (!_footerView) {
        self.footerView = [Mistake212Footer getFooterView];
        self.footerView.frame = CGRectMake(0, 0, kScreenWidth, 150);
    }
    return _footerView;
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
    }
    return _tableView;
}

#pragma mark -- Get Data

//获取首页Data数据
- (void)getDataFromNet {
    [HomePageModel getDataWithUrl:LOAD_DETAIL_API parameters:@{@"mobile":[LoginModel shareLoginModel].tel? [LoginModel shareLoginModel].tel:@"", @"orderCode":self.homePageModel.orderModel.code} endBlock:^(id model, NSError *error) {
        if (!error) {
            self.homePageModel = model;
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
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return HEIGHT_FOR_HEADER;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return HEIGHT_FOR_FOOTER;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    self.headerView.planTimeLabel.text = self.homePageModel.orderModel.planDate;
    return self.headerView;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return self.footerView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    HomePageModel *model = self.homePageModel.orderModel;
    CGFloat startNameConstant = [BaseModel heightForTextString:model.sourceName width:(kScreenWidth - 85.0)  fontSize:16.0];
    CGFloat startAddConstant = [BaseModel heightForTextString:model.sourceAddr width:(kScreenWidth - 85.0)  fontSize:16.0];
    CGFloat endDcNameConstant = [BaseModel heightForTextString:model.dcName width:(kScreenWidth - 85.0)  fontSize:13.0];
    CGFloat endDcAddConstant = [BaseModel heightForTextString:model.dcAddress width:(kScreenWidth - 85.0)  fontSize:13.0];
    CGFloat height = startNameConstant + startAddConstant + endDcNameConstant + endDcAddConstant + 50.0 + 20;
    return height < 130.0? 130.0:height;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    HomeTableCell *cell = [HomeTableCell getCellWithTable:tableView];
    cell.homeModel = self.homePageModel.orderModel;
    return cell;
}

/**
 返回按钮点击事件
 
 @param sender 返回按钮
 */
- (void)popBackAction:(UIButton *)sender {
    [self.navigationController popToRootViewControllerAnimated:YES];
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
