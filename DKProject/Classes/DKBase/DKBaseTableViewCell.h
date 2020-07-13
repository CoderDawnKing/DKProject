//
//  BaseTableViewCell.h
//  GardenManager
//
//  Created by 王 on 2019/6/19.
//  Copyright © 2019 wisezone. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DKBaseView;
@class DKCustonLabel;

typedef enum : NSUInteger {
    ///默认类型 只有标题 label
    DKBaseTableViewCellTypeDefault,
    ///有标题和详情 label
    DKBaseTableViewCellTypeValue1,
    ///有标题和详情 label 详情居右
    DKBaseTableViewCellTypeValue2,
    ///有标题和详情 label 标题固定高度
    DKBaseTableViewCellTypeValue3,
    ///有标题和左侧图片
    DKBaseTableViewCellTypeImageLeft,
    ///有标题和右侧图片
    DKBaseTableViewCellTypeImageRight,
    ///有标题 详情
    DKBaseTableViewCellTypeSubtitle,
    ///有标题 详情 左侧图片
    DKBaseTableViewCellTypeSubtitle1,
    ///只有输入框
    DKBaseTableViewCellTypeTextField,
    ///有标题输入框
    DKBaseTableViewCellTypeTitleTextField,
    ///有标题输入框
    DKBaseTableViewCellTypeTitleRightTextField,
    ///有标题输入框带单位
    DKBaseTableViewCellTypeTitleRightTextFieldUnit,
    ///自定义
    DKBaseTableViewCellTypeCustom,
} DKBaseTableViewCellType;

typedef NS_ENUM(NSInteger, DKBaseTableViewCellSelectionStyle) {
    DKBaseTableViewCellSelectionStyleNone,
    DKBaseTableViewCellSelectionStyleDefault,
};

NS_ASSUME_NONNULL_BEGIN
@protocol DKBaseCellProtocol <NSObject>
/** 加载子视图 */
- (void)__addSubViews;
/** 添加模型 */
- (void)__addViewModel;
/** 布置约束 */
- (void)__makeConstraints;
/** 更新约束 */
- (void)__updateConstraints;
/** 设置 cell 是否圆角 */
- (void)__setRoundedCorner;

@end

@interface DKBaseTableViewCell : UITableViewCell<DKBaseCellProtocol>
/** 输入框 */
@property (nonatomic, strong) UITextField *textField;
/** 顶部长线 */
@property (nonatomic, strong) DKBaseView *topLine;
/** 底部长线 */
@property (nonatomic, strong) DKBaseView *bottomLine;
/** 标题 */
@property (nonatomic, strong) DKCustonLabel *title;
/** 详情 */
@property (nonatomic, strong) DKCustonLabel *detail;
/** 图片 */
@property (nonatomic, strong) UIImageView *imageV;
/** 右侧箭头 */
@property (nonatomic, strong) UIImageView *arrow;
/** 背景view */
@property (nonatomic, strong) DKBaseView *cellBackgroundView;
/** 背景view内边距 */
@property (nonatomic, assign) UIEdgeInsets insets;
/** cell 类型 */
@property (nonatomic, assign) DKBaseTableViewCellType dk_type;
/** 是否有箭头 */
@property (nonatomic, assign, getter=isHasArrow) BOOL hasArrow;
/** 是否有圆角 */
@property (nonatomic, assign, getter=isHasRoundedCorner) BOOL hasRoundedCorner;
/** 圆角位置 */
@property (nonatomic, assign) UIRectCorner rectCorner;
/// 圆角弧度
@property (nonatomic, assign) CGFloat cornerRadii;
/** cell 背景色 */
@property (nonatomic, strong, nullable) UIColor *cellBackgroundColor;
/** 图片是否有圆角 */
@property (nonatomic, assign, getter=isHasImageRoundedCorner) BOOL hasImageRoundedCorner;
/// 图片圆角弧度
@property (nonatomic, assign) CGFloat imageRoundedCorner;
/** 顶部线内边距 */
@property (nonatomic, assign) UIEdgeInsets topLineInsets;
/** 底部线内边距 */
@property (nonatomic, assign) UIEdgeInsets bottomLineInsets;
/** 虚线内边距 */
@property (nonatomic, assign) UIEdgeInsets dottedLineInsets;
/** 内部 Label 内边距 */
@property (nonatomic, assign) UIEdgeInsets labelInsets;
/** 箭头边距 */
@property (nonatomic, assign) UIEdgeInsets arrowInsets;
///虚线 后期绘制
@property (nonatomic, strong) UIImageView *dottedLine;
///选择状态
@property (nonatomic, assign) DKBaseTableViewCellSelectionStyle dk_selectionStyle;
/// 输入框预估宽度
@property (nonatomic, assign) CGFloat textFieldEstimatedWidth;

/**
 创建cell 可修改 cell 的四方边距

 @param type cell 类型
 @param ident 重用标识符
 @param hasArrow 是否有右侧箭头
 @param hasRoundedCorner 是否圆角
 @param insets cell 四方边距
 @param rectCorner 圆角类型
 @return cell
 */
+ (instancetype)cellWithType:(DKBaseTableViewCellType)type
                       ident:(nullable NSString *)ident
                    hasArrow:(BOOL)hasArrow
            hasRoundedCorner:(BOOL)hasRoundedCorner
                      insets:(UIEdgeInsets)insets
                  rectCorner:(UIRectCorner)rectCorner;

/**
 创建cell 可修改 cell 的四方边距

 @param type cell 类型
 @param ident 重用标识符
 @param hasArrow 是否有右侧箭头
 @param hasRoundedCorner 是否圆角
 @param insets cell 四方边距
 @return cell
 */
+ (instancetype)cellWithType:(DKBaseTableViewCellType)type
                       ident:(nullable NSString *)ident
                    hasArrow:(BOOL)hasArrow
            hasRoundedCorner:(BOOL)hasRoundedCorner
                      insets:(UIEdgeInsets)insets;
/**
 创建cell 可修改 cell 的左右边距 上下边距为 0
 
 @param type cell 类型
 @param ident 重用标识符
 @param hasArrow 是否有右侧箭头
 @param hasRoundedCorner 是否圆角
 @param margin cell 左右边距 上下边距为 0
 @param rectCorner 圆角类型
 @return cell
 */
+ (instancetype)cellWithType:(DKBaseTableViewCellType)type
                       ident:(nullable NSString *)ident
                    hasArrow:(BOOL)hasArrow
            hasRoundedCorner:(BOOL)hasRoundedCorner
                      margin:(CGFloat)margin
                  rectCorner:(UIRectCorner)rectCorner;

/**
 创建cell 可修改 cell 的左右边距 上下边距为 0
 
 @param type cell 类型
 @param ident 重用标识符
 @param hasArrow 是否有右侧箭头
 @param hasRoundedCorner 是否圆角
 @param margin cell 左右边距 上下边距为 0
 @return cell
 */
+ (instancetype)cellWithType:(DKBaseTableViewCellType)type
                       ident:(nullable NSString *)ident
                    hasArrow:(BOOL)hasArrow
            hasRoundedCorner:(BOOL)hasRoundedCorner
                      margin:(CGFloat)margin;

/**
 创建cell cell 边距 为 0
 */
+ (instancetype)cellWithType:(DKBaseTableViewCellType)type
                       ident:(nullable NSString *)ident
                    hasArrow:(BOOL)hasArrow
            hasRoundedCorner:(BOOL)hasRoundedCorner
                  rectCorner:(UIRectCorner)rectCorner;
/**
 创建cell cell 边距 为 0 圆角为 All
 */
+ (instancetype)cellWithType:(DKBaseTableViewCellType)type
                       ident:(nullable NSString *)ident
                    hasArrow:(BOOL)hasArrow
            hasRoundedCorner:(BOOL)hasRoundedCorner;
/**
 创建cell 没有圆角 cell 边距 为 0
 */
+ (instancetype)cellWithType:(DKBaseTableViewCellType)type
                       ident:(nullable NSString *)ident
                    hasArrow:(BOOL)hasArrow;
/**
 创建cell 没有右侧箭头 没有圆角 边距 为 0
 */
+ (instancetype)cellWithType:(DKBaseTableViewCellType)type
                       ident:(nullable NSString *)ident;


- (instancetype)initWithStyle:(UITableViewCellStyle)style
              reuseIdentifier:(NSString *)reuseIdentifier
                         type:(DKBaseTableViewCellType)type
                       insets:(UIEdgeInsets)insets
                     hasArrow:(BOOL)hasArrow
             hasRoundedCorner:(BOOL)hasRoundedCorner;

- (instancetype)initWithStyle:(UITableViewCellStyle)style
              reuseIdentifier:(NSString *)reuseIdentifier
                         type:(DKBaseTableViewCellType)type
                       insets:(UIEdgeInsets)insets
                     hasArrow:(BOOL)hasArrow
             hasRoundedCorner:(BOOL)hasRoundedCorner
                   rectCorner:(UIRectCorner)rectCorner;
/**
 设置输入框属性

 @param placeholder 占位符
 @param textColor 字体颜色
 @param font 字体大小
 */
- (void)setFiedlPlaceholder:(NSString *)placeholder
                  textColor:(NSString *)textColor
                       font:(NSInteger)font;

@end

NS_ASSUME_NONNULL_END
