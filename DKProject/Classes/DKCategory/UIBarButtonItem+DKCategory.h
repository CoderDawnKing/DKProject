//
//  UIBarButtonItem+Category.h
//  GardenManager
//
//  Created by 王 on 2019/6/19.
//  Copyright © 2019 wisezone. All rights reserved.
//



NS_ASSUME_NONNULL_BEGIN

@interface UIBarButtonItem (DKCategory)

/**
 创建 x 按钮
 */
+ (instancetype)itemWithCloseTarget:(nullable id)target action:(nullable SEL)action;

/**
 返回按钮
 */
+ (instancetype)barButtonBackItemWithTarget:(nullable id)target
                                     action:(nullable SEL)action;

/**
 返回按钮-自定义文字
 */
+ (instancetype)barButtonBackItemWithTarget:(nullable id)target
                                     action:(nullable SEL)action
                                     string:(nullable NSString *)string;
/** 返回按钮-自定义文字 内容水平对齐 */
+ (instancetype)barButtonBackItemWithTarget:(nullable id)target
                                     action:(nullable SEL)action
                                     string:(nullable NSString *)string
                            imageEdgeInsets:(UIEdgeInsets)imageEdgeInsets
                 contentHorizontalAlignment:(UIControlContentHorizontalAlignment)contentHorizontalAlignment;

/**
 文字按钮 - 设置粗体文字
 */
+ (instancetype)itemWithBoldTitle:(nullable NSString *)title
                           target:(nullable id)target
                           action:(nullable SEL)action;

/**
 图片按钮 - 设置图片
 参数:image
 */
+(instancetype)itemWithTarget:(nullable id)target
                       action:(nullable SEL)action
                        image:(nullable UIImage *)image;
/**
 图片按钮 - 设置图片,是否根据文字等比拉伸宽高
 参数:image isAutoSize
 */
+(instancetype)itemWithTarget:(nullable id)target
                       action:(nullable SEL)action
                        image:(nullable UIImage *)image
                   isAutoSize:(BOOL)isAutoSize;

/**
 图片按钮 - 设置图片,内容水平对齐
 参数:image contentHorizontalAlignment
 */
+(instancetype)itemWithTarget:(nullable id)target
                       action:(nullable SEL)action
                        image:(nullable UIImage *)image
   contentHorizontalAlignment:(UIControlContentHorizontalAlignment)contentHorizontalAlignment;

/**
 图片按钮 - 设置图片,高亮图片
 参数:image highlightedImage
 */
+(instancetype)itemWithTarget:(nullable id)target
                       action:(nullable SEL)action
                        image:(nullable UIImage *)image
             highlightedImage:(nullable UIImage *)highlightedImage;

/**
 图片按钮 - 设置图片,高亮图片,是否根据文字等比拉伸宽高
 参数:image highlightedImage isAutoSize
 */
+(instancetype)itemWithTarget:(nullable id)target
                       action:(nullable SEL)action
                        image:(nullable UIImage *)image
             highlightedImage:(nullable UIImage *)highlightedImage
                   isAutoSize:(BOOL)isAutoSize;

/**
 图片按钮 - 设置图片,高亮图片,内容水平对齐
 参数:image highlightedImage contentHorizontalAlignment
 */
+(instancetype)itemWithTarget:(nullable id)target
                       action:(nullable SEL)action
                        image:(nullable UIImage *)image
             highlightedImage:(nullable UIImage *)highlightedImage
   contentHorizontalAlignment:(UIControlContentHorizontalAlignment)contentHorizontalAlignment;

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
                   isAutoSize:(BOOL)isAutoSize;


/**
 文字按钮 - 设置文字
 参数:title
 */
+(instancetype)itemWithTarget:(nullable id)target
                       action:(nullable SEL)action
                        title:(nullable NSString *)title;
/**
 文字按钮 - 设置文字,是否根据文字等比拉伸宽高
 参数:title isAutoSize
 */
+(instancetype)itemWithTarget:(nullable id)target
                       action:(nullable SEL)action
                        title:(nullable NSString *)title
                   isAutoSize:(BOOL)isAutoSize;
/**
 文字按钮 - 设置文字,颜色,高亮颜色,内容水平对齐
 参数:title titleColor highlightedColor contentHorizontalAlignment
 */
+(instancetype)itemWithTarget:(nullable id)target
                       action:(nullable SEL)action
                        title:(nullable NSString *)title
                   titleColor:(nullable UIColor *)titleColor
             highlightedColor:(nullable UIColor *)highlightedColor
   contentHorizontalAlignment:(UIControlContentHorizontalAlignment)contentHorizontalAlignment;
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
   contentHorizontalAlignment:(UIControlContentHorizontalAlignment)contentHorizontalAlignment;


/**
 文字图片按钮 - 设置文字,图片
 参数:title image
 */
+(instancetype)itemWithTarget:(nullable id)target
                       action:(nullable SEL)action
                        title:(nullable NSString *)title
                        image:(nullable UIImage *)image
                 isRightImage:(BOOL)isRightImage;

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
                 isRightImage:(BOOL)isRightImage;

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
                 isRightImage:(BOOL)isRightImage;

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
 @param disbaleImage 禁用图片
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
                 isRightImage:(BOOL)isRightImage;

/// 用作修正位置的UIBarButtonItem
/// @param width 修正宽度
- (void)fixedSpaceWithWidth:(CGFloat)width;

@end

NS_ASSUME_NONNULL_END
