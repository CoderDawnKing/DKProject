//
//  UIViewController+DKCategory.m
//  GardenManager
//
//  Created by 王 on 2019/9/3.
//  Copyright © 2019 wisezone. All rights reserved.
//

#import "UIViewController+DKCategory.h"

@implementation UIViewController (DKCategory)

- (void)dk_popToViewController:(NSString *)className animated:(BOOL)animated {
    for (UIViewController *temp in self.navigationController.viewControllers) {
        if([temp isKindOfClass:NSClassFromString(className)]) {
            [self.navigationController popToViewController:temp animated:animated];
        }
    }
}

- (void)dk_backToRootViewController {
    [self dk_backToRootViewControllerAnimated:YES completion:nil];
}

- (void)dk_backToRootViewControllerAnimated:(BOOL)flag completion:(void (^ __nullable)(void))completion {
    if (self.navigationController.viewControllers.count>1) {
        [self.navigationController popToRootViewControllerAnimated:flag];
    } else {
        [self dk_dismissRootViewControllerAnimated:flag completion:completion];
    }
}

- (void)dk_backToSuperViewController {
    [self dk_backToSuperViewControllerAnimated:YES completion:nil];
}


- (void)dk_backToSuperViewControllerAnimated:(BOOL)flag completion:(void (^ __nullable)(void))completion {
    if (self.navigationController.viewControllers.count>1) {
        [self.navigationController popViewControllerAnimated:flag];
    } else {
        [self dismissViewControllerAnimated:flag completion:completion];
    }
}

- (void)dk_dismissRootViewControllerAnimated:(BOOL)flag completion:(void (^ __nullable)(void))completion {
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
