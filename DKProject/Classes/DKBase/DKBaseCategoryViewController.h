//
//  DKBaseCategoryViewController.h
//  GardenManager
//
//  Created by 王 on 2019/7/24.
//  Copyright © 2019 wisezone. All rights reserved.
//

#import "DKBaseViewController.h"

@protocol JXCategoryViewDelegate;
@protocol JXCategoryListContainerViewDelegate;
@class JXCategoryBaseView;
@class JXCategoryListContainerView;

NS_ASSUME_NONNULL_BEGIN

@protocol DKBaseCategoryViewControllerDelegate <NSObject>

@optional
///默认是 NO 
- (BOOL)dk_isKindOfClass;

@end

@interface DKBaseCategoryViewController : DKBaseViewController<DKBaseCategoryViewControllerDelegate, JXCategoryViewDelegate, JXCategoryListContainerViewDelegate>

@property (nonatomic, strong) NSArray *titles;

@property (nonatomic, strong) JXCategoryBaseView *categoryView;

@property (nonatomic, strong) JXCategoryListContainerView *listContainerView;
///修改初始化的时候默认选择的index
@property (nonatomic, assign) NSInteger defaultSelectedIndex;

- (JXCategoryBaseView *)preferredCategoryView;

- (CGFloat)preferredCategoryViewHeight;

@end

NS_ASSUME_NONNULL_END
