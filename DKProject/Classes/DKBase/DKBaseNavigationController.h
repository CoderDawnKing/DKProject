//
//  DKBaseNavigationController.h
//  AFNetworking
//
//  Created by DawnKing on 2020/7/14.
//

#import <QMUIKit/QMUIKit.h>

NS_ASSUME_NONNULL_BEGIN

/// 导航栏样式
typedef NS_ENUM(NSInteger, DKNavigationBarStyle) {
    DKNavigationBarStyleOrigin,
    DKNavigationBarStyleLight,
    DKNavigationBarStyleDark,
    DKNavigationBarStyleCustom
};

@protocol DKBaseNavigationControllerDelegate <NSObject>
@optional
/// 当导航栏设置了自定义返回按钮并调用 pop 方法时,需要用该代理方法拦截返回按钮点击事件
/// YES 正常返回  NO 不执行返回
- (BOOL)dk_leftBarButtonItemPopViewController;
@end

@interface DKBaseNavigationController : QMUINavigationController

@property (nonatomic, weak) id<DKBaseNavigationControllerDelegate> dk_delegate;

@end

NS_ASSUME_NONNULL_END
