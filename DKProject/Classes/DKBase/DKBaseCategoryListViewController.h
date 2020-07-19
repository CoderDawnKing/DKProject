//
//  DKBaseCategoryListViewController.h
//  GardenManager
//
//  Created by 王 on 2019/11/8.
//  Copyright © 2019 wisezone. All rights reserved.
//

#import "DKBaseListViewController.h"
#import "DKBaseCategoryDelegate.h"

NS_ASSUME_NONNULL_BEGIN

@interface DKBaseCategoryListViewController : DKBaseListViewController<JXCategoryListContentViewDelegate>

/// 推荐使用该初始化方式 不然无法通过代理方法适配 tableView 的 inset
- (instancetype)initWithDelegate:(id<DKBaseCategoryListDelegate>)delegate;

@end

NS_ASSUME_NONNULL_END
