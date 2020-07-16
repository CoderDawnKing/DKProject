//
//  BaseViewController.h
//  GardenManager
//
//  Created by 王 on 2019/6/17.
//  Copyright © 2019 wisezone. All rights reserved.
//

#import <QMUIKit/QMUIKit.h>
#import "DKBaseNavigationController.h"

@protocol DKBaseViewModelProtocol;
@class DKBaseModel;
@class DKBaseTableView;

NS_ASSUME_NONNULL_BEGIN


@protocol DKBaseViewControllerProtocol <NSObject>

- (instancetype)initWithModel:(DKBaseModel *)model;
- (instancetype)initWithViewModel:(id <DKBaseViewModelProtocol>)viewModel;

- (void)__addSubViews;

- (void)__addViewModel;

- (void)__makeConstraints;
/** 更新约束 */
- (void)__updateConstraints;

@end

@protocol DKBaseViewControllerDelegate <NSObject>

/// 拦截返回方法 包括手势返回和按钮返回
/// 当导航栏设置了自定义返回按钮并调用 pop 方法时,需要用该代理方法拦截返回按钮点击事件
/// shouldPopViewControllerByBackButtonOrPopGesture 将拦截不到返回按钮事件
- (BOOL)dk_popViewController;

@end

@interface DKBaseViewController : QMUICommonViewController<DKBaseViewControllerProtocol, DKBaseViewControllerDelegate>

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

/** TableView */
@property (nonatomic, strong, nullable) DKBaseTableView *tableView;
/** 数据源 */
@property (nonatomic, strong) NSMutableArray *datasArrM;

@end

NS_ASSUME_NONNULL_END
