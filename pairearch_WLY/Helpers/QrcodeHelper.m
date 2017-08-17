//
//  QrcodeHelper.m
//  pairearch_WLY
//
//  Created by Jean on 2017/8/17.
//  Copyright © 2017年 Leo. All rights reserved.
//

#import "QrcodeHelper.h"

@implementation QrcodeHelper

+ (UIImage *)createLogoQrcodeImageWithMessage:(nonnull NSString *)message logoImage:(nullable UIImage *)logoImage imageSize:(CGFloat)imageSize {
    CIImage *outputImage = [self createQRForString:message];
    UIImage *tempImage = [UIImage imageWithCIImage:outputImage];
    CGFloat scale = imageSize / tempImage.size.width;
    outputImage = [outputImage imageByApplyingTransform:CGAffineTransformMakeScale(scale, scale)];
    UIImage *image = [UIImage imageWithCIImage:outputImage];
    
    // 为二维码加自定义图片
    CGFloat imgW = image.size.width;
    CGFloat imgH = image.size.height;
    UIGraphicsBeginImageContextWithOptions(image.size, 0, [UIScreen mainScreen].scale);
    [image drawInRect:CGRectMake(0, 0, imgW, imgH)];
    if (logoImage) {
        [logoImage drawInRect:CGRectMake(imgW * 2 / 5.0, imgH * 2 / 5.0, imgW/5.0, imgH/5.0)];
    }
    UIImage *finalImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return finalImage;
}

+ (UIImage *)creatCustomColorShadowLogoImageWithMessage:(NSString *)message logoImage:(UIImage *)logoImage imageSize:(CGFloat)imageSize drawColor:(UIColor *)drawColor {
    CIImage *outputImage = [self createQRForString:message];
    UIImage *qrcode = [self createNonInterpolatedUIImageFormCIImage:outputImage withSize:imageSize];
    UIImage *customQrcode = [self imageBlackToTransparent:qrcode color:drawColor];
    if (logoImage) {
        // 为二维码加自定义图片
        UIGraphicsBeginImageContextWithOptions(customQrcode.size, 0, [UIScreen mainScreen].scale);
        [customQrcode drawInRect:CGRectMake(0, 0, customQrcode.size.width, customQrcode.size.height)];
        [logoImage drawInRect:CGRectMake((customQrcode.size.width * 4 / 5.0) / 2, (customQrcode.size.height * 4 / 5.0) / 2, customQrcode.size.width/5.0, customQrcode.size.height/5.0)];
        UIImage *finalImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        return finalImage;
    }
    return customQrcode;
}

#pragma mark - QRCodeGenerator

/**
 根据给予的信息生成对应的原始二维码图片
 
 @param qrString 需要包含在二维码中的信息
 @return 返回生成的原始二维码图片
 */
+ (CIImage *)createQRForString:(NSString *)qrString {
    // 二维码过滤器
    CIFilter *filterImage = [CIFilter filterWithName:@"CIQRCodeGenerator"];
    // 将二位码过滤器设置为默认属性
    [filterImage setDefaults];
    // 将文字转化为二进制
    NSData *dataImage = [qrString dataUsingEncoding:NSUTF8StringEncoding];
    // KVC 赋值
    [filterImage setValue:dataImage forKey:@"inputMessage"];
    [filterImage setValue:@"M" forKey:@"inputCorrectionLevel"];
    return [filterImage outputImage];
}



/**
 给二维码添加背景阴影

 @param image 需要添加阴影的背景图片
 @param size 需要生成的图片的大小
 @return 返回处理过后的图片
 */
+ (UIImage *)createNonInterpolatedUIImageFormCIImage:(CIImage *)image withSize:(CGFloat) size {
    CGRect extent = CGRectIntegral(image.extent);
    CGFloat scale = MIN(size/CGRectGetWidth(extent), size/CGRectGetHeight(extent));
    // create a bitmap image that we'll draw into a bitmap context at the desired size;
    size_t width = CGRectGetWidth(extent) * scale;
    size_t height = CGRectGetHeight(extent) * scale;
    CGColorSpaceRef cs = CGColorSpaceCreateDeviceGray();
    CGContextRef bitmapRef = CGBitmapContextCreate(nil, width, height, 8, 0, cs, (CGBitmapInfo)kCGImageAlphaNone);
    CIContext *context = [CIContext contextWithOptions:nil];
    CGImageRef bitmapImage = [context createCGImage:image fromRect:extent];
    CGContextSetInterpolationQuality(bitmapRef, kCGInterpolationNone);
    CGContextScaleCTM(bitmapRef, scale, scale);
    CGContextDrawImage(bitmapRef, extent, bitmapImage);
    // Create an image with the contents of our bitmap
    CGImageRef scaledImage = CGBitmapContextCreateImage(bitmapRef);
    // Cleanup
    CGContextRelease(bitmapRef);
    CGImageRelease(bitmapImage);
    return [UIImage imageWithCGImage:scaledImage];
}

/**
 图片背景阴影虚化并设置二维码颜色

 @param image 需要处理的二维码图片
 @param red Red颜色值
 @param green Green颜色值
 @param blue Blue颜色值
 @return 返回处理过后的图片
 */
+ (UIImage *)imageBlackToTransparent:(UIImage *)image color:(UIColor *)color {
    const int imageWidth = image.size.width;
    const int imageHeight = image.size.height;
    size_t bytesPerRow = imageWidth * 4;
    uint32_t *rgbImageBuf = (uint32_t *)malloc(bytesPerRow * imageHeight);
    // create context
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGContextRef context = CGBitmapContextCreate(rgbImageBuf, imageWidth, imageHeight, 8, bytesPerRow, colorSpace,
                                                 kCGBitmapByteOrder32Little | kCGImageAlphaNoneSkipLast);
    CGContextDrawImage(context, CGRectMake(0, 0, imageWidth, imageHeight), image.CGImage);
    // traverse pixe
    int pixelNum = imageWidth * imageHeight;
    uint32_t *pCurPtr = rgbImageBuf;
    const CGFloat *components = CGColorGetComponents(color.CGColor);
    for (int i = 0; i < pixelNum; i++, pCurPtr++){
        if ((*pCurPtr & 0xFFFFFF00) < 0x99999900){
            // change color
            uint8_t *ptr = (uint8_t *)pCurPtr;
            ptr[3] = components[0] * 255; //0~255
            ptr[2] = components[1] * 255;
            ptr[1] = components[3] * 255;
        }else{
            uint8_t *ptr = (uint8_t*)pCurPtr;
            ptr[0] = 0;
        }
    }
    // context to image
    CGDataProviderRef dataProvider = CGDataProviderCreateWithData(NULL, rgbImageBuf, bytesPerRow * imageHeight, providerReleaseData);
    CGImageRef imageRef = CGImageCreate(imageWidth, imageHeight, 8, 32, bytesPerRow, colorSpace,
                                        kCGImageAlphaLast | kCGBitmapByteOrder32Little, dataProvider,
                                        NULL, true, kCGRenderingIntentDefault);
    CGDataProviderRelease(dataProvider);
    UIImage *resultUIImage = [UIImage imageWithCGImage:imageRef];
    // release
    CGImageRelease(imageRef);
    CGContextRelease(context);
    CGColorSpaceRelease(colorSpace);
    return resultUIImage;
}

#pragma mark - imageToTransparent
void providerReleaseData (void *info, const void *data, size_t size){
    free((void *)data);
}

@end
