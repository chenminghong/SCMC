//
//  TransferBidListCell.m
//  pairearch_WLY
//
//  Created by Jean on 2017/9/21.
//  Copyright © 2017年 Leo. All rights reserved.
//

#import "TransferBidListCell.h"

@implementation TransferBidListCell

//加载cell
+ (instancetype)getCellWithTable:(UITableView *)table  indexPath:(NSIndexPath *)indexPath {
    TransferBidListCell *cell = [table dequeueReusableCellWithIdentifier:@"TransferBidListCell"];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"TransferBidListCell" owner:self options:nil] firstObject];
    }
    return cell;
}

- (void)setFrame:(CGRect)frame {
    frame.origin.y += 20;
    frame.size.height -= 20;
    [super setFrame:frame];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    self.loadNumberLabel.textColor = UIColorFromRGB(0x666666);
    self.resultLabel.textColor = UIColorFromRGB(0xc0022e);
    self.latestLoadtimeLabel.textColor = UIColorFromRGB(0x666666);
    self.weightLabel.textColor = UIColorFromRGB(0x666666);
    self.totalPriceLabel.textColor = UIColorFromRGB(0x666666);
    self.fromNameLabel.textColor = UIColorFromRGB(0x4d4d4d);
    self.fromAddressLabel.textColor = UIColorFromRGB(0x808080);
    self.toNameLabel.textColor = UIColorFromRGB(0x4d4d4d);
    self.toAddressLabel.textColor = UIColorFromRGB(0x808080);
    [self.fromButton setBackgroundImage:[UIImage imageNamed:@"zhuanghuo"] forState:UIControlStateNormal];
    [self.toButton setBackgroundImage:[UIImage imageNamed:@"xiehuo"] forState:UIControlStateNormal];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
