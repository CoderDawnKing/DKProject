//
//  NSAttributedString+DKCategory.h
//  GardenManager
//
//  Created by 王 on 2020/6/2.
//  Copyright © 2020 wisezone. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSAttributedString (DKCategory)
///修改富文本属性
- (NSAttributedString *)dk_setAttributes:(nullable NSDictionary<NSAttributedStringKey,id> *)attr range:(NSRange)rang;

@end

NS_ASSUME_NONNULL_END
