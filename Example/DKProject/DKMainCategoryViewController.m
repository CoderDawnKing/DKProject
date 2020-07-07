//
//  DKMainCategoryViewController.m
//  DKProject_Example
//
//  Created by 王 on 2020/7/7.
//  Copyright © 2020 wangshaoyu. All rights reserved.
//

#import "DKMainCategoryViewController.h"

@interface DKMainCategoryViewController ()
@property (nonatomic, strong) JXCategoryTitleView *myCategoryView;
@end

@implementation DKMainCategoryViewController

- (void)viewDidLoad {
    self.titles = @[@"螃蟹", @"麻辣小龙虾", @"苹果", @"营养胡萝卜", @"葡萄", @"美味西瓜", @"香蕉", @"香甜菠萝", @"鸡肉", @"鱼", @"海星"];
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"第二页";
    self.myCategoryView.titles = self.titles;
}

- (JXCategoryBaseView *)preferredCategoryView {
    return [[JXCategoryTitleView alloc] init];
}

- (CGFloat)preferredCategoryViewHeight {
    return 35;
}

- (void)categoryView:(JXCategoryBaseView *)categoryView didSelectedItemAtIndex:(NSInteger)index {
    self.dk_Navi.recognizer.enabled = (index == 0);
}

- (void)categoryView:(JXCategoryBaseView *)categoryView scrollingFromLeftIndex:(NSInteger)leftIndex toRightIndex:(NSInteger)rightIndex ratio:(CGFloat)ratio {
    [self.listContainerView scrollingFromLeftIndex:leftIndex toRightIndex:rightIndex ratio:ratio selectedIndex:categoryView.selectedIndex];
}

- (id<JXCategoryListContentViewDelegate>)listContainerView:(JXCategoryListContainerView *)listContainerView initListForIndex:(NSInteger)index {
    DKBaseListViewController *list = [[DKBaseListViewController alloc] init];
    list.view.backgroundColor = dk_RGBColor(arc4random()%255/255.0, arc4random()%255/255.0, arc4random()%255/255.0);
    return list;
}

- (JXCategoryTitleView *)myCategoryView {
    if (!_myCategoryView) {
        _myCategoryView = (JXCategoryTitleView *)self.categoryView;
        _myCategoryView.defaultSelectedIndex = self.defaultSelectedIndex;
        _myCategoryView.titles = self.titles;
        _myCategoryView.titleColorGradientEnabled = YES;
        JXCategoryIndicatorLineView *lineView = [[JXCategoryIndicatorLineView alloc] init];
        lineView.indicatorColor = dk_HexColor(DK_COLOR_APPMAIN);
        lineView.indicatorHeight = 2;
        _myCategoryView.indicators = @[lineView];
    }
    return _myCategoryView;
}

@end
