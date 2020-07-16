//
//  DKThemeManager.h
//  qmuidemo
//
//  Created by QMUI Team on 2017/5/9.
//  Copyright © 2017年 QMUI Team. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DKThemeProtocol.h"

/// 简单对 QMUIThemeManager 做一层业务的封装，省去类型转换的工作量
@interface DKThemeManager : NSObject

@property(class, nonatomic, readonly, nullable) NSObject<DKThemeProtocol> *currentTheme;
@end

@interface UIColor (DKTheme)

@property(class, nonatomic, strong, readonly) UIColor *dk_backgroundColor;
@property(class, nonatomic, strong, readonly) UIColor *dk_backgroundColorLighten;
@property(class, nonatomic, strong, readonly) UIColor *dk_backgroundColorHighlighted;
@property(class, nonatomic, strong, readonly) UIColor *dk_tintColor;
@property(class, nonatomic, strong, readonly) UIColor *dk_titleTextColor;
@property(class, nonatomic, strong, readonly) UIColor *dk_mainTextColor;
@property(class, nonatomic, strong, readonly) UIColor *dk_descriptionTextColor;
@property(class, nonatomic, strong, readonly) UIColor *dk_placeholderColor;
@property(class, nonatomic, strong, readonly) UIColor *dk_codeColor;
@property(class, nonatomic, strong, readonly) UIColor *dk_separatorColor;
@property(class, nonatomic, strong, readonly) UIColor *dk_gridItemTintColor;
@end

@interface UIImage (DKTheme)

@property(class, nonatomic, strong, readonly) UIImage *dk_searchBarTextFieldBackgroundImage;
@property(class, nonatomic, strong, readonly) UIImage *dk_searchBarBackgroundImage;
@end

@interface UIVisualEffect (DKTheme)

@property(class, nonatomic, strong, readonly) UIVisualEffect *dk_standardBlurEffect;
@end
