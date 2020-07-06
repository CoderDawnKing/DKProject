//
//  NSDate+DKCategory.h
//  GardenManager
//
//  Created by 王 on 2019/7/9.
//  Copyright © 2019 wisezone. All rights reserved.
//

#import <Foundation/Foundation.h>

#define DK_MINUTE    60
#define DK_HOUR      3600
#define DK_DAY       86400
#define DK_WEEK      604800
#define DK_MONTH     2592000
#define DK_YEAR      31556926

NS_ASSUME_NONNULL_BEGIN

@interface NSDate (DKCategory)
/// 距离当前的时间间隔描述
- (NSString *)timeIntervalDescription;
/// 精确到分钟的日期描述
- (NSString *)minuteDescription;
/// 格式化日期描述
- (NSString *)formattedDateDescription;
/// 标准时间日期描述
- (NSString *)formattedTimeDescription;
/// 距离当前的时间间隔描述 xx 天 xx 时
- (NSString *)formattedDayHourDescription;
/// 距离当前的时间间隔描述 xx 月 xx 日 去年 xx 年 xx 月 xx 日
- (NSString *)formattedDayDescription;
/// 当前时间秒数
- (NSTimeInterval)timeIntervalSince1970InMilliSecond;
/// 秒/毫秒转 Date
+ (NSDate *)dateWithTimeIntervalInMilliSecondSince1970:(NSTimeInterval)timeIntervalInMilliSecond;
/// 秒/毫秒转字符串
+ (NSString *)formattedTimeFromTimeInterval:(NSTimeInterval)time;
/// 年月日时分秒
+ (NSDate *)dateWithDefaultFormatter;
///精确到毫秒显示
+ (NSString *)dateWithMSDefaultFormatter;
///获取当前是上午还是下午
+ (NSString *)dateIsAMOrPM;
/// 距离当前的时间超过 1 小时
- (BOOL)timeIntervalGreaterThanAnHour;
/// 明天
+ (NSDate *)dateTomorrow;
/// 昨天
+ (NSDate *)dateYesterday;
/// 往后多少天
+ (NSDate *)dateWithDaysFromNow:(NSInteger)days;
/// 往前多少天
+ (NSDate *)dateWithDaysBeforeNow:(NSInteger)days;
/// 往后多少小时
+ (NSDate *)dateWithHoursFromNow:(NSInteger)dHours;
/// 往前多少小时
+ (NSDate *)dateWithHoursBeforeNow:(NSInteger)dHours;
/// 往后多少分钟
+ (NSDate *)dateWithMinutesFromNow:(NSInteger)dMinutes;
/// 往前多少分钟
+ (NSDate *)dateWithMinutesBeforeNow:(NSInteger)dMinutes;
///秒数转换成时分秒
+ (NSString *)secondFormatterHour:(NSUInteger)time;

// Comparing dates
- (BOOL)isEqualToDateIgnoringTime:(NSDate *)aDate;
- (BOOL)isToday;
- (BOOL)isTomorrow;
- (BOOL)isYesterday;
- (BOOL)isSameWeekAsDate:(NSDate *)aDate;
- (BOOL)isThisWeek;
- (BOOL)isNextWeek;
- (BOOL)isLastWeek;
- (BOOL)isSameMonthAsDate:(NSDate *)aDate;
- (BOOL)isThisMonth;
- (BOOL)isSameYearAsDate:(NSDate *)aDate;
- (BOOL)isThisYear;
- (BOOL)isNextYear;
- (BOOL)isLastYear;
- (BOOL)isEarlierThanDate:(NSDate *)aDate;
- (BOOL)isLaterThanDate:(NSDate *)aDate;
- (BOOL)isInFuture;
- (BOOL)isInPast;

// Date roles
- (BOOL)isTypicallyWorkday;
- (BOOL)isTypicallyWeekend;

// Adjusting dates
- (NSDate *)dateByAddingDays:(NSInteger)dDays;
- (NSDate *)dateBySubtractingDays:(NSInteger)dDays;
- (NSDate *)dateByAddingHours:(NSInteger)dHours;
- (NSDate *)dateBySubtractingHours:(NSInteger)dHours;
- (NSDate *)dateByAddingMinutes:(NSInteger)dMinutes;
- (NSDate *)dateBySubtractingMinutes:(NSInteger)dMinutes;
- (NSDate *)dateAtStartOfDay;

// Retrieving intervals
- (NSInteger)minutesAfterDate:(NSDate *)aDate;
- (NSInteger)minutesBeforeDate:(NSDate *)aDate;
- (NSInteger)hoursAfterDate:(NSDate *)aDate;
- (NSInteger)hoursBeforeDate:(NSDate *)aDate;
- (NSInteger)daysAfterDate:(NSDate *)aDate;
- (NSInteger)daysBeforeDate:(NSDate *)aDate;
- (NSInteger)distanceInDaysToDate:(NSDate *)anotherDate;

// Decomposing dates
@property (readonly) NSInteger nearestHour;
@property (readonly) NSInteger hour;
@property (readonly) NSInteger minute;
@property (readonly) NSInteger seconds;
@property (readonly) NSInteger day;
@property (readonly) NSInteger month;
@property (readonly) NSInteger week;
@property (readonly) NSInteger weekday;
@property (readonly) NSInteger nthWeekday; // e.g. 2nd Tuesday of the month == 2
@property (readonly) NSInteger year;
@end

NS_ASSUME_NONNULL_END
