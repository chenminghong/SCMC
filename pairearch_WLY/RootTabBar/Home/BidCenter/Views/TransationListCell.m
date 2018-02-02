//
//  TransationListCell.m
//  pairearch_WLY
//
//  Created by Jean on 2017/9/21.
//  Copyright © 2017年 Leo. All rights reserved.
//

#import "TransationListCell.h"

@implementation TransationListCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    self.loadNumberLabel.textColor = UIColorFromRGB(0x666666);
    self.latestLoadtimeLabel.textColor = UIColorFromRGB(0x666666);
    self.weightLabel.textColor = UIColorFromRGB(0x666666);
    self.fromNameLabel.textColor = UIColorFromRGB(0x4d4d4d);
    self.fromAddressLabel.textColor = UIColorFromRGB(0x808080);
    self.toNameLabel.textColor = UIColorFromRGB(0x4d4d4d);
    self.toAddressLabel.textColor = UIColorFromRGB(0x808080);
    [self.fromButton setBackgroundImage:[UIImage imageNamed:@"zhuanghuo"] forState:UIControlStateNormal];
    [self.toButton setBackgroundImage:[UIImage imageNamed:@"xiehuo"] forState:UIControlStateNormal];
    self.immediatelyOfferBtn.layer.masksToBounds = YES;
    self.immediatelyOfferBtn.layer.cornerRadius = 5;
}

- (void)setFrame:(CGRect)frame {
    frame.origin.y += 20;
    frame.size.height -= 20;
    [super setFrame:frame];
}

//加载cell
+ (instancetype)getCellWithTable:(UITableView *)table  indexPath:(NSIndexPath *)indexPath offerButtonAction:(OfferButtonActionBlock)offerButtonAction {
    TransationListCell *cell = [table dequeueReusableCellWithIdentifier:@"TransationListCell"];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"TransationListCell" owner:self options:nil] firstObject];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.offerButtonAction = offerButtonAction;
    return cell;
}

//立即报价按钮点击事件
- (IBAction)offerButtonAction:(UIButton *)sender {
    if (self.offerButtonAction) {
        self.offerButtonAction(self.indexPath);
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
