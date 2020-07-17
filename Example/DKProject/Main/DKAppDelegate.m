//
//  DKAppDelegate.m
//  DKProject
//
//  Created by wangshaoyu on 07/04/2020.
//  Copyright (c) 2020 wangshaoyu. All rights reserved.
//

#import "DKAppDelegate.h"
#import "DKMainTabBarViewController.h"
#import "DKMainTabPlusButton.h"
#import <DKProject/DKProject.h>
#import "QDUIKitViewController.h"
#import "QDComponentsViewController.h"
#import "QDLabViewController.h"
#import "QMUIConfigurationTemplateGrapefruit.h"
#import "QMUIConfigurationTemplateGrass.h"
#import "QMUIConfigurationTemplatePinkRose.h"
#import "QMUIConfigurationTemplateDark.h"

#ifdef IOS13_SDK_ALLOWED
//#define UIWindowScene_Enabled
#endif

@implementation DKAppDelegate

#ifdef UIWindowScene_Enabled


#pragma mark - <UIWindowSceneDelegate>

- (void)scene:(UIScene *)scene willConnectToSession:(UISceneSession *)session options:(UISceneConnectionOptions *)connectionOptions API_AVAILABLE(ios(13.0)) {
    if (@available(iOS 13.0, *)) {
        if ([scene isKindOfClass:UIWindowScene.class]) {
            self.window = [[UIWindow alloc] initWithWindowScene:(UIWindowScene *)scene];
            [self didInitWindow];
        }
    }
}

#endif

#pragma mark - <UIApplicationDelegate>

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // 1. 先注册主题监听，在回调里将主题持久化存储，避免启动过程中主题发生变化时读取到错误的值
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleThemeDidChangeNotification:) name:QMUIThemeDidChangeNotification object:nil];
        
        // 2. 然后设置主题的生成器
        QMUIThemeManagerCenter.defaultThemeManager.themeGenerator = ^__kindof NSObject * _Nonnull(NSString * _Nonnull identifier) {
            if ([identifier isEqualToString:DKThemeIdentifierDefault]) return QMUIConfigurationTemplate.new;
            if ([identifier isEqualToString:DKThemeIdentifierGrapefruit]) return QMUIConfigurationTemplateGrapefruit.new;
            if ([identifier isEqualToString:DKThemeIdentifierGrass]) return QMUIConfigurationTemplateGrass.new;
            if ([identifier isEqualToString:DKThemeIdentifierPinkRose]) return QMUIConfigurationTemplatePinkRose.new;
            if ([identifier isEqualToString:DKThemeIdentifierDark]) return QMUIConfigurationTemplateDark.new;
            return nil;
        };
        
        // 3. 再针对 iOS 13 开启自动响应系统的 Dark Mode 切换
        // 如果不需要这个功能，则不需要这一段代码
        if (@available(iOS 13.0, *)) {
            // 做这个 if(currentThemeIdentifier) 的保护只是为了避免 QD 里的配置表没启动时，没人为 currentTheme/currentThemeIdentifier 赋值，导致后续的逻辑会 crash，业务项目里理论上不会有这种情况出现，所以可以省略这个 if 块
            if (QMUIThemeManagerCenter.defaultThemeManager.currentThemeIdentifier) {
                QMUIThemeManagerCenter.defaultThemeManager.identifierForTrait = ^__kindof NSObject<NSCopying> * _Nonnull(UITraitCollection * _Nonnull trait) {
                    if (trait.userInterfaceStyle == UIUserInterfaceStyleDark) {
                        return DKThemeIdentifierDark;
                    }
                    
                    if ([QMUIThemeManagerCenter.defaultThemeManager.currentThemeIdentifier isEqual:DKThemeIdentifierDark]) {
                        return DKThemeIdentifierDefault;
                    }
                    
                    return QMUIThemeManagerCenter.defaultThemeManager.currentThemeIdentifier;
                };
                QMUIThemeManagerCenter.defaultThemeManager.respondsSystemStyleAutomatically = YES;
            }
        }
        
        // QMUIConsole 默认只在 DEBUG 下会显示，作为 Demo，改为不管什么环境都允许显示
        [QMUIConsole sharedInstance].canShow = YES;
        
        // QD自定义的全局样式渲染
        [DKCommonUI renderGlobalAppearances];
        
        // 预加载 QQ 表情，避免第一次使用时卡顿
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            [DKUIHelper qmuiEmotions];
        });
        
    #ifdef UIWindowScene_Enabled
        if (@available(iOS 13.0, *)) {
        } else {
    #endif
            // 界面
            self.window = [[UIWindow alloc] init];
            [self didInitWindow];
    #ifdef UIWindowScene_Enabled
        }
    #endif
        
        return YES;
}

- (void)didInitWindow {
    
    /// 配置全局默认属性
    DKCONFIG.dkc_color_main = @"#31BDF3";
    DKCONFIG.dkc_color_tab_text_select = @"#31BDF3";
    
    // TODO: 后期改成 QMUITabBarViewController, 并且自定义 DKBaseTabBarController
    // 使用 CYLTabBarController 自动旋转设置失效 并且当首页滑动到底部,push 界面, pop 返回后, 有个向下回弹的 bug
    [DKMainTabPlusButton registerPlusButton];
    DKMainTabBarViewController *control = [[DKMainTabBarViewController alloc] initWithContext:@""];
    self.window.rootViewController = control;
//    self.window.rootViewController = [self generateWindowRootViewController];
    [self.window makeKeyAndVisible];
    [self startLaunchingAnimation];
}


- (UIViewController *)generateWindowRootViewController {
    DKBaseTabBarController *tabBarViewController = [[DKBaseTabBarController alloc] init];
    
    // QMUIKit
    QDUIKitViewController *uikitViewController = [[QDUIKitViewController alloc] init];
    uikitViewController.hidesBottomBarWhenPushed = NO;
    DKBaseNavigationController *uikitNavController = [[DKBaseNavigationController alloc] initWithRootViewController:uikitViewController];
    uikitNavController.tabBarItem = [DKUIHelper tabBarItemWithTitle:@"QMUIKit" image:UIImageMake(@"icon_tabbar_uikit") selectedImage:UIImageMake(@"icon_tabbar_uikit_selected") tag:0];
    AddAccessibilityHint(uikitNavController.tabBarItem, @"展示一系列对系统原生控件的拓展的能力");
    
    // UIComponents
    QDComponentsViewController *componentViewController = [[QDComponentsViewController alloc] init];
    componentViewController.hidesBottomBarWhenPushed = NO;
    DKBaseNavigationController *componentNavController = [[DKBaseNavigationController alloc] initWithRootViewController:componentViewController];
    componentNavController.tabBarItem = [DKUIHelper tabBarItemWithTitle:@"Components" image:UIImageMake(@"icon_tabbar_component") selectedImage:UIImageMake(@"icon_tabbar_component_selected") tag:1];
    AddAccessibilityHint(componentNavController.tabBarItem, @"展示 QMUI 自己的组件库");
    
    // Lab
    QDLabViewController *labViewController = [[QDLabViewController alloc] init];
    labViewController.hidesBottomBarWhenPushed = NO;
    DKBaseNavigationController *labNavController = [[DKBaseNavigationController alloc] initWithRootViewController:labViewController];
    labNavController.tabBarItem = [DKUIHelper tabBarItemWithTitle:@"Lab" image:UIImageMake(@"icon_tabbar_lab") selectedImage:UIImageMake(@"icon_tabbar_lab_selected") tag:2];
    AddAccessibilityHint(labNavController.tabBarItem, @"集合一些非正式但可能很有用的小功能");
    
    // window root controller
    tabBarViewController.viewControllers = @[uikitNavController, componentNavController, labNavController];
    tabBarViewController.tabBar.translucent = NO;
    return tabBarViewController;
}

- (void)startLaunchingAnimation {
    UIWindow *window = self.window;
    UIView *launchScreenView = [[NSBundle mainBundle] loadNibNamed:@"LaunchScreen" owner:self options:nil].firstObject;
    launchScreenView.frame = window.bounds;
    [window addSubview:launchScreenView];
    
    UIImageView *backgroundImageView = launchScreenView.subviews[0];
    backgroundImageView.clipsToBounds = YES;
    
    UIImageView *logoImageView = launchScreenView.subviews[1];
    UILabel *copyrightLabel = launchScreenView.subviews.lastObject;
    
    UIView *maskView = [[UIView alloc] initWithFrame:launchScreenView.bounds];
    maskView.backgroundColor = UIColorWhite;
    [launchScreenView insertSubview:maskView belowSubview:backgroundImageView];
    
    [launchScreenView layoutIfNeeded];
    
    
    [launchScreenView.constraints enumerateObjectsUsingBlock:^(__kindof NSLayoutConstraint * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj.identifier isEqualToString:@"bottomAlign"]) {
            obj.active = NO;
            [NSLayoutConstraint constraintWithItem:backgroundImageView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:launchScreenView attribute:NSLayoutAttributeTop multiplier:1 constant:NavigationContentTop].active = YES;
            *stop = YES;
        }
    }];
    
    [UIView animateWithDuration:.15 delay:0.9 options:QMUIViewAnimationOptionsCurveOut animations:^{
        [launchScreenView layoutIfNeeded];
        logoImageView.alpha = 0.0;
        copyrightLabel.alpha = 0;
    } completion:nil];
    [UIView animateWithDuration:1.2 delay:0.9 options:UIViewAnimationOptionCurveEaseOut animations:^{
        maskView.alpha = 0;
        backgroundImageView.alpha = 0;
    } completion:^(BOOL finished) {
        [launchScreenView removeFromSuperview];
    }];
}

- (void)handleThemeDidChangeNotification:(NSNotification *)notification {
    
    QMUIThemeManager *manager = notification.object;
    if (![manager.name isEqual:QMUIThemeManagerNameDefault]) return;
    
    [[NSUserDefaults standardUserDefaults] setObject:manager.currentThemeIdentifier forKey:DKSelectedThemeIdentifier];
    
    [DKThemeManager.currentTheme applyConfigurationTemplate];
    
    // 主题发生变化，在这里更新全局 UI 控件的 appearance
    [DKCommonUI renderGlobalAppearances];
    
    // 更新表情 icon 的颜色
    [DKUIHelper updateEmotionImages];
}

@end
