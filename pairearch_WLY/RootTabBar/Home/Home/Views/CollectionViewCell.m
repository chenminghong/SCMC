//
//  CollectionViewCell.m
//  pairearch_WLY
//
//  Created by Jean on 2017/8/14.
//  Copyright © 2017年 Leo. All rights reserved.
//

#import "CollectionViewCell.h"

#import "HomePageModel.h"

@implementation CollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    self.clipsToBounds = NO;
    
    CGFloat countLabelWidth = kScreenWidth * 86.0 / 640.0;
    self.countLabelWidth.constant = countLabelWidth;
    
    CGFloat scale = 1.0 - (240.0 / (640 - 35));
    CGFloat firstItemWidth = (kScreenWidth - 35.0) * scale;
    self.imgViewWidth.constant = firstItemWidth * 76.0 / 330;
    
    self.countLabel.layer.masksToBounds = YES;
    self.countLabel.layer.cornerRadius = countLabelWidth / 2.0;
    self.countLabel.backgroundColor = TOP_NAVIBAR_COLOR;
    
    [self.layer setMasksToBounds:YES];
    self.layer.cornerRadius = 5;
}



/**
 获取cell

 @param collectionView 需要添加cell的collectionView
 @param indexPath 当前的位置
 @return nib获取的cell
 */
+ (instancetype)getCellWithCollectionView:(UICollectionView *)collectionView indexPath:(NSIndexPath *)indexPath {
    CollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CollectionViewCell" forIndexPath:indexPath];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"CollectionViewCell" owner:self options:nil] firstObject];
    }
    
    NSArray *cellColorArr = @[UIColorFromRGB(0xe86e42),
                              UIColorFromRGB(0x54b8be),
                              UIColorFromRGB(0x33a881),
                              UIColorFromRGB(0xe86783)];
    NSArray *titleArr = @[@"交易大厅",
                          @"我的交易",
                          @"待运送",
                          @"运送中"];
    NSArray *iconNameArr = @[@"keqiangdan",
                             @"qiangdanzhong",
                             @"daiyunsong",
                             @"yunsongzhong"];
    
    //设置阴影
    cell.layer.masksToBounds = NO;
    cell.layer.shadowColor = [UIColor blackColor].CGColor;
    cell.layer.shadowOffset = CGSizeMake(0.0f, 2.0f);
    cell.layer.shadowOpacity = 0.5f;
    cell.layer.shouldRasterize = YES;
    cell.layer.rasterizationScale = [UIScreen mainScreen].scale;
    cell.backgroundColor = cellColorArr[indexPath.item];
    cell.centreTitleLabel.text = titleArr[indexPath.item];
    cell.iconImgView.image = [UIImage imageNamed:iconNameArr[indexPath.item]];
    cell.indexPath = indexPath;
    return cell;
}

- (void)setHomeModel:(HomePageModel *)homeModel {
    _homeModel = homeModel;
    //给数量标签赋值
    if (self.indexPath.item == 0) {
        self.countLabel.text = homeModel.orderGradCount;
    } else if (self.indexPath.item == 1) {
        self.countLabel.text = homeModel.orderGradingCount;
    } else if (self.indexPath.item == 2) {
        self.countLabel.text = homeModel.orderWaitTransCount;
    } else {
        self.countLabel.text = homeModel.orderWaitTransingCount;
    }
}

@end
