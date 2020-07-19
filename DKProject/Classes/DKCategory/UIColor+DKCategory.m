//
//  UIColor+DKCategory.m
//  GardenManager
//
//  Created by 王 on 2019/7/4.
//  Copyright © 2019 wisezone. All rights reserved.
//

#import "UIColor+DKCategory.h"

@implementation UIColor (DKCategory)

- (void)setRed:(CGFloat)red {

}

- (void)setGreen:(CGFloat)green {

}

- (void)setBlue:(CGFloat)blue {

}

- (void)setAlpha:(CGFloat)alpha {

}

- (CGFloat)red {
    CGFloat r = 0;
    if ([self respondsToSelector:@selector(getRed:green:blue:alpha:)]) {
        [self getRed:&r green:0 blue:0 alpha:0];
    } else {
        const CGFloat *components = CGColorGetComponents(self.CGColor);
        r = components[0];
    }
    //返回保存RGB值的数组
    return r;
}

- (CGFloat)green {
    CGFloat g = 0;
    if ([self respondsToSelector:@selector(getRed:green:blue:alpha:)]) {
        [self getRed:0 green:&g blue:0 alpha:0];
    } else {
        const CGFloat *components = CGColorGetComponents(self.CGColor);
        g = components[1];
    }
    //返回保存RGB值的数组
    return g;
}

- (CGFloat)blue {
    CGFloat b = 0;
    if ([self respondsToSelector:@selector(getRed:green:blue:alpha:)]) {
        [self getRed:0 green:0 blue:&b alpha:0];
    } else {
        const CGFloat *components = CGColorGetComponents(self.CGColor);
        b = components[2];
    }
    //返回保存RGB值的数组
    return b;
}

- (CGFloat)alpha {
    CGFloat a = 0;
    if ([self respondsToSelector:@selector(getRed:green:blue:alpha:)]) {
        [self getRed:0 green:0 blue:0 alpha:&a];
    } else {
        const CGFloat *components = CGColorGetComponents(self.CGColor);
        a = components[3];
    }
    //返回保存RGB值的数组
    return a;
}

- (BOOL)isEqualToColor:(UIColor *)color {
    if (self.red == color.red && self.green == color.green && self.blue == color.blue && self.alpha == color.alpha) {
        return YES;
    }
    return NO;
}

@end
