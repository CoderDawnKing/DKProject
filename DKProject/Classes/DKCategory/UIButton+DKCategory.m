//
//  UIButton+DKCategory.m
//  GardenManager
//
//  Created by 王 on 2019/6/23.
//  Copyright © 2019 wisezone. All rights reserved.
//

#import "UIButton+DKCategory.h"
#import "UIImage+DKCategory.h"
#import <objc/runtime.h>
#import <DKProject/DKColorConfigure.h>
#import <DKProject/DKDefaultConfigure.h>
@implementation UIButton (DKCategory)

+ (void)load {
    Method fromMethod = class_getInstanceMethod([self class], @selector(setHighlighted:));
    Method toMethod = class_getInstanceMethod([self class], @selector(swizzlingSetHighlighted:));
    // 验证
    if (!class_addMethod([self class], @selector(swizzlingSetHighlighted:), method_getImplementation(toMethod), method_getTypeEncoding(toMethod))) {
        method_exchangeImplementations(fromMethod, toMethod);
    }
}

/// 去除 button 选中下的高亮状态
- (void)swizzlingSetHighlighted:(BOOL)highlighted {
    if (self.isSelected) {
        [self swizzlingSetHighlighted:NO];
    }else {
        [self swizzlingSetHighlighted:highlighted];
    }
}

/** 文字按钮 */
- (instancetype)initWithTitle:(nullable NSString *)title
                        color:(nullable UIColor *)color
                         font:(nullable UIFont *)font {
    return [self initWithTitle:title color:color selectedColor:nil disableColor:nil font:font];
}

- (instancetype)initWithTitle:(nullable NSString *)title
                        color:(nullable UIColor *)color
                selectedColor:(nullable UIColor *)selectedColor
                 disableColor:(nullable UIColor *)disableColor
                         font:(nullable UIFont *)font {
    return [self initWithTitle:title selectedTitle:nil disableTitle:nil color:color selectedColor:selectedColor disableColor:disableColor font:font];
}

/** 文字按钮 - 设置三种状态文字 */
- (instancetype)initWithTitle:(nullable NSString *)title
                selectedTitle:(nullable NSString *)selectedTitle
                 disableTitle:(nullable NSString *)disableTitle
                        color:(nullable UIColor *)color
                selectedColor:(nullable UIColor *)selectedColor
                 disableColor:(nullable UIColor *)disableColor
                         font:(nullable UIFont *)font {
    return [self initWithTitle:title selectedTitle:selectedTitle disableTitle:disableTitle image:nil selectedImage:nil disableImage:nil color:color selectedColor:selectedColor disableColor:disableColor font:font backgroundColor:nil selectedBackgroundColor:nil disableBackgroundColor:nil titleEdgeInsets:UIEdgeInsetsZero imageEdgeInsets:UIEdgeInsetsZero isAutoSize:NO];
}

/** 图片按钮 */
- (instancetype)initWithImage:(nullable UIImage *)image {
    return [self initWithImage:image selectedImage:nil disableImage:nil];
}

/** 图片按钮 - 设置三种状态图片 */
- (instancetype)initWithImage:(nullable UIImage *)image
                selectedImage:(nullable UIImage *)selectedImage
                 disableImage:(nullable UIImage *)disableImage {
    return [self initWithTitle:nil selectedTitle:nil disableTitle:nil image:image selectedImage:selectedImage disableImage:disableImage color:nil selectedColor:nil disableColor:nil font:nil backgroundColor:nil selectedBackgroundColor:nil disableBackgroundColor:nil titleEdgeInsets:UIEdgeInsetsZero imageEdgeInsets:UIEdgeInsetsZero isAutoSize:NO];
}
/** 文字图片按钮 */
- (instancetype)initWithTitle:(nullable NSString *)title
                        image:(nullable UIImage *)image
                        color:(nullable UIColor *)color
                         font:(nullable UIFont *)font {
    return [self initWithTitle:title selectedTitle:nil disableTitle:nil image:image selectedImage:nil disableImage:nil color:color selectedColor:nil disableColor:nil font:font backgroundColor:nil selectedBackgroundColor:nil disableBackgroundColor:nil titleEdgeInsets:UIEdgeInsetsZero imageEdgeInsets:UIEdgeInsetsZero isAutoSize:NO];
}

/** 全能初始化 - 文字加图片 */
- (instancetype)initWithTitle:(NSString *)title
                selectedTitle:(nullable NSString *)selectedTitle
                 disableTitle:(nullable NSString *)disableTitle
                        image:(nullable UIImage *)image
                selectedImage:(nullable UIImage *)selectedImage
                 disableImage:(nullable UIImage *)disableImage
                        color:(nullable UIColor *)color
                selectedColor:(nullable UIColor *)selectedColor
                 disableColor:(nullable UIColor *)disableColor
                         font:(nullable UIFont *)font
              backgroundColor:(nullable UIColor *)backgroundColor
      selectedBackgroundColor:(nullable UIColor *)selectedBackgroundColor
       disableBackgroundColor:(nullable UIColor *)disableBackgroundColor
              titleEdgeInsets:(UIEdgeInsets)titleEdgeInsets
              imageEdgeInsets:(UIEdgeInsets)imageEdgeInsets
                   isAutoSize:(BOOL)isAutoSize {
    if (self = [super init]) {
        if (title) {
            [self setTitle:title forState:UIControlStateNormal];
        }
        if (selectedTitle) {
            [self setTitle:selectedTitle forState:UIControlStateSelected];
        }
        if (disableTitle) {
            [self setTitle:disableTitle forState:UIControlStateDisabled];
        }
        if (color) {
            [self setTitleColor:color forState:UIControlStateNormal];
        }
        if (selectedColor) {
            [self setTitleColor:selectedColor forState:UIControlStateSelected];
        }
        if (disableColor) {
            [self setTitleColor:disableColor forState:UIControlStateDisabled];
        }
        if (image) {
            [self setImage:image forState:UIControlStateNormal];
        }
        if (selectedImage) {
            [self setImage:selectedImage forState:UIControlStateSelected];
        }
        if (disableImage) {
            [self setImage:disableImage forState:UIControlStateDisabled];
        }
        if (backgroundColor) {
            [self setBackgroundImage:[UIImage imageWithColor:backgroundColor size:CGSizeMake(1, 1)] forState:UIControlStateNormal];
        }
        if (selectedBackgroundColor) {
            [self setBackgroundImage:[UIImage imageWithColor:selectedBackgroundColor size:CGSizeMake(1, 1)] forState:UIControlStateSelected];
        }
        if (disableBackgroundColor) {
            [self setBackgroundImage:[UIImage imageWithColor:disableBackgroundColor size:CGSizeMake(1, 1)] forState:UIControlStateDisabled];
        }
        if (font) {
            self.titleLabel.font = font;
        }
        
        [self setTitleEdgeInsets:titleEdgeInsets];
        [self setImageEdgeInsets:imageEdgeInsets];
        if (isAutoSize) {
            //设置字体大小适应label宽度
            self.titleLabel.adjustsFontSizeToFitWidth = YES;
            self.titleLabel.baselineAdjustment = UIBaselineAdjustmentAlignCenters;
        }
    }
    return self;
}

+ (instancetype)buttonWithMultiLineTitle:(nullable NSString *)title {
    UIButton *multiLine = [[UIButton alloc] init];
    [multiLine setTitle:title forState:UIControlStateNormal];
    multiLine.titleLabel.numberOfLines = 0;
    multiLine.titleLabel.textAlignment = NSTextAlignmentCenter;
    return multiLine;
}

- (void)setTitleString:(NSString *)titleString withAttributesArray:(nullable NSArray<NSDictionary<NSAttributedStringKey, id> *> *)attributesArray {
    NSArray *stringArray = [titleString componentsSeparatedByString:@"\n"];
    if (attributesArray.count == stringArray.count) {
        NSMutableAttributedString *attrString = [[NSMutableAttributedString alloc] initWithString:titleString];
        [stringArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [attrString setAttributes:attributesArray[idx] range:[titleString rangeOfString:obj]];
        }];
        [self setAttributedTitle:attrString forState:UIControlStateNormal];
    }
}

- (void)setAttributes:(NSDictionary<NSAttributedStringKey,id> *)attributes rangeString:(NSString *)rangString {
    NSMutableAttributedString *attrString = [[NSMutableAttributedString alloc] initWithString:self.titleLabel.text];
    [attrString setAttributes:attributes range:[self.titleLabel.text rangeOfString:rangString]];
    [self setAttributedTitle:attrString forState:UIControlStateNormal];
}

- (void)setBackgroundColor:(UIColor *)backgroundColor forState:(UIControlState)state {
    [self setBackgroundImage:[UIImage imageWithColor:backgroundColor] forState:state];
}

@end
