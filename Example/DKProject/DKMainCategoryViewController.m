//
//  DKMainCategoryViewController.m
//  DKProject_Example
//
//  Created by 王 on 2020/7/7.
//  Copyright © 2020 wangshaoyu. All rights reserved.
//

#import "DKMainCategoryViewController.h"
#import "DKMainListViewController.h"

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

- (void)handleBackButtonEvent:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
//    self.dk_Navi.navigationBarHidden = YES;
}

- (JXCategoryBaseView *)preferredCategoryView {
    return [[JXCategoryTitleView alloc] init];
}

- (CGFloat)preferredCategoryViewHeight {
    return 35;
}

- (void)categoryView:(JXCategoryBaseView *)categoryView didSelectedItemAtIndex:(NSInteger)index {
    self.recognizerEnable = (index == 0);
}

- (id<JXCategoryListContentViewDelegate>)listContainerView:(JXCategoryListContainerView *)listContainerView initListForIndex:(NSInteger)index {
    DKMainListViewController *list = [[DKMainListViewController alloc] init];
    list.view.backgroundColor = dk_RGBColor(arc4random()%255/255.0, arc4random()%255/255.0, arc4random()%255/255.0);
    return list;
}

- (JXCategoryTitleView *)myCategoryView {
    if (!_myCategoryView) {
        _myCategoryView = (JXCategoryTitleView *)self.categoryView;
        _myCategoryView.titleColorGradientEnabled = YES;
        JXCategoryIndicatorLineView *lineView = [[JXCategoryIndicatorLineView alloc] init];
        lineView.indicatorColor = dk_HexColor(DK_COLOR_APPMAIN);
        lineView.indicatorHeight = 2;
        _myCategoryView.indicators = @[lineView];
    }
    return _myCategoryView;
}

- (BOOL)dk_popViewController {
    // 这里不要做一些费时的操作，否则可能会卡顿。
    QMUIAlertController *alertController = [QMUIAlertController alertControllerWithTitle:@"是否返回？" message:@"返回后输入框的数据将不会自动保存" preferredStyle:QMUIAlertControllerStyleAlert];
    QMUIAlertAction *backActioin = [QMUIAlertAction actionWithTitle:@"返回" style:QMUIAlertActionStyleCancel handler:^(QMUIAlertController *aAlertController, QMUIAlertAction *action) {
        [self.navigationController popViewControllerAnimated:YES];
    }];
    QMUIAlertAction *continueAction = [QMUIAlertAction actionWithTitle:@"继续编辑" style:QMUIAlertActionStyleDefault handler:^(QMUIAlertController *aAlertController, QMUIAlertAction *action) {
        
    }];
    [alertController addAction:backActioin];
    [alertController addAction:continueAction];
    [alertController showWithAnimated:YES];
    return NO;
}

@end
