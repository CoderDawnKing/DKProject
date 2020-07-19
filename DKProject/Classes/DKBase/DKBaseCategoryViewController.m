//
//  DKBaseCategoryViewController.m
//  GardenManager
//
//  Created by 王 on 2019/7/24.
//  Copyright © 2019 wisezone. All rights reserved.
//

#import "DKBaseCategoryViewController.h"
#import <DKProject/DKProject.h>

@interface DKBaseCategoryViewController ()<DKBaseCategoryListDelegate>

@end

@implementation DKBaseCategoryViewController

- (void)didInitialize {
    [super didInitialize];
    /// 设置 view 不铺满 这样 categoryView 默认从导航栏下面开始布局  但是导航栏如果是默认的高斯模糊 并且控制器的上级界面导航栏有颜色 在 push 和 pop 的时候就会看到底部的颜色
    // TODO: 后面看看有没有办法解决
    // !!!: 如果需要 view 从界面铺满, 可以再自控制器的 didInitialize 方法设置成 UIRectEdgeAll 或者用全局默认配置为 All
    self.edgesForExtendedLayout = DKCONFIG.dk_categoryView_edgesForExtendedLayout;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.listContainerView];
    self.categoryView.listContainer = self.listContainerView;
    self.categoryView.delegate = self;
    [self.view addSubview:self.categoryView];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];

    if (![self dk_isKindOfClass]) {
        self.categoryView.frame = CGRectMake(0, [self preferredCategoryViewTop], self.view.bounds.size.width, [self preferredCategoryViewHeight]);
    }
    self.listContainerView.frame = CGRectMake(0, self.categoryView.bottom, self.view.bounds.size.width, self.view.bounds.size.height);
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];

    //处于第一个item的时候，才允许屏幕边缘手势返回
    self.recognizerEnable = (self.categoryView.selectedIndex == 0);
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];

    //离开页面的时候，需要恢复屏幕边缘手势，不能影响其他页面
    self.recognizerEnable = YES;
}

- (BOOL)dk_isKindOfClass {
    return NO;
}

/// 不要在 viewDidLayoutSubviews 中修改 tableView 的 ContentInset
- (BOOL)isLayoutTableViewContentInset {
    return NO;
}

- (JXCategoryBaseView *)preferredCategoryView {
    return [[JXCategoryBaseView alloc] init];
}

- (CGFloat)preferredCategoryViewHeight {
    return 50;
}

- (CGFloat)preferredCategoryViewTop {
    return self.edgesForExtendedLayout == UIRectEdgeNone? 0 : dk_NavBarAndStatusBarHeight;
}

/// 子类中不用实现该方法
/// 如果实现了自动隐藏导航栏,则底部需要再减去导航栏高度
- (UIEdgeInsets)preferredCategoryViewContentInset {
    return UIEdgeInsetsMake(0, 0, [self preferredCategoryViewHeight] + [self preferredCategoryViewTop] + dk_BottomSafeHeight - (self.isScrollingSnapAnimator?dk_NavBarHeight:0), 0);
}

- (JXCategoryBaseView *)categoryView {
    if (_categoryView == nil) {
        _categoryView = [self preferredCategoryView];
        _categoryView.defaultSelectedIndex = self.defaultSelectedIndex;
    }
    return _categoryView;
}

- (JXCategoryListContainerView *)listContainerView {
    if (_listContainerView == nil) {
        _listContainerView = [[JXCategoryListContainerView alloc] initWithType:JXCategoryListContainerType_ScrollView delegate:self];
    }
    return _listContainerView;
}

- (void)rightItemClicked {
    JXCategoryIndicatorView *componentView = (JXCategoryIndicatorView *)self.categoryView;
    for (JXCategoryIndicatorComponentView *view in componentView.indicators) {
        if (view.componentPosition == JXCategoryComponentPosition_Top) {
            view.componentPosition = JXCategoryComponentPosition_Bottom;
        }else {
            view.componentPosition = JXCategoryComponentPosition_Top;
        }
    }
    [componentView reloadDataWithoutListContainer];
}

#pragma mark - JXCategoryViewDelegate

- (void)categoryView:(JXCategoryBaseView *)categoryView didSelectedItemAtIndex:(NSInteger)index {
    //侧滑手势处理
    self.recognizerEnable = (index == 0);
}

- (void)categoryView:(JXCategoryBaseView *)categoryView didScrollSelectedItemAtIndex:(NSInteger)index {
}

#pragma mark - JXCategoryListContainerViewDelegate

- (id<JXCategoryListContentViewDelegate>)listContainerView:(JXCategoryListContainerView *)listContainerView initListForIndex:(NSInteger)index {
    DKBaseCategoryListViewController *list = [[DKBaseCategoryListViewController alloc] initWithDelegate:self];
    return list;
}

- (NSInteger)numberOfListsInlistContainerView:(JXCategoryListContainerView *)listContainerView {
    return self.titles.count;
}

@end
