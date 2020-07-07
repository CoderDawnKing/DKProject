//
//  DKBaseCollectionView.m
//  GardenManager
//
//  Created by 王 on 2019/6/23.
//  Copyright © 2019 wisezone. All rights reserved.
//

#import "DKBaseCollectionView.h"
#import <DKProject/DKProject.h>

@implementation DKBaseCollectionView

- (instancetype)init {
    if (self = [super init]) {
       
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame collectionViewLayout:(nonnull UICollectionViewLayout *)layout {
    if (self = [super initWithFrame:frame collectionViewLayout:layout]) {
        self.dk_emptyView = [[DKBaseEmptyView alloc] init];
        self.autoHideMjFooter = YES;
        self.autoShowEmpty = YES;
        [self __addSubViews];
        [self __makeConstraints];
        [self __addViewModel];
    }
    return self;
}

- (void)__addSubViews{}

- (void)__addViewModel{}

- (void)__makeConstraints{}

/** 更新约束 */
- (void)__updateConstraints {}

@end
