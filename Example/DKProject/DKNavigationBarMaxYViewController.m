//
//  DKNavigationBarMaxYViewController.m
//  DKProject_Example
//
//  Created by DawnKing on 2020/7/15.
//  Copyright © 2020 wangshaoyu. All rights reserved.
//

#import "DKNavigationBarMaxYViewController.h"

@interface DKNavigationBarMaxYViewController ()<UITableViewDelegate, UITableViewDataSource>

@property(nonatomic, strong) UIView *testView;

@end

@implementation DKNavigationBarMaxYViewController

@synthesize tableView = _tableView;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"隐藏导航栏";
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem qmui_itemWithTitle:@"返回首页" target:self action:@selector(popRoot)];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    // 主动在转场过程中触发布局的重新运算
    [self.view setNeedsLayout];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.view setNeedsLayout];
    });
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    // 主动在转场过程中触发布局的重新运算
    [self.view setNeedsLayout];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.view setNeedsLayout];
    });
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    // y 紧贴着导航栏底部，以表示当前的 self.qmui_navigationBarMaxYInViewCoordinator 的值
    self.testView.frame = CGRectSetXY(self.testView.frame, CGFloatGetCenter(CGRectGetWidth(self.view.bounds), CGRectGetWidth(self.testView.frame)), self.qmui_navigationBarMaxYInViewCoordinator);
}

- (void)__addSubViews {
    self.testView = [[UIView alloc] qmui_initWithSize:CGSizeMake(100, 100)];
    self.testView.userInteractionEnabled = NO;
    self.testView.backgroundColor = dk_HexColor(DK_COLOR_RED);
    [self.view addSubview:self.testView];
    [self.view addSubview:self.tableView];
}

- (void)__makeConstraints {
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.edges.mas_equalTo(UIEdgeInsetsMake(self.edgesForExtendedLayout == UIRectEdgeNone?self.isHiddenNavigationBar?dk_StatusBarHeight:0:dk_NavBarAndStatusBarHeight, 0, 0, 0));
    }];
}

#pragma UITableView DataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *ident = @"DKBaseTableViewCell";
    DKBaseTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ident];
    if (!cell) {
        cell = [DKBaseTableViewCell cellWithType:DKBaseTableViewCellTypeDefault ident:ident hasArrow:YES];
    }
    cell.title.text = @[@"进入显示 navigationBar 的界面", @"进入隐藏 navigationBar 的界面"][indexPath.row];
    return cell;
}

#pragma UITableView Delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    DKNavigationBarMaxYViewController *viewController = [[DKNavigationBarMaxYViewController alloc] init];
    viewController.hiddenNavigationBar = [@[@"进入显示 navigationBar 的界面", @"进入隐藏 navigationBar 的界面"][indexPath.row] isEqualToString:@"进入隐藏 navigationBar 的界面"];
    [self.navigationController pushViewController:viewController animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
//    return UITableViewAutomaticDimension;
    return 40;
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 40;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *header = [UIView new];
    return header;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return UITableViewAutomaticDimension;
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForHeaderInSection:(NSInteger)section {
    if (@available (iOS 11.0, *)) {// 11以下闪退
        return 0.0001;
    }
    return 40;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    QMUITableViewHeaderFooterView *footerView = [[QMUITableViewHeaderFooterView alloc] init];
    footerView.backgroundView.backgroundColor = UIColorClear;
    footerView.contentEdgeInsets = UIEdgeInsetsSetTop(footerView.contentEdgeInsets, 0);
    footerView.titleLabel.font = UIFontMake(12);
    footerView.titleLabel.textColor = dk_HexColor(DK_COLOR_DDDDDD);
    footerView.titleLabel.qmui_borderPosition = QMUIViewBorderPositionTop;
    footerView.titleLabel.qmui_borderColor = TableViewSeparatorColor;
    return footerView;
}

- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section {
    return @"\n色块顶部的 y 值也即 self.qmui_navigationBarMaxYInViewCoordinator 的值，选择不同显隐状态进入下一个界面，观察 push/pop/手势返回过程中色块布局是否会跳动";
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return UITableViewAutomaticDimension;
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForFooterInSection:(NSInteger)section {
    if (@available (iOS 11.0, *)) {
        return 0.0001;
    }
    return 40;
}

#pragma - mark lazy
- (DKBaseTableView *)tableView {
    if (!_tableView) {
        _tableView = [[DKBaseTableView alloc] initWithFrame:CGRectMake(0, 0, 0, 0) style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = dk_HexColor(DK_COLOR_WHITE);
    }
    return _tableView;
}

#pragma - mark action
- (void)popRoot {
    [self dk_backToRootViewController];
}


@end
