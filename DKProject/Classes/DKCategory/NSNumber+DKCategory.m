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

- (NSString *)dk_decimalString {
    NSNumberFormatter *formatter = [NSNumberFormatter dk_defaultDecimalNumberFormatter];
    NSString *numberString = [formatter stringFromNumber:self];
    return numberString.dk_notEmpty?numberString:@"0";
}

- (NSString *)dk_decimalFormatterString {
    NSNumberFormatter *formatter = [NSNumberFormatter dk_defaultDecimalNumberFormatter];
    NSString *numberString = [formatter stringFromNumber:self];
    if (self.integerValue >= 10000) {
        numberString = [NSString stringWithFormat:@"%.1f万", self.integerValue / 10000.0];
    }
    return numberString.dk_notEmpty?numberString:@"0";
}

- (NSString *)dk_currencyString {
    NSNumberFormatter *formatter = [NSNumberFormatter dk_defaultCurrencyNumberFormatter];
    NSString *numberString = [formatter stringFromNumber:self];
    return numberString.dk_notEmpty?numberString:@"¥0";
}

@end
