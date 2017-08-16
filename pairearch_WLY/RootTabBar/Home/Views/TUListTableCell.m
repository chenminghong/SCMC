//
//  TUListTableCell.m
//  pairearch_WLY
//
//  Created by Jean on 2017/8/16.
//  Copyright © 2017年 Leo. All rights reserved.
//

#import "TUListTableCell.h"

@implementation TUListTableCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    self.isGetTULabel.textColor = UIColorFromRGB(0xe86e42);
    self.tuNumberLabel.textColor = UIColorFromRGB(0x4c4c4c);
    self.countLabel.textColor = UIColorFromRGB(0x4c4c4c);
    self.planTimeLabel.textColor = UIColorFromRGB(0x4c4c4c);
}

+ (instancetype)getListCellWithTable:(UITableView *)table indexPath:(NSIndexPath *)indexPath {
    TUListTableCell *cell = [table dequeueReusableCellWithIdentifier:@"TUListTableCell"];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"TUListTableCell" owner:self options:nil] firstObject];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
