//
//  HomeCollectionCell.m
//  pairearch_WLY
//
//  Created by Jean on 2017/8/14.
//  Copyright © 2017年 Leo. All rights reserved.
//

#import "HomeCollectionCell.h"

#import "CollectionViewCell.h"

#define LINE_HEIGHT (kScreenWidth * 584.0 / 640.0)

@implementation HomeCollectionCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    [self.collectionView registerNib:[UINib nibWithNibName:@"CollectionViewCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:@"CollectionViewCell"];
    
    self.collectionView.scrollEnabled = NO;
}

/**
 获取cell
 
 @param tableView 需要显示cell的Table
 @param indexPath 当前cell的位置
 @return 返回获取的cell
 */
+ (instancetype)getCellWithTableView:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath selectAction:(SelectCellBlock)selectAction {
    HomeCollectionCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HomeCollectionCell"];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"HomeCollectionCell" owner:self options:nil] firstObject];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.selectAction = selectAction;
    return cell;
}

#pragma mark -- UICollectionViewDelegateFlowLayout

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat scale = 240.0 / (640 - 35);
    if (indexPath.item % 2 == 0) {
        scale = 1.0 - scale;
    }
    CGSize size = CGSizeMake((kScreenWidth - 35.0) * scale, (LINE_HEIGHT - 120.0) / 2.0);
    NSLog(@"%@", [NSValue valueWithCGSize:size]);
    NSLog(@"%@", @(LINE_HEIGHT));
    return size;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(45, 10, 30, 10);
}

#pragma mark -- UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 4;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    CollectionViewCell *cell = [CollectionViewCell getCellWithCollectionView:collectionView indexPath:indexPath];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (self.selectAction) {
        self.selectAction(indexPath);
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
