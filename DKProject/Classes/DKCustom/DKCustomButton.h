//
//  DKCustomButton.h
//  GardenManager
//
//  Created by 王 on 2019/6/24.
//  Copyright © 2019 wisezone. All rights reserved.
//

#import <QMUIKit/QMUIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef enum : NSUInteger {
    DKCustomButtonTypeImageLeft,
    DKCustomButtonTypeImageRight,
    DKCustomButtonTypeImageTop,
    DKCustomButtonTypeImageBottom,
} DKCustomButtonType;

typedef enum : NSUInteger {
    DKCustomButtonEventTypeNone,
    ///验证码倒计时
    DKCustomButtonEventTypeValidateCode,
    ///转圈圈
    DKCustomButtonEventTypeLoading,
} DKCustomButtonEventType;

@interface DKCustomButton : QMUIButton

typedef void(^DKCustomButtonClickBlock)(DKCustomButton *sender);

- (instancetype)initWithType:(DKCustomButtonType)type;
- (instancetype)initWithType:(DKCustomButtonType)type title:(nullable NSString *)title image:(nullable UIImage *)image color:(nullable UIColor *)color font:(nullable UIFont *)font;
- (instancetype)initWithType:(DKCustomButtonType)type title:(nullable NSString *)title image:(nullable UIImage *)image color:(nullable UIColor *)color font:(nullable UIFont *)font margin:(CGFloat)margin;

- (void)addEventType:(DKCustomButtonEventType)eventType clickBlock:(DKCustomButtonClickBlock)clickBlock;

@property (nonatomic, assign) CGFloat imageTop;
/// 开始倒计时
- (void)startCountDown;
/** 等待动画时显示文字 */
@property (nonatomic, copy) NSString *loadingText;
/// 开始动画
- (void)startLoadingAnimation;
/** 结束动画 */
- (void)endAnimation;

@end

NS_ASSUME_NONNULL_END
