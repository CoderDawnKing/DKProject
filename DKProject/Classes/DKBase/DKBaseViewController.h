//
//  BaseViewController.h
//  GardenManager
//
//  Created by 王 on 2019/6/17.
//  Copyright © 2019 wisezone. All rights reserved.
//

#import <QMUIKit/QMUICommonViewController.h>

@protocol DKBaseViewModelProtocol;
@class DKBaseModel;
@class DKBaseNavigationController;
@class DKBaseTableView;

NS_ASSUME_NONNULL_BEGIN


typedef enum : NSUInteger {
    /// 顶部
    DKTableViewScrollTypeTop,
    /// 底部
    DKTableViewScrollTypeBottom
} DKTableViewScrollType;


typedef NS_ENUM(NSInteger, DKNavigationBarStyle) {
    DKNavigationBarStyleOrigin,
    DKNavigationBarStyleLight,
    DKNavigationBarStyleDark
};

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
/// 导航栏底部投影图片
@property (nonatomic, strong, nullable) UIImage *dk_navigationBarShadowImage;
/// 导航栏颜色
@property (nonatomic, strong, nullable) UIColor *dk_navigationBarTintColor;
/// 导航栏标题颜色
@property (nonatomic, strong, nullable) UIColor *dk_titleViewTintColor;
/// 隐藏底部线条
@property (nonatomic, assign, getter=isHiddenShadowImage) BOOL hiddenShadowImage;
/// 隐藏导航栏
@property (nonatomic, assign, getter=isHiddenNavigationBar) BOOL hiddenNavigationBar;


/** TableView */
@property (nonatomic, strong, nullable) DKBaseTableView *tableView;
/** 数据源 */
@property (nonatomic, strong) NSMutableArray *datasArrM;

///展示大标题
@property (nonatomic, assign, getter=isShowBigTitle) BOOL showBigTitle;

@end

NS_ASSUME_NONNULL_END
