//
//  WaitingListCell.h
//  pairearch_WLY
//
//  Created by Jean on 2017/12/29.
//  Copyright © 2017年 Leo. All rights reserved.
//

#import <UIKit/UIKit.h>

@class NestedSelectModel;

@interface WaitingListCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIButton *tuNumberButton;

@property (nonatomic, strong) NestedSelectModel *selectedModel;

+ (instancetype)getCellWithTable:(UITableView *)table indexPath:(NSIndexPath *)indexPath;

@end
