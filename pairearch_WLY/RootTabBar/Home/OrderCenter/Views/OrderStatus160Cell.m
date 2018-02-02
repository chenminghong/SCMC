//
//  OrderStatus160Cell.m
//  pairearch_WLY
//
//  Created by Jean on 2017/12/8.
//  Copyright © 2017年 Leo. All rights reserved.
//

#import "OrderStatus160Cell.h"

#import "NestedSelectModel.h"

@implementation OrderStatus160Cell

- (void)setFrame:(CGRect)frame {
    frame.origin.x += 10;
    frame.size.width -= 20;
    [super setFrame:frame];
}

+ (instancetype)getCellWithTable:(UITableView *)table indexPath:(NSIndexPath *)indexPath {
    OrderStatus160Cell *cell = [table dequeueReusableCellWithIdentifier:@"OrderStatus160Cell"];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"OrderStatus160Cell" owner:self options:nil] firstObject];
    }
    cell.layer.masksToBounds = YES;
    cell.layer.cornerRadius = 10;
    return cell;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    self.photoImgButton.layer.cornerRadius = 8;
    self.takeRegistrationBtn.layer.cornerRadius = 5.0;
}

- (void)setSelectedModel:(NestedSelectModel *)selectedModel {
    _selectedModel = selectedModel;
    
    [self.tuNumberButton setTitle:selectedModel.tuCode forState:UIControlStateNormal];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
