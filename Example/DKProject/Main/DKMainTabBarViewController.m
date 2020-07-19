//
//  DKMainTabBarViewController.m
//  DKProject_Example
//
//  Created by 王 on 2020/7/7.
//  Copyright © 2020 wangshaoyu. All rights reserved.
//

#import "DKMainTabBarViewController.h"
#import "QDUIKitViewController.h"
#import "QDComponentsViewController.h"
#import "QDLabViewController.h"
#import "DKMineViewController.h"

static CGFloat const CYLTabBarControllerHeight = 40.f;

@interface DKMainTabBarViewController () <UITabBarControllerDelegate,UIActionSheetDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate>
{
    QDUIKitViewController *_first;
    QDComponentsViewController *_secode;
    QDLabViewController *_third;
    DKMineViewController *_fourth;
}

@property (nonatomic,strong)UIImageView *redImageView;
@property (nonatomic, assign) NSInteger defaultSelectedIndex;

@end

@implementation DKMainTabBarViewController

- (instancetype)initWithContext:(NSString *)context {
    /**
     * 以下两行代码目的在于手动设置让TabBarItem只显示图标，不显示文字，并让图标垂直居中。
     * 等 效于在 `-tabBarItemsAttributesForController` 方法中不传 `CYLTabBarItemTitle` 字段。
     * 更推荐后一种做法。
     */
    UIEdgeInsets imageInsets = UIEdgeInsetsZero;//UIEdgeInsetsMake(4.5, 0, -4.5, 0);
    UIOffset titlePositionAdjustment = UIOffsetMake(0, 0);
    if (self = [super initWithViewControllers:[self viewControllersForTabBar]
                        tabBarItemsAttributes:[self tabBarItemsAttributesForTabBar]
                                  imageInsets:imageInsets
                      titlePositionAdjustment:titlePositionAdjustment
                                      context:context
                ]) {
        [self customizeTabBarAppearance];
        self.delegate = self;
        self.navigationController.navigationBar.hidden = YES;
    }
    return self;
}

- (NSArray *)viewControllersForTabBar {
    QDUIKitViewController *firstViewController = [[QDUIKitViewController alloc] init];
    firstViewController.hidesBottomBarWhenPushed = NO;
    UIViewController *firstNavigationController = [[DKBaseNavigationController alloc]
                                                   initWithRootViewController:firstViewController];
    [firstViewController cyl_setHideNavigationBarSeparator:YES];
    QDComponentsViewController *secondViewController = [[QDComponentsViewController alloc] init];
    secondViewController.hidesBottomBarWhenPushed = NO;
    UIViewController *secondNavigationController = [[DKBaseNavigationController alloc]
                                                    initWithRootViewController:secondViewController];
    [secondViewController cyl_setHideNavigationBarSeparator:YES];
    
    QDLabViewController *thirdViewController = [[QDLabViewController alloc] init];
    thirdViewController.hidesBottomBarWhenPushed = NO;
    UIViewController *thirdNavigationController = [[DKBaseNavigationController alloc]
                                                   initWithRootViewController:thirdViewController];
    [thirdViewController cyl_setHideNavigationBarSeparator:YES];
    
    DKMineViewController *fourthViewController = [[DKMineViewController alloc] init];
    fourthViewController.hidesBottomBarWhenPushed = NO;
    UIViewController *fourthNavigationController = [[DKBaseNavigationController alloc]
                                                   initWithRootViewController:fourthViewController];
    [fourthViewController cyl_setHideNavigationBarSeparator:YES];
    NSArray *viewControllers = @[
                                 firstNavigationController,
                                 secondNavigationController,
                                 thirdNavigationController,
                                 fourthNavigationController,
                                 ];
    return viewControllers;
}

- (NSArray *)tabBarItemsAttributesForTabBar {
    NSDictionary *firstTabBarItemsAttributes = @{
                                                 CYLTabBarItemTitle : @"QMUIKit",
                                                 CYLTabBarItemImage : dk_Image(@"icon_tabbar_uikit"),
                                                 CYLTabBarItemSelectedImage : dk_Image(@"icon_tabbar_uikit_selected"),
                                                 };
    
    NSDictionary *secondTabBarItemsAttributes = @{
                                                  CYLTabBarItemTitle : @"Components",
                                                  CYLTabBarItemImage : dk_Image(@"icon_tabbar_component"),
                                                  CYLTabBarItemSelectedImage : dk_Image(@"icon_tabbar_component_selected"),
                                                  };
    
    NSDictionary *thirdTabBarItemsAttributes = @{
                                                  CYLTabBarItemTitle : @"Lab",
                                                  CYLTabBarItemImage : dk_Image(@"icon_tabbar_lab"),
                                                  CYLTabBarItemSelectedImage : dk_Image(@"icon_tabbar_lab_selected"),
                                                  };
    
    NSDictionary *fourthTabBarItemsAttributes = @{
                                                 CYLTabBarItemTitle : @"DKMine",
                                                 CYLTabBarItemImage : dk_Image(@"icon_tabbar_mine"),
                                                 CYLTabBarItemSelectedImage : @"icon_tabbar_mine_selected",
                                                 };
    NSArray *tabBarItemsAttributes = @[
                                       firstTabBarItemsAttributes,
                                       secondTabBarItemsAttributes,
                                       thirdTabBarItemsAttributes,
                                       fourthTabBarItemsAttributes,
                                       ];
    return tabBarItemsAttributes;
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [[UIApplication sharedApplication] setApplicationSupportsShakeToEdit:YES];
    [self becomeFirstResponder];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)dealloc
{
   
}


/**
 *  更多TabBar自定义设置：比如：tabBarItem 的选中和不选中文字和背景图片属性、tabbar 背景图片属性等等
 */
- (void)customizeTabBarAppearance {
    if (@available(iOS 13.0, *)) {
        UITabBarAppearance *appearance = [self.tabBar.standardAppearance copy];
        ///去除高斯模糊
        [appearance configureWithTransparentBackground];
        appearance.shadowColor = dk_ClearColor;
        ///配置透明背景
        appearance.backgroundColor = dk_ClearColor;
        
        appearance.backgroundImage = QMUICMI.tabBarBackgroundImage;
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
        [[UITabBar appearance] setBackgroundImage:QMUICMI.tabBarBackgroundImage];
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

- (void)updateTabBarCustomizationWhenTabBarItemWidthDidUpdate {
    void (^deviceOrientationDidChangeBlock)(NSNotification *) = ^(NSNotification *notification) {
        UIDeviceOrientation orientation = [[UIDevice currentDevice] orientation];
        if ((orientation == UIDeviceOrientationLandscapeLeft) || (orientation == UIDeviceOrientationLandscapeRight)) {
            DKLog(@"Landscape Left or Right !");
        } else if (orientation == UIDeviceOrientationPortrait) {
            DKLog(@"Landscape portrait!");
        }
        [self customizeTabBarSelectionIndicatorImage];
    };
    [[NSNotificationCenter defaultCenter] addObserverForName:CYLTabBarItemWidthDidChangeNotification
                                                      object:nil
                                                       queue:[NSOperationQueue mainQueue]
                                                  usingBlock:deviceOrientationDidChangeBlock];
}

- (void)customizeTabBarSelectionIndicatorImage {
    ///Get initialized TabBar Height if exists, otherwise get Default TabBar Height.
    CGFloat tabBarHeight = CYLTabBarControllerHeight;
    CGSize selectionIndicatorImageSize = CGSizeMake(CYLTabBarItemWidth, tabBarHeight);
    //Get initialized TabBar if exists.
    UITabBar *tabBar = [self cyl_tabBarController].tabBar ?: [UITabBar appearance];
    [tabBar setSelectionIndicatorImage:
     [[self class] imageWithColor:[UIColor whiteColor]
                             size:selectionIndicatorImageSize]];
}

#pragma mark - UITabBarControllerDelegate
- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController {
    BOOL should = YES;
    // TODO: 判断是否登录
    return should;
}

- (void)tabBarController:(UITabBarController *)tabBarController didSelectControl:(UIControl *)control {
    
}


#pragma mark - StatusBar

- (UIViewController *)childViewControllerForStatusBarHidden {
    return self.selectedViewController;
}

- (UIViewController *)childViewControllerForStatusBarStyle {
    return self.selectedViewController;
}

#pragma mark - 屏幕旋转
// 将 QMUITabBarViewController 的旋转代码拷贝到自定义的 TabBarController 实现自动旋转设置
- (BOOL)shouldAutorotate {
    return self.presentedViewController ? [self.presentedViewController shouldAutorotate] : ([self.selectedViewController qmui_hasOverrideUIKitMethod:_cmd] ? [self.selectedViewController shouldAutorotate] : YES);
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    
    // fix UIAlertController:supportedInterfaceOrientations was invoked recursively!
    // crash in iOS 9 and show log in iOS 10 and later
    // https://github.com/Tencent/QMUI_iOS/issues/502
    // https://github.com/Tencent/QMUI_iOS/issues/632
    UIViewController *visibleViewController = self.presentedViewController;
    if (!visibleViewController || visibleViewController.isBeingDismissed || [visibleViewController isKindOfClass:UIAlertController.class]) {
        visibleViewController = self.selectedViewController;
    }
    
    if ([visibleViewController isKindOfClass:NSClassFromString(@"AVFullScreenViewController")]) {
        return visibleViewController.supportedInterfaceOrientations;
    }
    
    return [visibleViewController qmui_hasOverrideUIKitMethod:_cmd] ? [visibleViewController supportedInterfaceOrientations] : SupportedOrientationMask;
}

#pragma mark - HomeIndicator

- (UIViewController *)childViewControllerForHomeIndicatorAutoHidden {
    return self.selectedViewController;
}


@end
