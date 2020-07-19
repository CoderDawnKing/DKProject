//
//  QDChangeNavBarStyleViewController.m
//  qmuidemo
//
//  Created by QMUI Team on 16/9/5.
//  Copyright © 2016年 QMUI Team. All rights reserved.
//

#import "QDChangeNavBarStyleViewController.h"

@interface QDChangeNavBarStyleViewController ()

@property(nonatomic, strong) QDChangeNavBarStyleViewController *viewController;

@end

@implementation QDChangeNavBarStyleViewController

- (void)didInitialize {
    [super didInitialize];
}

- (instancetype)initWithBarStyle:(DKNavigationBarStyle)barStyle {
    if (self = [super init]) {
        self.dk_barStyle = barStyle;
    }
    return self;
}

- (void)initDataSource {
    [super initDataSource];
    self.dataSource = @[@"默认navBar样式",
                        @"暗色navBar样式",
                        @"浅色navBar样式"];
}

- (void)didSelectCellWithTitle:(NSString *)title {
    if ([title isEqualToString:@"默认navBar样式"]) {
        self.viewController = [[QDChangeNavBarStyleViewController alloc] initWithBarStyle:DKNavigationBarStyleOrigin];
    }
    else if ([title isEqualToString:@"暗色navBar样式"]) {
        self.viewController = [[QDChangeNavBarStyleViewController alloc] initWithBarStyle:DKNavigationBarStyleDark];
    }
    else if ([title isEqualToString:@"浅色navBar样式"]) {
        self.viewController = [[QDChangeNavBarStyleViewController alloc] initWithBarStyle:DKNavigationBarStyleLight];
    }
    if (self.customNavBarTransition) {
        self.viewController.previousBarStyle = self.dk_barStyle;
        self.viewController.customNavBarTransition = YES;
    }
    self.viewController.title = title;
    [self.navigationController pushViewController:self.viewController animated:YES];
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    if (self.dk_barStyle == DKNavigationBarStyleOrigin || self.dk_barStyle == DKNavigationBarStyleDark) {
        return UIStatusBarStyleLightContent;
    } else {
        return UIStatusBarStyleDefault;
    }
}

@end
