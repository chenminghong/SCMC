//
//  HomePageModel.m
//  pairearch_WLY
//
//  Created by Leo on 2017/3/10.
//  Copyright © 2017年 Leo. All rights reserved.
//

#import "HomePageModel.h"

@implementation HomePageModel

- (NSString *)code {
    return [NSString stringWithFormat:@"%@", _code];
}

+ (NSURLSessionDataTask *)getDataWithUrl:(NSString *)url parameters:(NSDictionary *)paramDict endBlock:(void (^)(id, NSError *))endBlock {
    return [[NetworkHelper shareClient] GET:url parameters:paramDict progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
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

//- (NSString *)code {
//    return [NSString stringWithFormat:@"单号:%@", _code];
//}

- (NSString *)wareDispatchTime {
    return [NSString stringWithFormat:@"计划装运日期:%@", [_wareDispatchTime substringToIndex:10]];
}


@end
