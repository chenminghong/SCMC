//
//  DifferentWarehousesCell.h
//  pairearch_WLY
//
//  Created by Jean on 2017/12/7.
//  Copyright © 2017年 Leo. All rights reserved.
//

#import <UIKit/UIKit.h>

@class NestedSelectModel;

@interface DifferentWarehousesCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIButton *tuNumberButton;
@property (weak, nonatomic) IBOutlet UILabel *qrcodeAddLabel;
@property (weak, nonatomic) IBOutlet UIImageView *qrcodeImgView;
@property (weak, nonatomic) IBOutlet UILabel *photoAddLabel;
@property (weak, nonatomic) IBOutlet CustomVerticalButton *photoImgButton;
@property (weak, nonatomic) IBOutlet UIImageView *yiweimaImgV;
@property (nonatomic, strong) NestedSelectModel *selectedModel;

+ (instancetype)getCellWithTable:(UITableView *)table indexPath:(NSIndexPath *)indexPath;

@end
