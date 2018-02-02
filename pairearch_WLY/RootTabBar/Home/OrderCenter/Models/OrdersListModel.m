//
//  OrderListModel.m
//  pairearch_WLY
//
//  Created by Jean on 2017/11/24.
//  Copyright © 2017年 Leo. All rights reserved.
//

#import "OrdersListModel.h"

@implementation OrdersListModel

- (void)setPlanLoadDate:(NSString *)planLoadDate {
    _planLoadDate = [[self class] timeWithTimeIntervalString:planLoadDate];
}

//时间戳转化为时间
+ (NSString *)timeWithTimeIntervalString:(NSString *)timeString
{
    // 格式化时间
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    formatter.timeZone = [NSTimeZone systemTimeZone];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    
    // 毫秒值转化为秒
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:[timeString doubleValue] / 1000.0];
    NSString *dateString = [formatter stringFromDate:date];
    return dateString;
}

//时间转化为时间戳
+ (NSString *)timeIntervalStringWithTime:(NSDate *)date
{
    // 当前时间
    NSTimeInterval a =[date timeIntervalSince1970] * 1000; // *1000 是精确到毫秒，不乘就是精确到秒
    return [NSString stringWithFormat:@"%.0f", a]; //转为字符型
}


@end
