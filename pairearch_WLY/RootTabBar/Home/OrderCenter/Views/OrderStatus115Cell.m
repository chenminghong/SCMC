//
//  OrderStatus115Cell.m
//  pairearch_WLY
//
//  Created by Jean on 2017/12/8.
//  Copyright © 2017年 Leo. All rights reserved.
//

#import "OrderStatus115Cell.h"

#import "NestedSelectModel.h"

@implementation OrderStatus115Cell

- (void)setFrame:(CGRect)frame {
    frame.origin.x += 10;
    frame.size.width -= 20;
    [super setFrame:frame];
}

+ (instancetype)getCellWithTable:(UITableView *)table indexPath:(NSIndexPath *)indexPath {
    OrderStatus115Cell *cell = [table dequeueReusableCellWithIdentifier:@"OrderStatus115Cell"];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"OrderStatus115Cell" owner:self options:nil] firstObject];
    }
    cell.layer.masksToBounds = YES;
    cell.layer.cornerRadius = 10;
    return cell;
}

- (void)setSelectedModel:(NestedSelectModel *)selectedModel {
    _selectedModel = selectedModel;
    
    [self.tuNumberButton setTitle:selectedModel.tuCode forState:UIControlStateNormal];
    if (selectedModel.processList.count <= 0) {
        return;
    }
    NSString *statusStr = selectedModel.processList[0];
    NSDictionary *paraDict = @{@"tuCode":self.selectedModel.tuCode,
                               @"process":statusStr,
                               @"driverTel":[LoginModel shareLoginModel].phone};
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:paraDict options:0 error:nil];
    NSString *paraStr = [jsonData base64EncodedStringWithOptions:0];
    self.qrcodeImgView.image = [QrcodeHelper createLogoQrcodeImageWithMessage:paraStr logoImage:[UIImage imageNamed:@"applogo"] imageSize:self.qrcodeImgView.bounds.size.width];
    self.orderCountLabel.text = [NSString stringWithFormat:@"运单数量：%@", selectedModel.orderCount];
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
