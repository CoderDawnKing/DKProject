//
//  DKBaseCategoryDelegate.h
//  AFNetworking
//
//  Created by DawnKing on 2020/7/18.
//

#import <Foundation/Foundation.h>
#import <JXCategoryView/JXCategoryView.h>

NS_ASSUME_NONNULL_BEGIN

@protocol DKBaseCategoryDelegate <NSObject>

@optional
/// 默认 JXCategoryBaseView
- (JXCategoryBaseView *)preferredCategoryView;
/// 高度
- (CGFloat)preferredCategoryViewHeight;
/// y 值从控制器顶部开始
- (CGFloat)preferredCategoryViewTop;
///默认是 NO
- (BOOL)dk_isKindOfClass;

@end

@protocol DKBaseCategoryListDelegate <NSObject>

@optional
- (UIEdgeInsets)preferredCategoryViewContentInset;

@end

NS_ASSUME_NONNULL_END
