//
//  NoDataView.h
//  pairearch_WLY
//
//  Created by Jean on 2017/12/29.
//  Copyright © 2017年 Leo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NoDataView : UIView

@property (weak, nonatomic) IBOutlet UIImageView *imgView;

@property (weak, nonatomic) IBOutlet UILabel *textLabel;

//初始化视图
+ (instancetype)getPlaceHoldViewWithImgName:(NSString *)imgName titleText:(NSString *)titleText;

@end
