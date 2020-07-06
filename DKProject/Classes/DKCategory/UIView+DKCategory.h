//
//  UIView+DKCategory.h
//  GardenManager
//
//  Created by 王 on 2019/6/23.
//  Copyright © 2019 wisezone. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, DKViewBorderType) {
    ///default
    DKViewBorderTypeNone      = 1,       //值=1   向左位移0位   转换成2进制=1       转换成10进制=1
    DKViewBorderTypeTop       = 1 << 1,  //值=2   向左位移1位   转换成2进制=10      转换成10进制=2
    DKViewBorderTypeLeft      = 1 << 2,  //值=4   向左位移2位   转换成2进制=100     转换成10进制=4
    DKViewBorderTypeRight     = 1 << 3,  //值=8   向左位移3位   转换成2进制=1000    转换成10进制=8
    DKViewBorderTypeBottom    = 1 << 4,  //值=16  向左位移4位   转换成2进制=10000   转换成10进制=16
    DKViewBorderTypeAll = DKViewBorderTypeTop|DKViewBorderTypeLeft|DKViewBorderTypeBottom|DKViewBorderTypeRight,
};

typedef NS_ENUM(NSInteger , DKShadowPathType) {
    DKShadowPathTop    = 1,
    DKShadowPathBottom = 2,
    DKShadowPathLeft   = 3,
    DKShadowPathRight  = 4,
    DKShadowPathCommon = 5,
    DKShadowPathAround = 6,
};

typedef void(^DK_TapGestureRecognizerBlock)(UITapGestureRecognizer *tap);
typedef void(^DK_PanGestureRecognizerBlock)(UIPanGestureRecognizer *pan);
typedef void(^DK_LongPressGestureRecognizerBlock)(UILongPressGestureRecognizer *longPress);

@interface UIView (DKCategory)

@property (nonatomic, assign) CGFloat left;
@property (nonatomic, assign) CGFloat right;
@property (nonatomic, assign) CGFloat top;
@property (nonatomic, assign) CGFloat bottom;

@property (nonatomic, assign) CGFloat x;
@property (nonatomic, assign) CGFloat y;
@property (nonatomic, assign) CGFloat centerX;
@property (nonatomic, assign) CGFloat centerY;
@property (nonatomic, assign) CGFloat width;
@property (nonatomic, assign) CGFloat height;
@property (nonatomic, assign) CGSize  size;
@property (nonatomic, assign) CGPoint origin;

@property (nonatomic, assign, readonly) CGPoint boundsCenter;
@property (nonatomic, assign, readonly) CGFloat boundsCenterX;
@property (nonatomic, assign, readonly) CGFloat boundsCenterY;

//圆角
- (void)dk_radius;
- (void)dk_cornerRadii:(CGFloat)cornerRadii;
- (void)dk_roundingCorners:(UIRectCorner)corners cornerRadii:(CGFloat)cornerRadii;
//阴影
- (void)dk_addShadowDefault;
- (void)dk_addShadowRadius:(CGFloat)shadowRadius;
- (void)dk_addShadowRadius:(CGFloat)shadowRadius cornerRadius:(CGFloat)cornerRadius;
- (void)dk_addShadowWithColor:(UIColor *)shadowColor shadowOffset:(CGSize)shadowOffset shadowOpacity:(CGFloat)shadowOpacity shadowRadius:(CGFloat)shadowRadius;
- (void)dk_addShadowWithColor:(UIColor *)shadowColor shadowOffset:(CGSize)shadowOffset shadowOpacity:(CGFloat)shadowOpacity shadowRadius:(CGFloat)shadowRadius cornerRadius:(CGFloat)cornerRadius;
- (void)dk_addShadowWithColor:(UIColor *)shadowColor shadowOffset:(CGSize)shadowOffset shadowOpacity:(CGFloat)shadowOpacity shadowRadius:(CGFloat)shadowRadius cornerRadius:(CGFloat)cornerRadius roundingCorners:(UIRectCorner)corners;
- (void)dk_viewShadowPathWithColor:(UIColor *)shadowColor shadowOpacity:(CGFloat)shadowOpacity shadowRadius:(CGFloat)shadowRadius shadowPathType:(DKShadowPathType)shadowPathType shadowPathWidth:(CGFloat)shadowPathWidth;
//边框
- (void)dk_addBorderDefault;
- (void)dk_addBorderWithColor:(UIColor *)borderColor width:(CGFloat)borderWidth;
//虚线边框
- (void)dk_addDottedLineBorderWithColor:(UIColor *)borderColor width:(CGFloat)borderWidth  cornerRadii:(CGFloat)cornerRadii;
- (void)dk_addDottedLineWithLineWidth:(CGFloat)lineWidth
                       lineSpacing:(CGFloat)lineSpacing
                         lineColor:(UIColor *)lineColor
                     lineDirection:(BOOL)isHorizonal;

/** 圆角时显示被裁剪，后期修改 */
/** default #DDDDDD */
@property (nullable,nonatomic, copy) UIColor *dk_borderColor;
/** default 0.5f */
@property (nonatomic) CGFloat dk_borderWidth;
/** default ViewBorderTypeNone */
@property (nonatomic) DKViewBorderType dk_borderType;

/// 将 UIView 转换成 UIImage
- (UIImage *)dk_convertCreateImage;


/// 添加 tap 手势
/// @param tapGestureRecognizerBlock block 点击回调
- (void)dk_addTapGestureRecognizer:(DK_TapGestureRecognizerBlock)tapGestureRecognizerBlock;
/// 添加 pan 手势
/// @param panGestureRecognizerBlock block 点击回调
- (void)dk_addPanGestureRecognizer:(DK_PanGestureRecognizerBlock)panGestureRecognizerBlock;
/// 添加 long 手势
/// @param longPressGestureRecognizerBlock  block 点击回调
- (void)dk_addLongPressGestureRecognizer:(DK_LongPressGestureRecognizerBlock)longPressGestureRecognizerBlock;
/// 移除所有手势
- (void)dk_removeAllGestureRecognizer;

@end

NS_ASSUME_NONNULL_END
