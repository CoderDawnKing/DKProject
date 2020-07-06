//
//  UIImage+DKCategory.h
//  GardenManager
//
//  Created by 王 on 2019/6/22.
//  Copyright © 2019 wisezone. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Photos/Photos.h>
NS_ASSUME_NONNULL_BEGIN

typedef enum : NSUInteger {
    DKImageGradientDirectionTypeTopToBottom,
    DKImageGradientDirectionTypeLeftToRight,
} DKImageGradientDirectionType;

@interface UIImage (DKCategory)

///去除 name 为空时控制台警告
+ (nullable UIImage *)dkImageNamed:(nullable NSString *)name;
+ (nullable UIImage *)dkBundleImageNamed:(nullable NSString *)name;

/**
 修改图片颜色
 */
- (UIImage *)changeColor:(UIColor *)color;
+ (UIImage *)imageWithColor:(UIColor *)color;
+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size;
/** 获取一个透明的图片 */
+ (UIImage *)imageWithClearColor;
///PHAsset 转成 UIImage
+ (UIImage *)PHAssetToUIImage:(PHAsset *)asset;
///压缩指定大小的图片 maxLength 单位 KB
- (NSData *)resetSizeOfImageDataMaxSize:(NSInteger)maxSize;
///获取渐变色图片
+ (UIImage *)imageWithStartColor:(UIColor *)startColor endColor:(UIColor *)endColor size:(CGSize)size direction:(DKImageGradientDirectionType)direction;
@end

NS_ASSUME_NONNULL_END
