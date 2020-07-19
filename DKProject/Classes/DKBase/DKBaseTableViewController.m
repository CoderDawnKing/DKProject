//
//  DKBaseTableViewController.m
//  GardenManager
//
//  Created by 王 on 2019/7/13.
//  Copyright © 2019 wisezone. All rights reserved.
//

#import "DKBaseTableViewController.h"
#import <DKProject/DKProject.h>

@interface DKBaseTableViewController ()<DKBaseNavigationControllerDelegate>

@property (nonatomic, copy) NSString *barStyleString;

@end

@implementation DKBaseTableViewController

@synthesize dk_navigationBarBackgroundImage = _dk_navigationBarBackgroundImage;

- (void)didInitialize {
    [super didInitialize];
    self.customNavBarTransition = YES;
    self.recognizerEnable = YES;
    self.scrollingAnimator = NO;
    self.scrollingSnapAnimator = NO;
    self.dk_scrollingProgress = 1;
}

- (void)initTableView {
    [super initTableView];
    if (IsUITest) {
        self.tableView.accessibilityLabel = [NSString stringWithFormat:@"viewController-%@", self.title];
    }
}

- (void)setTitle:(NSString *)title {
    [super setTitle:title];
    if (IsUITest && self.isViewLoaded) {
        self.tableView.accessibilityLabel = [NSString stringWithFormat:@"viewController-%@", self.title];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self __addSubViews];
    [self __makeConstraints];
    [self __addViewModel];
    self.dk_Navi.dk_delegate = self;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(noNetwork) name:DK_Noti_NoNetwork_NameKey object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(networkError) name:DK_Noti_NetworkError_NameKey object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(networkSuccess) name:DK_Noti_NetworkSuccess_NameKey object:nil];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    if (self.isScrollingSnapAnimator) {
        self.dk_navigationScrollingSnapAnimator.scrollView.contentInset = UIEdgeInsetsMake(self.qmui_navigationBarMaxYInViewCoordinator, 0, self.view.qmui_safeAreaInsets.bottom, 0);
        self.dk_navigationScrollingSnapAnimator.scrollView.scrollIndicatorInsets = self.dk_navigationScrollingSnapAnimator.scrollView.contentInset;
        [self.dk_navigationScrollingSnapAnimator.scrollView qmui_scrollToTopUponContentInsetTopChange];
    }   
}

- (instancetype)initWithViewModel:(id<DKBaseViewModelProtocol>)viewModel {
    if (self = [super init]) {}
    return self;
}

- (instancetype)initWithModel:(DKBaseModel *)model {
    if (self = [super init]) {}
    return self;
}

/** 加载子视图 */
- (void)__addSubViews {}

/** 添加模型 */
- (void)__addViewModel {}

/** 布置约束 */
- (void)__makeConstraints {}

/** 更新约束 */
- (void)__updateConstraints{}

#pragma - mark method
- (DKBaseNavigationController *)dk_Navi {
    if (!_dk_Navi && [self.navigationController isKindOfClass:DKBaseNavigationController.class]) {
        _dk_Navi = (DKBaseNavigationController *)self.navigationController;
    }
    return _dk_Navi;
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    if (self.dk_barStyle == DKNavigationBarStyleDark) {
        return UIStatusBarStyleLightContent;
    } else {
        // 需要手动调用 navigationAnimator.statusbarStyleBlock 来告诉系统状态栏的变化
        if (self.isScrollingAnimator && self.dk_navigationScrollingAnimator) {
            return self.dk_navigationScrollingAnimator.statusbarStyleBlock(self.dk_navigationScrollingAnimator, self.dk_navigationScrollingAnimator.progress);
        }
        return UIStatusBarStyleDefault;
    }
}

#pragma - mark setter
- (void)setHiddenShadowImage:(BOOL)hiddenShadowImage {
    _hiddenShadowImage = hiddenShadowImage;
    if (_hiddenShadowImage) {
        self.dk_navigationBarShadowImage = [UIImage new];
    } else {
        self.dk_navigationBarShadowImage = nil;
    }
}

- (void)setDk_navigationBarAlpha:(CGFloat)dk_navigationBarAlpha {
    _dk_navigationBarAlpha = dk_navigationBarAlpha;
    self.navigationController.navigationBar.subviews.firstObject.alpha = _dk_navigationBarAlpha;
}

- (void)setDk_navigationBarBackgroundColor:(UIColor *)dk_navigationBarBackgroundColor {
    _dk_navigationBarBackgroundColor = dk_navigationBarBackgroundColor;
    self.dk_navigationBarBackgroundImage = [UIImage qmui_imageWithColor:_dk_navigationBarBackgroundColor];
}

- (void)setDk_navigationBarBackgroundImage:(UIImage *)dk_navigationBarBackgroundImage {
    _dk_navigationBarBackgroundImage = dk_navigationBarBackgroundImage;
    if (_dk_navigationBarBackgroundImage) {
        self.dk_barStyle = DKNavigationBarStyleCustom;
#ifdef DK_CustomNavBarTransition
        // 获取图片的均色, 根据图片的 rgba 来判断是否需要实现导航栏动画
        UIColor *color = [_dk_navigationBarBackgroundImage qmui_averageColor];
        self.barStyleString = [NSString stringWithFormat:@"r:%f,g:%f,b:%f,a:%f", color.qmui_red, color.qmui_green, color.qmui_blue, color.qmui_alpha];
#else
#endif
    } else {
        self.dk_barStyle = DKNavigationBarStyleOrigin;
    }
}

- (void)setScrollingSnapAnimator:(BOOL)scrollingSnapAnimator {
    _scrollingSnapAnimator = scrollingSnapAnimator;
    if (_scrollingSnapAnimator) {
        // 为了避免更改 navigationBar 显隐影响 scrollView 的滚动，这里屏蔽掉自动适应 contentInset
        if (@available(iOS 11, *)) {
            self.dk_navigationScrollingSnapAnimator.scrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        } else {
            self.automaticallyAdjustsScrollViewInsets = NO;
        }
    }
}

#pragma - mark getter
- (UIImage *)dk_navigationBarBackgroundImage {
    if (!_dk_navigationBarBackgroundImage) {
        _dk_navigationBarBackgroundImage = NavBarBackgroundImage;
    }
    return _dk_navigationBarBackgroundImage;
}

- (UIImage *)dk_navigationBarShadowImage {
    if (!_dk_navigationBarShadowImage) {
        _dk_navigationBarShadowImage = NavBarShadowImage;
    }
    return _dk_navigationBarShadowImage;
}

- (UIColor *)dk_navigationBarTintColor {
    if (!_dk_navigationBarTintColor) {
        _dk_navigationBarTintColor = NavBarTintColor;
    }
    return _dk_navigationBarTintColor;
}

- (UIColor *)dk_navigationBarOriginalTintColor {
    if (!_dk_navigationBarOriginalTintColor) {
        _dk_navigationBarOriginalTintColor = self.dk_navigationBarTintColor;
    }
    return _dk_navigationBarOriginalTintColor;
}

- (UIColor *)dk_titleViewTintColor {
    if (!_dk_titleViewTintColor) {
        _dk_titleViewTintColor = NavBarTitleColor;
    }
    return _dk_titleViewTintColor;
}

- (UIColor *)dk_titleViewOriginalTintColor {
    if (!_dk_titleViewOriginalTintColor) {
        _dk_titleViewOriginalTintColor = self.dk_titleViewTintColor;
    }
    return _dk_titleViewOriginalTintColor;
}

- (QMUINavigationBarScrollingAnimator *)dk_navigationScrollingAnimator {
    if (!_dk_navigationScrollingAnimator) {
        _dk_navigationScrollingAnimator = [[QMUINavigationBarScrollingAnimator alloc] init];
        _dk_navigationScrollingAnimator.backgroundImageBlock = ^UIImage * _Nonnull(QMUINavigationBarScrollingAnimator * _Nonnull animator, float progress) {
            return self.isScrollingAnimator?[self.dk_navigationBarBackgroundImage qmui_imageWithAlpha:progress]:self.dk_navigationBarBackgroundImage;
        };
        _dk_navigationScrollingAnimator.shadowImageBlock = ^UIImage * _Nonnull(QMUINavigationBarScrollingAnimator * _Nonnull animator, float progress) {
            return self.isScrollingAnimator?[self.dk_navigationBarShadowImage qmui_imageWithAlpha:progress]:self.dk_navigationBarShadowImage;
        };
        _dk_navigationScrollingAnimator.tintColorBlock = ^UIColor * _Nonnull(QMUINavigationBarScrollingAnimator * _Nonnull animator, float progress) {
            return self.isScrollingAnimator?[UIColor qmui_colorFromColor:self.dk_navigationBarOriginalTintColor toColor:self.dk_navigationBarTintColor progress:progress]:self.dk_navigationBarTintColor;
        };
        _dk_navigationScrollingAnimator.titleViewTintColorBlock = ^UIColor * _Nonnull(QMUINavigationBarScrollingAnimator * _Nonnull animator, float progress) {
            return self.isScrollingAnimator?[UIColor qmui_colorFromColor:self.dk_titleViewOriginalTintColor toColor:self.dk_titleViewTintColor progress:progress]:self.dk_titleViewTintColor;
        };
        _dk_navigationScrollingAnimator.statusbarStyleBlock = ^UIStatusBarStyle(QMUINavigationBarScrollingAnimator * _Nonnull animator, float progress) {
            return self.isScrollingAnimator?(progress<=self.dk_scrollingProgress?UIStatusBarStyleDefault:UIStatusBarStyleLightContent):UIStatusBarStyleDefault;
        };
    }
    return _dk_navigationScrollingAnimator;
}

- (QMUINavigationBarScrollingSnapAnimator *)dk_navigationScrollingSnapAnimator {
    if (!_dk_navigationScrollingSnapAnimator) {
        _dk_navigationScrollingSnapAnimator = [[QMUINavigationBarScrollingSnapAnimator alloc] init];
        _dk_navigationScrollingSnapAnimator.scrollView = self.tableView;
        _dk_navigationScrollingSnapAnimator.animationBlock = ^(QMUINavigationBarScrollingSnapAnimator * _Nonnull animator, BOOL offsetYReached) {
            if (self.dk_scrollingSnapAnimationBlock) {
                self.dk_scrollingSnapAnimationBlock(animator, offsetYReached);
            }
            if (self.isScrollingSnapAnimator) {
                [self.navigationController setNavigationBarHidden:offsetYReached animated:YES];
            }
        };
    }
    return _dk_navigationScrollingSnapAnimator;
}

#pragma - mark DKBaseViewControllerDelegate
- (BOOL)dk_popViewController {
    return YES;
}

#pragma - mark DKBaseNaviControllerDelegate
- (BOOL)dk_leftBarButtonItemPopViewController {
    return [self dk_popViewController];
}

#pragma - mark UINavigationControllerBackButtonHandlerProtocol
/**
* 点击系统返回按钮或者手势返回的时候是否要相应界面返回（手动调用代码pop排除）。支持参数判断是点击系统返回按钮还是通过手势触发
* 一般使用的场景是：可以在这个返回里面做一些业务的判断，比如点击返回按钮的时候，如果输入框里面的文本没有满足条件的则可以弹 Alert 并且返回 NO 来阻止用户退出界面导致不合法的数据或者数据丢失。
*/
- (BOOL)shouldPopViewControllerByBackButtonOrPopGesture:(BOOL)byPopGesture {
    return [self dk_popViewController];
}

/// 当自定义了`leftBarButtonItem`按钮之后，系统的手势返回就失效了。可以通过`forceEnableInteractivePopGestureRecognizer`来决定要不要把那个手势返回强制加回来。当 interactivePopGestureRecognizer.enabled = NO 或者当前`UINavigationController`堆栈的viewControllers小于2的时候此方法无效。
- (BOOL)forceEnableInteractivePopGestureRecognizer {
    return self.recognizerEnable;
}

#pragma mark - QMUINavigationControllerDelegate
- (UIImage *)navigationBarBackgroundImage {
    if (self.dk_navigationBarBackgroundImage) {
        if (self.isScrollingAnimator && self.dk_navigationScrollingAnimator) {
            return self.dk_navigationScrollingAnimator.backgroundImageBlock(self.dk_navigationScrollingAnimator, self.dk_navigationScrollingAnimator.progress);
        }
        return self.dk_navigationBarBackgroundImage;
    } else if (self.dk_barStyle == DKNavigationBarStyleOrigin) {
        return NavBarBackgroundImage;
    } else if (self.dk_barStyle == DKNavigationBarStyleLight) {
        return nil; // nil则用系统默认颜色（带磨砂）
    } else if (self.dk_barStyle == DKNavigationBarStyleDark) {
        return [UIImage qmui_imageWithColor:UIColorMake(66, 66, 66)];
    } else {
        return NavBarBackgroundImage;
    }
}

- (UIImage *)navigationBarShadowImage {
    if (self.dk_navigationBarShadowImage) {
        if (self.isScrollingAnimator && self.dk_navigationScrollingAnimator) {
            return self.dk_navigationScrollingAnimator.shadowImageBlock(self.dk_navigationScrollingAnimator, self.dk_navigationScrollingAnimator.progress);
        }
        return self.dk_navigationBarShadowImage;
    } else if (self.dk_barStyle == DKNavigationBarStyleOrigin) {
        return NavBarShadowImage;
    } else if (self.dk_barStyle == DKNavigationBarStyleLight) {
        return nil; // nil则用系统默认颜色
    } else if (self.dk_barStyle == DKNavigationBarStyleDark) {
        return [UIImage qmui_imageWithColor:UIColorMake(99, 99, 99) size:CGSizeMake(10, PixelOne) cornerRadius:0];
    } else {
        return NavBarShadowImage;
    }
}

- (UIColor *)navigationBarTintColor {
    if (self.dk_navigationBarTintColor) {
        if (self.isScrollingAnimator && self.dk_navigationScrollingAnimator) {
            return self.dk_navigationScrollingAnimator.tintColorBlock(self.dk_navigationScrollingAnimator, self.dk_navigationScrollingAnimator.progress);
        }
        return self.dk_navigationBarTintColor;
    } else if (self.dk_barStyle == DKNavigationBarStyleOrigin) {
        return NavBarTintColor;
    } else if (self.dk_barStyle == DKNavigationBarStyleLight) {
        return UIColorBlue;
    } else if (self.dk_barStyle == DKNavigationBarStyleDark) {
        return NavBarTintColor;
    } else {
        return NavBarTintColor;
    }
}

- (UIColor *)titleViewTintColor {
    if (self.dk_titleViewTintColor) {
        if (self.isScrollingAnimator && self.dk_navigationScrollingAnimator) {
            return self.dk_navigationScrollingAnimator.titleViewTintColorBlock(self.dk_navigationScrollingAnimator, self.dk_navigationScrollingAnimator.progress);
        }
        return self.dk_titleViewTintColor;
    } else if (self.dk_barStyle == DKNavigationBarStyleOrigin) {
        return NavBarTitleColor;
    } else if (self.dk_barStyle == DKNavigationBarStyleLight) {
        return UIColorBlack;
    } else if (self.dk_barStyle == DKNavigationBarStyleDark) {
        return UIColorWhite;
    } else {
        return NavBarTitleColor;
    }
}

#pragma mark - <QMUICustomNavigationBarTransitionDelegate>
- (BOOL)preferredNavigationBarHidden {
    if (self.isScrollingSnapAnimator && self.dk_navigationScrollingSnapAnimator) {
        return self.dk_navigationScrollingSnapAnimator.offsetYReached;
    }
    return self.hiddenNavigationBar;
}

- (BOOL)shouldCustomizeNavigationBarTransitionIfHideable {
    return YES;
}

#ifdef DK_CustomNavBarTransition
// 默认不实现该方法,如需要实现:
// 手动导入 请在 Xcode 工程->TAGGETS->Build Setting->preProcessing Marcos 添加 DK_CustomNavBarTransition=1
// pods 导入 请在 pods 工程->TAGGETS->Build Setting->preProcessing Marcos 添加 DK_CustomNavBarTransition=1
- (NSString *)customNavigationBarTransitionKey {
    // 不同的 barStyle 返回不同的 key，这样在不同 barStyle 的界面之间切换时就能使用自定义的 navigationBar 样式，会带来更好的视觉体验
    // 返回 nil 则表示当前界面没有修改过导航栏样式
    // 注意，如果你使用配置表，建议打开 AutomaticCustomNavigationBarTransitionStyle，由 QMUI 自动帮你判断是否需要使用自定义样式，这样就无需再实现 customNavigationBarTransitionKey 方法。QMUI Demo 里为了展示接口的使用，没有打开这个开关。
    if (self.customNavBarTransition) {
        return self.dk_barStyle == DKNavigationBarStyleOrigin ? nil : self.dk_barStyle == DKNavigationBarStyleCustom ? self.barStyleString : [NSString qmui_stringWithNSInteger:self.dk_barStyle];
    }
    return nil;
}
#else

#endif

- (void)qmui_themeDidChangeByManager:(QMUIThemeManager *)manager identifier:(__kindof NSObject<NSCopying> *)identifier theme:(__kindof NSObject *)theme {
    [super qmui_themeDidChangeByManager:manager identifier:identifier theme:theme];
    [self.tableView reloadData];
}

@end
