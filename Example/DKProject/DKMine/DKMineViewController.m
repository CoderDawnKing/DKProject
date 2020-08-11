//
//  DKMineViewController.m
//  DKProject
//
//  Created by DawnKing on 2020/7/18.
//  Copyright © 2020 wangshaoyu. All rights reserved.
//

#import "DKMineViewController.h"
#import "QDAboutViewController.h"
#import "DKMainCategoryViewController.h"
#import "DKMainViewController.h"
#import "DKMainTableViewController.h"

@interface DKMineViewController ()

@end

@implementation DKMineViewController

- (void)initDataSource {
    self.dataSource = [[QMUIOrderedDictionary alloc] initWithKeysAndObjects:
                       @"DKBaseCategoryViewController", UIImageMake(@"icon_mine_category"),
                       @"DKBaseViewController", UIImageMake(@"icon_mine_category"),
                       @"DKBaseTableViewController", UIImageMake(@"icon_mine_category"),
                       nil];
}

- (void)setupNavigationItems {
    [super setupNavigationItems];
    self.title = @"DKMine";
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem qmui_itemWithImage:UIImageMake(@"icon_nav_about") target:self action:@selector(handleAboutItemEvent)];
    AddAccessibilityLabel(self.navigationItem.rightBarButtonItem, @"打开关于界面");
}

- (void)didSelectCellWithTitle:(NSString *)title {
    UIViewController *viewController = nil;
    if ([title isEqualToString:@"DKBaseCategoryViewController"]) {
        viewController = [[DKMainCategoryViewController alloc] init];
        ((DKMainCategoryViewController *)viewController).defaultSelectedIndex = 0;
    } else if ([title isEqualToString:@"DKBaseViewController"]) {
        viewController = [[DKMainViewController alloc] init];
    } else if ([title isEqualToString:@"DKBaseTableViewController"]) {
           viewController = [[DKMainTableViewController alloc] init];
    }
    viewController.title = title;
    [self.navigationController pushViewController:viewController animated:YES];
}

- (void)handleAboutItemEvent {
    QDAboutViewController *viewController = [[QDAboutViewController alloc] init];
    [self.navigationController pushViewController:viewController animated:YES];
}

@end
