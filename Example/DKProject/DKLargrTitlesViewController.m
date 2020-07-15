//
//  DKLargrTitlesViewController.m
//  DKProject_Example
//
//  Created by DawnKing on 2020/7/15.
//  Copyright © 2020 wangshaoyu. All rights reserved.
//

#import "DKLargrTitlesViewController.h"

@interface DKLargrTitlesViewController ()
//<UITableViewDelegate, UITableViewDataSource>

@end

@implementation DKLargrTitlesViewController

//@synthesize tableView = _tableView;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

//- (void)__addSubViews {
//    [self.view addSubview:self.tableView];
//}
//
//- (void)__makeConstraints {
//    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.edges.mas_equalTo(0);
//    }];
//}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    // 上个界面如果不是 QDLargeTitlesViewController 就还原 prefersLargeTitles，以免影响其他界面
    if (@available(iOS 11.0, *)) {
        UIViewController *currentViewController = UIApplication.sharedApplication.keyWindow.rootViewController.qmui_visibleViewControllerIfExist;
        if ([currentViewController class] != [DKLargrTitlesViewController class]) {
            currentViewController.navigationController.navigationBar.prefersLargeTitles = NO;
        }
    }
}

- (void)setupNavigationItems {
    [super setupNavigationItems];
    self.title = @"LargeTitle";
    if (@available(iOS 11.0, *)) {
        self.navigationController.navigationBar.prefersLargeTitles = YES;
    }
}

//#pragma UITableView DataSource
//
//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//    return 1;
//}
//
//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//    return 4;
//}
//
//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
//    NSString *ident = @"DKBaseTableViewCell";
//    DKBaseTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ident];
//    if (!cell) {
//        cell = [DKBaseTableViewCell cellWithType:DKBaseTableViewCellTypeValue1 ident:ident];
//    }
//    return cell;
//}
//
//#pragma UITableView Delegate
//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
//    [tableView deselectRowAtIndexPath:indexPath animated:YES];
//}
//
//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
//    return 60;
//}
//
//- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
//    return 40;
//}
//
//- (DKBaseTableView *)tableView {
//    if (!_tableView) {
//        _tableView = [[DKBaseTableView alloc] initWithFrame:CGRectMake(0, 0, 0, 0) style:UITableViewStyleGrouped];
//        _tableView.delegate = self;
//        _tableView.dataSource = self;
//        _tableView.tableFooterView = [UIView new];
//    }
//    return _tableView;
//}

@end
