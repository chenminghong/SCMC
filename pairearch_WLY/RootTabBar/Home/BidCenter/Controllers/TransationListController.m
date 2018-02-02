//
//  TransactionListController.m
//  pairearch_WLY
//
//  Created by Jean on 2017/9/21.
//  Copyright © 2017年 Leo. All rights reserved.
//

#import "TransationListController.h"

#import "TransationCollectionCell.h"
#import "OrderListModel.h"
#import "BiddingInformationController.h"

@interface TransationListController ()<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UIScrollViewDelegate>

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@property (weak, nonatomic) IBOutlet UIView *selectView;
@property (weak, nonatomic) IBOutlet UIView *separatorLineView;
@property (weak, nonatomic) IBOutlet UIView *separatorViewOne;
@property (nonatomic, strong) UIButton *selectedBtn;  //已经选中的Button

@end

@implementation TransationListController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.title = @"交易大厅";
    self.collectionView.backgroundColor = TABLE_BACKGROUND_COLOR;
    [self.collectionView registerNib:[UINib nibWithNibName:@"OrdersCollectionCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:@"OrdersCollectionCell"];
    self.separatorLineView.backgroundColor = TABLE_SEPARATOR_COLOR;
    self.separatorViewOne.backgroundColor = TABLE_SEPARATOR_COLOR;
    
    for (NSInteger i = 0; i < 2; i++) {
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

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    //刷新页面
//    [self.collectionView reloadData];
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
    return CGSizeMake([UIScreen mainScreen].bounds.size.width, ([UIScreen mainScreen].bounds.size.height - 64) * 866/926);
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 2;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    TransationCollectionCell *cell = [TransationCollectionCell getCellWithCollectionView:collectionView indexPath:indexPath pushBlock:^(id model) {
        NSLog(@"%@", model);
        BiddingInformationController *biddingInformationVC = [BiddingInformationController new];
        [self.navigationController pushViewController:biddingInformationVC animated:YES];
    }];
    cell.backgroundColor = TABLE_BACKGROUND_COLOR;
    cell.indexPath = indexPath;
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath NS_AVAILABLE_IOS(8_0) {
    TransationCollectionCell *tempCell = (TransationCollectionCell *)cell;
    [tempCell.listTableView reloadData];
//    [MJRefreshUtil begainRefresh:tempCell.listTableView];
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
