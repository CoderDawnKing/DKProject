//
//  DKBaseNavigationController.h
//  AFNetworking
//
//  Created by DawnKing on 2020/7/14.
//

#import <QMUIKit/QMUIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, DKNavigationBarStyle) {
    DKNavigationBarStyleOrigin,
    DKNavigationBarStyleLight,
    DKNavigationBarStyleDark
};

@protocol DKBaseNavigationControllerDelegate <NSObject>
@optional
///return NO 不执行返回
- (BOOL)dk_leftBarButtonItemPopViewController;
@end

@interface DKBaseNavigationController : QMUINavigationController

@property (nonatomic, weak) id<DKBaseNavigationControllerDelegate> dk_delegate;

@end

NS_ASSUME_NONNULL_END
