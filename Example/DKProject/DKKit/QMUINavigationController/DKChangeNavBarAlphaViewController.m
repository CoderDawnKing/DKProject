//
//  DKChangeNavBarAlphaViewController.m
//  DKProject_Example
//
//  Created by DawnKing on 2020/7/17.
//  Copyright © 2020 wangshaoyu. All rights reserved.
//

#import "DKChangeNavBarAlphaViewController.h"

@interface DKChangeNavBarAlphaViewController ()

@end

@implementation DKChangeNavBarAlphaViewController

- (void)initDataSource {
    [super initDataSource];
    self.dataSource = @[@"滑动 tableView 改变导航栏透明度", @"滑动 tableView 改变导航栏透明度", @"滑动 tableView 改变导航栏透明度", @"滑动 tableView 改变导航栏透明度", @"滑动 tableView 改变导航栏透明度", @"滑动 tableView 改变导航栏透明度", @"滑动 tableView 改变导航栏透明度", @"滑动 tableView 改变导航栏透明度", @"滑动 tableView 改变导航栏透明度", @"滑动 tableView 改变导航栏透明度", @"滑动 tableView 改变导航栏透明度", @"滑动 tableView 改变导航栏透明度", @"滑动 tableView 改变导航栏透明度", @"滑动 tableView 改变导航栏透明度", @"滑动 tableView 改变导航栏透明度", @"滑动 tableView 改变导航栏透明度", @"滑动 tableView 改变导航栏透明度", @"滑动 tableView 改变导航栏透明度", @"滑动 tableView 改变导航栏透明度", @"滑动 tableView 改变导航栏透明度", @"滑动 tableView 改变导航栏透明度", @"滑动 tableView 改变导航栏透明度", @"滑动 tableView 改变导航栏透明度", @"滑动 tableView 改变导航栏透明度", @"滑动 tableView 改变导航栏透明度", @"滑动 tableView 改变导航栏透明度", @"滑动 tableView 改变导航栏透明度", @"滑动 tableView 改变导航栏透明度", @"滑动 tableView 改变导航栏透明度", @"滑动 tableView 改变导航栏透明度", @"滑动 tableView 改变导航栏透明度", @"滑动 tableView 改变导航栏透明度", @"滑动 tableView 改变导航栏透明度", @"滑动 tableView 改变导航栏透明度", @"滑动 tableView 改变导航栏透明度", @"滑动 tableView 改变导航栏透明度", @"滑动 tableView 改变导航栏透明度", @"滑动 tableView 改变导航栏透明度", @"滑动 tableView 改变导航栏透明度", @"滑动 tableView 改变导航栏透明度"];
}

- (void)didSelectCellWithTitle:(NSString *)title {
    DKChangeNavBarAlphaViewController *viewController = [[DKChangeNavBarAlphaViewController alloc] init];
    viewController.title = title;
    [self.navigationController pushViewController:viewController animated:YES];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat alpha = scrollView.contentOffset.y;
    if (dk_IS_IPHONE_X) {
        alpha += dk_NavBarAndStatusBarHeight;
    }
    
    if (alpha < 0) {
        alpha = 0;
    }
    if (alpha > 100) {
        alpha = 100;
    }
    self.dk_navigationBarAlpha = (100 - alpha) / 100.0;
}

@end
