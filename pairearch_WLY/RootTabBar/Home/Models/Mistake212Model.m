//
//  Mistake212Model.m
//  pairearch_WLY
//
//  Created by Jean on 2017/5/4.
//  Copyright © 2017年 Leo. All rights reserved.
//

#import "Mistake212Model.h"

@implementation Mistake212Model

+ (NSURLSessionDataTask *)getDataWithUrl:(NSString *)url parameters:(NSDictionary *)paramDict endBlock:(void (^)(id, NSError *))endBlock {
    return [[NetworkHelper shareClient] GET:url parameters:paramDict progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *responseDict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];
        NSInteger ordersCount = [responseDict[@"loadResult"] integerValue];
        Mistake212Model *model = [Mistake212Model getModelWithDict:responseDict];
        if (ordersCount > 0) {
            NSArray *orderArr = responseDict[@"orders"];
            model.orders = [NSMutableArray array];
            for (NSDictionary *orderDict in orderArr) {
                Mistake212Model *orderModel = [Mistake212Model getModelWithDict:orderDict];
                [model.orders addObject:orderModel];
            }
        }
        endBlock(model, nil);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        endBlock(nil, error);
    }];
}

@end
