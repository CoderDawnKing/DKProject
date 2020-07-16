//
//  DKCommonUI.m
//  AFNetworking
//
//  Created by DawnKing on 2020/7/17.
//

#import "DKCommonUI.h"
#import <DKProject/DKProject.h>

NSString *const DKSelectedThemeIdentifier = @"selectedThemeIdentifier";
NSString *const DKThemeIdentifierDefault = @"Default";
NSString *const DKThemeIdentifierGrapefruit = @"Grapefruit";
NSString *const DKThemeIdentifierGrass = @"Grass";
NSString *const DKThemeIdentifierPinkRose = @"Pink Rose";
NSString *const DKThemeIdentifierDark = @"Dark";

const CGFloat DKButtonSpacingHeight = 72;

@implementation DKCommonUI

+ (void)renderGlobalAppearances {
    [DKUIHelper customMoreOperationAppearance];
    [DKUIHelper customAlertControllerAppearance];
    [DKUIHelper customDialogViewControllerAppearance];
    [DKUIHelper customImagePickerAppearance];
    [DKUIHelper customEmotionViewAppearance];
    
    UISearchBar *searchBar = [UISearchBar appearance];
    searchBar.searchTextPositionAdjustment = UIOffsetMake(4, 0);
    
    QMUILabel *label = [QMUILabel appearance];
    label.highlightedBackgroundColor = TableViewCellSelectedBackgroundColor;
}

@end

@implementation DKCommonUI (ThemeColor)

static NSArray<UIColor *> *themeColors = nil;
+ (UIColor *)randomThemeColor {
    if (!themeColors) {
        themeColors = @[UIColorTheme1,
                        UIColorTheme2,
                        UIColorTheme3,
                        UIColorTheme4,
                        UIColorTheme5,
                        UIColorTheme6,
                        UIColorTheme7,
                        UIColorTheme8,
                        UIColorTheme9,
                        UIColorTheme10];
    }
    return themeColors[arc4random() % themeColors.count];
}

@end

@implementation DKCommonUI (Layer)

+ (CALayer *)generateSeparatorLayer {
    CALayer *layer = [CALayer layer];
    [layer qmui_removeDefaultAnimations];
    layer.backgroundColor = UIColorSeparator.CGColor;
    return layer;
}

@end


