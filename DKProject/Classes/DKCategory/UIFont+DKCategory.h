//
//  UIFont+Category.h
//  GardenManager
//
//  Created by 王 on 2019/6/18.
//  Copyright © 2019 wisezone. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIFont (DKCategory)
+ (instancetype)pfMediumWithSize:(CGFloat)size;
+ (instancetype)pfRegularWithSize:(CGFloat)size;
+ (instancetype)pfBoldWithSize:(CGFloat)size;
+ (instancetype)pfUltralightWithSize:(CGFloat)size;
+ (instancetype)pfThinWithSize:(CGFloat)size;
+ (instancetype)pfLightWithSize:(CGFloat)size;
+ (instancetype)arialItalicMTWithSize:(CGFloat)size;
+ (instancetype)arialBlackWithSize:(CGFloat)size;
///楷体
+ (instancetype)ktRegularWithSize:(CGFloat)size;
///站酷小微
+ (instancetype)xwRegularWithSize:(CGFloat)size;
///Cochin
+ (instancetype)ccRegularWithSize:(CGFloat)size;
+ (instancetype)ccItalicWithSize:(CGFloat)size;
@end

NS_ASSUME_NONNULL_END
