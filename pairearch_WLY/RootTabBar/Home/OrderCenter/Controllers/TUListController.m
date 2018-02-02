//
//  TUListController.m
//  pairearch_WLY
//
//  Created by Jean on 2017/8/16.
//  Copyright © 2017年 Leo. All rights reserved.
//

#import "TUListController.h"

#import "TUListTableCell.h"
#import "OrderListController.h"
#import "TuListModel.h"

@interface TUListController ()<UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) UITableView *tableView;

@property (nonatomic, strong) TuListModel *tulistModel;

@end

@implementation TUListController

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
        self.tableView.separatorInset = UIEdgeInsetsZero;
        self.tableView.separatorColor = TABLE_SEPARATOR_COLOR;
        [MJRefreshUtil pullDownRefresh:self andScrollView:self.tableView andAction:@selector(loadData)];
    }
    return _tableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [MJRefreshUtil begainRefresh:self.tableView];
}

//加载数据
- (void)loadData {
    NSDictionary *paraDict = @{@"driverTel":[LoginModel shareLoginModel].phone,
                               OPERATION_KEY:WAIT_TRANSPORT_LIST_API};
    [TuListModel getDataWithUrl:PAIREACH_NETWORK_URL parameters:paraDict hudTarget:self endBlock:^(NSURLSessionDataTask *task, id responseObject, NSError *error) {
        if (!error) {
            self.tulistModel = responseObject;
        }
        NSLog(@"%lud",(unsigned long) self.tulistModel.modelListArr.count);
        if (self.tulistModel.modelListArr.count <= 0) {
            self.tableView.placeHolderView = [NoDataView getPlaceHoldViewWithImgName:@"zanwuyundan" titleText:@"暂无可运输的运单，可联系承运商指派运单"];
        }
        [self.tableView reloadData];
        [MJRefreshUtil endRefresh:self.tableView];
    }];
}

#pragma mark -- UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.tulistModel.modelListArr.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 96;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TUListTableCell *cell = [TUListTableCell getListCellWithTable:tableView indexPath:indexPath];
    cell.tuModel = self.tulistModel.modelListArr[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    TuListModel *model = self.tulistModel.modelListArr[indexPath.row];
    [OrderListController enterTulistDetailViewControllerWithTarget:self tuCode:model.tuCode status:100];
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
