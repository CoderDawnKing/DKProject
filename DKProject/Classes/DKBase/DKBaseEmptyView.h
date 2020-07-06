//
//  DKBaseEmptyView.h
//  GardenManager
//
//  Created by 王 on 2019/7/22.
//  Copyright © 2019 wisezone. All rights reserved.
//

#import "DKBaseView.h"

NS_ASSUME_NONNULL_BEGIN

@interface DKBaseEmptyView : DKBaseView

@property (nonatomic, strong, nullable) UIImage *emptyImage;
@property (nonatomic, strong, nullable) NSString *emptyPrompt;
@property (nonatomic, strong, nullable) NSString *emptyButtonTitle;
@property (nonatomic, assign, getter=isShowButton) BOOL showButton;
@property (nonatomic, assign) CGPoint emptyOffset;
@property (nonatomic, assign) CGFloat emptyTop;
@property (nonatomic, copy) void (^buttonBlock) (UIButton *button);

@end

NS_ASSUME_NONNULL_END
