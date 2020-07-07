//
//  DKBaseCollectionViewFlowLayout.h
//  GardenManager
//
//  Created by 王 on 2019/7/10.
//  Copyright © 2019 wisezone. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef enum : NSUInteger {
    DKBaseCollectionViewAlignmentLeft,
    DKBaseCollectionViewAlignmentCenter,
    DKBaseCollectionViewAlignmentRight,
} DKBaseCollectionViewAlignment;

@interface DKBaseCollectionViewFlowLayout : UICollectionViewFlowLayout

//两个Cell之间的距离
@property (nonatomic,assign) CGFloat dk_cellMargin;
//cell对齐方式
@property (nonatomic, assign) DKBaseCollectionViewAlignment dk_alignment;

- (instancetype)initWithAlignment:(DKBaseCollectionViewAlignment)alignment;
//全能初始化方法 其他方式初始化最终都会走到这里
- (instancetype)initWithAlignment:(DKBaseCollectionViewAlignment)alignment cellMargin:(CGFloat)cellMargin;

@end

NS_ASSUME_NONNULL_END
