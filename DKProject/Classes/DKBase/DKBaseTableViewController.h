//
//  DKBaseTableViewController.h
//  GardenManager
//
//  Created by 王 on 2019/7/13.
//  Copyright © 2019 wisezone. All rights reserved.
//

#import <QMUIKit/QMUIKit.h>
#import "DKBaseNavigationController.h"

@class DKBaseTableViewCell;
@class DKBaseModel;
@protocol DKBaseViewModelProtocol;

NS_ASSUME_NONNULL_BEGIN

@protocol DKBaseTableViewControllerProtocol <NSObject>

- (instancetype)initWithModel:(DKBaseModel *)model;
- (instancetype)initWithViewModel:(id <DKBaseViewModelProtocol>)viewModel;

- (void)__addSubViews;

- (void)__addViewModel;

- (void)__makeConstraints;
/** 更新约束 */
- (void)__updateConstraints;

@end

@protocol DKBaseTableViewControllerDelegate <NSObject>

/// 拦截返回方法 包括手势返回和按钮返回
- (BOOL)dk_popViewController;

@end

@interface DKBaseTableViewController : QMUICommonTableViewController<DKBaseTableViewControllerProtocol, DKBaseTableViewControllerDelegate>

/// 默认导航栏
@property (nonatomic, strong, nullable) DKBaseNavigationController *dk_Navi;
/// 返回手势
@property (nonatomic, assign, getter=isRecognizerEnable) BOOL recognizerEnable;
/// 导航栏样式 优先级最低
@property(nonatomic, assign) DKNavigationBarStyle dk_barStyle;
/// 导航栏背景图片
@property (nonatomic, strong, nullable) UIImage *dk_navigationBarBackgroundImage;
/// 导航栏背景颜色
@property (nonatomic, strong, nullable) UIColor *dk_navigationBarBackgroundColor;
/// 导航栏底部投影图片
@property (nonatomic, strong, nullable) UIImage *dk_navigationBarShadowImage;
/// 导航栏颜色
@property (nonatomic, strong, nullable) UIColor *dk_navigationBarTintColor;
/// 导航栏标题颜色
@property (nonatomic, strong, nullable) UIColor *dk_titleViewTintColor;
/// 导航栏透明度
@property (nonatomic, assign) CGFloat dk_navigationBarAlpha;
/// 隐藏底部线条
@property (nonatomic, assign, getter=isHiddenShadowImage) BOOL hiddenShadowImage;
/// 隐藏导航栏
@property (nonatomic, assign, getter=isHiddenNavigationBar) BOOL hiddenNavigationBar;

@end

NS_ASSUME_NONNULL_END
