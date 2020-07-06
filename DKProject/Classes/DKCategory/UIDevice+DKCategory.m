//
//  UIDevice+DKCategory.m
//  GardenManager
//
//  Created by 王 on 2019/8/2.
//  Copyright © 2019 wisezone. All rights reserved.
//

#import "UIDevice+DKCategory.h"

@implementation UIDevice (DKCategory)

+ (void)switchNewOrientation:(UIInterfaceOrientation)interfaceOrientation {
    NSNumber *resetOrientationTarget = [NSNumber numberWithInt:UIInterfaceOrientationUnknown];
    [[UIDevice currentDevice] setValue:resetOrientationTarget forKey:@"orientation"];
    NSNumber *orientationTarget = [NSNumber numberWithInt:interfaceOrientation];
    [[UIDevice currentDevice] setValue:orientationTarget forKey:@"orientation"];
}

@end
