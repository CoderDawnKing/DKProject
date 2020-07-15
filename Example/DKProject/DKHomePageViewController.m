//
//  DKHomePageViewController.m
//  DKProject_Example
//
//  Created by 王 on 2020/7/7.
//  Copyright © 2020 wangshaoyu. All rights reserved.
//

#import "DKHomePageViewController.h"
#import "DKChangeNaviBarViewController.h"
#import "DKNavigationBarMaxYViewController.h"
#import "DKLargrTitlesViewController.h"

@interface DKHomePageViewController ()<UITableViewDelegate, UITableViewDataSource>

@end

@implementation DKHomePageViewController

@synthesize tableView = _tableView;
@synthesize datasArrM = _datasArrM;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"首页";
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem qmui_itemWithTitle:@"关于" target:self action:@selector(click)];
    self.dk_barStyle = DKNavigationBarStyleDark;
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
        make.edges.mas_equalTo(0);
    }];
}

#pragma UITableView DataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.datasArrM.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *ident = @"DKBaseTableViewCell";
    DKBaseTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ident];
    if (!cell) {
        cell = [DKBaseTableViewCell cellWithType:DKBaseTableViewCellTypeDefault ident:ident hasArrow:YES];
    }
    cell.title.text = self.datasArrM[indexPath.row];
    return cell;
}

#pragma UITableView Delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    UIViewController *viewController = nil;
    NSString *title = self.datasArrM[indexPath.row];
    if ([title isEqualToString:@"方便控制界面导航栏样式"]) {
        viewController = [[DKChangeNaviBarViewController alloc] initWithBarStyle:DKNavigationBarStyleOrigin];
    }
    else if ([title isEqualToString:@"优化导航栏在转场时的样式"]) {
        viewController = [[DKChangeNaviBarViewController alloc] init];
        ((DKChangeNaviBarViewController *)viewController).customNavBarTransition = YES;
    }
    else if ([title isEqualToString:@"获取导航栏的正确布局位置"]) {
        viewController = [[DKNavigationBarMaxYViewController alloc] init];
        ((DKNavigationBarMaxYViewController *)viewController).hiddenNavigationBar = YES;
    } else if ([title isEqualToString:@"兼容 LargeTitle"]) {
        viewController = [[DKLargrTitlesViewController alloc] init];
    }
    viewController.title = title;
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

- (NSMutableArray *)datasArrM {
    if (!_datasArrM) {
        _datasArrM = [NSMutableArray array];
        [_datasArrM addObjectsFromArray:@[@"方便控制界面导航栏样式", @"优化导航栏在转场时的样式", @"获取导航栏的正确布局位置", @"兼容 LargeTitle"]];
    }
    return _datasArrM;
}

#pragma - mark action
- (void)click {
    
}

@end
