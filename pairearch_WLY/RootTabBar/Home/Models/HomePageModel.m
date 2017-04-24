//
//  HomePageModel.m
//  pairearch_WLY
//
//  Created by Leo on 2017/3/10.
//  Copyright © 2017年 Leo. All rights reserved.
//

#import "HomePageModel.h"

@implementation HomePageModel


+ (NSURLSessionDataTask *)getDataWithParameters:(NSDictionary *)paramDict endBlock:(void (^)(id, NSError *))endBlock {
    return [[NetworkHelper shareClient] GET:HOME_PAGE_DATA_API parameters:paramDict progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *responseDict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];
        NSInteger ordersCount = [responseDict[@"loadResult"] integerValue];
        HomePageModel *model = [HomePageModel getModelWithDict:responseDict];
        if (ordersCount > 0) {
            NSDictionary *orderDict = responseDict[@"orders"];
            model.orderModel = [HomePageModel getModelWithDict:orderDict];
        }
        endBlock(model, nil);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        endBlock(nil, error);
    }];
}


@end
