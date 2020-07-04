//
//  UIFont+Category.m
//  GardenManager
//
//  Created by 王 on 2019/6/18.
//  Copyright © 2019 wisezone. All rights reserved.
//

#import "UIFont+DKCategory.h"

@implementation UIFont (DKCategory)

+ (instancetype)pfMediumWithSize:(CGFloat)size {
    return [self fontWithName:@"PingFangSC-Medium" size:size];
}
+ (instancetype)pfRegularWithSize:(CGFloat)size {
    return [self fontWithName:@"PingFangSC-Regular" size:size];
}
+ (instancetype)pfBoldWithSize:(CGFloat)size {
    return [self fontWithName:@"PingFangSC-Semibold" size:size];
}
+ (instancetype)pfUltralightWithSize:(CGFloat)size {
    return [self fontWithName:@"PingFangSC-Ultralight" size:size];
}
+ (instancetype)pfThinWithSize:(CGFloat)size {
    return [self fontWithName:@"PingFangSC-Thin" size:size];
}
+ (instancetype)pfLightWithSize:(CGFloat)size {
    return [self fontWithName:@"PingFangSC-Light" size:size];
}
+ (instancetype)arialItalicMTWithSize:(CGFloat)size {
    return [UIFont fontWithName:@"Arial-ItalicMT" size:size];
}
+ (instancetype)arialBlackWithSize:(CGFloat)size {
    return [UIFont fontWithName:@"Arial-Black" size:size];
}
+ (instancetype)ktRegularWithSize:(CGFloat)size {
    return [self fontWithName:@"KaiTi" size:size];
}
+ (instancetype)xwRegularWithSize:(CGFloat)size {
    return [self fontWithName:@"xiaowei" size:size];
}
+ (instancetype)ccRegularWithSize:(CGFloat)size {
    return [self fontWithName:@"Cochin" size:size];
}
+ (instancetype)ccItalicWithSize:(CGFloat)size {
    return [self fontWithName:@"Cochin-Italic" size:size];
}

@end
