//
//  NSDictionary+DKCategory.m
//  GardenManager
//
//  Created by 王 on 2019/7/10.
//  Copyright © 2019 wisezone. All rights reserved.
//

#import "NSDictionary+DKCategory.h"
#import "NSObject+DKCategory.h"

@implementation NSDictionary (DKCategory)

- (void)setToJsonData:(NSData *)toJsonData {}

- (NSData *)toJsonData {
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:self options:NSJSONWritingPrettyPrinted error:&error];
    return jsonData;
}

#ifdef DEBUG
- (NSString *)descriptionWithLocale:(id)locale
{
    NSMutableString *str = [NSMutableString string];
    
    [str appendString:@"{\n"];
    
    // 遍历字典的所有键值对
    [self enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        [str appendFormat:@"\t%@ = %@,\n", key, obj];
    }];
    
    [str appendString:@"}"];
    
    // 查出最后一个,的范围
    NSRange range = [str rangeOfString:@"," options:NSBackwardsSearch];
    if (range.length != 0) {
        // 删掉最后一个,
        [str deleteCharactersInRange:range];
    }
    
    return str;
}
#else

#endif

@end

@implementation NSMutableDictionary (DKCategory)

- (void)addUnEmptyString:(id)stringObject forKey:(NSString *)key{
    if (![stringObject isNotEmpty]) {
        [self setObject:@"" forKey:key];
    }else{
        [self setObject:stringObject forKey:key];
    }
}
@end
