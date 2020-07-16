//
//  QDCollectionDemoViewController.h
//  qmuidemo
//
//  Created by QMUI Team on 16/9/8.
//  Copyright © 2016年 QMUI Team. All rights reserved.
//

#import "DKBaseViewController.h"

@interface QDCollectionDemoViewController : DKBaseViewController<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property(nonatomic, strong, readonly) UICollectionView *collectionView;
@property(nonatomic, strong, readonly) QMUICollectionViewPagingLayout *collectionViewLayout;

- (instancetype)initWithLayoutStyle:(QMUICollectionViewPagingLayoutStyle)style;
@end
