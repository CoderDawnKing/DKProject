//
//  DKBaseAlertController.m
//  GardenManager
//
//  Created by 王 on 2019/7/18.
//  Copyright © 2019 wisezone. All rights reserved.
//

#import "DKBaseAlertController.h"
#import <DKProject/DKProject.h>

@implementation DKBaseAlertController

+ (instancetype)dk_AlertControllerWithTitle:(nullable NSString *)title {
    return [self dk_AlertControllerWithTitle:title actionCancel:@"确定" handlerCancel:nil];
}

+ (instancetype)dk_AlertControllerWithMessage:(nullable NSString *)message {
    return [self dk_AlertControllerWithTitle:nil message:message actionDefault:nil actionCancel:@"确定" handlerDefault:nil handlerCancel:nil];
}

+ (instancetype)dk_AlertControllerWithTitle:(nullable NSString *)title
                               actionCancel:(nullable NSString *)actionCancelStr
                              handlerCancel:(void (^ __nullable)(UIAlertAction *action))handlerCancel {
    return [self dk_AlertControllerWithTitle:title message:nil actionDefault:nil actionCancel:actionCancelStr handlerDefault:nil handlerCancel:handlerCancel];
}

+ (instancetype)dk_AlertControllerWithTitle:(nullable NSString *)title
                             handlerDefault:(void (^ __nullable)(UIAlertAction *action))handlerDefault {
    return [self dk_AlertControllerWithTitle:title message:nil handlerDefault:handlerDefault];
}

+ (instancetype)dk_AlertControllerWithTitle:(nullable NSString *)title
                                    message:(nullable NSString *)message
                             handlerDefault:(void (^ __nullable)(UIAlertAction *action))handlerDefault {
    return [self dk_AlertControllerWithTitle:title message:message actionDefault:@"确定" actionCancel:@"取消" handlerDefault:handlerDefault handlerCancel:nil];
}

+ (instancetype)dk_AlertControllerWithTitle:(NSString *)title message:(NSString *)message actionDefault:(NSString *)actionDefaultStr actionCancel:(NSString *)actionCancelStr handlerDefault:(void (^)(UIAlertAction *))handlerDefault handlerCancel:(void (^)(UIAlertAction *))handlerCancel {
    return [self dk_AlertControllerWithTitle:title message:message actionDefault:actionDefaultStr actionDefaultColor:dk_HexColor(COLOR_APPMAIN) actionCancel:actionCancelStr actionCancelColor:dk_HexColor(COLOR_414141) handlerDefault:handlerDefault handlerCancel:handlerCancel];
}

+ (instancetype)dk_AlertControllerWithTitle:(nullable NSString *)title
                                    message:(nullable NSString *)message
                              actionDefault:(nullable NSString *)actionDefaultStr
                         actionDefaultColor:(nullable UIColor *)actionDefaultColor
                               actionCancel:(nullable NSString *)actionCancelStr
                          actionCancelColor:(nullable UIColor *)actionCancelColor
                             handlerDefault:(void (^ __nullable)(UIAlertAction *action))handlerDefault
                              handlerCancel:(void (^ __nullable)(UIAlertAction *action))handlerCancel {
    DKBaseAlertController *alert = [self alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    
    //修改 title
    if (title) {
        NSMutableAttributedString *alertControllerStr = [[NSMutableAttributedString alloc] initWithString:title];
        [alertControllerStr addAttribute:NSForegroundColorAttributeName value:dk_HexColor(COLOR_414141) range:NSMakeRange(0, title.length)];
        [alertControllerStr addAttribute:NSFontAttributeName value:[UIFont pfMediumWithSize:17] range:NSMakeRange(0, title.length)];
        [alert setValue:alertControllerStr forKey:@"attributedTitle"];
    }
    
    //修改 message
    if (message) {
        NSMutableAttributedString *alertControllerMessageStr = [[NSMutableAttributedString alloc] initWithString:message];
        UIColor *msgColor = dk_HexColor(COLOR_999999);
        if (!title) {
            msgColor = dk_HexColor(COLOR_414141);
        }
        [alertControllerMessageStr addAttribute:NSForegroundColorAttributeName value:msgColor range:NSMakeRange(0, message.length)];
        [alertControllerMessageStr addAttribute:NSFontAttributeName value:[UIFont pfRegularWithSize:14] range:NSMakeRange(0, message.length)];
        [alert setValue:alertControllerMessageStr forKey:@"attributedMessage"];
    }
    
    if (actionDefaultStr) {
        UIAlertAction *actionDefault = [UIAlertAction actionWithTitle:actionDefaultStr style:UIAlertActionStyleDefault handler:handlerDefault];
        //修改 action
        [actionDefault setValue:actionDefaultColor?:dk_HexColor(COLOR_APPMAIN) forKey:@"titleTextColor"];
        [alert addAction:actionDefault];
    }
    
    if (actionCancelStr) {
        UIAlertAction *actionCancel = [UIAlertAction actionWithTitle:actionCancelStr style:UIAlertActionStyleCancel handler:handlerCancel];
        //修改 action
        [actionCancel setValue:actionCancelColor?:dk_HexColor(COLOR_414141) forKey:@"titleTextColor"];
        [alert addAction:actionCancel];
    }
    
    return alert;
}

+ (instancetype)dk_AlertControllerWithTitle:(nullable NSString *)title
                                    message:(nullable NSString *)message
                             actionDefaults:(nullable NSArray <NSString *> *)actionDefaultStrs
                        actionDefaultColors:(nullable NSArray <UIColor *> *)actionDefaultColors
                               actionCancel:(nullable NSString *)actionCancelStr
                            handlerDefaults:(void (^ __nullable)(UIAlertAction *action, NSInteger index))handlerDefaults
                              handlerCancel:(void (^ __nullable)(UIAlertAction *action))handlerCancel {
    DKBaseAlertController *alert = [self alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    
    //修改 title
    if (title) {
        NSMutableAttributedString *alertControllerStr = [[NSMutableAttributedString alloc] initWithString:title];
        [alertControllerStr addAttribute:NSForegroundColorAttributeName value:dk_HexColor(COLOR_414141) range:NSMakeRange(0, title.length)];
        [alertControllerStr addAttribute:NSFontAttributeName value:[UIFont pfMediumWithSize:17] range:NSMakeRange(0, title.length)];
        [alert setValue:alertControllerStr forKey:@"attributedTitle"];
    }
    
    //修改 message
    if (message) {
        NSMutableAttributedString *alertControllerMessageStr = [[NSMutableAttributedString alloc] initWithString:message];
        UIColor *msgColor = dk_HexColor(COLOR_999999);
        if (!title) {
            msgColor = dk_HexColor(COLOR_414141);
        }
        [alertControllerMessageStr addAttribute:NSForegroundColorAttributeName value:msgColor range:NSMakeRange(0, message.length)];
        [alertControllerMessageStr addAttribute:NSFontAttributeName value:[UIFont pfRegularWithSize:14] range:NSMakeRange(0, message.length)];
        [alert setValue:alertControllerMessageStr forKey:@"attributedMessage"];
    }
    
    if (actionDefaultStrs.count) {
        for (int i = 0; i < actionDefaultStrs.count; i ++) {
            NSString *actionDefaultStr = actionDefaultStrs[i];
            UIAlertAction *actionDefault = [UIAlertAction actionWithTitle:actionDefaultStr style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                handlerDefaults(action, i);
            }];
            //修改 action
            if (actionDefaultColors.count >= actionDefaultStrs.count) {
                [actionDefault setValue:actionDefaultColors[i] forKey:@"titleTextColor"];
            } else if (actionDefaultColors.count < actionDefaultStrs.count && actionDefaultColors.count) {
                if (i > actionDefaultColors.count - 1) {
                    [actionDefault setValue:[actionDefaultColors lastObject] forKey:@"titleTextColor"];
                } else {
                    [actionDefault setValue:actionDefaultColors[i] forKey:@"titleTextColor"];
                }
            } else {
                [actionDefault setValue:dk_HexColor(COLOR_APPMAIN) forKey:@"titleTextColor"];
            }
            [alert addAction:actionDefault];
        }
    }
    
    if (actionCancelStr) {
        UIAlertAction *actionCancel = [UIAlertAction actionWithTitle:actionCancelStr style:UIAlertActionStyleCancel handler:handlerCancel];
        //修改 action
        [actionCancel setValue:dk_HexColor(COLOR_414141) forKey:@"titleTextColor"];
        [alert addAction:actionCancel];
    }
    
    return alert;
}

+ (instancetype)dk_AlertSheetWithTitle:(NSString *)title message:(NSString *)message actionDefault:(NSArray<NSString *> *)actionDefaultStrs actionCancel:(NSString *)actionCancelStr handlerDefault:(void (^)(UIAlertAction *, NSInteger))handlerDefault handlerCancel:(void (^)(UIAlertAction *))handlerCancel {
    
    DKBaseAlertController *alert = [self alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleActionSheet];
    
    if (actionDefaultStrs.count > 0) {
        for (NSInteger i = 0; i < actionDefaultStrs.count; i ++) {
            NSString *title = actionDefaultStrs[i];
            UIAlertAction *actionDefault = [UIAlertAction actionWithTitle:title style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                handlerDefault(action, i);
            }];
            //修改 action
            [actionDefault setValue:dk_HexColor(COLOR_666666) forKey:@"titleTextColor"];
            [alert addAction:actionDefault];
        }
    }
    if (actionCancelStr) {
        UIAlertAction *actionCancel = [UIAlertAction actionWithTitle:actionCancelStr style:UIAlertActionStyleCancel handler:handlerCancel];
        //修改 action
        [actionCancel setValue:dk_HexColor(COLOR_666666) forKey:@"titleTextColor"];
        [alert addAction:actionCancel];
    }
    
    return alert;
}

+ (instancetype)dk_AlertSheetWithTitle:(NSString *)title message:(NSString *)message actionCancel:(NSString *)actionCancelStr handlerDefault:(void (^)(UIAlertAction *, NSInteger))handlerDefault handlerCancel:(void (^)(UIAlertAction *))handlerCancel actionDefault:(NSString *)actionDefaultStrs, ... {
    DKBaseAlertController *alert = [self alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleActionSheet];
    NSMutableArray *argsArray = [NSMutableArray array];
    va_list params; //定义一个指向个数可变的参数列表指针;
    va_start(params,actionDefaultStrs);//va_start 得到第一个可变参数地址,
    id arg;
    if (actionDefaultStrs) {
        //将第一个参数添加到array
        id prev = actionDefaultStrs;
        NSInteger index = 0;
        [argsArray addObject:prev];
        UIAlertAction *actionDefault = [UIAlertAction actionWithTitle:prev style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            handlerDefault(action, index);
        }];
        //修改 action
        [actionDefault setValue:dk_HexColor(COLOR_666666) forKey:@"titleTextColor"];
        [alert addAction:actionDefault];
        //va_arg 指向下一个参数地址
        //这里是问题的所在 网上的例子，没有保存第一个参数地址，后边循环，指针将不会在指向第一个参数
        while((arg = va_arg(params,id))) {
            if (arg) {
                [argsArray addObject:arg];
                index ++;
                UIAlertAction *actionDefault = [UIAlertAction actionWithTitle:arg style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    handlerDefault(action, index);
                }];
                //修改 action
                [actionDefault setValue:dk_HexColor(COLOR_666666) forKey:@"titleTextColor"];
                [alert addAction:actionDefault];
            }
        }
        //置空
        va_end(params);
    }
    
    if (actionCancelStr) {
        UIAlertAction *actionCancel = [UIAlertAction actionWithTitle:actionCancelStr style:UIAlertActionStyleCancel handler:handlerCancel];
        //修改 action
        [actionCancel setValue:dk_HexColor(COLOR_666666) forKey:@"titleTextColor"];
        [alert addAction:actionCancel];
    }
    
    return alert;
}

- (void)show {
    if ([[self getCurrentViewController] isKindOfClass:[DKBaseAlertController class]]) {
        return;
    }
    [[self getCurrentViewController] presentViewController:self animated:YES completion:nil];
}

@end
