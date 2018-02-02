//
//  BiddingInformationController.m
//  pairearch_WLY
//
//  Created by Jean on 2017/9/22.
//  Copyright © 2017年 Leo. All rights reserved.
//

#import "BiddingInformationController.h"

#import "BiddingInformationCellOne.h"
#import "BiddingInformationCellTwo.h"

@interface BiddingInformationController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation BiddingInformationController

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
        self.tableView.backgroundColor = TABLE_BACKGROUND_COLOR;
        self.tableView.tableFooterView = [UITableView new];
        self.tableView.separatorInset = UIEdgeInsetsZero;
        self.tableView.separatorColor = TABLE_SEPARATOR_COLOR;
    }
    return _tableView;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.view.backgroundColor = TABLE_BACKGROUND_COLOR;
    [self.view addSubview:self.tableView];
}

#pragma mark -- UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        return 120.0;
    }
    return 420;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        BiddingInformationCellOne *cell = [BiddingInformationCellOne getListCellWithTable:tableView indexPath:indexPath];
        return cell;
    }
    BiddingInformationCellTwo *cell = [BiddingInformationCellTwo getListCellWithTable:tableView indexPath:indexPath];
    return cell;
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
