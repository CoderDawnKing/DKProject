//
//  UITextView+DKCategory.h
//  GardenManager
//
//  Created by 王 on 2019/7/4.
//  Copyright © 2019 wisezone. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITextView (DKCategory)

/*########################属性###########################*/

/** 占位符 label */
@property (nonatomic, readonly) UILabel *placeholderLabel;
/** 占位符 */
@property (nonatomic, copy) NSString *placeholder_text;
/** 占位符字体颜色 */
@property (nonatomic, strong) UIColor *placeholder_color;
/** 占位符富文本 */
@property (nonatomic, copy) NSAttributedString *placeholder_attributed;
/*########################成员变量###########################*/

/**
 占位符的字体大小  此属性无需设置
 */
@property (nonatomic,strong) UIFont *placeholder_font;

/**
 自动增长
 */
@property (nonatomic,assign) BOOL isAutoHeight;

/**
 最高增长高度
 */
@property (nonatomic,assign) CGFloat maxAutoHeight;

/**
 最小收缩高度
 */
@property (nonatomic,assign) CGFloat minAutoHeight;

@property (nonatomic,assign) NSUInteger dk_maxNumberOfLines;

@property (nonatomic,assign) BOOL dk_autoLineBreak;


+ (UIColor *)defaultPlaceholderColor;



@end
