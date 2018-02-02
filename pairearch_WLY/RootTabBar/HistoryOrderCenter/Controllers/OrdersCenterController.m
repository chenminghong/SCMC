//
//  OrdersCenterController.m
//  pairearch_WLY
//
//  Created by Leo on 2017/2/15.
//  Copyright © 2017年 Leo. All rights reserved.
//

#import "OrdersCenterController.h"

#import "OrdersCollectionCell.h"
#import "OrderListModel.h"
#import "BiddingDetailController.h"
#import "BiddingCheckingController.h"
#import "GetBiddingDetailController.h"


@interface OrdersCenterController ()<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UIScrollViewDelegate>

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@property (weak, nonatomic) IBOutlet UIView *selectView;
@property (weak, nonatomic) IBOutlet UIView *separatorLineView;
@property (weak, nonatomic) IBOutlet UIView *separatorViewOne;
@property (weak, nonatomic) IBOutlet UIView *separatorViewTwo;

@property (nonatomic, strong) UIButton *selectedBtn;  //已经选中的Button

//@property (nonatomic, strong) UIView *markView; //按钮标记view

//@property (nonatomic, strong) NSMutableArray *reloadFlags;  //table刷新标识
//
//@property (nonatomic, strong) OrdersCollectionCell *currentCell;  //当前显示的cell

@end

@implementation OrdersCenterController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"历史运单";
    self.collectionView.backgroundColor = TABLE_BACKGROUND_COLOR;
    self.separatorLineView.backgroundColor = TABLE_SEPARATOR_COLOR;
    self.separatorViewOne.backgroundColor = TABLE_SEPARATOR_COLOR;
    self.separatorViewTwo.backgroundColor = TABLE_SEPARATOR_COLOR;
    
    for (NSInteger i = 0; i < 3; i++) {
        [self.collectionView registerClass:[OrdersCollectionCell class] forCellWithReuseIdentifier:[NSString stringWithFormat:@"cell%ld", i]];
    }
    
    for (NSInteger i = 0; i < 3; i++) {
        UIButton *btn = (UIButton *)[self.selectView viewWithTag:(100 + i)];
        [btn setTitleColor:UIColorFromRGB(0x666666) forState:UIControlStateNormal];
        [btn setTitleColor:UIColorFromRGB(0xc0022e) forState:UIControlStateSelected];
        if (i == 0) {
            btn.selected = YES;
            self.selectedBtn = btn;
        } else {
            btn.selected = NO;
        }
    }
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    //刷新页面
    [self.collectionView reloadData];
}

#pragma mark -- ButtonActions
- (IBAction)selectButtonAction:(UIButton *)sender {
    if (self.selectedBtn != sender) {
        self.selectedBtn.selected = NO;
        sender.selected = YES;
        self.selectedBtn = sender;
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:(sender.tag - 100) inSection:0];
        [self.collectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];
    }
}

#pragma mark -- CommoMethods

#pragma mark -- DelegateMethods

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake([UIScreen mainScreen].bounds.size.width, ([UIScreen mainScreen].bounds.size.height - 64 - 47) * 866.0/926.0);
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 3;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    OrdersCollectionCell *cell = [OrdersCollectionCell getCellWithCollectionView:collectionView indexPath:indexPath pushBlock:^(NSArray *selectModelArr, NSIndexPath *indexPath) {
        if (indexPath.item == 0) {
            
        } else if (indexPath.item == 1) {
            
        } else {
            
        }
    }];
    cell.backgroundColor = TABLE_BACKGROUND_COLOR;
    cell.indexPath = indexPath;
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath NS_AVAILABLE_IOS(8_0) {
    OrdersCollectionCell *tempCell = (OrdersCollectionCell *)cell;
    if (indexPath.item == 2) {
        [MJRefreshUtil begainRefresh:tempCell.listTableView];
    } else {
        [tempCell.listTableView reloadData];
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    if (scrollView == self.collectionView) {
        NSInteger index = (NSInteger)(scrollView.contentOffset.x / [UIScreen mainScreen].bounds.size.width);
        UIButton *btn = (UIButton *)[self.selectView viewWithTag:(100 + index)];
        if (index + 100 == btn.tag) {
            [self selectButtonAction:btn];
        }
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
