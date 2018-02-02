//
//  OrderStatus140Cell.m
//  pairearch_WLY
//
//  Created by Jean on 2017/12/8.
//  Copyright © 2017年 Leo. All rights reserved.
//

#import "OrderStatus140Cell.h"

#import "NestedSelectModel.h"

@implementation OrderStatus140Cell

- (void)setFrame:(CGRect)frame {
    frame.origin.x += 10;
    frame.size.width -= 20;
    [super setFrame:frame];
}

+ (instancetype)getCellWithTable:(UITableView *)table indexPath:(NSIndexPath *)indexPath {
    OrderStatus140Cell *cell = [table dequeueReusableCellWithIdentifier:@"OrderStatus140Cell"];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"OrderStatus140Cell" owner:self options:nil] firstObject];
    }
    cell.layer.masksToBounds = YES;
    cell.layer.cornerRadius = 10;
    return cell;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    self.photoImgButton.layer.cornerRadius = 8;
}

- (void)setSelectedModel:(NestedSelectModel *)selectedModel {
    _selectedModel = selectedModel;
    [self.tuNumberButton setTitle:selectedModel.tuCode forState:UIControlStateNormal];
    if (selectedModel.wharfName.length > 0) {
        self.wharfLabel.hidden = NO;
        self.whartConstraint.constant = 40.0;
        NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"到达装货码头%@", selectedModel.wharfName]];
        NSRange range = NSMakeRange(string.length - selectedModel.wharfName.length, selectedModel.wharfName.length);
        [string setAttributes:@{NSForegroundColorAttributeName:[UIColor redColor], NSFontAttributeName:[UIFont systemFontOfSize:26.0]} range:range];
        self.wharfLabel.attributedText = string;
    } else {
        self.wharfLabel.text = selectedModel.wharfName;
        self.wharfLabel.hidden = YES;
        self.whartConstraint.constant = 0.0;
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
