//
//  Constant.h
//  GardenManager
//
//  Created by DiDa on 2018/1/16.
//  Copyright (c) 2018年 DiDa. All rights reserved.
//

/// 应用ID
#define dk_ApplicationID  @"yourId"

/// 版本号
#define dk_Version [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]
/// 屏幕高
#define dk_ScreenHeight [UIScreen mainScreen].bounds.size.height
/// 屏幕宽
#define dk_ScreenWidth [UIScreen mainScreen].bounds.size.width
/// 线条宽度
#define dk_LineWidth 1.0/[[UIScreen mainScreen] scale]

#define dk_ScreenHeightRatio (ScreenHeight / 667.0)
#define dk_ScreenWidthRatio (ScreenWidth / 375.0)

#define dk_WidthRatio(width) ((width * ScreenWidth) / 375.0)
#define dk_HeightRatio(height) ((height * ScreenHeight) / 667.0)

#define dk_Window [UIApplication sharedApplication].keyWindow

#define dk_LogRespone DKLog(@"%@", respone.mj_keyValues)

/*状态栏高度*/
#define dk_StatusBarHeight (CGFloat)(IS_IPHONE_X?(44.0):(20.0))
/*导航栏高度*/
#define dk_NavBarHeight (44.0)
/*状态栏和导航栏总高度*/
#define dk_NavBarAndStatusBarHeight (CGFloat)(IS_IPHONE_X?(88.0):(64.0))
/*TabBar高度*/
#define dk_TabBarHeight (CGFloat)(IS_IPHONE_X?(49.0 + 34.0):(49.0))
/*顶部安全区域远离高度*/
#define dk_TopBarSafeHeight (CGFloat)(IS_IPHONE_X?(44.0):(0))
/*底部安全区域远离高度*/
#define dk_BottomSafeHeight (CGFloat)(IS_IPHONE_X?(34.0):(0))
/*iPhoneX的状态栏高度差值*/
#define dk_TopBarDifHeight (CGFloat)(IS_IPHONE_X?(24.0):(0))
/*导航条和Tabbar总高度*/
#define dk_NavAndTabHeight (kNavBarAndStatusBarHeight + kTabBarHeight)

#define dkIMAGE(image) [UIImage dkImageNamed:image]
#define dkIMAGEClearColor [UIImage imageWithClearColor]

#define dk_KeyboardHeight 216.0 //键盘高度
#define dk_ViewHeight 90  //键盘上面textview高度
#define dk_ToolViewHeight 145.0  //带有工具栏键盘上面textview高度

//新增
#define IS_IPHONE_5 (fabs([[ UIScreen mainScreen ] bounds ].size.height)>=568)
#define IS_SMALL_IPHONE (fabs([[ UIScreen mainScreen ] bounds ].size.width)==320) //小屏
#define IS_IPHONE_X \
({BOOL isPhoneX = NO;\
if (@available(iOS 11.0, *)) {\
isPhoneX = [[UIApplication sharedApplication] delegate].window.safeAreaInsets.bottom > 0.0;\
}\
(isPhoneX);})

#define dk_NetErrorAlertString @"网络好像不给力哦:-("
#define dk_NoWifiAlertString @"您当前正在使用移动网络，继续播放将消耗流量"
