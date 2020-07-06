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

- (void)setCanCopy:(BOOL)canCopy {
    _canCopy = canCopy;
    if (_canCopy) {
        self.userInteractionEnabled = YES;
        [self addGestureRecognizer:[[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressCellHandle:)]];
    }
}

-(void)longPressCellHandle:(UILongPressGestureRecognizer *)gesture {
    if (gesture.state == UIGestureRecognizerStateBegan){
        [self becomeFirstResponder];
        UIMenuItem *copyItem = [[UIMenuItem alloc]initWithTitle:@"复制" action:@selector(menuCopyBtnPressed:)];
        UIMenuController *menuController = [UIMenuController sharedMenuController];
        [menuController setMenuItems:[NSArray arrayWithObjects:copyItem, nil]];
        [menuController setTargetRect:self.frame inView:self.superview];
        [menuController setMenuVisible:YES animated:YES];
    }
}


-(void)menuCopyBtnPressed:(UIMenuItem *)menuItem {
    [UIPasteboard generalPasteboard].string = self.text;
}


-(BOOL)canBecomeFirstResponder {
    UIWindow *window = [[UIApplication sharedApplication].delegate window];
    if ([window isKeyWindow] == NO) {
        [window becomeKeyWindow];
        [window makeKeyAndVisible];
    }
    return YES;
}


-(BOOL)canPerformAction:(SEL)action withSender:(id)sender {
    if (action == @selector(menuCopyBtnPressed:)) {
        return YES;
    }
    return NO;
}

@end
