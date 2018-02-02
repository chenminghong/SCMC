//
//  OrderStatus150Cell.h
//  pairearch_WLY
//
//  Created by Jean on 2017/12/8.
//  Copyright © 2017年 Leo. All rights reserved.
//

#import <UIKit/UIKit.h>

@class NestedSelectModel;

@interface OrderStatus150Cell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIButton *tuNumberButton;
@property (weak, nonatomic) IBOutlet UIImageView *qrcodeImgView;
@property (weak, nonatomic) IBOutlet UILabel *statusDescriptionLabel;

@property (nonatomic, strong) NestedSelectModel *selectedModel;

+ (instancetype)getCellWithTable:(UITableView *)table indexPath:(NSIndexPath *)indexPath;

@end
