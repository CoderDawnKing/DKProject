//
//  NSArray+DKCategory.m
//  GardenManager
//
//  Created by 王 on 2019/8/7.
//  Copyright © 2019 wisezone. All rights reserved.
//

#import "NSArray+DKCategory.h"

@implementation NSArray (DKCategory)
#ifdef DEBUG
- (NSString *)descriptionWithLocale:(id)locale
{
    NSMutableString *str = [NSMutableString string];
    
    [str appendString:@"[\n"];
    
    // 遍历数组的所有元素
    [self enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        [str appendFormat:@"%@,\n", obj];
    }];
    
    [str appendString:@"]"];
    
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

- (NSArray *)dk_filteredArrayWithFormat:(NSString *)format, ... {
    va_list ap;
    va_start(ap, format);
    NSPredicate *pred = [NSPredicate predicateWithFormat:format arguments:ap];
    va_end(ap);
    return [self filteredArrayUsingPredicate:pred];
}

@end


@implementation NSMutableArray (DKCategory)

@end
