//
//  NSDateFormatter+DKCategory.m
//  GardenManager
//
//  Created by 王 on 2019/7/9.
//  Copyright © 2019 wisezone. All rights reserved.
//

#import "NSDateFormatter+DKCategory.h"

@implementation NSDateFormatter (DKCategory)

+ (instancetype)dateFormatter
{
    return [[self alloc] init];
}

+ (instancetype)dateFormatterWithFormat:(NSString *)dateFormat
{
    NSDateFormatter *dateFormatter = [[self alloc] init];
    dateFormatter.dateFormat = dateFormat;
    return dateFormatter;
}

+ (instancetype)defaultDateFormatter {
    return [self dateFormatterWithFormat:@"yyyy-MM-dd HH:mm:ss"];
}

+ (instancetype)defaultYearMonthDayMilliScondDateFormatter {
    return [self dateFormatterWithFormat:@"yyyy-MM-dd HH:mm:ss:SSS"];
}

+ (instancetype)defaultYearMonthDayDateFormatter {
    return [self dateFormatterWithFormat:@"yyyy-MM-dd"];
}

+ (instancetype)defaultYearMonthDateFormatter {
    return [self dateFormatterWithFormat:@"yyyy-MM"];
}

+ (instancetype)defaultMonthDayDateFormatter {
    return [self dateFormatterWithFormat:@"MM-dd"];
}

+ (instancetype)defaultHourDateFormatter {
    return [self dateFormatterWithFormat:@"HH"];
}

+ (instancetype)defaultHourMinuteDateFormatter {
    return [self dateFormatterWithFormat:@"HH:mm"];
}

+ (instancetype)defaultHourMinuteSecondDateFormatter {
    return [self dateFormatterWithFormat:@"HH:mm:ss"];
}

@end
