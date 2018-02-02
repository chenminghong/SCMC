//
//  PrepareEnterController.m
//  pairearch_WLY
//
//  Created by Jean on 2017/8/18.
//  Copyright © 2017年 Leo. All rights reserved.
//

#import "PrepareEnterController.h"

#import "PrepareEnterCell.h"
#import "OrderListController.h"
#import "NestedSelectModel.h"


@interface PrepareEnterController ()<UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) UITableView *tableView;

@property (nonatomic, strong) NSTimer *timer;   //定时器

@end

@implementation PrepareEnterController

#pragma mark -- Lazy Loading

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
//        self.tableView.backgroundColor = UIColorFromRGB(0xfdf6de);
        self.tableView.backgroundColor = TOP_NAVIBAR_COLOR;
        self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        self.tableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 10)];
        self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 10)];
    }
    return _tableView;
}

//初始化定时器
- (NSTimer *)timer {
    if (!_timer) {
        _timer = [NSTimer scheduledTimerWithTimeInterval:120.0 target:self selector:@selector(refreshViewstatus) userInfo:nil repeats:YES];
    }
    return _timer;
}

/**
 重启定时器
 */
- (void)startTimer {
    [self.timer setFireDate:[NSDate distantPast]];
}


/**
 暂停定时器
 */
- (void)stopTimer {
    [self.timer setFireDate:[NSDate distantFuture]];
}

//获取前面排队的车子数量和等待时间
- (void)refreshViewstatus {
    NSDictionary *paraDict = @{@"driverTel":[LoginModel shareLoginModel].phone,
                               OPERATION_KEY:GET_TRANSPORT_ORDERINFO_API
                               };
    
    [NetworkHelper GET:PAIREACH_NETWORK_URL parameters:paraDict progress:nil endResult:^(NSURLSessionDataTask *task, id responseObject, NSError *error) {
        if (!error && responseObject) {
            [self.selectedModel setValuesForKeysWithDictionary:responseObject];
            [self.tableView reloadData];
        }
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.view.backgroundColor = TOP_NAVIBAR_COLOR;
    [self.view addSubview:self.tableView];
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
    PrepareEnterCell *cell = [PrepareEnterCell getCellWithTable:tableView indexPath:indexPath];
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
