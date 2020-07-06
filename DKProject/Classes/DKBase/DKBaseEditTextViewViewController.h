//
//  DKBaseEditTextViewViewController.h
//  GardenManager
//
//  Created by 王 on 2020/1/7.
//  Copyright © 2020 wisezone. All rights reserved.
//

#import "DKBaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface DKBaseEditTextViewViewController : DKBaseViewController
@property (nonatomic, assign) NSInteger limitNumber;
@property (nonatomic, strong) NSString *context;
@property (nonatomic, strong) NSString *placeholder;
@property (nonatomic, assign) UIKeyboardType keyboardType;
@property (nonatomic, copy) void (^backBlock) (NSString *context);
@end

NS_ASSUME_NONNULL_END
