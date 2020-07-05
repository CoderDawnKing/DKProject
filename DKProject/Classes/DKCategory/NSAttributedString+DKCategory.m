//
//  NSAttributedString+DKCategory.m
//  GardenManager
//
//  Created by 王 on 2020/6/2.
//  Copyright © 2020 wisezone. All rights reserved.
//

#import "NSAttributedString+DKCategory.h"

@implementation NSAttributedString (DKCategory)

- (NSAttributedString *)setAttributes:(NSDictionary<NSAttributedStringKey,id> *)attr range:(NSRange)rang {
    NSMutableAttributedString *attrM = [[NSMutableAttributedString alloc] initWithAttributedString:self];
    [attrM setAttributes:attr range:rang];
    return attrM;
}

@end
