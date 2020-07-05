//
//  UILabel+Category.h
//  GardenManager
//
//  Created by 王 on 2019/6/19.
//  Copyright © 2019 wisezone. All rights reserved.
//



NS_ASSUME_NONNULL_BEGIN

@interface UILabel (DKCategory)

/**
 创建 label

 @param color 字体颜色
 @param font 字体大小
 @return label
 */
+ (instancetype)labelWithColor:(UIColor *)color font:(UIFont *)font;

/**
 改变属性
 
 @param attributed 属性
 @param range 位置
 */
- (void)changeAttributed:(NSDictionary <NSAttributedStringKey, id> *)attributed range:(NSRange)range;

/**
 改变行间距

 @param space 行间距
 */
- (void)changeLineSpaceForLabelWithSpace:(CGFloat)space;

/**
 改变字间距
 
 @param space 字间距
 */
- (void)changeWordSpaceForLabelWithSpace:(CGFloat)space;

/**
  改变行高

 @param space 行高
 */
- (void)changeLineHeightForLabelWithSpace:(CGFloat)space;

/// 改变行间距
/// @param lineSpace 行间距
/// @param wordSpace 字间距
- (void)changeSpaceForLabelWithLineSpace:(CGFloat)lineSpace WordSpace:(CGFloat)wordSpace;

/**
 行首缩进

 @param space 缩进间距
 */
- (void)changeHeadIndentForLabelWithSpace:(CGFloat)space;

/**
 行尾缩进

 @param space 缩进间距
 */
- (void)changeTailIndentForLabelWithSpace:(CGFloat)space;

/**
 首行缩进

 @param character 缩进字符
 */
- (void)changeFirstLineHeadIndentForLabelWithCharacter:(NSInteger)character;

/// 首尾缩进
/// @param space 缩进间距
- (void)changeIndentForLabelWithSpace:(CGFloat)space;

/// 首尾缩进
/// @param headIndent 行首缩进
/// @param tailIndent 行位缩进
- (void)changeHeadIndentForLabelWithSpace:(CGFloat)headIndent tailIndentForLabelWithSpace:(CGFloat)tailIndent;

/**
 改版颜色

 @param color 颜色
 @param range 位置
 */
- (void)changeColorWithColor:(UIColor *)color range:(NSRange)range;
/**
 添加下划线

 @param color 颜色
 @param range 位置
 */
- (void)addUnderLineWithColor:(UIColor *)color range:(NSRange)range;

/**
 获取指定字符串的 CGRect

 @param range 字符串 range
 @return CGRect
 */
- (CGRect)boundingRectForCharacterRange:(NSRange)range;

- (void)setAttributedString:(NSString *)attributedString withAttributesArray:(nullable NSArray<NSDictionary<NSAttributedStringKey, id> *> *)attributesArray;

@end

NS_ASSUME_NONNULL_END
