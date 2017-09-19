//
//  HomeViewController.m
//  pairearch_WLY
//
//  Created by Leo on 2017/2/15.
//  Copyright © 2017年 Leo. All rights reserved.
//

#import "HomeViewController.h"

#import "HomePageModel.h"
//#import "LoginViewController.h"
//#import "PaomaLabel.h"
//#import "WQLPaoMaView.h"
//#import "HomeTableCell.h"
//#import "OrderStatus212Controller.h"
//#import "Mistake212Controller.h"
//#import "BiddingListController.h"

#import "HomeCollectionCell.h"

#import "TUListController.h"
#import "OrderStatus220Controller.h"
#import "MessageCenterController.h"

@interface HomeViewController ()<SDCycleScrollViewDelegate, UITableViewDelegate, UITableViewDataSource>


@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) HomePageModel *homePageModel;

@property (nonatomic, strong) SDCycleScrollView *sdCycleView;

@property (nonatomic, strong) UIButton *newsButton;  //右上角消息按钮

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.newsButton];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"我来运";
    
    [self.view addSubview:self.tableView];
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    
    NSArray *imageUrlStrArr = @[@"https://ss1.bdstatic.com/70cFvXSh_Q1YnxGkpoWK1HF6hhy/it/u=1238497980,1597218505&fm=26&gp=0.jpg",
                                @"https://ss0.bdstatic.com/70cFvHSh_Q1YnxGkpoWK1HF6hhy/it/u=1450410798,281036268&fm=26&gp=0.jpg",
                                @"https://ss1.bdstatic.com/70cFvXSh_Q1YnxGkpoWK1HF6hhy/it/u=3503460854,933931965&fm=26&gp=0.jpg",
                                @"https://ss0.bdstatic.com/70cFvHSh_Q1YnxGkpoWK1HF6hhy/it/u=1128343348,3478453008&fm=26&gp=0.jpg"];
    self.sdCycleView.imageURLStringsGroup = imageUrlStrArr;
    
    [self getHomePageData];
    
//    [ProgressHUD bwm_showTitle:@"加载成功" toView:self.view hideAfter:MAXFLOAT msgType:BWMMBProgressHUDMsgTypeSuccessful];
}


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
        self.tableView.backgroundColor = UIColorFromRGB(0xf2f2f2);
        self.tableView.tableFooterView = [UITableView new];
        self.tableView.tableHeaderView = self.sdCycleView;
        self.tableView.separatorColor = TABLE_SEPARATOR_COLOR;
        self.tableView.separatorInset = UIEdgeInsetsZero;
    }
    return _tableView;
}

- (SDCycleScrollView *)sdCycleView {
    if (!_sdCycleView) {
        CGRect cycleViewFrame = CGRectMake(0, 0, kScreenWidth, kScreenWidth * 260 / 640);
        self.sdCycleView = [SDCycleScrollView cycleScrollViewWithFrame:cycleViewFrame imageURLStringsGroup:@[]];
        self.sdCycleView.dotColor = TOP_NAVIBAR_COLOR;
        self.sdCycleView.placeholderImage = [UIImage imageNamed:@"placeholder_img"];
        self.sdCycleView.delegate = self;
    }
    return _sdCycleView;
}

- (UIButton *)newsButton {
    if (!_newsButton) {
        _newsButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _newsButton.frame = CGRectMake(kScreenWidth - 60, 31, 22, 22);
        [_newsButton setBackgroundImage:[UIImage imageNamed:@"havenews"] forState:UIControlStateNormal];
//        [_newsButton setImage:[UIImage imageNamed:@"havenews"] forState:UIControlStateNormal];
//        [_newsButton setTitle:@"消息" forState:UIControlStateNormal];
        [_newsButton addTarget:self action:@selector(newsButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        UIView *tipsView = [UIView new];
        tipsView.backgroundColor = [UIColor redColor];
        [_newsButton addSubview:tipsView];
        [tipsView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(_newsButton.mas_top).with.offset(1);
            make.right.mas_equalTo(_newsButton.mas_right).with.offset(1);
            make.size.mas_equalTo(CGSizeMake(5, 5));
        }];
        tipsView.layer.masksToBounds = YES;
        tipsView.layer.cornerRadius = 2.5;
    }
    return _newsButton;
}

- (void)newsButtonAction:(UIButton *)sender {
    MessageCenterController *messageVC = [MessageCenterController new];
    [self.navigationController pushViewController:messageVC animated:YES];
}

#pragma mark -- Get Data

//获取首页Data数据
- (void)getHomePageData {
    
    [HomePageModel getDataWithUrl:HOME_PAGE_COUNT_API parameters:@{@"mobile":[LoginModel shareLoginModel].tel? [LoginModel shareLoginModel].tel:@""} endBlock:^(id model, NSError *error) {
        if (!error) {
            self.homePageModel = model;
            if (self.homePageModel.orderModelList.count > 0) {
                HomePageModel *model = self.homePageModel.orderModelList[0];
                if ([model.status integerValue] > ORDER_STATUS_212) {
                    [LocationManager shareManager].orderCode = model.code;  //开启定位上传
                } else {
                    [LocationManager shareManager].orderCode = nil;   //结束定位上传
                }
            } else {
                [LocationManager shareManager].orderCode = nil;   //结束定位上传
            }
        } else {
            [MBProgressHUD bwm_showTitle:error.userInfo[ERROR_MSG] toView:self.view hideAfter:HUD_HIDE_TIMEINTERVAL];
        }
        [self.tableView reloadData];
        [MJRefreshUtil endRefresh:self.tableView];
    }];
}

//设置不同字体颜色
- (void)fuwenbenLabel:(UILabel *)labell FontNumber:(id)font AndRange:(NSRange)range AndColor:(UIColor *)vaColor {
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:labell.text];
    
    //设置字号
    [str addAttribute:NSFontAttributeName value:font range:range];
    
    //设置文字颜色
    [str addAttribute:NSForegroundColorAttributeName value:vaColor range:range];
    labell.attributedText = str;
}

#pragma mark -- SDCycleScrollViewDelegate

- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index {
    [ProgressHUD bwm_showTitle:[NSString stringWithFormat:@"第%ld张", index+1] toView:self.view hideAfter:HUD_HIDE_TIMEINTERVAL/2.0];
}

#pragma mark -- TableViewDelegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return kScreenWidth * 584.0 / 640.0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    HomeCollectionCell *cell = [HomeCollectionCell getCellWithTableView:tableView indexPath:indexPath selectAction:^(NSIndexPath *indexPath) {
        switch (indexPath.item) {
            case 0:
            {
                [ProgressHUD bwm_showTitle:@"正在开发" toView:self.view hideAfter:1.0];
            }
                break;
                
            case 1:
            {
                [ProgressHUD bwm_showTitle:@"正在开发" toView:self.view hideAfter:1.0];
            }
                break;
                
            case 2:
            {
                TUListController *tulistVC = [TUListController new];
                [self.navigationController pushViewController:tulistVC animated:YES];
            }
                break;
                
            case 3:
            {
                OrderStatus220Controller *orderVC = [OrderStatus220Controller new];
                [self.navigationController pushViewController:orderVC animated:YES];

            }
                break;
                
            default:
                break;
        }
    }];
    return cell;
}

#pragma mark -- ButtonAction



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
