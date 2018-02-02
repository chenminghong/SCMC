//
//  PressEnterCell.h
//  pairearch_WLY
//
//  Created by Jean on 2017/12/8.
//  Copyright © 2017年 Leo. All rights reserved.
//

#import <UIKit/UIKit.h>

@class NestedSelectModel;

@interface PressEnterCell : UITableViewCell

@property (weak, nonatomic) IBOutlet CustomHexagonLabel *topStatusLabel;
@property (weak, nonatomic) IBOutlet UILabel *wharfLabel;
@property (weak, nonatomic) IBOutlet UIImageView *qrcodeImgView;
@property (weak, nonatomic) IBOutlet UILabel *planEnterTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *pageDesLabel;
@property (weak, nonatomic) IBOutlet UIView *labelView;
@property (weak, nonatomic) IBOutlet UILabel *enterDesLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *enterDesConstant;

@property (nonatomic, strong) NestedSelectModel *selectedModel;

+ (instancetype)getCellWithTable:(UITableView *)table indexPath:(NSIndexPath *)indexPath;

@end
