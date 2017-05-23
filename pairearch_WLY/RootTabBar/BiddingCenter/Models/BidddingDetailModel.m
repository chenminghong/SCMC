//
//  BidddingDetailModel.m
//  pairearch_WLY
//
//  Created by Jean on 2017/5/23.
//  Copyright © 2017年 Leo. All rights reserved.
//

#import "BidddingDetailModel.h"

@implementation BidddingDetailModel

+ (NSURLSessionDataTask *)getDataWithParameters:(NSDictionary *)paramDict endBlock:(void (^)(id, NSError *))endBlock {
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    __weak MBProgressHUD *hud = [MBProgressHUD bwm_showHUDAddedTo:window title:kBWMMBProgressHUDMsgLoading animated:YES];
    return [[NetworkHelper shareClientBidd] GET:BIDDING_DETAIL_API parameters:paramDict progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [hud hide:YES];
        responseObject = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
        BidddingDetailModel *model = [BidddingDetailModel new];
        model.driverArr = [NSMutableArray arrayWithArray:[BidddingDetailModel getModelsWithDicts:responseObject[@"driver"]]];
        model.productArr = [NSMutableArray array];
        for (NSArray *array in responseObject[@"product"]) {
            NSArray *productArr = [BidddingDetailModel getModelsWithDicts:array];
            [model.productArr addObject:productArr];
        }
        model.scorderbidArr = [NSMutableArray arrayWithArray:[BidddingDetailModel getModelsWithDicts:responseObject[@"scorderbid"]]];
        model.supplieArr = [NSMutableArray arrayWithArray:[BidddingDetailModel getModelsWithDicts:responseObject[@"supplie"]]];
        if (endBlock) {
            endBlock(model, nil);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [hud hide:NO];
        if (endBlock) {
            endBlock(nil, error);
        }
    }];
}

@end
