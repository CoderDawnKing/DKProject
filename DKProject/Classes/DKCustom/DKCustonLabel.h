//
//  DKCustonLabel.h
//  GardenManager
//
//  Created by 王 on 2019/7/30.
//  Copyright © 2019 wisezone. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef enum : NSUInteger {
    DKCustonLabelVerticalAlignmentCenter = 0,// default
    DKCustonLabelVerticalAlignmentTop,
    DKCustonLabelVerticalAlignmentBottom,
} DKCustonLabelVerticalAlignmentType;

@interface DKCustonLabel : UILabel

@property (nonatomic, assign) DKCustonLabelVerticalAlignmentType dk_verticalAlignment;
@property (nonatomic, assign, getter=isCanCopy) BOOL canCopy;


@end

NS_ASSUME_NONNULL_END
