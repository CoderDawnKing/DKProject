//
//  DKBaseAlertController.h
//  GardenManager
//
//  Created by 王 on 2019/7/18.
//  Copyright © 2019 wisezone. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface DKBaseAlertController : UIAlertController

/**
 创建单按钮 alert 确定按钮
 
 @param title 标题
 @return self
 */
+ (instancetype)dk_AlertControllerWithTitle:(nullable NSString *)title;

/**
 创建单按钮 alert 确定按钮
 
 @param message 内容
 @return self
 */
+ (instancetype)dk_AlertControllerWithMessage:(nullable NSString *)message;

/**
 创建单按钮 alert
 @param title 标题
 @param handlerDefault 按钮回调
 @return self
 */
+ (instancetype)dk_AlertControllerWithTitle:(nullable NSString *)title
                               actionCancel:(nullable NSString *)actionCancelStr
                              handlerCancel:(void (^ __nullable)(UIAlertAction *action))handlerCancel;

/**
 创建双按钮 alert 确定取消按钮 单文本 title
 @param title 标题
 @param handlerDefault 按钮回调
 @return self
 */
+ (instancetype)dk_AlertControllerWithTitle:(nullable NSString *)title
                             handlerDefault:(void (^ __nullable)(UIAlertAction *action))handlerDefault;

/**
 创建双按钮 alert 确定取消按钮
 @param title 标题
 @param message 内容
 @param handlerDefault 按钮回调
 @return self
 */
+ (instancetype)dk_AlertControllerWithTitle:(nullable NSString *)title
                                    message:(nullable NSString *)message
                             handlerDefault:(void (^ __nullable)(UIAlertAction *action))handlerDefault;

/**
 创建双按钮 alert 按钮颜色为主色
 
 @param title 标题
 @param message 内容
 @param actionDefaultStr 按钮
 @param actionCancelStr 取消按钮
 @param handlerDefault 按钮回调
 @param handlerCancel 取消回调
 @return self
 */
+ (instancetype)dk_AlertControllerWithTitle:(nullable NSString *)title
                                    message:(nullable NSString *)message
                              actionDefault:(nullable NSString *)actionDefaultStr
                               actionCancel:(nullable NSString *)actionCancelStr
                             handlerDefault:(void (^ __nullable)(UIAlertAction *action))handlerDefault
                              handlerCancel:(void (^ __nullable)(UIAlertAction *action))handlerCancel;

/**
 创建双按钮 alert 设置按钮颜色
 
 @param title 标题
 @param message 内容
 @param actionDefaultStr 按钮
 @param actionDefaultColors 按钮颜色
 @param actionCancelStr 取消按钮
 @param actionCancelColors 取消按钮颜色
 @param handlerDefault 按钮回调
 @param handlerCancel 取消回调
 @return self
 */
+ (instancetype)dk_AlertControllerWithTitle:(nullable NSString *)title
                                    message:(nullable NSString *)message
                              actionDefault:(nullable NSString *)actionDefaultStr
                         actionDefaultColor:(nullable UIColor *)actionDefaultColor
                               actionCancel:(nullable NSString *)actionCancelStr
                          actionCancelColor:(nullable UIColor *)actionCancelColor
                             handlerDefault:(void (^ __nullable)(UIAlertAction *action))handlerDefault
                              handlerCancel:(void (^ __nullable)(UIAlertAction *action))handlerCancel;

/**
 创建多按钮 alert
 
 @param title 标题
 @param message 内容
 @param actionDefaultStrs 多个按钮按钮
 @param actionCancelStr 取消按钮
 @param handlerDefault 多个按钮回调
 @param handlerCancel 取消回调
 @return self
 */
+ (instancetype)dk_AlertControllerWithTitle:(nullable NSString *)title
                                    message:(nullable NSString *)message
                              actionDefaults:(nullable NSArray <NSString *> *)actionDefaultStrs
                             actionDefaultColors:(nullable NSArray <UIColor *> *)actionDefaultColors
                               actionCancel:(nullable NSString *)actionCancelStr
                             handlerDefaults:(void (^ __nullable)(UIAlertAction *action, NSInteger index))handlerDefaults
                              handlerCancel:(void (^ __nullable)(UIAlertAction *action))handlerCancel;


/**
 数组创建 sheet
 
 @param title 标题
 @param message 内容
 @param actionDefaultStrs 按钮数组
 @param actionCancelStr 取消按钮
 @param handlerDefault 按钮回调
 @param handlerCancel 取消回调
 @return self
 */
+ (instancetype)dk_AlertSheetWithTitle:(nullable NSString *)title
                               message:(nullable NSString *)message
                         actionDefault:(nullable NSArray <NSString *> *)actionDefaultStrs
                          actionCancel:(nullable NSString *)actionCancelStr
                        handlerDefault:(void (^ __nullable)(UIAlertAction *action, NSInteger index))handlerDefault
                         handlerCancel:(void (^ __nullable)(UIAlertAction *action))handlerCancel;

/**
 可变参数创建 sheet
 
 @param title 标题
 @param message 内容
 @param actionCancelStr 取消按钮
 @param handlerDefault 按钮回调
 @param handlerCancel 取消回调
 @param actionDefaultStrs 按钮可变参数
 @return self
 
 */
+ (instancetype)dk_AlertSheetWithTitle:(nonnull NSString*)title
                               message:(nullable NSString *)message
                          actionCancel:(nullable NSString *)actionCancelStr
                        handlerDefault:(void (^ __nullable)(UIAlertAction *action, NSInteger index))handlerDefault
                         handlerCancel:(void (^ __nullable)(UIAlertAction *action))handlerCancel
                         actionDefault:(nullable NSString *)actionDefaultStrs, ...NS_REQUIRES_NIL_TERMINATION;


/**
 显示 alert
 使用 show 不会推出两个 alert
 如果要推出两个 alert 使用 present 推出
 */
- (void)show;

@end

NS_ASSUME_NONNULL_END
