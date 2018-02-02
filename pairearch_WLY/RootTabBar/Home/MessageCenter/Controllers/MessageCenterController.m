//
//  MessageCenterController.m
//  pairearch_WLY
//
//  Created by Jean on 2017/9/18.
//  Copyright © 2017年 Leo. All rights reserved.
//

#import "MessageCenterController.h"

#import "MessageTableCell.h"
#import "BidSuccessController.h"
#import "BidFailController.h"

@interface MessageCenterController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation MessageCenterController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.view.backgroundColor = TOP_NAVIBAR_COLOR;
    self.title = @"消息";
    
    [self.view addSubview:self.tableView];
}

#pragma mark -- LazyLoding

- (UITableView *)tableView {
    if (!_tableView) {
        self.tableView = [UITableView new];
        self.tableView.separatorInset = UIEdgeInsetsMake(0, 10, 0, 0);
        self.tableView.separatorColor = TABLE_SEPARATOR_COLOR;
        [self.view addSubview:self.tableView];
        [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.and.left.and.bottom.and.right.mas_equalTo(self.view);
        }];
        self.tableView.delegate = self;
        self.tableView.dataSource = self;
        self.tableView.tableFooterView = [UIView new];
        self.tableView.backgroundColor = TOP_NAVIBAR_COLOR;
        self.tableView.placeHolderView = [NoDataView getPlaceHoldViewWithImgName:@"zanwuxiaoxi" titleText:@"暂无消息"];
//        [MJRefreshUtil pullDownRefresh:self andScrollView:self.listTableView andAction:@selector(loadDataFromNet)];
    }
    return _tableView;
}

#pragma marks -- TableViewDelegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 80.0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MessageTableCell *cell = [MessageTableCell getListCellWithTable:tableView indexPath:indexPath];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row % 2 == 0) {
        BidSuccessController *bidSuccessVC = [BidSuccessController new];
        [self.navigationController pushViewController:bidSuccessVC animated:YES];
    } else {
        BidFailController *bidFailVC = [BidFailController new];
        [self.navigationController pushViewController:bidFailVC animated:YES];
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
