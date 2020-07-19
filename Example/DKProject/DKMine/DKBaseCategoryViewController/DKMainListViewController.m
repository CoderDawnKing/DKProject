//
//  DKMainListViewController.m
//  DKProject_Example
//
//  Created by DawnKing on 2020/7/15.
//  Copyright © 2020 wangshaoyu. All rights reserved.
//

#import "DKMainListViewController.h"
#import "DKMainCategoryViewController.h"

@interface DKMainListViewController ()

@end

@implementation DKMainListViewController

- (void)initDataSource {
    [super initDataSource];
    NSMutableArray *arrayM = [NSMutableArray array];
    for (int i = 0; i < 30; i ++) {
        [arrayM addObject:[NSString stringWithFormat:@"%d", i]];
    }
    self.dataSource = arrayM.mutableCopy;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if ([self.scrollDelegate respondsToSelector:@selector(dk_scrollViewDidScroll:)]) {
        [self.scrollDelegate dk_scrollViewDidScroll:scrollView];
    }
}


@end
