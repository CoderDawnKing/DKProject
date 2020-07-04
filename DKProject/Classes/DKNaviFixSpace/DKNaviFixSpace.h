//
//  DKNaviFixSpace.h
//  DKNaviFixSpace
//
//  Created by 王 on 2018/6/12.
//  Copyright © 2018年 王King. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

static CGFloat dk_defaultSpace = 20;// 导航栏按钮间距 可根据需求自定义

@interface UINavigationConfig : NSObject
@property (nonatomic, assign) CGFloat dk_defaultFixSpace; //item距离两端的间距,默认为0
@property (nonatomic, assign) CGFloat dk_defaultFixLeftSpace; //item距离左端的间距,默认为0
@property (nonatomic, assign) CGFloat dk_defaultFixRightSpace; //item距离右端的间距,默认为0
@property (nonatomic, assign) BOOL dk_disableFixSpace;    //是否禁止使用修正,默认为NO

+ (instancetype)shared;
- (instancetype)init NS_UNAVAILABLE;
+ (instancetype)new NS_UNAVAILABLE;

- (CGFloat)dk_systemSpace;

@end
@interface UINavigationItem (DKFixSpace)

@end

@interface NSObject (DKFixSpace)

@end
