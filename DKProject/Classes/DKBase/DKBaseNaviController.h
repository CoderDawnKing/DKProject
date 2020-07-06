//
//  DKBaseNaviController.h
//  GardenManager
//
//  Created by 王 on 2019/6/19.
//  Copyright © 2019 wisezone. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol DKBaseNaviControllerDelegate <NSObject>
@optional
///return NO 不执行返回
- (BOOL)dk_popViewController;
@end

@interface DKBaseNaviController : UINavigationController

///隐藏底部线条
@property (nonatomic, assign, getter=isHiddenShadowImage) BOOL hiddenShadowImage;
///导航栏透明
@property (nonatomic, assign, getter=isTransparent) BOOL transparent;
///大标题
@property (nonatomic, strong) NSString *leftBarTitle;
@property (nonatomic, weak) id<DKBaseNaviControllerDelegate> dk_delegate;
///导航栏透明度
@property (nonatomic, assign) CGFloat dk_navAlpha;
///导航栏背景色
@property (nonatomic, strong) UIColor *backgroundColor;
///导航栏背景图片
@property (nonatomic, strong) UIImage *backgroundImage;

@end

NS_ASSUME_NONNULL_END
