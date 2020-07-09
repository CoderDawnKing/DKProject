//
//  DKBaseCategoryViewController.m
//  GardenManager
//
//  Created by 王 on 2019/7/24.
//  Copyright © 2019 wisezone. All rights reserved.
//

#import "DKBaseCategoryViewController.h"
#import <DKProject/DKProject.h>

@interface DKBaseCategoryViewController ()

@end

@implementation DKBaseCategoryViewController

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
    self.dk_Navi.recognizer.enabled = (self.categoryView.selectedIndex == 0);
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];

    //离开页面的时候，需要恢复屏幕边缘手势，不能影响其他页面
    self.dk_Navi.recognizer.enabled = YES;
}

- (BOOL)dk_isKindOfClass {
    return NO;
}

- (JXCategoryBaseView *)preferredCategoryView {
    return [[JXCategoryBaseView alloc] init];
}

- (CGFloat)preferredCategoryViewHeight {
    return 50;
}

- (CGFloat)preferredCategoryViewTop {
    return 0;
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
    self.dk_Navi.recognizer.enabled = (index == 0);
}

- (void)categoryView:(JXCategoryBaseView *)categoryView didScrollSelectedItemAtIndex:(NSInteger)index {
}

#pragma mark - JXCategoryListContainerViewDelegate

- (id<JXCategoryListContentViewDelegate>)listContainerView:(JXCategoryListContainerView *)listContainerView initListForIndex:(NSInteger)index {
    DKBaseListViewController *list = [[DKBaseListViewController alloc] init];
    return list;
}

- (NSInteger)numberOfListsInlistContainerView:(JXCategoryListContainerView *)listContainerView {
    return self.titles.count;
}

@end
