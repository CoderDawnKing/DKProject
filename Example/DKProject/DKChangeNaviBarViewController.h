//
//  DKChangeNaviBarViewController.h
//  DKProject_Example
//
//  Created by DawnKing on 2020/7/15.
//  Copyright © 2020 wangshaoyu. All rights reserved.
//

#import <DKProject/DKProject.h>

NS_ASSUME_NONNULL_BEGIN

@interface DKChangeNaviBarViewController : DKBaseViewController

@property(nonatomic, assign) DKNavigationBarStyle previousBarStyle;
@property(nonatomic, assign) BOOL customNavBarTransition;
- (instancetype)initWithBarStyle:(DKNavigationBarStyle)barStyle;

@end

NS_ASSUME_NONNULL_END
