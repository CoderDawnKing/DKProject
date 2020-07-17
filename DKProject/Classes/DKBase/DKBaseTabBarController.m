//
//  MainViewController.m
//  GoodAlbum
//
//  Created by Song xiaojun on 2017/6/8.
//  Copyright © 2018年 differ. All rights reserved.
//

#import "DKBaseTabBarController.h"
#import <DKProject/DKProject.h>

@interface DKBaseTabBarController ()

@end

@implementation DKBaseTabBarController

- (void)didInitialize {
    [super didInitialize];
//    [self customizeTabBarAppearance];
}

- (void)customizeTabBarAppearance {
    if (@available(iOS 13.0, *)) {
        UITabBarAppearance *appearance = [self.tabBar.standardAppearance copy];
        ///去除高斯模糊
        [appearance configureWithTransparentBackground];
        appearance.shadowColor = dk_ClearColor;
        ///配置透明背景
        appearance.backgroundColor = dk_ClearColor;
        
        appearance.backgroundImage = dk_Image(@"tabbarClearBg");
//        appearance.backgroundImage = [UIImage imageWithColor:dk_HexColor(DK_COLOR_WHITE)];
        self.tabBar.tintColor = dk_HexColor(DK_COLOR_TAB_TEXT_SELECT);
        self.tabBar.standardAppearance = appearance;
        self.tabBar.layer.shadowColor = [UIColor blackColor].CGColor;
        self.tabBar.layer.shadowRadius = 15;
        self.tabBar.layer.shadowOpacity = 0.05;
        self.tabBar.layer.shadowOffset = CGSizeMake(0, 2);
        self.tabBar.layer.masksToBounds = NO;
        self.tabBar.clipsToBounds = NO;
    } else {
        // Customize UITabBar height
        // 自定义 TabBar 高度
        // tabBarController.tabBarHeight = CYL_IS_IPHONE_X ? 65 : 40;
        
        //    [tabBarController rootWindow].backgroundColor = [UIColor cyl_systemBackgroundColor];
        
        // set the text color for unselected state
        // 普通状态下的文字属性
        NSMutableDictionary *normalAttrs = [NSMutableDictionary dictionary];
        //    normalAttrs[NSForegroundColorAttributeName] = [UIColor blackColor];
        
        // set the text color for selected state
        // 选中状态下的文字属性
        NSMutableDictionary *selectedAttrs = [NSMutableDictionary dictionary];
        selectedAttrs[NSForegroundColorAttributeName] = dk_HexColor(DK_COLOR_TAB_TEXT_SELECT);
        
        
        // set the text Attributes
        // 设置文字属性
        UITabBarItem *tabBar = [UITabBarItem appearance];
        [tabBar setTitleTextAttributes:normalAttrs forState:UIControlStateNormal];
        [tabBar setTitleTextAttributes:selectedAttrs forState:UIControlStateSelected];
        
        // Set the dark color to selected tab (the dimmed background)
        // TabBarItem选中后的背景颜色
        // [self customizeTabBarSelectionIndicatorImage];
        
        // update TabBar when TabBarItem width did update
        // If your app need support UIDeviceOrientationLandscapeLeft or UIDeviceOrientationLandscapeRight，
        // remove the comment '//'
        // 如果你的App需要支持横竖屏，请使用该方法移除注释 '//'
        // [self updateTabBarCustomizationWhenTabBarItemWidthDidUpdate];
        
        // set background color
        // 设置 TabBar 背景
        [UITabBar appearance].translucent = YES;
        //             [UITabBar appearance].barTintColor = [UIColor cyl_systemBackgroundColor];
        
        [[UITabBar appearance] setBackgroundColor:dk_ClearColor];
        [[UITabBar appearance] setBackgroundImage:dk_Image(@"tabbarClearBg")];
//        [[UITabBar appearance] setBackgroundColor:dk_HexColor(DK_COLOR_WHITE)];
//        [[UITabBar appearance] setBackgroundImage:[UIImage imageWithColor:dk_HexColor(DK_COLOR_WHITE)]];
        
        
        
        //    [[UITabBar appearance] setBackgroundImage:[[self class] imageWithColor:[UIColor whiteColor] size:CGSizeMake([UIScreen mainScreen].bounds.size.width, tabBarController.tabBarHeight ?: (CYL_IS_IPHONE_X ? 65 : 40))]];
        //    [[UITabBar appearance] setUnselectedItemTintColor:[UIColor systemGrayColor]];
        
        //Three way to deal with shadow 三种阴影处理方式：
        // NO.3, without shadow : use -[[CYLTabBarController hideTabBarShadowImageView] in CYLMainRootViewController.m
        
        // NO.2，using Image
        // set the bar shadow image
        // This shadow image attribute is ignored if the tab bar does not also have a custom background image.So at least set somthing.
        //    [[UITabBar appearance] setBackgroundImage:[[UIImage alloc] init]];
        //    [[UITabBar appearance] setShadowImage:[UIImage imageNamed:@"tapbar_top_line"]];
        // NO.1，using layer to add shadow. note:recommended. 推荐该方式，可以给PlusButton突出的部分也添加上阴影
        self.tabBar.layer.shadowColor = [UIColor blackColor].CGColor;
        self.tabBar.layer.shadowRadius = 15;
        self.tabBar.layer.shadowOpacity = 0.05;
        self.tabBar.layer.shadowOffset = CGSizeMake(0, 2);
        self.tabBar.layer.masksToBounds = NO;
        self.tabBar.clipsToBounds = NO;
    }
    
}

@end
