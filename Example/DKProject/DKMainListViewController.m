//
//  DKMainListViewController.m
//  DKProject_Example
//
//  Created by DawnKing on 2020/7/15.
//  Copyright © 2020 wangshaoyu. All rights reserved.
//

#import "DKMainListViewController.h"
#import "DKMainCategoryViewController.h"

@interface DKMainListViewController ()<UITableViewDelegate, UITableViewDataSource>

@end

@implementation DKMainListViewController

@synthesize tableView = _tableView;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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
    return 100;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *ident = @"DKBaseTableViewCell";
    DKBaseTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ident];
    if (!cell) {
        cell = [DKBaseTableViewCell cellWithType:DKBaseTableViewCellTypeDefault ident:ident hasArrow:YES];
        cell.cellBackgroundColor = dk_ClearColor;
    }
    cell.title.text = [NSString stringWithFormat:@"%ld", (long)indexPath.row];
    return cell;
}

#pragma UITableView Delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    DKMainCategoryViewController *secondViewController = [[DKMainCategoryViewController alloc] init];
    secondViewController.defaultSelectedIndex = indexPath.row > 10 ? 10 : indexPath.row;
    [self.navigationController pushViewController:secondViewController animated:YES];
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

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if ([self.delegate respondsToSelector:@selector(dk_scrollViewDidScroll:)]) {
        [self.delegate dk_scrollViewDidScroll:scrollView];
    }
}

#pragma - mark lazy
- (DKBaseTableView *)tableView {
    if (!_tableView) {
        _tableView = [[DKBaseTableView alloc] initWithFrame:CGRectMake(0, 0, 0, 0) style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = dk_ClearColor;
    }
    return _tableView;
}

@end
