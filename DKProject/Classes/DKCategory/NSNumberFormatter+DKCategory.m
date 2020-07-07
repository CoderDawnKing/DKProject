//
//  NSNumberFormatter+DKCategory.m
//  GardenManager
//
//  Created by 王 on 2020/1/13.
//  Copyright © 2020 wisezone. All rights reserved.
//

/**
 No Style                  = 1234568 四舍五入的整数
 Decimal Style             = 1,234,567.837 小数形式
 Currency Style            = $1,234,567.84 货币形式 -- 本地化
 Percent Style             = 123,456,784% 百分数形式
 Scientific Style          = 1.2345678369E6 科学计数
 Spell Out Style           = one million two hundred thirty-four thousand five hundred sixty-seven point eight three six nine 朗读形式 -- 本地化
 Ordinal Style             = 1,234,568th 序数形式 -- 本地化
 Currency ISO Style        = USD1,234,567.84 货币形式 ISO -- 本地化
 Currency plural Style     = 1,234,567.84 US dollars 货币形式 -- 本地化
 Currency accounting Style = $1,234,567.84 会计计数 -- 本地化
 */

#import "NSNumberFormatter+DKCategory.h"

@implementation NSNumberFormatter (DKCategory)

+ (instancetype)dk_numberFormatter {
    return [[self alloc] init];
}

+ (instancetype)dk_numberFormatterWithStyle:(NSNumberFormatterStyle)style {
    NSNumberFormatter *formatter = [[self alloc]init];
    formatter.numberStyle = style;
    return formatter;
}

+ (instancetype)dk_defaultDecimalNumberFormatter {
    NSNumberFormatter *formatter = [self dk_numberFormatterWithStyle:NSNumberFormatterDecimalStyle];
    formatter.locale = [NSLocale localeWithLocaleIdentifier:@"zh-cn"];
    // 小数位最多位数
    formatter.maximumFractionDigits = 2;
    // 小数位最少位数
    formatter.minimumFractionDigits = 2;
    return formatter;
}

+ (instancetype)dk_defaultCurrencyNumberFormatter {
    NSNumberFormatter *formatter = [self dk_numberFormatterWithStyle:NSNumberFormatterCurrencyStyle];
    formatter.locale = [NSLocale localeWithLocaleIdentifier:@"zh-cn"];
    return formatter;
}

@end
