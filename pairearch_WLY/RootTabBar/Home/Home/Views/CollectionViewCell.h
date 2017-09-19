//
//  CollectionViewCell.h
//  pairearch_WLY
//
//  Created by Jean on 2017/8/14.
//  Copyright © 2017年 Leo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UILabel *countLabel;
@property (weak, nonatomic) IBOutlet UIImageView *iconImgView;
@property (weak, nonatomic) IBOutlet UILabel *centreTitleLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *countLabelWidth;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *imgViewWidth;

/**
 获取cell
 
 @param collectionView 需要添加cell的collectionView
 @param indexPath 当前的位置
 @return nib获取的cell
 */
+ (instancetype)getCellWithCollectionView:(UICollectionView *)collectionView indexPath:(NSIndexPath *)indexPath;

@end
