//
//  DKBaseNaviController.m
//  GardenManager
//
//  Created by 王 on 2019/6/19.
//  Copyright © 2019 wisezone. All rights reserved.
//

#import "DKBaseNaviController.h"
#import <DKProject/DKProject.h>

@interface DKBaseNaviController ()<UINavigationControllerDelegate, UIGestureRecognizerDelegate>
{
    CGPoint startPoint;
    
    UIImageView *lastScreenShotView;// view
}

//@property (nonatomic, strong) id popDelegate;

@property (nonatomic, strong) UIView *backGroundView;

@property (nonatomic, strong) NSMutableArray *screenShotList;

@property (nonatomic, assign) BOOL isMoving;

@end

static CGFloat offset_float = 0.65;// 拉伸参数
static CGFloat min_distance = 100;// 最小回弹距离

@implementation DKBaseNaviController

@synthesize backgroundColor = _backgroundColor;

- (NSMutableArray *)screenShotList {
    if (!_screenShotList) {
        _screenShotList = [NSMutableArray array];
    }
    return _screenShotList;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    self.popDelegate = self.interactivePopGestureRecognizer.delegate;
//    self.delegate = self;
    //设置导航栏 title 的字体样式
    [self.navigationBar setTitleTextAttributes:@{
                                                 NSFontAttributeName:[UIFont pfMediumWithSize:18],
                                                 NSForegroundColorAttributeName:dk_HexColor(COLOR_333333),
                                                 }];
    if (@available(iOS 11.0, *)) {
        NSMutableParagraphStyle *style = [[NSMutableParagraphStyle defaultParagraphStyle] mutableCopy];
        //首行缩进
        style.firstLineHeadIndent = 0;
        [self.navigationBar setLargeTitleTextAttributes:@{
                                                          NSFontAttributeName:[UIFont pfMediumWithSize:20],
                                                          NSForegroundColorAttributeName:dk_HexColor(COLOR_333333),
                                                          NSParagraphStyleAttributeName:style
                                                          }];
    } else {
        // Fallback on earlier versions
    }
    //设置导航栏按钮间距
    [UINavigationConfig shared].dk_defaultFixSpace = dk_defaultSpace;
    self.view.backgroundColor = dk_HexColor(COLOR_WHITE);
    self.view.superview.backgroundColor = dk_HexColor(COLOR_WHITE);
    self.navigationBar.barTintColor = dk_HexColor(COLOR_WHITE);
    [self.navigationBar setShadowImage:[UIImage imageWithColor:dk_HexColor(COLOR_LINE) size:CGSizeMake(dk_ScreenWidth, 1)]];
    self.extendedLayoutIncludesOpaqueBars = YES;
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    //打印字体名称
//    for (NSString *fontFamilyName in UIFont.familyNames) {
//        DKLog(@"familyName:%@", fontFamilyName);
//        for (NSString *fontName in [UIFont fontNamesForFamilyName:fontFamilyName]) {
//            DKLog(@"fontName:%@", fontName);
//        }
//    }
}

#pragma mark - UINavigationControllerDelegate
// 将要显示控制器
- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    // 判断要隐藏导航栏的控制器
//    BOOL isHideNav = ([viewController isKindOfClass:[PostingViewController class]]);
    BOOL isHideNav = NO;
    [self setNavigationBarHidden:self.isNavigationBarHidden?:isHideNav animated:YES];
}

//导航控制器跳转完成的时候调用
- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
//    if (viewController == self.viewControllers[0]) {
        //显示根控制器
        //还原滑动返回手势的代理
//        self.interactivePopGestureRecognizer.delegate = self.popDelegate;
        
//    } else {
        //实现滑动返回功能
        //清空滑动返回手势的代理，就能实现滑动返回
//        self.interactivePopGestureRecognizer.delegate = nil;
//    }
}


- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    if (self.childViewControllers.count > 0) { // 如果push进来的不是第一个控制器
        UIBarButtonItem *leftBarButtonItem = [UIBarButtonItem barButtonBackItemWithTarget:self action:@selector(pop) string:nil];
        viewController.navigationItem.leftBarButtonItem = leftBarButtonItem;
        // 隐藏tabbar
        viewController.hidesBottomBarWhenPushed = YES;
    }
    if (!self.recognizer && ([self.viewControllers count] == 1)) {
        self.recognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(paningGestureReceive:)];
        self.recognizer.delegate = self;
        [self.view addGestureRecognizer:self.recognizer];
    }
    [self.screenShotList addObject:[self capture]];
    
    // 这句super的push要放在后面, 让viewController可以覆盖上面设置的leftBarButtonItem
    [super pushViewController:viewController animated:animated];
}

- (void)pop {
    if ([self.dk_delegate respondsToSelector:@selector(dk_popViewController)]) {
        BOOL isPop = [self.dk_delegate dk_popViewController];
        if (!isPop) return;
    }
    [self popViewControllerAnimated:YES];
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations
{
    if (self.topViewController) {
        return [self.topViewController supportedInterfaceOrientations];
    }
    return UIInterfaceOrientationMaskPortrait;
}

-(UIInterfaceOrientation)preferredInterfaceOrientationForPresentation{
    return UIInterfaceOrientationPortrait;
}

- (NSArray *)popToRootViewControllerAnimated:(BOOL)animated{
    if (self.viewControllers.count  <= 2) {
        if (self.recognizer) {
            [self.view removeGestureRecognizer:self.recognizer];
            self.recognizer = nil;
            self.recognizer.delegate = nil;
        }
    }
    
    return [super popToRootViewControllerAnimated:animated];
}

// override the pop method
- (UIViewController *)popViewControllerAnimated:(BOOL)animated {
    if (animated) {
        if([self.screenShotList count]>0){
            [self.screenShotList removeLastObject];
        }
        if (self.viewControllers.count  <= 2) {
            if (self.recognizer) {
                [self.view removeGestureRecognizer:self.recognizer];
                self.recognizer = nil;
                self.recognizer.delegate = nil;
            }
        }
        
        return [super popViewControllerAnimated:animated];
        
    } else {
        if([self.screenShotList count]>0){
            [self.screenShotList removeLastObject];
        }
        if (self.viewControllers.count  <= 2) {
            if (self.recognizer) {
                [self.view removeGestureRecognizer:self.recognizer];
                self.recognizer = nil;
                self.recognizer.delegate = nil;
            }
        }
        
        return [super popViewControllerAnimated:animated];
    }
}

- (void)popAnimation {

    if (self.viewControllers.count <= 2) {
        if (self.recognizer) {
            [self.view removeGestureRecognizer:self.recognizer];
            self.recognizer = nil;
            self.recognizer.delegate = nil;
        }

    }
    if (!self.backGroundView) {
        CGRect frame = self.view.frame;

        _backGroundView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, frame.size.width , frame.size.height)];

        _backGroundView.backgroundColor = dk_HexColor(COLOR_WHITE);

    }

    [self.view.superview insertSubview:self.backGroundView belowSubview:self.view];

    _backGroundView.hidden = NO;

    if (lastScreenShotView) [lastScreenShotView removeFromSuperview];

    UIImage *lastScreenShot = [self.screenShotList lastObject];

    lastScreenShotView = [[UIImageView alloc] initWithImage:lastScreenShot];

    lastScreenShotView.frame = (CGRect){-(dk_ScreenWidth*offset_float),0,dk_ScreenWidth,dk_ScreenHeight};

    [self.backGroundView addSubview:lastScreenShotView];

    [UIView animateWithDuration:0.25 animations:^{

        [self moveViewWithX:dk_ScreenWidth];

    } completion:^(BOOL finished) {
        [self gestureAnimation:NO];

        CGRect frame = self.view.frame;

        frame.origin.x = 0;

        self.view.frame = frame;

        self.isMoving = NO;

        self.backGroundView.hidden = YES;
    }];
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch{
    CGPoint point = [touch locationInView:self.view];
    if (point.x > 49) {
        return NO;
    }
    return YES;
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldBeRequiredToFailByGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    //手势冲突解决
    return (self.topViewController != [self.viewControllers firstObject]);
}

#pragma mark - Utility Methods -
// get the current view screen shot
- (UIImage *)capture {
    CGSize imageSize = [[UIScreen mainScreen] bounds].size;
    UIGraphicsBeginImageContextWithOptions(imageSize, NO, 0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    
    UIWindow *window = [[UIApplication sharedApplication].delegate window];
    if (![window respondsToSelector:@selector(screen)] || [window screen] == [UIScreen mainScreen]) {
        CGContextSaveGState(context);
        CGContextTranslateCTM(context, [window center].x, [window center].y);
        CGContextConcatCTM(context, [window transform]);
        CGContextTranslateCTM(context, -[window bounds].size.width*[[window layer] anchorPoint].x, -[window bounds].size.height*[[window layer] anchorPoint].y);
        [[window layer] renderInContext:context];
        
        CGContextRestoreGState(context);
    }
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    return image;
}

// set lastScreenShotView 's position when paning
- (void)moveViewWithX:(float)x {
    x = x>dk_ScreenWidth?dk_ScreenWidth:x;
    
    x = x<0?0:x;
    
    CGRect frame = self.view.frame;
    frame.origin.x = x;
    self.view.frame = frame;
    // TODO
    lastScreenShotView.frame = (CGRect){-(dk_ScreenWidth*offset_float)+x*offset_float,0,dk_ScreenWidth,dk_ScreenHeight};
}

- (void)gestureAnimation:(BOOL)animated {
    if([self.screenShotList count]>0){
        [self.screenShotList removeLastObject];
    }
    if (self.viewControllers.count<=2) {
        if (self.recognizer) {
            [self.view removeGestureRecognizer:self.recognizer];
            self.recognizer = nil;
            self.recognizer.delegate = nil;
        }
    }
    if (self.HideNavType == 2) {
        self.navigationBarHidden=NO;
        self.HideNavType = 1;
    }
    if (self.popType == 2) {
        [super popToRootViewControllerAnimated:animated];
        self.popType = 1;
    }else{
        [super popViewControllerAnimated:animated];
    }
    
}

#pragma mark - Gesture Recognizer -
- (void)paningGestureReceive:(UIPanGestureRecognizer *)recoginzer
{
    // If the viewControllers has only one vc or disable the interaction, then return.
    if (self.viewControllers.count <= 1) return;
    
    // we get the touch position by the window's coordinate
    CGPoint touchPoint = [recoginzer locationInView:[UIApplication sharedApplication].keyWindow];
    
    // begin paning, show the backgroundView(last screenshot),if not exist, create it.
    if (recoginzer.state == UIGestureRecognizerStateBegan) {
        
        _isMoving = YES;
        
        startPoint = touchPoint;
        
        if (!self.backGroundView) {
            CGRect frame = self.view.frame;
            
            _backGroundView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, frame.size.width , frame.size.height)];
            
            _backGroundView.backgroundColor = dk_HexColor(COLOR_WHITE);
            
        }
        [self.view.superview insertSubview:self.backGroundView belowSubview:self.view];
        
        _backGroundView.hidden = NO;
        
        if (lastScreenShotView) [lastScreenShotView removeFromSuperview];
        
        UIImage *lastScreenShot = [self.screenShotList lastObject];
        
        lastScreenShotView = [[UIImageView alloc] initWithImage:lastScreenShot];
        
        lastScreenShotView.frame = (CGRect){-(dk_ScreenWidth*offset_float),0,dk_ScreenWidth,dk_ScreenHeight};
        
        [self.backGroundView addSubview:lastScreenShotView];
        
        //End paning, always check that if it should move right or move left automatically
    }else if (recoginzer.state == UIGestureRecognizerStateEnded){
        
        if (touchPoint.x - startPoint.x > min_distance)
        {
            [UIView animateWithDuration:0.25 animations:^{
                
                [self moveViewWithX:dk_ScreenWidth];
                
            } completion:^(BOOL finished) {
                [self gestureAnimation:NO];
                
                CGRect frame = self.view.frame;
                
                frame.origin.x = 0;
                
                self.view.frame = frame;
                
                self.isMoving = NO;
            }];
        }
        else
        {
            [UIView animateWithDuration:0.25 animations:^{
                [self moveViewWithX:0];
            } completion:^(BOOL finished) {
                self.isMoving = NO;
                
                self.backGroundView.hidden = YES;
            }];
            
        }
        return;
        // cancal panning, alway move to left side automatically
    }else if (recoginzer.state == UIGestureRecognizerStateCancelled){
        
        [UIView animateWithDuration:0.25 animations:^{
            [self moveViewWithX:0];
        } completion:^(BOOL finished) {
            self.isMoving = NO;
            
            self.backGroundView.hidden = YES;
        }];
        
        return;
    }
    // it keeps move with touch
    if (_isMoving) {
        [self moveViewWithX:touchPoint.x - startPoint.x];
    }
}

//旋转问题
- (BOOL)shouldAutorotate {
    if (self.topViewController) {
        return [self.topViewController shouldAutorotate];
    }
    return NO;
}

- (void)setHiddenShadowImage:(BOOL)hiddenShadowImage {
    _hiddenShadowImage = hiddenShadowImage;
    if (_hiddenShadowImage) {
        //去掉导航栏底部的黑线
        [self.navigationBar setShadowImage:[UIImage imageWithColor:dk_ClearColor size:CGSizeMake(dk_ScreenWidth, 1)]];
    } else {
        [self.navigationBar setShadowImage:[UIImage imageWithColor:dk_HexColor(COLOR_LINE) size:CGSizeMake(dk_ScreenWidth, 1)]];
    }
}

- (void)setTransparent:(BOOL)transparent {
    _transparent = transparent;
    if (_transparent) {
        self.navigationBar.translucent = YES;
        [self.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
        self.hiddenShadowImage = YES;
    } else {
        self.navigationBar.translucent = NO;
        [self.navigationBar setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
        self.hiddenShadowImage = NO;
    }
}

- (void)setDk_navAlpha:(CGFloat)dk_navAlpha {
    _dk_navAlpha = dk_navAlpha;
    if (_dk_navAlpha < 0.0) {
        [self.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    } else if (_dk_navAlpha > 1.0) {
        [self.navigationBar setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
    } else {
        self.backgroundImage = [UIImage imageWithColor:[self.backgroundColor colorWithAlphaComponent:_dk_navAlpha]];
    }
}

- (void)setBackgroundColor:(UIColor *)backgroundColor {
    _backgroundColor = backgroundColor;
    self.backgroundImage = [UIImage imageWithColor:backgroundColor];
}

- (UIColor *)backgroundColor {
    if (!_backgroundColor) {
        _backgroundColor = dk_HexColor(COLOR_WHITE);
    }
    return _backgroundColor;
}

- (void)setBackgroundImage:(UIImage *)backgroundImage {
    _backgroundImage = backgroundImage;
    [self.navigationBar setBackgroundImage:_backgroundImage forBarMetrics:UIBarMetricsDefault];
}

- (void)setLeftBarTitle:(NSString *)leftBarTitle {
    _leftBarTitle = leftBarTitle;
}

- (UIModalPresentationStyle)modalPresentationStyle {
    return UIModalPresentationFullScreen;
}

@end

// TODO: 有时间添加侧滑到指定控制器功能。并显示对应截图
//    //在需要侧滑到指定控制器的控制器的 view 加载完毕后偷偷将当前控制器与目标控制器之间的所有控制器出栈
////     # 1. 获取当行控制器所有子控制器
//     NSMutableArray <UIViewController *>* tmp = self.navigationController.viewControllers.mutableCopy;
////     # 2. 获取目标控制器索引
//     UIViewController * targetVC = nil;
//       for (NSInteger i = 0 ; i < tmp.count; i++) {
//
//           UIViewController * vc = tmp[i];
//           if ([vc isKindOfClass:NSClassFromString(@"PersonalCenterViewController")])
//           {
//               targetVC = vc;
//               // 也可在此直接获取 i 的数值
//               break;
//           }
//       }
//     NSInteger index = [tmp indexOfObject:targetVC];
////     # 3. 移除目标控制器与当前控制器之间的所有控制器
//     NSRange  range = NSMakeRange(index + 1, tmp.count - 1 - (index + 1));
//
//     [tmp removeObjectsInRange:range];
////     # 4. 重新赋值给导航控制器
//     self.navigationController.viewControllers = [tmp copy];
