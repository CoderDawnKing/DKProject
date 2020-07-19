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
@end

@implementation DKMainCategoryViewController

- (void)didInitialize {
    [super didInitialize];
    self.edgesForExtendedLayout = UIRectEdgeAll;
//    self.dk_barStyle = DKNavigationBarStyleDark;
//    self.scrollingAnimator = YES;
    self.scrollingSnapAnimator = YES;
    
    self.dk_navigationBarBackgroundImage = [UIImage imageWithColor:UIColorRed];
    @weakify(self);
    self.dk_navigationScrollingSnapAnimator.animationBlock = ^(QMUINavigationBarScrollingSnapAnimator * _Nonnull animator, BOOL offsetYReached) {
        @strongify(self);
        [UIView animateWithDuration:.2 animations:^{
            self.categoryView.y = offsetYReached ? dk_StatusBarHeight : dk_NavBarAndStatusBarHeight;
        }];
        [self.navigationController setNavigationBarHidden:offsetYReached animated:YES];
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
}

- (id<JXCategoryListContentViewDelegate>)listContainerView:(JXCategoryListContainerView *)listContainerView initListForIndex:(NSInteger)index {
    DKMainListViewController *list = [[DKMainListViewController alloc] initWithDelegate:self]; /// 子类中不用实现该代理方法
    list.view.backgroundColor = dk_RGBColor(arc4random()%255/255.0, arc4random()%255/255.0, arc4random()%255/255.0);
    self.dk_navigationScrollingSnapAnimator.scrollView = list.tableView;
    self.dk_navigationScrollingSnapAnimator.offsetYToStartAnimation = 44;
    return list;
}

- (void)dk_scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat alpha = scrollView.contentOffset.y;
    if (alpha < 0) {
        alpha = 0;
    }
    if (alpha > 100) {
        alpha = 100;
    }
    self.dk_navigationBarAlpha = (100 - alpha) / 100.0;
}

- (JXCategoryTitleView *)myCategoryView {
    if (!_myCategoryView) {
        _myCategoryView = (JXCategoryTitleView *)self.categoryView;
        _myCategoryView.titleColorGradientEnabled = YES;
        _myCategoryView.titleSelectedColor = dk_HexColor(DK_COLOR_APPMAIN);
        JXCategoryIndicatorLineView *lineView = [[JXCategoryIndicatorLineView alloc] init];
        lineView.indicatorColor = dk_HexColor(DK_COLOR_APPMAIN);
        lineView.indicatorHeight = 2;
        _myCategoryView.indicators = @[lineView];
    }
    return _myCategoryView;
}

@end
