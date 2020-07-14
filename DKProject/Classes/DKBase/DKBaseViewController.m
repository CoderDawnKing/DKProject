//
//  BaseViewController.m
//  GardenManager
//
//  Created by 王 on 2019/6/17.
//  Copyright © 2019 wisezone. All rights reserved.
//

#import "DKBaseViewController.h"
#import <DKProject/DKProject.h>

@interface DKBaseViewController ()<UINavigationControllerBackButtonHandlerProtocol, DKBaseNaviControllerDelegate>

@property (nonatomic, strong) UIView *navigationBarLargeTitleView;
@property (nonatomic, strong) UIView *barBackgroundView;
@property (nonatomic, strong) UILabel *largeTitleLabel;
@property (nonatomic, strong, nullable) UIImage *emptyOriginalImage;
@property (nonatomic, strong, nullable) NSString *emptyOriginalPrompt;

@end

@implementation DKBaseViewController

- (void)didInitialize {
    [super didInitialize];
    self.recognizerEnable = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = dk_HexColor(DK_COLOR_WHITE);
    
    // TODO: 不让view延伸到整个屏幕  但是默认高斯模糊导航栏切换颜色时会闪一下 后面看情况修改
    self.edgesForExtendedLayout = UIRectEdgeNone;
    [self __addSubViews];
    [self __makeConstraints];
    [self __addViewModel];
    self.dk_Navi.dk_delegate = self;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(noNetwork) name:DK_Noti_NoNetwork_NameKey object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(networkError) name:DK_Noti_NetworkError_NameKey object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(networkSuccess) name:DK_Noti_NetworkSuccess_NameKey object:nil];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
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
- (void)setShowBigTitle:(BOOL)showBigTitle {
    if ([self.navigationController isKindOfClass:[DKBaseNaviController class]]) {
        DKBaseNaviController *navi = (DKBaseNaviController *)self.navigationController;
        navi.hiddenShadowImage = _showBigTitle = showBigTitle;
        
        
        if (@available(iOS 11.0, *)) {
            self.navigationController.navigationBar.prefersLargeTitles = _showBigTitle;
            self.navigationItem.largeTitleDisplayMode = _showBigTitle ? UINavigationItemLargeTitleDisplayModeAlways : UINavigationItemLargeTitleDisplayModeNever;
        } else {
            // Fallback on earlier versions
        }
    }
    
}

- (DKBaseNaviController *)dk_Navi {
    if (!_dk_Navi && [self.navigationController isKindOfClass:DKBaseNavigationController.class]) {
        _dk_Navi = (DKBaseNavigationController *)self.navigationController;
    }
    return _dk_Navi;
}

//- (UIModalPresentationStyle)modalPresentationStyle {
//    return UIModalPresentationFullScreen;
//}
//
//- (UIUserInterfaceStyle)overrideUserInterfaceStyle {
//    return UIUserInterfaceStyleLight;
//}

- (UIStatusBarStyle)preferredStatusBarStyle {
    if (self.dk_barStyle == DKNavigationBarStyleDark) {
        return UIStatusBarStyleLightContent;
    } else {
        return UIStatusBarStyleDefault;
    }
}

#pragma - mark 修改缺省页通知
- (void)noNetwork {
    if (!self.emptyOriginalImage) {
        self.emptyOriginalImage = self.tableView.dk_emptyView.emptyImage;
    }
    if (!self.emptyOriginalPrompt) {
        self.emptyOriginalPrompt = self.tableView.dk_emptyView.emptyPrompt;
    }
    self.tableView.dk_emptyView.emptyImage = dk_BundleImage(@"default_img_noNetwork");
    self.tableView.dk_emptyView.emptyPrompt = @"网络出错啦，请检查网络情况~";
}

- (void)networkError {
    if (!self.emptyOriginalImage) {
        self.emptyOriginalImage = self.tableView.dk_emptyView.emptyImage;
    }
    if (!self.emptyOriginalPrompt) {
        self.emptyOriginalPrompt = self.tableView.dk_emptyView.emptyPrompt;
    }
    self.tableView.dk_emptyView.emptyImage = dk_BundleImage(@"default_img_networkError");
    self.tableView.dk_emptyView.emptyPrompt = @"程序猿小哥哥正在维修中，请稍后再试～";
}

- (void)networkSuccess {
    if (self.emptyOriginalImage) {
        self.tableView.dk_emptyView.emptyImage = self.emptyOriginalImage;
        self.emptyOriginalImage = nil;
    }
    if (self.emptyOriginalPrompt) {
        self.tableView.dk_emptyView.emptyPrompt =self.emptyOriginalPrompt;
        self.emptyOriginalPrompt = nil;
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
    return self.hiddenNavigationBar;
}

- (BOOL)shouldCustomizeNavigationBarTransitionIfHideable {
    return YES;
}

- (NSString *)customNavigationBarTransitionKey {
    // 不同的 barStyle 返回不同的 key，这样在不同 barStyle 的界面之间切换时就能使用自定义的 navigationBar 样式，会带来更好的视觉体验
    // 返回 nil 则表示当前界面没有修改过导航栏样式
    // 注意，如果你使用配置表，建议打开 AutomaticCustomNavigationBarTransitionStyle，由 QMUI 自动帮你判断是否需要使用自定义样式，这样就无需再实现 customNavigationBarTransitionKey 方法。QMUI Demo 里为了展示接口的使用，没有打开这个开关。
    return self.dk_barStyle == DKNavigationBarStyleOrigin ? nil : [NSString qmui_stringWithNSInteger:self.dk_barStyle];
}

@end
