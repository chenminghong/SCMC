//
//  HomeCollectionCell.h
//  pairearch_WLY
//
//  Created by Jean on 2017/8/14.
//  Copyright © 2017年 Leo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HomeCollectionCell : UITableViewCell<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;



/**
 获取cell

 @param tableView 需要显示cell的Table
 @param indexPath 当前cell的位置
 @return 返回获取的cell
 */
+ (instancetype)getCellWithTableView:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath;

@end
