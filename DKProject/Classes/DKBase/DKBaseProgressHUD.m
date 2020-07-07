//
//  DKBaseProgressHUD.m
//  GardenManager
//
//  Created by 王 on 2019/7/20.
//  Copyright © 2019 wisezone. All rights reserved.
//

#import "DKBaseProgressHUD.h"
#import <DKProject/DKProject.h>

@implementation DKBaseProgressHUD

+ (void)showErrorWithStatus:(NSString *)status {
    [self setMinimumDismissTimeInterval:1];
    [self setDefaultStyle:SVProgressHUDStyleDark];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        dispatch_async(dispatch_get_main_queue(), ^{
            [super showErrorWithStatus:status];
        });
    });
}

+ (void)showWithStatus:(NSString *)status {
    [self setMinimumDismissTimeInterval:1];
    [self setDefaultStyle:SVProgressHUDStyleDark];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        dispatch_async(dispatch_get_main_queue(), ^{
            [super showWithStatus:status];
        });
    });
}

+ (void)showInfoWithStatus:(NSString *)status {
    [self setMinimumDismissTimeInterval:1];
    [self setDefaultStyle:SVProgressHUDStyleDark];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        dispatch_async(dispatch_get_main_queue(), ^{
            [super showInfoWithStatus:status];
        });
    });
}

+ (void)showSuccessWithStatus:(NSString *)status {
    [self setMinimumDismissTimeInterval:1];
    [self setDefaultStyle:SVProgressHUDStyleDark];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        dispatch_async(dispatch_get_main_queue(), ^{
            [super showSuccessWithStatus:status];
        });
    });
}

+ (void)showOnlyTextWithStatus:(NSString *)status {
    [self setInfoImage:dk_BundleImage(@"")];
    [self showInfoWithStatus:status];
}

+ (void)dismiss {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        dispatch_async(dispatch_get_main_queue(), ^{
            [super dismiss];
        });
    });
}

@end
