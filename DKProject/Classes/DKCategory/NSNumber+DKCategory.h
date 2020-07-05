//
//  NSNumber+DKCategory.h
//  GardenManager
//
//  Created by 王 on 2020/1/13.
//  Copyright © 2020 wisezone. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSNumberFormatter+DKCategory.h"

NS_ASSUME_NONNULL_BEGIN

@interface NSNumber (DKCategory)
/// 1,234 类型
- (NSString *)decimalString;
/// 1,234 类型 超过 1 万自动显示万
- (NSString *)decimalFormatterString;
/// 货币类型
- (NSString *)currencyString;

@end

NS_ASSUME_NONNULL_END
