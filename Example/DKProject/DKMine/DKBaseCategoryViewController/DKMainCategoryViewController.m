//
//  DKMainCategoryViewController.m
//  DKProject_Example
//
//  Created by 王 on 2020/7/7.
//  Copyright © 2020 wangshaoyu. All rights reserved.
//

#import "DKMainCategoryViewController.h"
#import "DKMainListViewController.h"

@interface DKMainCategoryViewController ()<DKMainListViewControllerDelegate, DKBaseCategoryListDelegate>
@property (nonatomic, strong) JXCategoryTitleView *myCategoryView;
@property (nonatomic, strong) NSMutableArray *listArrayM;
@end

@implementation DKMainCategoryViewController

- (void)didInitialize {
    [super didInitialize];
    self.edgesForExtendedLayout = UIRectEdgeAll;
//    self.dk_barStyle = DKNavigationBarStyleDark;
    self.scrollingAnimator = YES;
    self.scrollingSnapAnimator = YES;
    self.dk_navigationScrollingAnimator.offsetYToStartAnimation = 30;// 设置滚动的起点，值即表示在默认停靠的位置往下滚动多少距离后即触发动画，默认是 0
    self.dk_navigationScrollingAnimator.distanceToStopAnimation = 64;// 设置从起点开始滚动多长的距离达到终点
    self.dk_navigationBarBackgroundImage = [UIImage imageWithColor:[UIColorRed qmui_colorWithAlphaAddedToWhite:0.5]];
    self.dk_navigationBarShadowImage = NavBarShadowImage;
    self.dk_navigationBarOriginalTintColor = UIColorBlack;
    self.dk_titleViewOriginalTintColor = UIColorBlack;
    self.dk_scrollingProgress = 0.25;
    self.dk_navigationScrollingSnapAnimator.offsetYToStartAnimation = 100;
    
    @weakify(self);
    self.dk_scrollingSnapAnimationBlock = ^(QMUINavigationBarScrollingSnapAnimator * _Nonnull animator, BOOL offsetYReached) {
        @strongify(self);
        // 实现跟随导航栏隐藏的动画效果
        [UIView animateWithDuration:.2 animations:^{
            self.categoryView.y = offsetYReached ? [self preferredCategoryViewTop] - dk_NavBarHeight : [self preferredCategoryViewTop];
            self.listContainerView.y = self.categoryView.y + [self preferredCategoryViewHeight];
        }];
    };
    
}

- (void)viewDidLoad {
    self.titles = @[@"螃蟹", @"麻辣小龙虾", @"苹果", @"营养胡萝卜", @"葡萄", @"美味西瓜", @"香蕉", @"香甜菠萝", @"鸡肉", @"鱼", @"海星"];
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.myCategoryView.titles = self.titles;
}

- (JXCategoryBaseView *)preferredCategoryView {
    return [[JXCategoryTitleView alloc] init];
}

- (CGFloat)preferredCategoryViewHeight {
    return 40;
}

- (void)categoryView:(JXCategoryBaseView *)categoryView didSelectedItemAtIndex:(NSInteger)index {
    self.recognizerEnable = (index == 0);
    if (index < self.listArrayM.count) {// 防止 Controller 还未创建
        DKMainListViewController *list = self.listArrayM[index];
        self.dk_navigationScrollingAnimator.scrollView = list.tableView;
        self.dk_navigationScrollingSnapAnimator.scrollView = list.tableView;
    }
}

- (id<JXCategoryListContentViewDelegate>)listContainerView:(JXCategoryListContainerView *)listContainerView initListForIndex:(NSInteger)index {
    DKMainListViewController *list = [[DKMainListViewController alloc] initWithDelegate:self]; /// 子类中不用实现该代理方法
    list.view.backgroundColor = dk_RGBColor(arc4random()%255/255.0, arc4random()%255/255.0, arc4random()%255/255.0);
    self.dk_navigationScrollingAnimator.scrollView = list.tableView;
    self.dk_navigationScrollingSnapAnimator.scrollView = list.tableView;
    [self.listArrayM replaceObjectAtIndex:index withObject:list];// 因为创建只走一次,所以需要用数组存储
    return list;
}

- (JXCategoryTitleView *)myCategoryView {
    if (!_myCategoryView) {
        _myCategoryView = (JXCategoryTitleView *)self.categoryView;
        _myCategoryView.titleColorGradientEnabled = YES;
        _myCategoryView.titleSelectedColor = dk_HexColor(DK_COLOR_APPMAIN);
        _myCategoryView.backgroundColor = UIColorGray;
        JXCategoryIndicatorLineView *lineView = [[JXCategoryIndicatorLineView alloc] init];
        lineView.indicatorColor = dk_HexColor(DK_COLOR_APPMAIN);
        lineView.indicatorHeight = 2;
        _myCategoryView.indicators = @[lineView];
    }
    return _myCategoryView;
}

- (NSMutableArray *)listArrayM {
    if (!_listArrayM) {
        _listArrayM = [NSMutableArray arrayWithCapacity:self.titles.count];
        for (NSString *title in self.titles) {
            [_listArrayM addObject:title];
        }
    }
    return _listArrayM;
}

@end
