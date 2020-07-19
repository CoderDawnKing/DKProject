//
//  DKBaseCategoryListViewController.m
//  GardenManager
//
//  Created by 王 on 2019/11/8.
//  Copyright © 2019 wisezone. All rights reserved.
//

#import "DKBaseCategoryListViewController.h"
#import <JXCategoryView/JXCategoryListContainerView.h>
#import <DKProject/DKProject.h>

@interface DKBaseCategoryListViewController ()

@property (nonatomic, weak) id<DKBaseCategoryListDelegate> dk_delegate;
@end

@implementation DKBaseCategoryListViewController

- (instancetype)initWithDelegate:(id<DKBaseCategoryListDelegate>)delegate {
    if (self = [super init]) {
        self.dk_delegate = delegate;
    }
    return self;
}

- (void)initTableView {
    [super initTableView];
    /// 修改 tableView 的 inset 因为不是从导航栏下放开始算的  所以顶部不用留距离 但是底部需要重新算上距离
    self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    if ([self.dk_delegate respondsToSelector:@selector(preferredCategoryViewContentInset)]) {
        self.tableView.contentInset = [self.dk_delegate preferredCategoryViewContentInset];
    } else {
        self.tableView.contentInset = UIEdgeInsetsMake(0, 0, dk_NavBarAndStatusBarHeight + dk_BottomSafeHeight, 0);
    }
}

#pragma mark - JXCategoryListContentViewDelegate

- (UIView *)listView {
    return self.view;
}

@end
