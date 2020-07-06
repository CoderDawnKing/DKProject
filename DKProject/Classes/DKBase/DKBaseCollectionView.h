//
//  DKBaseCollectionView.h
//  GardenManager
//
//  Created by 王 on 2019/6/23.
//  Copyright © 2019 wisezone. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@protocol DKBaseCollectionViewProtocol <NSObject>

- (void)__addSubViews;

- (void)__addViewModel;

- (void)__makeConstraints;
/** 更新约束 */
- (void)__updateConstraints;

@end
@interface DKBaseCollectionView : UICollectionView<DKBaseCollectionViewProtocol>

@end

NS_ASSUME_NONNULL_END
