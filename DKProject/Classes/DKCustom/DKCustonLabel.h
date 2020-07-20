//
//  DKCustonLabel.h
//  GardenManager
//
//  Created by 王 on 2019/7/30.
//  Copyright © 2019 wisezone. All rights reserved.
//

#import <QMUIKit/QMUIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef enum : NSUInteger {
    DKCustonLabelVerticalAlignmentCenter = 0,// default
    DKCustonLabelVerticalAlignmentTop,
    DKCustonLabelVerticalAlignmentBottom,
} DKCustonLabelVerticalAlignmentType;

@interface DKCustonLabel : QMUILabel

@property (nonatomic, assign) DKCustonLabelVerticalAlignmentType dk_verticalAlignment;

@end

NS_ASSUME_NONNULL_END
