//
//  DKChangeNaviBarViewController.m
//  DKProject_Example
//
//  Created by DawnKing on 2020/7/15.
//  Copyright © 2020 wangshaoyu. All rights reserved.
//

#import "DKChangeNaviBarViewController.h"

@interface DKChangeNaviBarViewController ()<UITableViewDelegate, UITableViewDataSource>

@property(nonatomic, strong) DKChangeNaviBarViewController *viewController;
@end

@implementation DKChangeNaviBarViewController

@synthesize tableView = _tableView;

- (instancetype)initWithBarStyle:(DKNavigationBarStyle)barStyle {
    if (self = [super init]) {
        self.dk_barStyle = barStyle;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"修改导航栏样式";
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem qmui_itemWithTitle:@"返回首页" target:self action:@selector(popRoot)];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}

- (void)__addSubViews {
    [self.view addSubview:self.tableView];
}

- (void)__makeConstraints {
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.edges.mas_equalTo(UIEdgeInsetsMake(self.edgesForExtendedLayout == UIRectEdgeNone?0:dk_NavBarAndStatusBarHeight, 0, 0, 0));
    }];
}

#pragma UITableView DataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *ident = @"DKBaseTableViewCell";
    DKBaseTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ident];
    if (!cell) {
        cell = [DKBaseTableViewCell cellWithType:DKBaseTableViewCellTypeDefault ident:ident hasArrow:YES];
    }
    cell.title.text = @[@"默认navBar样式", @"浅色navBar样式", @"暗色navBar样式"][indexPath.row];
    return cell;
}

#pragma UITableView Delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    self.viewController = [[DKChangeNaviBarViewController alloc] initWithBarStyle:indexPath.row];
    if (self.customNavBarTransition) {
        self.viewController.previousBarStyle = self.dk_barStyle;
        self.viewController.customNavBarTransition = YES;
    }
    self.viewController.title = @[@"默认navBar样式", @"浅色navBar样式", @"暗色navBar样式"][indexPath.row];
    [self.navigationController pushViewController:self.viewController animated:YES];
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
    UIView *footer = [UIView new];
    return footer;
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

#pragma mark - <QMUICustomNavigationBarTransitionDelegate>

- (NSString *)customNavigationBarTransitionKey {
    // 父类已经支持 这里重新实现
    // 不同的 barStyle 返回不同的 key，这样在不同 barStyle 的界面之间切换时就能使用自定义的 navigationBar 样式，会带来更好的视觉体验
    // 返回 nil 则表示当前界面没有修改过导航栏样式
    // 注意，如果你使用配置表，建议打开 AutomaticCustomNavigationBarTransitionStyle，由 QMUI 自动帮你判断是否需要使用自定义样式，这样就无需再实现 customNavigationBarTransitionKey 方法。QMUI Demo 里为了展示接口的使用，没有打开这个开关。
    if (self.customNavBarTransition) {
        return self.dk_barStyle == DKNavigationBarStyleOrigin ? nil : [NSString qmui_stringWithNSInteger:self.dk_barStyle];
    }
    return nil;
}

@end
