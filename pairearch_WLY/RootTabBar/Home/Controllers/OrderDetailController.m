//
//  OrderDetailController.m
//  pairearch_WLY
//
//  Created by Jean on 2017/5/5.
//  Copyright © 2017年 Leo. All rights reserved.
//

#import "OrderDetailController.h"

@interface OrderDetailController ()

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation OrderDetailController

//- (UITableView *)tableView {
//    if (!_tableView) {
//        self.tableView = [UITableView new];
//        [self.view addSubview:self.tableView];
//        [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.top.equalTo(self.stateView.mas_bottom);
//            make.left.equalTo(self.view.mas_left);
//            make.bottom.equalTo(self.bottomView.mas_top);
//            make.right.equalTo(self.view.mas_right);
//        }];
//        self.tableView.showsVerticalScrollIndicator = NO;
//        self.tableView.delegate = self;
//        self.tableView.dataSource = self;
//        self.tableView.tableFooterView = [UITableView new];
//        self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
//    }
//    return _tableView;
//}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.view addSubview:self.tableView];
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
