//
//  ImageListModel.h
//  pairearch_WLY
//
//  Created by Jean on 2017/11/23.
//  Copyright © 2017年 Leo. All rights reserved.
//

#import "BaseModel.h"

@interface ImageListModel : BaseModel

@property (nonatomic, copy) NSString *content;    //广告内容

@property (nonatomic, copy) NSString *imagePath;  //广告图片

@property (nonatomic, copy) NSString *title;      //广告标题

@property (nonatomic, copy) NSString *url;        //广告跳转链接

@end
