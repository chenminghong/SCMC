//
//  WaitingListCell.m
//  pairearch_WLY
//
//  Created by Jean on 2017/12/29.
//  Copyright © 2017年 Leo. All rights reserved.
//

#import "WaitingListCell.h"

#import "NestedSelectModel.h"

@implementation WaitingListCell

- (void)setFrame:(CGRect)frame {
    frame.origin.x += 10;
    frame.size.width -= 20;
    [super setFrame:frame];
}

+ (instancetype)getCellWithTable:(UITableView *)table indexPath:(NSIndexPath *)indexPath {
    WaitingListCell *cell = [table dequeueReusableCellWithIdentifier:@"WaitingListCell"];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"WaitingListCell" owner:self options:nil] firstObject];
    }
    cell.layer.masksToBounds = YES;
    cell.layer.cornerRadius = 10;
    return cell;
}

- (void)setSelectedModel:(NestedSelectModel *)selectedModel {
    _selectedModel = selectedModel;
    
    [self.tuNumberButton setTitle:selectedModel.tuCode forState:UIControlStateNormal];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
