//
//  UIButton+DKCategory.h
//  GardenManager
//
//  Created by 王 on 2019/6/23.
//  Copyright © 2019 wisezone. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIButton (DKCategory)
/** 文字按钮 */
- (instancetype)initWithTitle:(nullable NSString *)title
                        color:(nullable UIColor *)color
                         font:(nullable UIFont *)font;
/** 文字按钮 - 设置三种状态文字颜色 */
- (instancetype)initWithTitle:(nullable NSString *)title
                        color:(nullable UIColor *)color
                selectedColor:(nullable UIColor *)selectedColor
                 disableColor:(nullable UIColor *)disableColor
                         font:(nullable UIFont *)font;
/** 文字按钮 - 设置三种状态文字 */
- (instancetype)initWithTitle:(nullable NSString *)title
                selectedTitle:(nullable NSString *)selectedTitle
                 disableTitle:(nullable NSString *)disableTitle
                        color:(nullable UIColor *)color
                selectedColor:(nullable UIColor *)selectedColor
                 disableColor:(nullable UIColor *)disableColor
                         font:(nullable UIFont *)font;

/** 图片按钮 */
- (instancetype)initWithImage:(nullable UIImage *)image;

/** 图片按钮 - 设置三种状态图片 */
- (instancetype)initWithImage:(nullable UIImage *)image
                selectedImage:(nullable UIImage *)selectedImage
                 disableImage:(nullable UIImage *)disableImage;

/** 文字图片按钮 */
- (instancetype)initWithTitle:(nullable NSString *)title
                        image:(nullable UIImage *)image
                        color:(nullable UIColor *)color
                         font:(nullable UIFont *)font;

/** 全能初始化 - 文字加图片 */
- (instancetype)initWithTitle:(nullable NSString *)title
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
                   isAutoSize:(BOOL)isAutoSize;

/** 创建多行文字按钮 */
+ (instancetype)buttonWithMultiLineTitle:(nullable NSString *)title;
/** 设置按钮富文本属性 */
- (void)setTitleString:(NSString *)titleString withAttributesArray:(nullable NSArray<NSDictionary<NSAttributedStringKey, id> *> *)attributesArray;
- (void)setAttributes:(nullable NSDictionary<NSAttributedStringKey, id> *)attributes rangeString:(nullable NSString *)rangString;

- (void)setBackgroundColor:(UIColor *)backgroundColor forState:(UIControlState)state;

@end

NS_ASSUME_NONNULL_END
