//
//  DKBaseScrollView.m
//  GardenManager
//
//  Created by 王 on 2019/11/25.
//  Copyright © 2019 wisezone. All rights reserved.
//

#import "DKBaseScrollView.h"

@implementation DKBaseScrollView

-(BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    if (gestureRecognizer.state != 0) {
        return YES;
    } else {
        return NO;
    }
}

@end
