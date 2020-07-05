//
//  UIScrollView+DKCategory.m
//  GardenManager
//
//  Created by 王 on 2019/7/10.
//  Copyright © 2019 wisezone. All rights reserved.
//

#import "UIScrollView+DKCategory.h"
#import <objc/runtime.h>
#import <MJRefresh/MJRefresh.h>
#import <DKProject/DKColorConfigure.h>
@implementation UIScrollView (DKCategory)

/** 添加头部刷新 */
- (void)addHeaderRefresh:(DKRefreshComponentAction)refreshBlock{
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingBlock:refreshBlock];
    header.stateLabel.font = [UIFont systemFontOfSize:14];
    header.stateLabel.textColor = dk_HexColor(COLOR_888888);
    header.lastUpdatedTimeLabel.hidden = YES;
    self.mj_header = header;
}
/** 开始头部刷新 */
- (void)beginHeaderRefresh{
    [self.mj_header beginRefreshing];
}
/** 结束头部刷新 */
- (void)endHeaderRefresh{
    [self.mj_header endRefreshing];
}
/** 添加脚部刷新 */
- (void)addFooterRefresh:(DKRefreshComponentAction)refreshBlock{
    MJRefreshAutoNormalFooter *footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:refreshBlock];
    footer.stateLabel.font = [UIFont systemFontOfSize:14];
    footer.stateLabel.textColor = dk_HexColor(COLOR_888888);
    self.mj_footer = footer;
}
/** 开始脚部刷新 */
- (void)beginFooterRefresh{
    [self.mj_footer beginRefreshing];
}
/** 结束脚部刷新 */
- (void)endFooterRefresh{
    [self.mj_footer endRefreshing];
}
- (void)endFooterRefreshWithNoMoreData{
    [self.mj_footer endRefreshingWithNoMoreData];
}
- (void)resetNoMoreData{
    [self.mj_footer resetNoMoreData];
}
/** 隐藏脚部 */
- (void)setHiddenFooter:(BOOL)hiddenFooter{
    self.mj_footer.hidden = hiddenFooter;
}

@end

