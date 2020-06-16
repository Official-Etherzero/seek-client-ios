//
//  YYDateModel.m
//  ETZClientForiOS
//
//  Created by yang on 2019/9/27.
//  Copyright © 2019 yang123. All rights reserved.
//

#import "YYDateModel.h"
#import "YYCalculateModel.h"

@implementation YYDateModel

+ (NSString *)yy_getTimeFromTimeStamp:(double)stamp {
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:stamp];
    NSDateFormatter *format1 = [[NSDateFormatter alloc] init];
    [format1 setDateFormat:@"yyyy-MM-dd"];
//    [format1 setDateFormat:@"yyyy-MM-dd hh:mm:ss"];
    NSString *str = [format1 stringFromDate:date];
    return str;
}

+ (NSString *)yy_getFullTimeWithTimeStamp:(double)stamp {
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:stamp];
    NSDateFormatter *format1 = [[NSDateFormatter alloc] init];
    [format1 setDateFormat:@"yyyy-MM-dd hh:mm:ss"];
    NSString *str = [format1 stringFromDate:date];
    return str;
}

+ (NSDate *)yy_currentTime {
    NSDate *date = [NSDate date];
    NSDateFormatter *format1 = [[NSDateFormatter alloc] init];
    [format1 setDateFormat:@"yyyy-MM-dd hh:mm:ss"];
    NSString *dateStr;
    dateStr = [format1 stringFromDate:date];
    return date;
}

+ (NSDate *)yy_nextDayTime {
    NSDate *nextDay = [NSDate dateWithTimeInterval:24*60*60 sinceDate:[self yy_currentTime]];
    return nextDay;
}

+ (NSDate *)yy_markTimeByCurrentTime:(NSDate *)date {
    NSDate *nextDay = [NSDate dateWithTimeInterval:24*60*60 sinceDate:date];
    return nextDay;
}

+ (BOOL)yy_compareDate:(NSDate *)stary withDate:(NSDate *)end {
    NSComparisonResult result = [stary compare: end];
    if (result == NSOrderedSame) {
        //相等
        return NO;
    } else if (result == NSOrderedAscending) {
        //结束时间大于开始时间
        return NO;
    } else if (result==NSOrderedDescending) {
        //结束时间小于开始时间
        return YES;
    }
    return NO;
}

@end
