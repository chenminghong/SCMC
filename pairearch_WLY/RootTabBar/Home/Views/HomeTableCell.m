//
//  HomeTableCell.m
//  pairearch_WLY
//
//  Created by Leo on 2017/2/27.
//  Copyright © 2017年 Leo. All rights reserved.
//

#import "HomeTableCell.h"

#import "HomePageModel.h"

@implementation HomeTableCell

- (void)setFrame:(CGRect)frame {
    frame.origin.x += 10;
    frame.origin.y += 10;
    frame.size.width -= 20;
    frame.size.height -= 20;
    [super setFrame:frame];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    self.startAssortLabel.layer.masksToBounds = YES;
    self.startAssortLabel.layer.cornerRadius = CGRectGetWidth(self.startAssortLabel.bounds)/2.0;
    self.startAssortLabel.layer.borderWidth = 1.0;
    self.startAssortLabel.layer.borderColor = MAIN_THEME_COLOR.CGColor;
    
    self.endAssortLabel.layer.masksToBounds = YES;
    self.endAssortLabel.layer.cornerRadius = CGRectGetWidth(self.endAssortLabel.bounds)/2.0;
    self.endAssortLabel.layer.borderWidth = 1.0;
    self.endAssortLabel.layer.borderColor = MAIN_THEME_COLOR.CGColor;
    
    [self.layer setMasksToBounds:YES];
    self.layer.cornerRadius = 5;
}

//加载cell
+ (instancetype)getCellWithTable:(UITableView *)table {
    HomeTableCell *cell = [table dequeueReusableCellWithIdentifier:@"HomeTableCell"];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"HomeTableCell" owner:self options:nil] firstObject];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    //设置阴影
    cell.layer.masksToBounds = NO;
    cell.layer.shadowColor = [UIColor blackColor].CGColor;
    cell.layer.shadowOffset = CGSizeMake(0.0f, 2.0f);
    cell.layer.shadowOpacity = 0.5f;
    cell.layer.shouldRasterize = YES;
    cell.layer.rasterizationScale = [UIScreen mainScreen].scale;
    return cell;
}

- (void)setHomeModel:(HomePageModel *)homeModel {
    _homeModel = homeModel;
//    if ([homeModel.TRANSPORT_CODE isEqualToString:ORDER_TYPE_KA]) {
//        self.assortLabel.text = @"KA";
//    } else if ([homeModel.TRANSPORT_CODE isEqualToString:ORDER_TYPE_BACK]) {
//        self.assortLabel.text = @"回";
//    } else if ([homeModel.TRANSPORT_CODE isEqualToString:ORDER_TYPE_COMMON]) {
//        self.assortLabel.text = @"常";
//    }
//    
//    self.loadNumberLabel.text = [NSString stringWithFormat:@"负载单号：%@", homeModel.CODE];
//    self.loadAddressLabel.text = [NSString stringWithFormat:@"收货地址：%@", homeModel.DC_ADDRESS];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
