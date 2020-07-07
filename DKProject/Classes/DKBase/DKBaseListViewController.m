//
//  DKBaseListViewController.m
//  GardenManager
//
//  Created by 王 on 2019/11/8.
//  Copyright © 2019 wisezone. All rights reserved.
//

#import "DKBaseListViewController.h"
#import <JXCategoryView/JXCategoryListContainerView.h>
#import <DKProject/DKProject.h>

@interface DKBaseListViewController ()

@end

@implementation DKBaseListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

#pragma mark - JXCategoryListContentViewDelegate

- (UIView *)listView {
    return self.view;
}

@end
