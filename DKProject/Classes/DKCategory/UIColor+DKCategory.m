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
    return [self getUIColorToRed:self];
}

- (CGFloat)green {
    return [self getUIColorToGreen:self];
}

- (CGFloat)blue {
    return [self getUIColorToBlue:self];
}

- (CGFloat)alpha {
    return [self getUIColorToAlpha:self];
}

- (CGFloat)getUIColorToRed:(UIColor *)color {
    return [[[self getUIColorToRGB:color] valueForKey:@"red"] floatValue];
}
- (CGFloat)getUIColorToGreen:(UIColor *)color {
    return [[[self getUIColorToRGB:color] valueForKey:@"green"] floatValue];
}
- (CGFloat)getUIColorToBlue:(UIColor *)color {
    return [[[self getUIColorToRGB:color] valueForKey:@"blue"] floatValue];
}
- (CGFloat)getUIColorToAlpha:(UIColor *)color {
    return [[[self getUIColorToRGB:color] valueForKey:@"alpha"] floatValue];
}
//将UIColor转换为RGB值
- (NSDictionary *)getUIColorToRGB:(UIColor *)color
{
    CGFloat red = 0.0;
    CGFloat green = 0.0;
    CGFloat blue = 0.0;
    CGFloat alpha = 0.0;
    if ([self respondsToSelector:@selector(getRed:green:blue:alpha:)]) {
        [color getRed:&red green:&green blue:&blue alpha:&alpha];
    } else {
        const CGFloat *components = CGColorGetComponents(color.CGColor);
        red = components[0];
        green = components[1];
        blue = components[2];
        alpha = components[3];
    }
    [color getRed:&red green:&green blue:&blue alpha:&alpha];
    //返回保存RGB值的数组
    return @{@"red":@(red), @"green":@(green), @"blue":@(blue), @"alpha":@(alpha)};
}
@end
