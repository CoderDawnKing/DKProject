//
//  UIScrollView+DKCategory.h
//  GardenManager
//
//  Created by 王 on 2019/7/10.
//  Copyright © 2019 wisezone. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void (^DKRefreshComponentAction)(void);

@interface UIScrollView (DKCategory)

/** 添加头部刷新 */
- (void)addHeaderRefresh:(DKRefreshComponentAction)refreshBlock;
/** 开始头部刷新 */
- (void)beginHeaderRefresh;
/** 结束头部刷新 */
- (void)endHeaderRefresh;
/** 添加脚部刷新 */
- (void)addFooterRefresh:(DKRefreshComponentAction)refreshBlock;
/** 开始脚部刷新 */
- (void)beginFooterRefresh;
/** 结束脚部刷新 */
- (void)endFooterRefresh;
- (void)endFooterRefreshWithNoMoreData;
- (void)resetNoMoreData;
/** 隐藏脚部 */
- (void)setHiddenFooter:(BOOL)hiddenFooter;


@end




NS_ASSUME_NONNULL_END
