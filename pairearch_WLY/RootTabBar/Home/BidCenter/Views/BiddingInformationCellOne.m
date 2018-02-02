//
//  BiddingInformationCellOne.m
//  pairearch_WLY
//
//  Created by Jean on 2017/9/22.
//  Copyright © 2017年 Leo. All rights reserved.
//

#import "BiddingInformationCellOne.h"

@implementation BiddingInformationCellOne

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    self.separatorViewOne.backgroundColor = TABLE_SEPARATOR_COLOR;
    self.separatorViewOne.alpha = 0.4;
    self.separatorViewTwo.backgroundColor = TABLE_SEPARATOR_COLOR;
    self.separatorViewTwo.alpha = 0.4;
}

+ (instancetype)getListCellWithTable:(UITableView *)table indexPath:(NSIndexPath *)indexPath  {
    BiddingInformationCellOne *cell = [table dequeueReusableCellWithIdentifier:@"BiddingInformationCellOne"];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"BiddingInformationCellOne" owner:self options:nil] firstObject];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
