//
//  DKBaseProgressHUD.h
//  GardenManager
//
//  Created by 王 on 2019/7/20.
//  Copyright © 2019 wisezone. All rights reserved.
//

#import <SVProgressHUD/SVProgressHUD.h>

NS_ASSUME_NONNULL_BEGIN

@interface DKBaseProgressHUD : SVProgressHUD

+ (void)showOnlyTextWithStatus:(NSString *)status;

@end

NS_ASSUME_NONNULL_END
