//
//  UITextField+DKCategory.h
//  GardenManager
//
//  Created by 王 on 2019/10/23.
//  Copyright © 2019 wisezone. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UITextField (DKCategory)

- (NSRange)selectedRange;
- (void)setSelectedRange:(NSRange)range;

@end

NS_ASSUME_NONNULL_END
