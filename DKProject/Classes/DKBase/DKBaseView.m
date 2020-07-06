//
//  BaseView.m
//  GardenManager
//
//  Created by 王 on 2019/6/17.
//  Copyright © 2019 wisezone. All rights reserved.
//

#import "DKBaseView.h"
#import <DKProject/DKProject.h>

@implementation DKBaseView

+ (instancetype)lineView {
    DKBaseView *view = [[DKBaseView alloc] init];
    view.backgroundColor = dk_HexColor(DK_COLOR_LINE);
    return view;
}

+ (instancetype)circularViewWithRadius:(CGFloat)radius {
    DKBaseView *view = [[DKBaseView alloc] init];
    view.backgroundColor = dk_HexColor(DK_COLOR_DDDDDD);
    view.layer.cornerRadius = radius;
    view.layer.masksToBounds = YES;
    return view;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self __addSubViews];
        [self __makeConstraints];
        [self __addViewModel];
    }
    return self;
}

- (instancetype)init {
    if (self = [super init]) {
        
    }
    return self;
}

- (instancetype)initWithModel:(DKBaseModel *)model {
    if (self = [super init]) {
        
    }
    return self;
}

- (instancetype)initWithViewModel:(id<DKBaseViewModelProtocol>)viewModel {
    if (self = [super init]) {
        
    }
    return self;
}

/** 加载子视图 */
- (void)__addSubViews {
    
}

/** 添加模型 */
- (void)__addViewModel {
    
}

/** 布置约束 */
- (void)__makeConstraints {
    
}

/** 更新约束 */
- (void)__updateConstraints {}

@end
