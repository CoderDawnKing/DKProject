//
//  DKUIHelper.h
//  AFNetworking
//
//  Created by DawnKing on 2020/7/17.
//

#import <Foundation/Foundation.h>
#import <QMUIKit/QMUIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface DKUIHelper : NSObject

+ (void)forceInterfaceOrientationPortrait;

@end

NS_ASSUME_NONNULL_END

@interface DKUIHelper (QMUIMoreOperationAppearance)

+ (void)customMoreOperationAppearance;

@end


@interface DKUIHelper (QMUIAlertControllerAppearance)

+ (void)customAlertControllerAppearance;

@end

@interface DKUIHelper (QMUIDialogViewControllerAppearance)

+ (void)customDialogViewControllerAppearance;

@end


@interface DKUIHelper (QMUIEmotionView)

+ (void)customEmotionViewAppearance;
@end


@interface DKUIHelper (QMUIImagePicker)

+ (void)customImagePickerAppearance;

@end


@interface DKUIHelper (UITabBarItem)

+ (UITabBarItem *)tabBarItemWithTitle:(NSString *)title image:(UIImage *)image selectedImage:(UIImage *)selectedImage tag:(NSInteger)tag;

@end


@interface DKUIHelper (Button)

+ (QMUIButton *)generateDarkFilledButton;
+ (QMUIButton *)generateLightBorderedButton;

@end


@interface DKUIHelper (Emotion)

+ (NSArray<QMUIEmotion *> *)qmuiEmotions;

/// 用于主题更新后，更新表情 icon 的颜色
+ (void)updateEmotionImages;
@end


@interface DKUIHelper (SavePhoto)

+ (void)showAlertWhenSavedPhotoFailureByPermissionDenied;

@end


@interface DKUIHelper (Calculate)

+ (NSString *)humanReadableFileSize:(long long)size;
    
@end


@interface DKUIHelper (Theme)

+ (UIImage *)navigationBarBackgroundImageWithThemeColor:(UIColor *)color;
@end


@interface NSString (Code)

- (void)enumerateCodeStringUsingBlock:(void (^)(NSString *codeString, NSRange codeRange))block;

@end
