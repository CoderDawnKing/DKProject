//
//  DKThemeManager.m
//  qmuidemo
//
//  Created by QMUI Team on 2017/5/9.
//  Copyright © 2017年 QMUI Team. All rights reserved.
//

#import "DKThemeManager.h"
#import <DKProject/DKProject.h>

@interface DKThemeManager ()

@property(nonatomic, strong) UIColor *dk_backgroundColor;
@property(nonatomic, strong) UIColor *dk_backgroundColorLighten;
@property(nonatomic, strong) UIColor *dk_backgroundColorHighlighted;
@property(nonatomic, strong) UIColor *dk_tintColor;
@property(nonatomic, strong) UIColor *dk_titleTextColor;
@property(nonatomic, strong) UIColor *dk_mainTextColor;
@property(nonatomic, strong) UIColor *dk_descriptionTextColor;
@property(nonatomic, strong) UIColor *dk_placeholderColor;
@property(nonatomic, strong) UIColor *dk_codeColor;
@property(nonatomic, strong) UIColor *dk_separatorColor;
@property(nonatomic, strong) UIColor *dk_gridItemTintColor;

@property(nonatomic, strong) UIImage *dk_searchBarTextFieldBackgroundImage;
@property(nonatomic, strong) UIImage *dk_searchBarBackgroundImage;

@property(nonatomic, strong) UIVisualEffect *dk_standardBlueEffect;

@property(class, nonatomic, strong, readonly) DKThemeManager *sharedInstance;
@end

@implementation DKThemeManager

+ (instancetype)sharedInstance {
    static dispatch_once_t onceToken;
    static DKThemeManager *instance = nil;
    dispatch_once(&onceToken,^{
        instance = [[super allocWithZone:NULL] init];
    });
    return instance;
}

+ (id)allocWithZone:(struct _NSZone *)zone{
    return [self sharedInstance];
}

- (instancetype)init {
    if (self = [super init]) {
        self.dk_backgroundColor = [UIColor qmui_colorWithThemeProvider:^UIColor * _Nonnull(__kindof QMUIThemeManager * _Nonnull manager, __kindof NSObject<NSCopying> * _Nullable identifier, NSObject<DKThemeProtocol> *theme) {
            return theme.themeBackgroundColor;
        }];
        self.dk_backgroundColorLighten = [UIColor qmui_colorWithThemeProvider:^UIColor * _Nonnull(__kindof QMUIThemeManager * _Nonnull manager, NSString * _Nullable identifier, NSObject<DKThemeProtocol> * _Nullable theme) {
            return theme.themeBackgroundColorLighten;
        }];
        self.dk_backgroundColorHighlighted = [UIColor qmui_colorWithThemeProvider:^UIColor * _Nonnull(__kindof QMUIThemeManager * _Nonnull manager, __kindof NSObject<NSCopying> * _Nullable identifier, NSObject<DKThemeProtocol> *theme) {
            return theme.themeBackgroundColorHighlighted;
        }];
        self.dk_tintColor = [UIColor qmui_colorWithThemeProvider:^UIColor * _Nonnull(__kindof QMUIThemeManager * _Nonnull manager, __kindof NSObject<NSCopying> * _Nullable identifier, NSObject<DKThemeProtocol> *theme) {
            return theme.themeTintColor;
        }];
        self.dk_titleTextColor = [UIColor qmui_colorWithThemeProvider:^UIColor * _Nonnull(__kindof QMUIThemeManager * _Nonnull manager, __kindof NSObject<NSCopying> * _Nullable identifier, NSObject<DKThemeProtocol> *theme) {
            return theme.themeTitleTextColor;
        }];
        self.dk_mainTextColor = [UIColor qmui_colorWithThemeProvider:^UIColor * _Nonnull(__kindof QMUIThemeManager * _Nonnull manager, __kindof NSObject<NSCopying> * _Nullable identifier, NSObject<DKThemeProtocol> *theme) {
            return theme.themeMainTextColor;
        }];
        self.dk_descriptionTextColor = [UIColor qmui_colorWithThemeProvider:^UIColor * _Nonnull(__kindof QMUIThemeManager * _Nonnull manager, __kindof NSObject<NSCopying> * _Nullable identifier, NSObject<DKThemeProtocol> *theme) {
            return theme.themeDescriptionTextColor;
        }];
        self.dk_placeholderColor = [UIColor qmui_colorWithThemeProvider:^UIColor * _Nonnull(__kindof QMUIThemeManager * _Nonnull manager, __kindof NSObject<NSCopying> * _Nullable identifier, NSObject<DKThemeProtocol> *theme) {
            return theme.themePlaceholderColor;
        }];
        self.dk_codeColor = [UIColor qmui_colorWithThemeProvider:^UIColor * _Nonnull(__kindof QMUIThemeManager * _Nonnull manager, __kindof NSObject<NSCopying> * _Nullable identifier, NSObject<DKThemeProtocol> *theme) {
            return theme.themeCodeColor;
        }];
        self.dk_separatorColor = [UIColor qmui_colorWithThemeProvider:^UIColor * _Nonnull(__kindof QMUIThemeManager * _Nonnull manager, __kindof NSObject<NSCopying> * _Nullable identifier, NSObject<DKThemeProtocol> *theme) {
            return theme.themeSeparatorColor;
        }];
        self.dk_gridItemTintColor = [UIColor qmui_colorWithThemeProvider:^UIColor * _Nonnull(__kindof QMUIThemeManager * _Nonnull manager, NSString * _Nullable identifier, NSObject<DKThemeProtocol> * _Nullable theme) {
            return theme.themeGridItemTintColor;
        }];
        
        self.dk_searchBarTextFieldBackgroundImage = [UIImage qmui_imageWithThemeProvider:^UIImage * _Nonnull(__kindof QMUIThemeManager * _Nonnull manager, __kindof NSObject<NSCopying> * _Nullable identifier, __kindof NSObject<DKThemeProtocol> * _Nullable theme) {
            return [UISearchBar qmui_generateTextFieldBackgroundImageWithColor:theme.themeBackgroundColorHighlighted];
        }];
        self.dk_searchBarBackgroundImage = [UIImage qmui_imageWithThemeProvider:^UIImage * _Nonnull(__kindof QMUIThemeManager * _Nonnull manager, __kindof NSObject<NSCopying> * _Nullable identifier, __kindof NSObject<DKThemeProtocol> * _Nullable theme) {
            return [UISearchBar qmui_generateBackgroundImageWithColor:theme.themeBackgroundColor borderColor:nil];
        }];
        
        self.dk_standardBlueEffect = [UIVisualEffect qmui_effectWithThemeProvider:^UIVisualEffect * _Nonnull(__kindof QMUIThemeManager * _Nonnull manager, NSString * _Nullable identifier, NSObject<DKThemeProtocol> * _Nullable theme) {
            return [UIBlurEffect effectWithStyle:[identifier isEqualToString:DKThemeIdentifierDark] ? UIBlurEffectStyleDark : UIBlurEffectStyleLight];
        }];
    }
    return self;
}

+ (NSObject<DKThemeProtocol> *)currentTheme {
    return QMUIThemeManagerCenter.defaultThemeManager.currentTheme;
}

@end

@implementation UIColor (QDTheme)

+ (instancetype)dk_sharedInstance {
    static dispatch_once_t onceToken;
    static UIColor *instance = nil;
    dispatch_once(&onceToken,^{
        instance = [[super allocWithZone:NULL] init];
    });
    return instance;
}

+ (UIColor *)dk_backgroundColor {
    return DKThemeManager.sharedInstance.dk_backgroundColor;
}

+ (UIColor *)dk_backgroundColorLighten {
    return DKThemeManager.sharedInstance.dk_backgroundColorLighten;
}

+ (UIColor *)dk_backgroundColorHighlighted {
    return DKThemeManager.sharedInstance.dk_backgroundColorHighlighted;
}

+ (UIColor *)dk_tintColor {
    return DKThemeManager.sharedInstance.dk_tintColor;
}

+ (UIColor *)dk_titleTextColor {
    return DKThemeManager.sharedInstance.dk_titleTextColor;
}

+ (UIColor *)dk_mainTextColor {
    return DKThemeManager.sharedInstance.dk_mainTextColor;
}

+ (UIColor *)dk_descriptionTextColor {
    return DKThemeManager.sharedInstance.dk_descriptionTextColor;
}

+ (UIColor *)dk_placeholderColor {
    return DKThemeManager.sharedInstance.dk_placeholderColor;
}

+ (UIColor *)dk_codeColor {
    return DKThemeManager.sharedInstance.dk_codeColor;
}

+ (UIColor *)dk_separatorColor {
    return DKThemeManager.sharedInstance.dk_separatorColor;
}

+ (UIColor *)dk_gridItemTintColor {
    return DKThemeManager.sharedInstance.dk_gridItemTintColor;
}

@end

@implementation UIImage (QDTheme)

+ (UIImage *)dk_searchBarTextFieldBackgroundImage {
    return DKThemeManager.sharedInstance.dk_searchBarTextFieldBackgroundImage;
}

+ (UIImage *)dk_searchBarBackgroundImage {
    return DKThemeManager.sharedInstance.dk_searchBarBackgroundImage;
}

@end

@implementation UIVisualEffect (QDTheme)

+ (UIVisualEffect *)dk_standardBlurEffect {
    return DKThemeManager.sharedInstance.dk_standardBlueEffect;
}

@end
