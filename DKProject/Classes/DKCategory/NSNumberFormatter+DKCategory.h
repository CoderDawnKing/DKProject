//
//  NSNumberFormatter+DKCategory.h
//  GardenManager
//
//  Created by 王 on 2020/1/13.
//  Copyright © 2020 wisezone. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSNumberFormatter (DKCategory)

+ (instancetype)numberFormatter;
+ (instancetype)numberFormatterWithStyle:(NSNumberFormatterStyle)style;
///显示 1,234.00 小数
+ (instancetype)defaultDecimalNumberFormatter;
+ (instancetype)defaultCurrencyNumberFormatter;

@end

NS_ASSUME_NONNULL_END
