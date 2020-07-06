//
//  UIViewController+DKCategory.h
//  GardenManager
//
//  Created by 王 on 2019/9/3.
//  Copyright © 2019 wisezone. All rights reserved.
//



NS_ASSUME_NONNULL_BEGIN

@interface UIViewController (DKCategory)

- (void)dk_backToSuperViewController;
- (void)dk_backToSuperViewControllerAnimated:(BOOL)flag completion:(void (^ __nullable)(void))completion;
- (void)dk_backToRootViewControllerAnimated:(BOOL)flag completion:(void (^ __nullable)(void))completion;
- (void)dk_backToRootViewController;
- (void)dk_dismissRootViewControllerAnimated:(BOOL)flag completion:(void (^ __nullable)(void))completion;
- (void)dk_popToViewController:(NSString *)className animated:(BOOL)animated;
- (void)dk_presentViewController:(UIViewController *)viewControllerToPresent animated:(BOOL)flag completion:(void (^)(void))completion;

@end

NS_ASSUME_NONNULL_END
