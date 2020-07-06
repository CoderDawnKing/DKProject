//
//  DKBaseEditTextFieldViewController.h
//  GardenManager
//
//  Created by 王 on 2019/7/11.
//  Copyright © 2019 wisezone. All rights reserved.
//

#import "DKBaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface DKBaseEditTextFieldViewController : DKBaseViewController
@property (nonatomic, strong) NSString *context;
@property (nonatomic, strong) NSString *placeholder;
@property (nonatomic, strong) NSString *prompt;
@property (nonatomic, assign) UIKeyboardType keyboardType;
@property (nonatomic, assign) CGFloat headerHeight;
@property (nonatomic, assign, getter=isCanEmpty) BOOL canEmpty;
@property (nonatomic, copy) void (^backBlock) (NSString *context);
/// 根据返回值判断是否返回上级界面
@property (nonatomic, copy) BOOL (^backClickBlock) (NSString *context);
@end

NS_ASSUME_NONNULL_END
