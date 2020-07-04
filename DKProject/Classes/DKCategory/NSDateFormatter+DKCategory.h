//
//  NSDateFormatter+DKCategory.h
//  GardenManager
//
//  Created by 王 on 2019/7/9.
//  Copyright © 2019 wisezone. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSDateFormatter (DKCategory)
/// 创建 formatter
+ (instancetype)dateFormatter;

/// 创建 formatter
/// @param dateFormat 格式
+ (instancetype)dateFormatterWithFormat:(NSString *)dateFormat;

/** yyyy-MM-dd HH:mm:ss */
+ (instancetype)defaultDateFormatter;
/** yyyy-MM */
+ (instancetype)defaultYearMonthDateFormatter;
/** MM-dd */
+ (instancetype)defaultMonthDayDateFormatter;
/** yyyy-MM-dd */
+ (instancetype)defaultYearMonthDayDateFormatter;
/** HH:mm */
+ (instancetype)defaultMinuteDateFormatter;
/** HH:mm:ss */
+ (instancetype)defaultSecondDateFormatter;

@end

NS_ASSUME_NONNULL_END
