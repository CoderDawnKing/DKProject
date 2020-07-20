//
//  DKCustonLabel.m
//  GardenManager
//
//  Created by 王 on 2019/7/30.
//  Copyright © 2019 wisezone. All rights reserved.
//

#import "DKCustonLabel.h"

@implementation DKCustonLabel

@synthesize dk_verticalAlignment = _dk_verticalAlignment;

- (instancetype)init {
    if (self = [super init]) {
        self.dk_verticalAlignment = DKCustonLabelVerticalAlignmentCenter;
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.dk_verticalAlignment = DKCustonLabelVerticalAlignmentCenter;
    }
    return self;
}

- (void)setDk_verticalAlignment:(DKCustonLabelVerticalAlignmentType)dk_verticalAlignment {
    _dk_verticalAlignment = dk_verticalAlignment;
    [self setNeedsDisplay];
}

- (CGRect)textRectForBounds:(CGRect)bounds limitedToNumberOfLines:(NSInteger)numberOfLines {
    CGRect textRect = [super textRectForBounds:bounds limitedToNumberOfLines:numberOfLines];
    switch (self.dk_verticalAlignment) {
        case DKCustonLabelVerticalAlignmentTop:
            textRect.origin.y = bounds.origin.y;
            break;
        case DKCustonLabelVerticalAlignmentBottom:
            textRect.origin.y = bounds.origin.y + bounds.size.height - textRect.size.height;
            break;
        default:
            textRect.origin.y = bounds.origin.y + (bounds.size.height - textRect.size.height) / 2.0;
            break;
    }
    return textRect;
}

- (void)drawTextInRect:(CGRect)rect {
    CGRect actualRect = [self textRectForBounds:rect limitedToNumberOfLines:self.numberOfLines];
    [super drawTextInRect:actualRect];
}


@end
