//
//  HomeViewController.m
//  pairearch_WLY
//
//  Created by Leo on 2017/2/15.
//  Copyright © 2017年 Leo. All rights reserved.
//

#import "HomeViewController.h"

#import "HomePageModel.h"
#import "HomeCollectionCell.h"
#import "TUListController.h"
#import "NestedSelectStateController.h"
#import "MessageCenterController.h"
#import "TransationListController.h"
#import "MyTransationController.h"
#import "ImageListModel.h"

@interface HomeViewController ()<SDCycleScrollViewDelegate, UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) SDCycleScrollView *sdCycleView;

@property (nonatomic, strong) UIButton *newsButton;  //右上角消息按钮

@property (nonatomic, strong) ImageListModel *imageListModel;   //顶部图片数据源

@property (nonatomic, strong) HomePageModel *homePageModel;

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:self.newsButton];
    self.navigationItem.rightBarButtonItem = item;
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"我来运";
    
    [self.view addSubview:self.tableView];
    [MJRefreshUtil pullDownRefresh:self andScrollView:self.tableView andAction:@selector(getHomePageData)];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [MJRefreshUtil begainRefresh:self.tableView];
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
//        _newsButton.frame = CGRectMake(kScreenWidth - 60, -20, 60, 44);
        _newsButton.backgroundColor = [UIColor lightGrayColor];
//        [_newsButton setBackgroundImage:[UIImage imageNamed:@"havenews"] forState:UIControlStateNormal];
        [_newsButton setImage:[UIImage imageNamed:@"havenews"] forState:UIControlStateNormal];
//        [_newsButton setImage:[UIImage imageNamed:@"havenews"] forState:UIControlStateNormal];
//        [_newsButton setTitle:@"消息" forState:UIControlStateNormal];
        [_newsButton addTarget:self action:@selector(newsButtonAction:) forControlEvents:UIControlEventTouchUpInside];
//        UIView *tipsView = [UIView new];
//        tipsView.backgroundColor = [UIColor redColor];
//        [_newsButton addSubview:tipsView];
//        [tipsView mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.top.mas_equalTo(_newsButton.mas_top).with.offset(1);
//            make.right.mas_equalTo(_newsButton.mas_right).with.offset(1);
//            make.size.mas_equalTo(CGSizeMake(5, 5));
//        }];
//        tipsView.layer.masksToBounds = YES;
//        tipsView.layer.cornerRadius = 2.5;
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
    //获取首页顶部图片的数据
    [self getImageListData];
    
    //获取首页各个模块订单数量的数据
    NSDictionary *paraDict = @{@"account":[LoginModel shareLoginModel].phone,
                               OPERATION_KEY:HOME_TOTAL_API
                               };
    [HomePageModel getDataWithUrl:PAIREACH_NETWORK_URL parameters:paraDict hudTarget:self endBlock:^(NSURLSessionDataTask *task, id responseObject, NSError *error) {
        if (!error) {
            self.homePageModel = responseObject;
            if ([self.homePageModel.orderWaitTransingCount integerValue] > 0) {
//                [[LocationManager shareManager] startUploadLocation];  //开启定位上传
                [MyBMKLocationManager startUploadLocationWithTUCode:self.homePageModel.tuCode];
            } else {
//                [[LocationManager shareManager] stopUploadLocation];   //结束定位上传
                [MyBMKLocationManager stopUploadLocation];
            }
        }
        [self.tableView reloadData];
        [MJRefreshUtil endRefresh:self.tableView];
    }];
}

//获取顶部图片轮播图数据
- (void)getImageListData {
    NSDictionary *paraDict = @{OPERATION_KEY:HOME_IMAGE_LIST_API};
    
    [ImageListModel getDataWithUrl:PAIREACH_NETWORK_URL parameters:paraDict endBlock:^(NSURLSessionDataTask *task, id responseObject, NSError *error) {
        if (!error) {
            self.imageListModel = responseObject;
            NSMutableArray *imageUrlArr = [NSMutableArray array];
            for (ImageListModel *imageModel in self.imageListModel.modelListArr) {
                [imageUrlArr addObject:imageModel.imagePath];
            }
            /*
            NSArray *tempUrlArr = @[@"https://ss1.bdstatic.com/70cFvXSh_Q1YnxGkpoWK1HF6hhy/it/u=1238497980,1597218505&fm=26&gp=0.jpg",
                            @"https://ss0.bdstatic.com/70cFvHSh_Q1YnxGkpoWK1HF6hhy/it/u=1450410798,281036268&fm=26&gp=0.jpg",
                            @"https://ss1.bdstatic.com/70cFvXSh_Q1YnxGkpoWK1HF6hhy/it/u=3503460854,933931965&fm=26&gp=0.jpg",
                            @"https://ss0.bdstatic.com/70cFvHSh_Q1YnxGkpoWK1HF6hhy/it/u=1128343348,3478453008&fm=26&gp=0.jpg"];
            imageUrlArr = [NSMutableArray arrayWithArray:tempUrlArr];
             */
            
            self.sdCycleView.imageURLStringsGroup = imageUrlArr;
            if (imageUrlArr.count > 1) {
                self.sdCycleView.infiniteLoop = YES;
                self.sdCycleView.autoScroll = YES;
                self.sdCycleView.showPageControl = YES;
            } else {
                self.sdCycleView.infiniteLoop = NO;
                self.sdCycleView.autoScroll = NO;
                self.sdCycleView.showPageControl = NO;
            }
        }
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
    ImageListModel *model = self.imageListModel.modelListArr[index];
    [ProgressHUD bwm_showTitle:[NSString stringWithFormat:@"第%ld张:%@", index+1, model.content] toView:self.view hideAfter:HUD_HIDE_TIMEINTERVAL/2.0];
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
                TransationListController *transationVC = [TransationListController new];
                [self.navigationController pushViewController:transationVC animated:YES];
            }
                break;
                
            case 1:
            {
                MyTransationController *myTransationVC = [MyTransationController new];
                [self.navigationController pushViewController:myTransationVC animated:YES];
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
                NestedSelectStateController *selectedVC = [NestedSelectStateController new];
                [self.navigationController pushViewController:selectedVC animated:YES];

            }
                break;
                
            default:
                break;
        }
    }];
    cell.homeModel = self.homePageModel;
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
