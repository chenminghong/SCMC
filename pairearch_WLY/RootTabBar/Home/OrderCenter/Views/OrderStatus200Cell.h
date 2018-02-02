//
//  OrderStatus200Cell.h
//  pairearch_WLY
//
//  Created by Jean on 2017/12/8.
//  Copyright © 2017年 Leo. All rights reserved.
//

#import <UIKit/UIKit.h>

@class NestedSelectModel;

@interface OrderStatus200Cell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIButton *tuNumberButton;
@property (weak, nonatomic) IBOutlet CustomVerticalButton *photoImgButton;
@property (weak, nonatomic) IBOutlet UILabel *statusDescriptionLabel;
@property (weak, nonatomic) IBOutlet UIButton *takeRegistrationBtn;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *failBtnTopConstant;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *failBtnHeightConstant;

@property (nonatomic, strong) NestedSelectModel *selectedModel;

+ (instancetype)getCellWithTable:(UITableView *)table indexPath:(NSIndexPath *)indexPath;

@end
