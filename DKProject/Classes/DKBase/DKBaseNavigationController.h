//
//  DKBaseNavigationController.h
//  AFNetworking
//
//  Created by DawnKing on 2020/7/14.
//

#import <QMUIKit/QMUIKit.h>

NS_ASSUME_NONNULL_BEGIN


@protocol DKBaseNavigationControllerDelegate <NSObject>
@optional
///return NO 不执行返回
- (BOOL)dk_leftBarButtonItemPopViewController;
@end

@interface DKBaseNavigationController : QMUINavigationController

@property (nonatomic, weak) id<DKBaseNavigationControllerDelegate> dk_delegate;
///隐藏底部线条
@property (nonatomic, assign, getter=isHiddenShadowImage) BOOL hiddenShadowImage;
///导航栏透明
@property (nonatomic, assign, getter=isTransparent) BOOL transparent;
///大标题
@property (nonatomic, strong) NSString *leftBarTitle;
///导航栏透明度
@property (nonatomic, assign) CGFloat dk_navAlpha;
///导航栏背景色
@property (nonatomic, strong) UIColor *backgroundColor;
///导航栏背景图片
@property (nonatomic, strong) UIImage *backgroundImage;

@end

NS_ASSUME_NONNULL_END
