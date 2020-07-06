//
//  BaseViewController.m
//  GardenManager
//
//  Created by 王 on 2019/6/17.
//  Copyright © 2019 wisezone. All rights reserved.
//

#import "DKBaseViewController.h"
#import <DKProject/DKProject.h>

@interface DKBaseViewController ()

@property (nonatomic, strong) UIView *navigationBarLargeTitleView;
@property (nonatomic, strong) UIView *barBackgroundView;
@property (nonatomic, strong) UILabel *largeTitleLabel;
@property (nonatomic, strong, nullable) UIImage *emptyOriginalImage;
@property (nonatomic, strong, nullable) NSString *emptyOriginalPrompt;

@end

@implementation DKBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = dk_HexColor(COLOR_WHITE);
    [self __addSubViews];
    [self __makeConstraints];
    [self __addViewModel];
    self.showBigTitle = NO;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(noNetwork) name:DK_Noti_NoNetwork_NameKey object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(networkError) name:DK_Noti_NetworkError_NameKey object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(networkSuccess) name:DK_Noti_NetworkSuccess_NameKey object:nil];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.dk_Navi.navigationBarHidden = NO;
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    self.navigationBarLargeTitleView.backgroundColor = dk_ClearColor;
    self.barBackgroundView.backgroundColor = dk_ClearColor;
    self.largeTitleLabel.hidden = YES;
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    if (@available (iOS 13.0, *)) {
        if (self.showBigTitle && !self.largeTitleLabel) {
            for (UIView *view in self.dk_Navi.navigationBar.subviews) {
                if ([view isKindOfClass:NSClassFromString(@"_UINavigationBarLargeTitleView")]) {
                    for (UIView *largeTitleLabel1 in view.subviews) {
                        if ([largeTitleLabel1 isKindOfClass:[UILabel class]]) {
                            largeTitleLabel1.hidden = NO;
                            self.largeTitleLabel = (UILabel *)largeTitleLabel1;
                        } else {
                            for (UIView *largeTitleLabel2 in largeTitleLabel1.subviews) {
                                if ([largeTitleLabel2 isKindOfClass:[UILabel class]]) {
                                    largeTitleLabel2.hidden = NO;
                                    self.largeTitleLabel = (UILabel *)largeTitleLabel2;
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    if (@available (iOS 13.0, *)) {
        // iOS 13 将大标题的背景色改成透明了
        if (self.showBigTitle) {
            for (UIView *view in self.dk_Navi.navigationBar.subviews) {
                if ([view isKindOfClass:NSClassFromString(@"_UINavigationBarLargeTitleView")]) {
                    view.backgroundColor = dk_HexColor(COLOR_WHITE);
                    self.navigationBarLargeTitleView = view;
                    for (UIView *largeTitleLabel1 in view.subviews) {
                        if ([largeTitleLabel1 isKindOfClass:[UILabel class]]) {
                            largeTitleLabel1.hidden = NO;
                            self.largeTitleLabel = (UILabel *)largeTitleLabel1;
                        } else {
                            for (UIView *largeTitleLabel2 in largeTitleLabel1.subviews) {
                                if ([largeTitleLabel2 isKindOfClass:[UILabel class]]) {
                                    largeTitleLabel2.hidden = NO;
                                    self.largeTitleLabel = (UILabel *)largeTitleLabel2;
                                }
                            }
                        }
                    }
                }
                if ([view isKindOfClass:NSClassFromString(@"_UIBarBackground")]) {
                    view.backgroundColor = dk_HexColor(COLOR_WHITE);
                    self.barBackgroundView = view;
                }
            }
            for (UIView *transitionView in self.dk_Navi.view.subviews) {
                if ([transitionView isKindOfClass:NSClassFromString(@"UINavigationTransitionView")]) {
                    for (UIView * wrapperView in transitionView.subviews) {
                        if ([wrapperView isKindOfClass:NSClassFromString(@"UIViewControllerWrapperView")]) {
                            for (UIView *view in wrapperView.subviews) {
                                view.backgroundColor = dk_HexColor(COLOR_WHITE);
                            }
                        }
                    }
                }
            }
        }
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
    if (!_dk_Navi) {
        _dk_Navi = (DKBaseNaviController *)self.navigationController;
    }
    return _dk_Navi;
}

- (UIModalPresentationStyle)modalPresentationStyle {
    return UIModalPresentationFullScreen;
}

- (UIUserInterfaceStyle)overrideUserInterfaceStyle {
    return UIUserInterfaceStyleLight;
}

#pragma - mark 修改缺省页通知
- (void)noNetwork {
    if (!self.emptyOriginalImage) {
        self.emptyOriginalImage = self.tableView.emptyView.emptyImage;
    }
    if (!self.emptyOriginalPrompt) {
        self.emptyOriginalPrompt = self.tableView.emptyView.emptyPrompt;
    }
    self.tableView.emptyView.emptyImage = dk_IMAGE(@"default_img_noNetwork");
    self.tableView.emptyView.emptyPrompt = @"网络出错啦，请检查网络情况~";
}

- (void)networkError {
    if (!self.emptyOriginalImage) {
        self.emptyOriginalImage = self.tableView.emptyView.emptyImage;
    }
    if (!self.emptyOriginalPrompt) {
        self.emptyOriginalPrompt = self.tableView.emptyView.emptyPrompt;
    }
    self.tableView.emptyView.emptyImage = dk_IMAGE(@"default_img_networkError");
    self.tableView.emptyView.emptyPrompt = @"程序猿小哥哥正在维修中，请稍后再试～";
}

- (void)networkSuccess {
    if (self.emptyOriginalImage) {
        self.tableView.emptyView.emptyImage = self.emptyOriginalImage;
        self.emptyOriginalImage = nil;
    }
    if (self.emptyOriginalPrompt) {
        self.tableView.emptyView.emptyPrompt =self.emptyOriginalPrompt;
        self.emptyOriginalPrompt = nil;
    }
}

@end
