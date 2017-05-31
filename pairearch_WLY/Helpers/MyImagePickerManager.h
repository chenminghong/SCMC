//
//  MyImagePickerManager.h
//  pairearch_WLY
//
//  Created by Jean on 2017/5/31.
//  Copyright © 2017年 Leo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MyImagePickerManager : NSObject


/**
 进入图片选择器并选择照片

 @param target 主视图控制器
 @param finishPickingBlock 选择照片回调
 */
+ (void)presentImagePickerControllerInTarget:(UIViewController *)target finishPickingBlock:(void(^)(NSArray<UIImage *> *photos, NSArray *assets, BOOL isSelectOriginalPhoto))finishPickingBlock postUrlStr:(NSString *)urlStr paraDict:(NSDictionary *)paraDict endBlock:(void(^)(id responseObject, NSError *error))endBlock;

@end
