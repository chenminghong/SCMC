//
//  WaitingListController.m
//  pairearch_WLY
//
//  Created by Jean on 2017/12/29.
//  Copyright © 2017年 Leo. All rights reserved.
//

#import "WaitingListController.h"

#import "OrderListController.h"
#import "WaitingListCell.h"
#import "NestedSelectModel.h"

@interface WaitingListController ()<UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) UITableView *tableView;

@end

@implementation WaitingListController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = TOP_NAVIBAR_COLOR;
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
        self.tableView.estimatedRowHeight = 700;
        self.tableView.backgroundColor = UIColorFromRGB(0xfdf6de);
        self.tableView.backgroundColor = TOP_NAVIBAR_COLOR;
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
    WaitingListCell *cell = [WaitingListCell getCellWithTable:tableView indexPath:indexPath];
    [cell.tuNumberButton addTarget:self action:@selector(tunumberButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    cell.selectedModel = self.selectedModel;
    return cell;
}

- (void)tunumberButtonAction:(UIButton *)sender {
    NSString *tuCode = sender.currentTitle;
    [OrderListController enterTulistDetailViewControllerWithTarget:self tuCode:tuCode status:[self.selectedModel.processList[0] integerValue]];
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
