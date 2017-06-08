//
//  MyImagePickerManager.m
//  pairearch_WLY
//
//  Created by Jean on 2017/5/31.
//  Copyright © 2017年 Leo. All rights reserved.
//

#import "MyImagePickerManager.h"

#import <Photos/Photos.h>
#import <TZImageManager.h>

@implementation MyImagePickerManager

/**
 初始化
 
 @return 返回当前定位上传助手对象
 */
+ (instancetype)shareManager {
    static MyImagePickerManager *sharedManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedManager = [MyImagePickerManager new];
    });
    return sharedManager;
}

- (UIImagePickerController *)imagePickerVC {
    if (!_imagePickerVC) {
        _imagePickerVC = [[UIImagePickerController alloc] init];
        _imagePickerVC.delegate = self;
        // set appearance / 改变相册选择页的导航栏外观
        UIBarButtonItem *tzBarItem, *BarItem;
        if (iOS9Later) {
            tzBarItem = [UIBarButtonItem appearanceWhenContainedInInstancesOfClasses:@[[TZImagePickerController class]]];
            BarItem = [UIBarButtonItem appearanceWhenContainedInInstancesOfClasses:@[[UIImagePickerController class]]];
        } else {
            tzBarItem = [UIBarButtonItem appearanceWhenContainedInInstancesOfClasses:@[[TZImagePickerController class]]];
            BarItem = [UIBarButtonItem appearanceWhenContainedInInstancesOfClasses:@[[UIImagePickerController class]]];
        }
        NSDictionary *titleTextAttributes = [tzBarItem titleTextAttributesForState:UIControlStateNormal];
        [BarItem setTitleTextAttributes:titleTextAttributes forState:UIControlStateNormal];
    }
    return _imagePickerVC;
}


+ (MyImagePickerManager *)presentPhotoTakeControllerInTarget:(UIViewController *)target finishPickingBlock:(FinishPickerBlock)finishPickerBlock postUrlStr:(NSString *)urlStr paraDict:(NSDictionary *)paraDict endBlock:(void (^)(id responseObject, NSError *error))endBlock {
    MyImagePickerManager *manager = [self shareManager];
    manager.target = target;
    manager.imagePickerVC.navigationBar.barTintColor = target.navigationController.navigationBar.barTintColor;
    manager.imagePickerVC.navigationBar.tintColor = target.navigationController.navigationBar.tintColor;
    manager.finishPickerBlock = finishPickerBlock;
    manager.finishPostBlock = endBlock;
    manager.urlStr = urlStr;
    manager.paraDict = paraDict;
    [manager takePhotoWithTarget:target];
    return manager;
}

#pragma mark - UIImagePickerController
//拍照
- (void)takePhotoWithTarget:(UIViewController *)target {
    AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    if ((authStatus == AVAuthorizationStatusRestricted || authStatus == AVAuthorizationStatusDenied) && iOS7Later) {
        // 无相机权限 做一个友好的提示
        // 拍照之前还需要检查相册权限
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"无法使用相机" message:@"请在iPhone的""设置-隐私-相机""中允许访问相机" preferredStyle:UIAlertControllerStyleActionSheet];
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        }];
        
        [alertController addAction:action];
        [target presentViewController:alertController animated:YES completion:nil];
        
    } else if ([[TZImageManager manager] authorizationStatus] == 2) { // 已被拒绝，没有相册权限，将无法保存拍的照片
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"无法访问相册" message:@"请在iPhone的""设置-隐私-相册""中允许访问相册" preferredStyle:UIAlertControllerStyleActionSheet];
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        }];
        
        [alertController addAction:action];
        [target presentViewController:alertController animated:YES completion:nil];
    } else if ([[TZImageManager manager] authorizationStatus] == 0) { // 正在弹框询问用户是否允许访问相册，监听权限状态
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            return [self takePhotoWithTarget:target];
        });
    } else { // 调用相机
        UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypeCamera;
        if ([UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypeCamera]) {
            self.imagePickerVC.sourceType = sourceType;
            if(iOS8Later) {
                _imagePickerVC.modalPresentationStyle = UIModalPresentationOverCurrentContext;
            }
            [target presentViewController:self.imagePickerVC animated:YES completion:nil];
        } else {
            NSLog(@"模拟器中无法打开照相机，请在真机中使用");
        }
    }
}

/**
 拍照结束回调
 
 @param picker imagepickerVC对象
 @param info 拍照获取的资源
 */
- (void)imagePickerController:(UIImagePickerController*)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    if (self.finishPickerBlock) {
        self.finishPickerBlock(info);
    }
    NSString *type = [info objectForKey:UIImagePickerControllerMediaType];
    if ([type isEqualToString:@"public.image"]) {
        
//        [picker dismissViewControllerAnimated:YES completion:^{
//            // save photo and get asset / 保存图片，获取到asset
//            UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
//            [[TZImageManager manager] savePhotoWithImage:image completion:^(NSError *error){
//                if (error) {
//                    NSLog(@"图片保存失败 %@",error);
//                } else {
//                    TZImageManager *manager = [TZImageManager manager];
//                    [[TZImageManager manager] getCameraRollAlbum:NO allowPickingImage:YES completion:^(TZAlbumModel *model) {
//                        [[TZImageManager manager] getAssetsFromFetchResult:model.result allowPickingVideo:NO allowPickingImage:YES completion:^(NSArray<TZAssetModel *> *models) {
//                            TZAssetModel *assetModel = [models firstObject];
//                            if (manager.sortAscendingByModificationDate) {
//                                assetModel = [models lastObject];
//                            }
//                            NSData *data = UIImageJPEGRepresentation(image, 0.4);
//                            NSLog(@"length:%lu", data.length / 1000);
//                            
//                            NSString *photoTime = @"";
//                            NSDateFormatter *dateFormatter = [NSDateFormatter new];
//                            [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
//                            PHAsset *tempAsset = assetModel.asset;
//                            photoTime = [dateFormatter stringFromDate:tempAsset.creationDate];
//                            
//                            NSMutableDictionary *tempParaDict = [NSMutableDictionary dictionaryWithDictionary:self.paraDict];
//                            [tempParaDict setObject:photoTime forKey:@"photoTime"];
//                            NSString *addressStr = [NSString stringWithFormat:@"%@", [LocationManager shareManager].addressInfo[@"address"]];
//                            [tempParaDict setObject:addressStr forKey:@"address"];
//                            
//                            [NetworkHelper POST:self.urlStr parameters:tempParaDict constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
//                                [formData appendPartWithFileData:data name:@"photo" fileName:@"abnormal_upload.jpg" mimeType:@"image/jpeg"];
//                            } progress:nil success:^(NSURLSessionDataTask *task, id responseObject) {
//                                if (self.finishPostBlock) {
//                                    self.finishPostBlock(responseObject, nil);
//                                }
//                            } failure:^(NSError *error) {
//                                if (self.finishPostBlock) {
//                                    self.finishPostBlock(nil, error);
//                                }
//                            }];
//                        }];
//                    }];
//                }
//            }];
//        }];
        
        
        
        UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
        __block NSData *data = UIImageJPEGRepresentation(image, 0.2);
        NSLog(@"%lu", data.length / 1000);
        
        NSDictionary *dataDict = [info objectForKey:UIImagePickerControllerMediaMetadata];
        NSDictionary *infoDict = [dataDict objectForKey:@"{TIFF}"];
        NSString *photoTime = [infoDict objectForKey:@"DateTime"];
        
        NSDateFormatter *dateFormatter = [NSDateFormatter new];
        [dateFormatter setDateFormat:@"yyyy:MM:dd HH:mm:ss"];
        NSDate *date = [dateFormatter dateFromString:photoTime];
        [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        photoTime = [dateFormatter stringFromDate:date];
        
        __block NSMutableDictionary *tempParaDict = [NSMutableDictionary dictionaryWithDictionary:self.paraDict];
        [tempParaDict setObject:photoTime forKey:@"photoTime"];
        NSString *addressStr = [NSString stringWithFormat:@"%@", [LocationManager shareManager].addressInfo[@"address"]];
        [tempParaDict setObject:addressStr forKey:@"address"];
        
        [picker dismissViewControllerAnimated:YES completion:^{
            [NetworkHelper POST:self.urlStr parameters:tempParaDict constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
                [formData appendPartWithFileData:data name:@"photo" fileName:@"abnormal_upload.jpg" mimeType:@"image/jpeg"];
            } progress:nil success:^(NSURLSessionDataTask *task, id responseObject) {
                if (self.finishPostBlock) {
                    self.finishPostBlock(responseObject, nil);
                }
            } failure:^(NSError *error) {
                if (self.finishPostBlock) {
                    self.finishPostBlock(nil, error);
                }
            }];
        }];
    } else {
        [picker dismissViewControllerAnimated:YES completion:nil];
    }
    
    
}

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
    
    [imagePickerVc setDidFinishPickingPhotosHandle:^(NSArray<UIImage *> *photos, NSArray *assets, BOOL isSelectOriginalPhoto) {
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
        NSString *addressStr = [NSString stringWithFormat:@"%@", [LocationManager shareManager].addressInfo[@"address"]];
        [tempParaDict setObject:addressStr forKey:@"address"];
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
    }];
}


@end
