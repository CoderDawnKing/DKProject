//
//  BaseModel.m
//  GardenManager
//
//  Created by 王 on 2019/6/17.
//  Copyright © 2019 wisezone. All rights reserved.
//

#import "DKBaseModel.h"
#import <DKProject/DKProject.h>

@implementation DKBaseModel

MJLogAllIvars
MJImplementDebugDescription
MJCodingImplementation

+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{
             @"Id" : @"id",
             @"desc" : @"description"
             };
}

- (id)mj_newValueFromOldValue:(id)oldValue property:(MJProperty *)property {
    if (property.type.typeClass == [NSString class]) {//过滤空字符串
        if (oldValue == nil) return @"";
    } else if (property.type.typeClass == [NSDate class]) {//转换 date
        if (oldValue == [NSString class]) {
            NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
            fmt.dateFormat = @"yyyy-MM-dd HH:mm:ss";
            return [fmt dateFromString:oldValue];
        } else {
            return [NSDate dateWithTimeIntervalInMilliSecondSince1970:((NSNumber *)oldValue).integerValue];
        }
    }
    return oldValue;
}

@end
