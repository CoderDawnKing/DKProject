//
//  NSData+DKCategory.m
//  GardenManager
//
//  Created by 王 on 2019/7/11.
//  Copyright © 2019 wisezone. All rights reserved.
//

#import "NSData+DKCategory.h"

@implementation NSData (DKCategory)

- (void)setDk_toJsonString:(NSString *)dk_toJsonString {}

- (NSString *)dk_toJsonString {
    return [[NSString alloc] initWithData:self encoding:NSUTF8StringEncoding];
}

@end
