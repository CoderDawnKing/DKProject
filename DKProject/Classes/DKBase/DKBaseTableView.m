//
//  DKBaseTableView.m
//  GardenManager
//
//  Created by 王 on 2019/6/19.
//  Copyright © 2019 wisezone. All rights reserved.
//

#import "DKBaseTableView.h"
#import <DKProject/DKProject.h>

#define dk_ash_action_img 

@implementation DKBaseTableView

- (void)didInitialize {
    [self __addSubViews];
    [self __makeConstraints];
    [self __addViewModel];
    self.backgroundColor = dk_HexColor(DK_COLOR_TABLEVIEW_BACKGROUND);
}

- (void)__addSubViews {}

- (void)__addViewModel {}

- (void)__makeConstraints {}
/** 更新约束 */
- (void)__updateConstraints {}

@end
