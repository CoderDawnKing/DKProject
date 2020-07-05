//
//  NSArray+DKCategory.h
//  GardenManager
//
//  Created by 王 on 2019/8/7.
//  Copyright © 2019 wisezone. All rights reserved.
//



NS_ASSUME_NONNULL_BEGIN

@interface NSArray (DKCategory)
- (NSArray *)filteredArrayWithFormat:(NSString *)format, ... NS_FORMAT_FUNCTION(1, 2);
@end

@interface NSMutableArray (DKCategory)

@end

NS_ASSUME_NONNULL_END
