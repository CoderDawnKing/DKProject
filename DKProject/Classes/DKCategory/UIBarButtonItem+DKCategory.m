//
//  UIBarButtonItem+Category.m
//  GardenManager
//
//  Created by 王 on 2019/6/19.
//  Copyright © 2019 wisezone. All rights reserved.
//

#import "UIBarButtonItem+DKCategory.h"
#import "UIImage+DKCategory.h"
#import "UIView+DKCategory.h"
#import "UIFont+DKCategory.h"
#import <DKProject/DKDefaultConfigure.h>
#import <DKProject/DKColorConfigure.h>
#import <DKProject/DKCustomButton.h>

@implementation UIBarButtonItem (DKCategory)

+ (instancetype)itemWithCloseTarget:(id)target action:(SEL)action {
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setBackgroundImage:dk_IMAGE(@"release_nav_ic_close") forState:UIControlStateNormal];
    [btn setBackgroundImage:dk_IMAGE(@"release_nav_ic_close") forState:UIControlStateHighlighted];
    [btn sizeToFit];
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    
    return [UIBarButtonItem itemWithTarget:target action:action image:dk_IMAGE(@"release_nav_ic_close")];
}

+ (instancetype)barButtonBackItemWithTarget:(id)target action:(SEL)action {
    return [self barButtonBackItemWithTarget:target action:action string:@"返回"];
}

+ (instancetype)barButtonBackItemWithTarget:(id)target action:(SEL)action string:(NSString *)string {
    return [self barButtonBackItemWithTarget:target action:action string:string imageEdgeInsets:UIEdgeInsetsZero contentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
}

+ (instancetype)barButtonBackItemWithTarget:(id)target action:(SEL)action string:(NSString *)string imageEdgeInsets:(UIEdgeInsets)imageEdgeInsets contentHorizontalAlignment:(UIControlContentHorizontalAlignment)contentHorizontalAlignment {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    [button setImage:[[UIImage imageNamed:@"icon_back"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
    [button setImage:nil forState:UIControlStateHighlighted];
    button.frame = CGRectMake(0, 0, 40, 44);
    [button setImageEdgeInsets:imageEdgeInsets];
    // 让按钮内部的所有内容左对齐
    button.contentHorizontalAlignment = contentHorizontalAlignment;
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    if (string) {
        [button setTitle:string forState:UIControlStateNormal];
        [button setTitleColor:dk_HexColor(COLOR_666666) forState:UIControlStateNormal];
        [button setTitleColor:dk_HexColor(COLOR_DDDDDD) forState:UIControlStateHighlighted];
        button.titleLabel.font = [UIFont systemFontOfSize:16];
        button.titleEdgeInsets = UIEdgeInsetsMake(0, 5, 0, 0);
        [button sizeToFit];
        button.width = button.width + 5;
    }
    return [[UIBarButtonItem alloc] initWithCustomView:button];
}

/**
 文字按钮 - 设置粗体文字
 */
+ (instancetype)itemWithBoldTitle:(nullable NSString *)title
                           target:(nullable id)target
                           action:(nullable SEL)action {
    return [self itemWithTarget:target
                         action:action
                          title:title
                           font:[UIFont pfBoldWithSize:16]
                     titleColor:dk_HexColor(COLOR_666666)
               highlightedColor:dk_HexColor(COLOR_DDDDDD)
                titleEdgeInsets:UIEdgeInsetsZero
     contentHorizontalAlignment:UIControlContentHorizontalAlignmentCenter];
}

/**
 图片按钮 - 设置图片
 参数:image
 */
+(instancetype)itemWithTarget:(nullable id)target
                       action:(nullable SEL)action
                        image:(nullable UIImage *)image {
    return [self itemWithTarget:target
                         action:action
                          image:image
               highlightedImage:nil];
}

/**
 图片按钮 - 设置图片,是否根据文字等比拉伸宽高
 参数:image
 */
+(instancetype)itemWithTarget:(nullable id)target
                       action:(nullable SEL)action
                        image:(nullable UIImage *)image
                   isAutoSize:(BOOL)isAutoSize {
    return [self itemWithTarget:target
                         action:action
                          title:nil
                           font:nil
                     titleColor:nil
               highlightedColor:nil
                titleEdgeInsets:UIEdgeInsetsZero
                          image:image
               highlightedImage:nil
                   disableImage:nil
                imageEdgeInsets:UIEdgeInsetsZero
     contentHorizontalAlignment:UIControlContentHorizontalAlignmentCenter
                     isAutoSize:isAutoSize
                   isRightImage:NO];
}

/**
 图片按钮 - 设置图片,内容水平对齐
 参数:image contentHorizontalAlignment
 */
+(instancetype)itemWithTarget:(nullable id)target
                       action:(nullable SEL)action
                        image:(nullable UIImage *)image
   contentHorizontalAlignment:(UIControlContentHorizontalAlignment)contentHorizontalAlignment {
    return [self itemWithTarget:target
                         action:action
                          image:image
               highlightedImage:nil
     contentHorizontalAlignment:contentHorizontalAlignment];
}

/**
 图片按钮 - 设置图片,高亮图片
 参数:image highlightedImage
 */
+(instancetype)itemWithTarget:(nullable id)target
                       action:(nullable SEL)action
                        image:(nullable UIImage *)image
             highlightedImage:(nullable UIImage *)highlightedImage {
    return [self itemWithTarget:target
                         action:action
                          image:image
               highlightedImage:highlightedImage
     contentHorizontalAlignment:UIControlContentHorizontalAlignmentCenter];
}

/**
 图片按钮 - 设置图片,高亮图片,是否根据文字等比拉伸宽高
 参数:image highlightedImage isAutoSize
 */
+(instancetype)itemWithTarget:(nullable id)target
                       action:(nullable SEL)action
                        image:(nullable UIImage *)image
             highlightedImage:(nullable UIImage *)highlightedImage
                   isAutoSize:(BOOL)isAutoSize {
    return [self itemWithTarget:target
                         action:action
                          title:nil
                           font:nil
                     titleColor:nil
               highlightedColor:nil
                titleEdgeInsets:UIEdgeInsetsZero
                          image:image
               highlightedImage:highlightedImage
                   disableImage:nil
                imageEdgeInsets:UIEdgeInsetsZero
     contentHorizontalAlignment:UIControlContentHorizontalAlignmentCenter
                     isAutoSize:isAutoSize
                   isRightImage:NO];
}

/**
 图片按钮 - 设置图片,高亮图片,内容水平对齐
 参数:image highlightedImage contentHorizontalAlignment
 */
+(instancetype)itemWithTarget:(nullable id)target
                       action:(nullable SEL)action
                        image:(nullable UIImage *)image
             highlightedImage:(nullable UIImage *)highlightedImage
   contentHorizontalAlignment:(UIControlContentHorizontalAlignment)contentHorizontalAlignment {
    return [self itemWithTarget:target
                         action:action
                          image:image
               highlightedImage:highlightedImage
                   disableImage:nil
                imageEdgeInsets:UIEdgeInsetsZero
     contentHorizontalAlignment:contentHorizontalAlignment
                     isAutoSize:YES];
}

/**
 图片按钮全能初始化方法 - 设置图片,高亮图片,图片偏移,内容水平对齐,是否根据文字等比拉伸宽高
 参数:image highlightedImage imageEdgeInsets contentHorizontalAlignment isAutoSize
 */
+(instancetype)itemWithTarget:(nullable id)target
                       action:(nullable SEL)action
                        image:(nullable UIImage *)image
             highlightedImage:(nullable UIImage *)highlightedImage
                 disableImage:(nullable UIImage *)disbaleImage
              imageEdgeInsets:(UIEdgeInsets)imageEdgeInsets
   contentHorizontalAlignment:(UIControlContentHorizontalAlignment)contentHorizontalAlignment
                   isAutoSize:(BOOL)isAutoSize {
    return [self itemWithTarget:target
                         action:action
                          title:nil
                           font:nil
                     titleColor:nil
               highlightedColor:nil
                titleEdgeInsets:UIEdgeInsetsZero
                          image:image
               highlightedImage:highlightedImage
                   disableImage:disbaleImage
                imageEdgeInsets:imageEdgeInsets
     contentHorizontalAlignment:contentHorizontalAlignment
                     isAutoSize:isAutoSize
                   isRightImage:NO];
}

/**
 文字按钮 - 设置文字
 参数:title
 */
+(instancetype)itemWithTarget:(nullable id)target
                       action:(nullable SEL)action
                        title:(nullable NSString *)title {
    return [self itemWithTarget:target
                         action:action
                          title:title
                     isAutoSize:YES];
}

/**
 文字按钮 - 设置文字,是否根据文字等比拉伸宽高
 参数:title isAutoSize
 */
+(instancetype)itemWithTarget:(nullable id)target
                       action:(nullable SEL)action
                        title:(nullable NSString *)title
                   isAutoSize:(BOOL)isAutoSize {
    return [self itemWithTarget:target
                         action:action
                          title:title
                           font:[UIFont pfRegularWithSize:16]
                     titleColor:dk_HexColor(COLOR_666666)
               highlightedColor:dk_HexColor(COLOR_666666)
                titleEdgeInsets:UIEdgeInsetsZero
                          image:nil
               highlightedImage:nil
                   disableImage:nil
                imageEdgeInsets:UIEdgeInsetsZero
     contentHorizontalAlignment:UIControlContentHorizontalAlignmentCenter
                     isAutoSize:isAutoSize
                   isRightImage:NO];
}

/**
 文字按钮 - 设置文字,颜色,高亮颜色,内容水平对齐
 参数:title titleColor highlightedColor contentHorizontalAlignment
 */
+(instancetype)itemWithTarget:(nullable id)target
                       action:(nullable SEL)action
                        title:(nullable NSString *)title
                   titleColor:(nullable UIColor *)titleColor
             highlightedColor:(nullable UIColor *)highlightedColor
   contentHorizontalAlignment:(UIControlContentHorizontalAlignment)contentHorizontalAlignment {
    return [self itemWithTarget:target
                         action:action
                          title:title
                           font:[UIFont pfRegularWithSize:16]
                     titleColor:titleColor
               highlightedColor:highlightedColor
                titleEdgeInsets:UIEdgeInsetsZero
     contentHorizontalAlignment:contentHorizontalAlignment];
}

/**
 文字按钮全能初始化 - 设置文字,字体大小,颜色,高亮颜色,文字偏移,内容水平对齐
 参数:title font titleColor highlightedColor titleEdgeInsets contentHorizontalAlignment
 */
+(instancetype)itemWithTarget:(nullable id)target
                       action:(nullable SEL)action
                        title:(nullable NSString *)title
                         font:(nullable UIFont *)font
                   titleColor:(nullable UIColor *)titleColor
             highlightedColor:(nullable UIColor *)highlightedColor
              titleEdgeInsets:(UIEdgeInsets)titleEdgeInsets
   contentHorizontalAlignment:(UIControlContentHorizontalAlignment)contentHorizontalAlignment {
    return [self itemWithTarget:target
                         action:action
                          title:title
                           font:font
                     titleColor:titleColor
               highlightedColor:highlightedColor
                titleEdgeInsets:titleEdgeInsets
                          image:nil
               highlightedImage:nil
                   disableImage:nil
                imageEdgeInsets:UIEdgeInsetsZero
     contentHorizontalAlignment:contentHorizontalAlignment
                     isAutoSize:YES
                   isRightImage:NO];
}

/**
 文字图片按钮 - 设置文字,图片
 参数:title image
 */
+(instancetype)itemWithTarget:(nullable id)target
                       action:(nullable SEL)action
                        title:(nullable NSString *)title
                        image:(nullable UIImage *)image
                 isRightImage:(BOOL)isRightImage {
    return [self itemWithTarget:target action:action title:title font:[UIFont pfRegularWithSize:16] titleColor:dk_HexColor(COLOR_666666) image:image isRightImage:isRightImage];
}

/**
 文字图片按钮 - 设置文字,字体大小,颜色,图片
 参数:title font titleColor image
 */
+(instancetype)itemWithTarget:(nullable id)target
                       action:(nullable SEL)action
                        title:(nullable NSString *)title
                         font:(nullable UIFont *)font
                   titleColor:(nullable UIColor *)titleColor
                        image:(nullable UIImage *)image
                 isRightImage:(BOOL)isRightImage {
    return [self itemWithTarget:target action:action title:title font:font titleColor:titleColor titleEdgeInsets:UIEdgeInsetsZero image:image imageEdgeInsets:UIEdgeInsetsZero isRightImage:isRightImage];
}

/**
 文字图片按钮 - 设置文字,字体大小,颜色,文字偏移,图片,图片偏移
 参数:title font titleColor titleEdgeInsets image imageEdgeInsets
 */
+(instancetype)itemWithTarget:(nullable id)target
                       action:(nullable SEL)action
                        title:(nullable NSString *)title
                         font:(nullable UIFont *)font
                   titleColor:(nullable UIColor *)titleColor
              titleEdgeInsets:(UIEdgeInsets)titleEdgeInsets
                        image:(nullable UIImage *)image
              imageEdgeInsets:(UIEdgeInsets)imageEdgeInsets
                 isRightImage:(BOOL)isRightImage {
    return [self itemWithTarget:target action:action title:title font:[UIFont pfRegularWithSize:16] titleColor:titleColor highlightedColor:nil titleEdgeInsets:titleEdgeInsets image:image highlightedImage:nil disableImage:nil imageEdgeInsets:imageEdgeInsets contentHorizontalAlignment:UIControlContentHorizontalAlignmentCenter isAutoSize:YES isRightImage:isRightImage];
}

/**
 全能初始化方法
 
 @param target target对象
 @param action 响应方法
 @param title 文字内容
 @param font 字体大小
 @param titleColor 字体颜色
 @param highlightedColor 高亮颜色
 @param titleEdgeInsets 字体偏移
 @param image 图片
 @param highlightedImage 高亮图片
 @param imageEdgeInsets 图片偏移
 @param contentHorizontalAlignment 内容水平对齐
 @param isAutoSize 是否根据文字等比拉伸宽高
 @return UIBarButtonItem
 */
+(instancetype)itemWithTarget:(nullable id)target
                       action:(nullable SEL)action
                        title:(nullable NSString *)title
                         font:(nullable UIFont *)font
                   titleColor:(nullable UIColor *)titleColor
             highlightedColor:(nullable UIColor *)highlightedColor
              titleEdgeInsets:(UIEdgeInsets)titleEdgeInsets
                        image:(nullable UIImage *)image
             highlightedImage:(nullable UIImage *)highlightedImage
                 disableImage:(nullable UIImage *)disbaleImage
              imageEdgeInsets:(UIEdgeInsets)imageEdgeInsets
   contentHorizontalAlignment:(UIControlContentHorizontalAlignment)contentHorizontalAlignment
                   isAutoSize:(BOOL)isAutoSize
                 isRightImage:(BOOL)isRightImage {
    DKCustomButtonType type = DKCustomButtonTypeDefault;
    if (isRightImage) {
        type = DKCustomButtonTypeRightImage;
    }
    DKCustomButton *button = [[DKCustomButton alloc] initWithType:type];
//    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    if (title) {
        [button setTitle:title forState:UIControlStateNormal];
    }
    if (font) {
        button.titleLabel.font = font;
    }
    [button setTitleColor:titleColor?titleColor:[UIColor blackColor] forState:UIControlStateNormal];
    if (highlightedColor) {
        [button setTitleColor:highlightedColor forState:UIControlStateHighlighted];
    }
    [button setTitleColor:dk_HexColor(COLOR_DDDDDD) forState:UIControlStateDisabled];
    
    if (image) {
        [button setImage:[image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
    }
    if (highlightedColor) {
        [button setImage:highlightedImage forState:UIControlStateHighlighted];
    }
    if (disbaleImage) {
        [button setImage:disbaleImage forState:UIControlStateDisabled];
    }
    
    [button sizeToFit];
    CGFloat width = button.bounds.size.width;
    CGFloat height = button.bounds.size.height;
    if (isAutoSize) {
        if (height < 44) {
            button.bounds = CGRectMake(0, 0, width, height);
        }
    } else {
        if (width < 40) {
            width = 40;
        }
        if (height < 44) {
            height = 44;
        }
        button.bounds = CGRectMake(0, 0, width, height);
    }
    button.titleEdgeInsets = titleEdgeInsets;
    button.imageEdgeInsets = imageEdgeInsets;
    button.contentHorizontalAlignment = contentHorizontalAlignment;
    CGFloat widthMore = 0;
    if (titleEdgeInsets.left || imageEdgeInsets.right) {
        widthMore += titleEdgeInsets.left >= imageEdgeInsets.right?titleEdgeInsets.left:imageEdgeInsets.right;
    }
    if (titleEdgeInsets.right || imageEdgeInsets.left) {
        widthMore += titleEdgeInsets.right >= imageEdgeInsets.left?titleEdgeInsets.right:imageEdgeInsets.left;
    }
    button.width += widthMore;
    
    return [[UIBarButtonItem alloc] initWithCustomView:button];
}

/**
 用作修正位置的UIBarButtonItem
 
 @param width 修正宽度
 @return 修正位置的UIBarButtonItem
 */
- (void)fixedSpaceWithWidth:(CGFloat)width {
    self.customView.width = width;
}

@end
