//
//  DifferentWarehousesCell.m
//  pairearch_WLY
//
//  Created by Jean on 2017/12/7.
//  Copyright © 2017年 Leo. All rights reserved.
//

#import "DifferentWarehousesCell.h"

#import "NestedSelectModel.h"

@implementation DifferentWarehousesCell

- (void)setFrame:(CGRect)frame {
    frame.origin.x += 10;
    frame.size.width -= 20;
    [super setFrame:frame];
}

+ (instancetype)getCellWithTable:(UITableView *)table indexPath:(NSIndexPath *)indexPath {
    DifferentWarehousesCell *cell = [table dequeueReusableCellWithIdentifier:@"DifferentWarehousesCell"];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"DifferentWarehousesCell" owner:self options:nil] firstObject];
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
    if (selectedModel.processList.count <= 0) {
        return;
    }
    
    for (id statusCode in selectedModel.processList) {
        if ([statusCode integerValue] == ORDER_STATUS_115) {
//            NSString *statusStr = selectedModel.processList[0];
            NSDictionary *paraDict = @{@"tuCode":self.selectedModel.tuCode,
                                       @"process":@"115",
                                       @"driverTel":[LoginModel shareLoginModel].phone};
            NSData *jsonData = [NSJSONSerialization dataWithJSONObject:paraDict options:0 error:nil];
            NSString *paraStr = [jsonData base64EncodedStringWithOptions:0];
            UIImage *qrcodeImage = [QrcodeHelper createLogoQrcodeImageWithMessage:paraStr logoImage:[UIImage imageNamed:@"applogo"] imageSize:self.qrcodeImgView.bounds.size.width];
            self.qrcodeImgView.image = qrcodeImage;
            break;
        }
    }
    
    UIImage *qrcodeImage = [QrcodeHelper generateBarCode:selectedModel.tuCode.length>0? selectedModel.tuCode:@"1234567890" size:self.yiweimaImgV.bounds.size color:[UIColor blackColor] backGroundColor:[UIColor whiteColor]];
    self.yiweimaImgV.image = qrcodeImage;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
