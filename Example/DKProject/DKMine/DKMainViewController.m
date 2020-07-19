//
//  DKMainViewController.m
//  DKProject
//
//  Created by DawnKing on 2020/7/18.
//  Copyright © 2020 Dawn King. All rights reserved.
//

#import "DKMainViewController.h"

@interface DKMainViewController ()

@end

@implementation DKMainViewController

- (void)didInitialize {
    [super didInitialize];
    // init 时做的事情请写在这里
    NSArray *array = @[UIColorGray, UIColorRed, UIColorBlue];
    NSInteger num = arc4random()%3;
    self.dk_navigationBarBackgroundColor = array[num];
}

- (void)initSubviews {
    [super initSubviews];
    // 对 subviews 的初始化写在这里
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // 对 self.view 的操作写在这里
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
}

- (void)setupNavigationItems {
    [super setupNavigationItems];
    self.title = [NSString qmui_stringWithNSInteger:arc4random()%1000];
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem qmui_itemWithTitle:@"next" target:self action:@selector(next)];
}

- (void)next {
    DKMainViewController *viewcontroller = [[DKMainViewController alloc] init];
    [self.navigationController pushViewController:viewcontroller animated:YES];
}

@end
