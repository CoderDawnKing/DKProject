//
//  NSDictionary+DKCategory.h
//  GardenManager
//
//  Created by 王 on 2019/7/10.
//  Copyright © 2019 wisezone. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSDictionary (DKCategory)

@property (nonatomic, strong) NSData *toJsonData;

@end

@interface NSMutableDictionary (DKCategory)

/// 添加非空字符串
/// @param stringObject 字符串
/// @param key 关键字
- (void)addUnEmptyString:(id)stringObject forKey:(NSString *)key;
@end

NS_ASSUME_NONNULL_END
