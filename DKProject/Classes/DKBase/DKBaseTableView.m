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

- (instancetype)init {
    if (self = [super init]) {
        
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    if (self = [super initWithFrame:frame style:style]) {
        if (@available(iOS 11.0, *)) {
            self.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        } else {
            // Fallback on earlier versions
        }
        self.estimatedRowHeight = 0;
        self.estimatedSectionFooterHeight = 0;
        self.estimatedSectionHeaderHeight = 0;
        self.contentInset = UIEdgeInsetsMake(0, 0, dk_BottomSafeHeight, 0);
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
        self.backgroundColor = dk_HexColor(DK_COLOR_TABLEVIEW_BACKGROUND);
        self.dk_emptyView = [[DKBaseEmptyView alloc] init];
        self.autoHideMjFooter = YES;
        self.autoShowEmpty = YES;
    }
    return self;
}

- (instancetype)initWithViewModel:(id<DKBaseTableViewProtocol>)viewModel style:(UITableViewStyle)style {
    if (self = [super initWithFrame:CGRectZero style:style]) {
        [self __addSubViews];
        [self __makeConstraints];
        [self __addViewModel];
        self.backgroundColor = dk_HexColor(DK_COLOR_TABLEVIEW_BACKGROUND);
    }
    return self;
}

- (void)__addSubViews {
}

- (void)__addViewModel {
}

- (void)__makeConstraints {
}
/** 更新约束 */
- (void)__updateConstraints {}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [super touchesBegan:touches withEvent:event];
    if (self.tableViewTouchsBeginBlock) {
        self.tableViewTouchsBeginBlock(touches, event);
    }
}

@end
