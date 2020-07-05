//
//  UIViewController+DKCategory.m
//  GardenManager
//
//  Created by 王 on 2019/9/3.
//  Copyright © 2019 wisezone. All rights reserved.
//

#import "UIViewController+DKCategory.h"

@implementation UIViewController (DKCategory)

- (void)popToViewController:(NSString *)className animated:(BOOL)animated {
    for (UIViewController *temp in self.navigationController.viewControllers) {
        if([temp isKindOfClass:NSClassFromString(className)]) {
            [self.navigationController popToViewController:temp animated:animated];
        }
    }
}

- (void)backToRootViewController {
    [self backToRootViewControllerAnimated:YES completion:nil];
}

- (void)backToRootViewControllerAnimated:(BOOL)flag completion:(void (^ __nullable)(void))completion {
    if (self.navigationController.viewControllers.count>1) {
        [self.navigationController popToRootViewControllerAnimated:flag];
    } else {
        [self dismissRootViewControllerAnimated:flag completion:completion];
    }
}

- (void)backToSuperViewController {
    [self backToSuperViewControllerAnimated:YES completion:nil];
}


- (void)backToSuperViewControllerAnimated:(BOOL)flag completion:(void (^ __nullable)(void))completion {
    if (self.navigationController.viewControllers.count>1) {
        [self.navigationController popViewControllerAnimated:flag];
    } else {
        [self dismissViewControllerAnimated:flag completion:completion];
    }
}

- (void)dismissRootViewControllerAnimated:(BOOL)flag completion:(void (^ __nullable)(void))completion {
    UIViewController *rootVC = self.presentingViewController;
    while (rootVC.presentingViewController) {
        rootVC = rootVC.presentingViewController;
    }
    [rootVC dismissViewControllerAnimated:flag completion:completion];
}

- (void)dk_presentViewController:(UIViewController *)viewControllerToPresent animated:(BOOL)flag completion:(void (^)(void))completion {
    viewControllerToPresent.modalPresentationStyle = UIModalPresentationFullScreen;
    [self presentViewController:viewControllerToPresent animated:flag completion:completion];
}

@end
