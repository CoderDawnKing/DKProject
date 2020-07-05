//
//  NSNumber+DKCategory.m
//  GardenManager
//
//  Created by 王 on 2020/1/13.
//  Copyright © 2020 wisezone. All rights reserved.
//

#import "NSNumber+DKCategory.h"
#import "NSObject+DKCategory.h"

@implementation NSNumber (DKCategory)

- (NSString *)decimalString {
    NSNumberFormatter *formatter = [NSNumberFormatter defaultDecimalNumberFormatter];
    NSString *numberString = [formatter stringFromNumber:self];
    return numberString.isNotEmpty?numberString:@"0";
}

- (NSString *)decimalFormatterString {
    NSNumberFormatter *formatter = [NSNumberFormatter defaultDecimalNumberFormatter];
    NSString *numberString = [formatter stringFromNumber:self];
    if (self.integerValue >= 10000) {
        numberString = [NSString stringWithFormat:@"%.1f万", self.integerValue / 10000.0];
    }
    return numberString.isNotEmpty?numberString:@"0";
}

- (NSString *)currencyString {
    NSNumberFormatter *formatter = [NSNumberFormatter defaultCurrencyNumberFormatter];
    NSString *numberString = [formatter stringFromNumber:self];
    return numberString.isNotEmpty?numberString:@"¥0";
}

@end
