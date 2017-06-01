//
//  MyImagePickerManager.m
//  pairearch_WLY
//
//  Created by Jean on 2017/5/31.
//  Copyright © 2017年 Leo. All rights reserved.
//

#import "MyImagePickerManager.h"

#import <Photos/Photos.h>

@implementation MyImagePickerManager

+ (void)presentImagePickerControllerInTarget:(UIViewController *)target finishPickingBlock:(void (^)(NSArray<UIImage *> *, NSArray *, BOOL))finishPickingBlock postUrlStr:(NSString *)urlStr paraDict:(NSDictionary *)paraDict endBlock:(void (^)(id responseObject, NSError *error))endBlock {
    //弹出选择相册
    TZImagePickerController *imagePickerVc = [[TZImagePickerController alloc] initWithMaxImagesCount:1 columnNumber:4 delegate:nil pushPhotoPickerVc:YES];
    [imagePickerVc.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:UIColorFromRGB(0x666666), NSFontAttributeName:[UIFont systemFontOfSize:18.0]}];
    imagePickerVc.navigationBar.barTintColor = TOP_BOTTOMBAR_COLOR;
    imagePickerVc.navigationBar.tintColor = UIColorFromRGB(0x666666);
    imagePickerVc.barItemTextFont = [UIFont systemFontOfSize:16.0];
    imagePickerVc.barItemTextColor = UIColorFromRGB(0x666666);
    imagePickerVc.alwaysEnableDoneBtn = NO;
    imagePickerVc.allowPreview = NO;
    imagePickerVc.allowPickingVideo = NO;
    imagePickerVc.allowPickingOriginalPhoto = NO;
    [target presentViewController:imagePickerVc animated:YES completion:nil];
    
    imagePickerVc.didFinishPickingPhotosHandle = ^(NSArray<UIImage *> *photos, NSArray *assets, BOOL isSelectOriginalPhoto) {
        if (finishPickingBlock) {
            finishPickingBlock(photos, assets, isSelectOriginalPhoto);
        }
        
        NSData *data = nil;
        NSString *photoTime = @"";
        if (photos.count > 0) {
            UIImage *image = photos[0];
            data = UIImageJPEGRepresentation(image, 0.4);
            NSLog(@"imageLength:%lu", data.length);
            
            NSDateFormatter *dateFormatter = [NSDateFormatter new];
            [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
            PHAsset *tempAsset = assets[0];
            photoTime = [dateFormatter stringFromDate:tempAsset.creationDate];
        }
        NSMutableDictionary *tempParaDict = [NSMutableDictionary dictionaryWithDictionary:paraDict];
        [tempParaDict setObject:photoTime forKey:@"photoTime"];
        [NetworkHelper POST:urlStr parameters:tempParaDict constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
            [formData appendPartWithFileData:data name:@"photo" fileName:@"abnormal_upload.jpg" mimeType:@"image/jpeg"];
        } progress:nil success:^(NSURLSessionDataTask *task, id responseObject) {
            if (endBlock) {
                endBlock(responseObject, nil);
            }
        } failure:^(NSError *error) {
            if (endBlock) {
                endBlock(nil, error);
            }
        }];
    };
}

@end
