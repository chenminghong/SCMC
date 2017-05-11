//
//  OrdersViewController.m
//  pairearch_WLY
//
//  Created by Jean on 2017/4/24.
//  Copyright © 2017年 Leo. All rights reserved.
//

#import "OrdersViewController.h"

#import "HomeTableCell.h"
#import "HomePageModel.h"

@interface OrdersViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) HomePageModel *homePageModel;

@end

@implementation OrdersViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"运单中心";
    
    [self.view addSubview:self.tableView];
    
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

#pragma mark -- TableViewDelegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.homePageModel.orderModel? 1:0;
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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
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
