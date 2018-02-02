//
//  QrcodeHelper.h
//  pairearch_WLY
//
//  Created by Jean on 2017/8/17.
//  Copyright © 2017年 Leo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QrcodeHelper : NSObject


/**
 生成带有中间Logo的二维码

 @param message 当前二维码包含的信息
 @param logoImage 二维码中间的Logo信息
 @param imageSize 需要生成的图片的长或者宽
 @return 返回生成的中间带Logo的二维码图片
 */
+ (UIImage *)createLogoQrcodeImageWithMessage:(NSString *)message logoImage:(UIImage *)logoImage imageSize:(CGFloat)imageSize;


/**
 根据给予的信息生成中间带Logo的图片

 @param message 需要生成的二维码信息
 @param logoImage 需要嵌套的logo图片
 @param imageSize 需要生成的二维码图片大小
 @param drawColor 需要生成的二维码图片颜色
 @return 生成的二维码图片
 */
+ (UIImage *)creatCustomColorShadowLogoImageWithMessage:(NSString *)message logoImage:(UIImage *)logoImage imageSize:(CGFloat)imageSize drawColor:(UIColor *)drawColor;


/**
 生成条形码

 @param code 需要生成条形码的内容
 @param size 生成的条形码的大小
 @param color 生成的条形码的颜色
 @param backGroundColor 生成的条形码的背景颜色
 @return 生成的条形码图片的对象
 */
+ (UIImage *)generateBarCode:(NSString *)code size:(CGSize)size color:(UIColor *)color backGroundColor:(UIColor *)backGroundColor;

@end
