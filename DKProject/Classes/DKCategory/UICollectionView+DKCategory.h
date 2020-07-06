//
//  UICollectionView+DKCategory.h
//  GardenManager
//
//  Created by 王 on 2019/7/21.
//  Copyright © 2019 wisezone. All rights reserved.
//



NS_ASSUME_NONNULL_BEGIN

@class DKBaseEmptyView;

@interface UICollectionView (DKCategory)

/**是否开启<数据不满一页的话就自动隐藏下面的mj_footer>功能*/
@property(nonatomic, assign) BOOL autoHideMjFooter;
/** 是否开启自动显示空界面 */
@property (nonatomic, assign, getter=isAutoShowEmpty) BOOL autoShowEmpty;
/** 是否空数据 autoShowEmpty 为 NO 时生效 */
@property (nonatomic, assign, getter=isEmptyDatas) BOOL emptyDatas;

@property (nonatomic, strong, nullable) DKBaseEmptyView *dk_emptyView;

@end

NS_ASSUME_NONNULL_END
