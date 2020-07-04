//
//  BaseView.h
//  GardenManager
//
//  Created by 王 on 2019/6/17.
//  Copyright © 2019 wisezone. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol DKBaseViewModelProtocol;
@class DKBaseViewModel;
@class DKBaseModel;

NS_ASSUME_NONNULL_BEGIN

@protocol DKBaseViewProtocol <NSObject>

- (instancetype)initWithModel:(DKBaseModel *)model;

- (instancetype)initWithViewModel:(id <DKBaseViewModelProtocol>)viewModel;

- (void)__addSubViews;

- (void)__addViewModel;

- (void)__makeConstraints;
/** 更新约束 */
- (void)__updateConstraints;

@end

@interface DKBaseView : UIView <DKBaseViewProtocol>

+ (instancetype)lineView;

+ (instancetype)circularViewWithRadius:(CGFloat)radius;

@end

NS_ASSUME_NONNULL_END
