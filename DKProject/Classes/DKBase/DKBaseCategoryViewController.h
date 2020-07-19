//
//  DKBaseCategoryViewController.h
//  GardenManager
//
//  Created by 王 on 2019/7/24.
//  Copyright © 2019 wisezone. All rights reserved.
//

#import "DKBaseViewController.h"
#import "DKBaseCategoryDelegate.h"

NS_ASSUME_NONNULL_BEGIN

@interface DKBaseCategoryViewController : DKBaseViewController<DKBaseCategoryDelegate, JXCategoryViewDelegate, JXCategoryListContainerViewDelegate>

@property (nonatomic, strong) NSArray *titles;

@property (nonatomic, strong) JXCategoryBaseView *categoryView;

@property (nonatomic, strong) JXCategoryListContainerView *listContainerView;
///修改初始化的时候默认选择的index
@property (nonatomic, assign) NSInteger defaultSelectedIndex;

@end

NS_ASSUME_NONNULL_END
