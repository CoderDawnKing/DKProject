//
//  DKBaseNaviController.m
//  GardenManager
//
//  Created by 王 on 2019/6/19.
//  Copyright © 2019 wisezone. All rights reserved.
//

#import "DKBaseNaviController.h"
#import <DKProject/DKProject.h>

@interface DKBaseNaviController ()<UINavigationControllerDelegate, UIGestureRecognizerDelegate>

@property (nonatomic, strong) id popDelegate;

@end

@implementation DKBaseNaviController

@synthesize backgroundColor = _backgroundColor;

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    self.popDelegate = self.interactivePopGestureRecognizer.delegate;
//    self.delegate = self;
    //设置导航栏 title 的字体样式
    [self.navigationBar setTitleTextAttributes:@{
                                                 NSFontAttributeName:[UIFont pfMediumWithSize:18],
                                                 NSForegroundColorAttributeName:dk_HexColor(DK_COLOR_333333),
                                                 }];
    if (@available(iOS 11.0, *)) {
        NSMutableParagraphStyle *style = [[NSMutableParagraphStyle defaultParagraphStyle] mutableCopy];
        //首行缩进
        style.firstLineHeadIndent = 0;
        [self.navigationBar setLargeTitleTextAttributes:@{
                                                          NSFontAttributeName:[UIFont pfMediumWithSize:20],
                                                          NSForegroundColorAttributeName:dk_HexColor(DK_COLOR_333333),
                                                          NSParagraphStyleAttributeName:style
                                                          }];
    } else {
        // Fallback on earlier versions
    }
    //设置导航栏按钮间距
    [UINavigationConfig shared].dk_defaultFixSpace = dk_defaultSpace;
    self.view.backgroundColor = dk_HexColor(DK_COLOR_WHITE);
    self.view.superview.backgroundColor = dk_HexColor(DK_COLOR_WHITE);
    self.navigationBar.barTintColor = dk_HexColor(DK_COLOR_WHITE);
    [self.navigationBar setShadowImage:[UIImage imageWithColor:dk_HexColor(DK_COLOR_LINE) size:CGSizeMake(dk_ScreenWidth, 1)]];
    self.extendedLayoutIncludesOpaqueBars = YES;
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    //打印字体名称
//    for (NSString *fontFamilyName in UIFont.familyNames) {
//        DKLog(@"familyName:%@", fontFamilyName);
//        for (NSString *fontName in [UIFont fontNamesForFamilyName:fontFamilyName]) {
//            DKLog(@"fontName:%@", fontName);
//        }
//    }
}

#pragma mark - UINavigationControllerDelegate
// 将要显示控制器
- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    // 判断要隐藏导航栏的控制器
//    BOOL isHideNav = ([viewController isKindOfClass:[PostingViewController class]]);
    BOOL isHideNav = NO;
    [self setNavigationBarHidden:self.isNavigationBarHidden?:isHideNav animated:YES];
}

//导航控制器跳转完成的时候调用
- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    if (viewController == self.viewControllers[0]) {
        //显示根控制器
        //还原滑动返回手势的代理
        self.interactivePopGestureRecognizer.delegate = self.popDelegate;
        
    } else {
        //实现滑动返回功能
        //清空滑动返回手势的代理，就能实现滑动返回
        self.interactivePopGestureRecognizer.delegate = nil;
    }
}


- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    if (self.childViewControllers.count > 0) { // 如果push进来的不是第一个控制器
        UIBarButtonItem *leftBarButtonItem = [UIBarButtonItem barButtonBackItemWithTarget:self action:@selector(pop) string:nil];
        viewController.navigationItem.leftBarButtonItem = leftBarButtonItem;
        // 隐藏tabbar
        viewController.hidesBottomBarWhenPushed = YES;
    }
    
    // 这句super的push要放在后面, 让viewController可以覆盖上面设置的leftBarButtonItem
    [super pushViewController:viewController animated:animated];
}

- (void)pop {
    if ([self.dk_delegate respondsToSelector:@selector(dk_popViewController)]) {
        BOOL isPop = [self.dk_delegate dk_popViewController];
        if (!isPop) return;
    }
    [self popViewControllerAnimated:YES];
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations
{
    if (self.topViewController) {
        return [self.topViewController supportedInterfaceOrientations];
    }
    return UIInterfaceOrientationMaskPortrait;
}

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation{
    return UIInterfaceOrientationPortrait;
}

//旋转问题
- (BOOL)shouldAutorotate {
    if (self.topViewController) {
        return [self.topViewController shouldAutorotate];
    }
    return NO;
}

- (void)setHiddenShadowImage:(BOOL)hiddenShadowImage {
    _hiddenShadowImage = hiddenShadowImage;
    if (_hiddenShadowImage) {
        //去掉导航栏底部的黑线
        [self.navigationBar setShadowImage:[UIImage imageWithColor:dk_ClearColor size:CGSizeMake(dk_ScreenWidth, 1)]];
    } else {
        [self.navigationBar setShadowImage:[UIImage imageWithColor:dk_HexColor(DK_COLOR_LINE) size:CGSizeMake(dk_ScreenWidth, 1)]];
    }
}

- (void)setTransparent:(BOOL)transparent {
    _transparent = transparent;
    if (_transparent) {
        self.navigationBar.translucent = YES;
        [self.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
        self.hiddenShadowImage = YES;
    } else {
        self.navigationBar.translucent = NO;
        [self.navigationBar setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
        self.hiddenShadowImage = NO;
    }
}

- (void)setDk_navAlpha:(CGFloat)dk_navAlpha {
    _dk_navAlpha = dk_navAlpha;
    if (_dk_navAlpha < 0.0) {
        [self.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    } else if (_dk_navAlpha > 1.0) {
        [self.navigationBar setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
    } else {
        self.backgroundImage = [UIImage imageWithColor:[self.backgroundColor colorWithAlphaComponent:_dk_navAlpha]];
    }
}

- (void)setBackgroundColor:(UIColor *)backgroundColor {
    _backgroundColor = backgroundColor;
    self.backgroundImage = [UIImage imageWithColor:backgroundColor];
}

- (UIColor *)backgroundColor {
    if (!_backgroundColor) {
        _backgroundColor = dk_HexColor(DK_COLOR_WHITE);
    }
    return _backgroundColor;
}

- (void)setBackgroundImage:(UIImage *)backgroundImage {
    _backgroundImage = backgroundImage;
    [self.navigationBar setBackgroundImage:_backgroundImage forBarMetrics:UIBarMetricsDefault];
}

- (void)setLeftBarTitle:(NSString *)leftBarTitle {
    _leftBarTitle = leftBarTitle;
}

- (UIModalPresentationStyle)modalPresentationStyle {
    return UIModalPresentationFullScreen;
}

@end

// TODO: 有时间添加侧滑到指定控制器功能。并显示对应截图
//    //在需要侧滑到指定控制器的控制器的 view 加载完毕后偷偷将当前控制器与目标控制器之间的所有控制器出栈
////     # 1. 获取当行控制器所有子控制器
//     NSMutableArray <UIViewController *>* tmp = self.navigationController.viewControllers.mutableCopy;
////     # 2. 获取目标控制器索引
//     UIViewController * targetVC = nil;
//       for (NSInteger i = 0 ; i < tmp.count; i++) {
//
//           UIViewController * vc = tmp[i];
//           if ([vc isKindOfClass:NSClassFromString(@"PersonalCenterViewController")])
//           {
//               targetVC = vc;
//               // 也可在此直接获取 i 的数值
//               break;
//           }
//       }
//     NSInteger index = [tmp indexOfObject:targetVC];
////     # 3. 移除目标控制器与当前控制器之间的所有控制器
//     NSRange  range = NSMakeRange(index + 1, tmp.count - 1 - (index + 1));
//
//     [tmp removeObjectsInRange:range];
////     # 4. 重新赋值给导航控制器
//     self.navigationController.viewControllers = [tmp copy];
