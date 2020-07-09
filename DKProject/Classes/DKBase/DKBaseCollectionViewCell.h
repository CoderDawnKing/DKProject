//
//  DKBaseCollectionViewCell.h
//  GardenManager
//
//  Created by 王 on 2019/6/23.
//  Copyright © 2019 wisezone. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef enum : NSUInteger {
    DKBaseCollectionViewCellTypeNone,
    DKBaseCollectionViewCellTypeImage,
    DKBaseCollectionViewCellTypeTitle,
    ///标题在右侧
    DKBaseCollectionViewCellTypeRightTitleLeftImage,
    ///标题在底部
    DKBaseCollectionViewCellTypeBottomTitleTopImage,
} DKBaseCollectionViewCellType;

@protocol DKBaseCollectionViewCellProtocol <NSObject>
/** 加载子视图 */
- (void)__addSubViews;
/** 添加模型 */
- (void)__addViewModel;
/** 布置约束 */
- (void)__makeConstraints;
/** 更新约束 */
- (void)__updateConstraints;

@end

@interface DKBaseCollectionViewCell : UICollectionViewCell<DKBaseCollectionViewCellProtocol>

@property (nonatomic, assign) DKBaseCollectionViewCellType dk_type;

@property (nonatomic, strong) UILabel *title;
@property (nonatomic, strong) UIImageView *imageV;

/** 内部 Label 内边距 */
@property (nonatomic, assign) UIEdgeInsets labelInsets;

@end

NS_ASSUME_NONNULL_END
