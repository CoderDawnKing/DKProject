//
//  QDChangeNavBarStyleViewController.h
//  qmuidemo
//
//  Created by QMUI Team on 16/9/5.
//  Copyright © 2016年 QMUI Team. All rights reserved.
//

#import "DKBaseListViewController.h"

@interface QDChangeNavBarStyleViewController : DKBaseListViewController

@property(nonatomic, assign) DKNavigationBarStyle previousBarStyle;
- (instancetype)initWithBarStyle:(DKNavigationBarStyle)barStyle;

@end
