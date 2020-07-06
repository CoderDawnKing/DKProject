//
//  NSData+DKCategory.m
//  GardenManager
//
//  Created by 王 on 2019/7/11.
//  Copyright © 2019 wisezone. All rights reserved.
//

#import "NSData+DKCategory.h"

@implementation NSData (DKCategory)

- (void)setToJsonString:(NSString *)toJsonString {}

- (NSString *)toJsonString {
    return [[NSString alloc] initWithData:self encoding:NSUTF8StringEncoding];
}

@end
