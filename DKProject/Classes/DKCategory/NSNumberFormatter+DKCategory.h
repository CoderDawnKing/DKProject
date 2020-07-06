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

+ (instancetype)dk_numberFormatter;
+ (instancetype)dk_numberFormatterWithStyle:(NSNumberFormatterStyle)style;
///显示 1,234.00 小数
+ (instancetype)dk_defaultDecimalNumberFormatter;
+ (instancetype)dk_defaultCurrencyNumberFormatter;

@end

NS_ASSUME_NONNULL_END
