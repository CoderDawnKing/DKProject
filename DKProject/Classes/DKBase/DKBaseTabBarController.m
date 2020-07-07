//
//  MainViewController.m
//  GoodAlbum
//
//  Created by Song xiaojun on 2017/6/8.
//  Copyright © 2018年 differ. All rights reserved.
//

#import "DKBaseTabBarController.h"
#import <DKProject/DKProject.h>

static CGFloat const CYLTabBarControllerHeight = 40.f;

@interface DKBaseTabBarController () <UITabBarControllerDelegate,UIActionSheetDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate>
{
    DKBaseViewController *_gardenVC;
    DKBaseViewController *_homeVC;
    DKBaseViewController *_plantVC;
    DKBaseViewController *_myinfoVC;
}

@property (nonatomic,strong)UIImageView *redImageView;
@property (nonatomic, assign) NSInteger defaultSelectedIndex;

@end

@implementation DKBaseTabBarController

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
    DKBaseViewController *firstViewController = [[DKBaseViewController alloc] init];
    UIViewController *firstNavigationController = [[DKBaseNaviController alloc]
                                                   initWithRootViewController:firstViewController];
    [firstViewController cyl_setHideNavigationBarSeparator:YES];
    DKBaseViewController *secondViewController = [[DKBaseViewController alloc] init];
    _gardenVC = secondViewController;
    UIViewController *secondNavigationController = [[DKBaseNaviController alloc]
                                                    initWithRootViewController:secondViewController];
    [secondViewController cyl_setHideNavigationBarSeparator:YES];
    
    DKBaseViewController *thirdViewController = [[DKBaseViewController alloc] init];
    UIViewController *thirdNavigationController = [[DKBaseNaviController alloc]
                                                   initWithRootViewController:thirdViewController];
    [thirdViewController cyl_setHideNavigationBarSeparator:YES];
    
    DKBaseViewController *fourthViewController = [[DKBaseViewController alloc] init];
    UIViewController *fourthNavigationController = [[DKBaseNaviController alloc]
                                                   initWithRootViewController:fourthViewController];
    [fourthViewController cyl_setHideNavigationBarSeparator:YES];
    DKBaseViewController *fifthViewController = [[DKBaseViewController alloc] init];
    UIViewController *fifthNavigationController = [[DKBaseNaviController alloc]
                                                    initWithRootViewController:fifthViewController];
    [fourthNavigationController cyl_setHideNavigationBarSeparator:YES];
    NSArray *viewControllers = @[
                                 firstNavigationController,
                                 secondNavigationController,
                                 thirdNavigationController,
//                                 fourthNavigationController,
                                 fifthNavigationController
                                 ];
    return viewControllers;
}

- (NSArray *)tabBarItemsAttributesForTabBar {
    NSDictionary *firstTabBarItemsAttributes = @{
                                                 CYLTabBarItemTitle : @"花信风",
                                                 CYLTabBarItemImage : dk_BundleIMAGE(@"home_tab_ic_1_nor")?:@"",
//                                                 CYLTabBarItemSelectedImage : @"home_tab_ic_1_sel",
                                                 };
    
    NSDictionary *secondTabBarItemsAttributes = @{
                                                  CYLTabBarItemTitle : @"我的花园",
//                                                  CYLTabBarItemImage : [UIImage imageNamed:@"home_tab_ic_2_nor"],
//                                                  CYLTabBarItemSelectedImage : @"home_tab_ic_2_sel",
                                                  };
    
    NSDictionary *thirdTabBarItemsAttributes = @{
                                                  CYLTabBarItemTitle : @"附近花店",
//                                                  CYLTabBarItemImage : [UIImage imageNamed:@"home_tab_ic_5_nor"],
//                                                  CYLTabBarItemSelectedImage : @"home_tab_ic_5_sel",
                                                  };
    
//    NSDictionary *fourthTabBarItemsAttributes = @{
//                                                 CYLTabBarItemTitle : @"植物百科",
//                                                 CYLTabBarItemImage : [UIImage imageNamed:@"home_tab_ic_3_nor"],
//                                                 CYLTabBarItemSelectedImage : @"home_tab_ic_3_sel",
//                                                 };
    
    NSDictionary *fifthTabBarItemsAttributes = @{
                                                  CYLTabBarItemTitle : @"个人中心",
//                                                  CYLTabBarItemImage :[UIImage imageNamed:@"home_tab_ic_4_nor"],
//                                                  CYLTabBarItemSelectedImage : @"home_tab_ic_4_sel",
                                                  };
    NSArray *tabBarItemsAttributes = @[
                                       firstTabBarItemsAttributes,
                                       secondTabBarItemsAttributes,
                                       thirdTabBarItemsAttributes,
//                                       fourthTabBarItemsAttributes,
                                       fifthTabBarItemsAttributes
                                       ];
    return tabBarItemsAttributes;
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
//    self.edgesForExtendedLayout = UIRectEdgeNone;
//    self.extendedLayoutIncludesOpaqueBars = YES;
    [[UIApplication sharedApplication] setApplicationSupportsShakeToEdit:YES];
    [self becomeFirstResponder];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(gotoLogin) name:DK_Noti_NotLoggedIn_NameKey object:nil];
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
        NSInteger scale = [[UIScreen mainScreen] scale];
        appearance.backgroundImage = [dk_BundleIMAGE(@"tabbarClearBg") resizableImageWithCapInsets:UIEdgeInsetsMake(89, 0, 14, 0) resizingMode:UIImageResizingModeStretch];
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
        [[UITabBar appearance] setBackgroundImage:dk_BundleIMAGE(@"tabbarClearBg")];
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
    switch (tabBarController.selectedIndex) {
        case 0:
        {
            
        }
            break;
        case 1:
        {
            
        }
            break;
        case 3:
        {
            
        }
            break;
        default:
            break;
    }
}

- (BOOL)shouldAutorotate {
    return self.selectedViewController.shouldAutorotate;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskAll;
}

-(UIInterfaceOrientation)preferredInterfaceOrientationForPresentation{
    return UIInterfaceOrientationPortrait;
}

- (BOOL)prefersStatusBarHidden {
    return NO;
}

#pragma - mark noti
- (void)gotoLogin {
    DKBaseViewController *loginVC = [[DKBaseViewController alloc] init];
    DKBaseNaviController *navi = [[DKBaseNaviController alloc] initWithRootViewController:loginVC];
    [[self dk_getCurrentController] presentViewController:navi animated:YES completion:nil];
}

@end
