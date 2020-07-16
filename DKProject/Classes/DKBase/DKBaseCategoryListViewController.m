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

@end

@implementation DKBaseCategoryListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

#pragma mark - JXCategoryListContentViewDelegate

- (UIView *)listView {
    return self.view;
}

@end
