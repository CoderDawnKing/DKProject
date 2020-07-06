//
//  DKNaviFixSpace.m
//  DKNaviFixSpace
//
//  Created by 王 on 2018/6/12.
//  Copyright © 2018年 王King. All rights reserved.
//

#import "DKNaviFixSpace.h"

#import <objc/runtime.h>

void dk_swizzle(Class oldClass, NSString *oldSelector, Class newClass) {
    NSString *newSelector = [NSString stringWithFormat:@"dk_%@", oldSelector];
    Method old = class_getInstanceMethod(oldClass, NSSelectorFromString(oldSelector));
    Method new = class_getInstanceMethod(newClass, NSSelectorFromString(newSelector));
    method_exchangeImplementations(old, new);
}

@implementation UINavigationConfig

+ (instancetype)shared {
    static UINavigationConfig *config;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        config = [[self alloc] init];
    });
    return config;
}

-(instancetype)init {
    if (self = [super init]) {
        self.dk_defaultFixSpace = 0;
        self.dk_defaultFixLeftSpace = 0;
        self.dk_defaultFixRightSpace = 0;
        self.dk_disableFixSpace = NO;
    }
    return self;
}

- (CGFloat)dk_systemSpace {
    return MIN([UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height) > 375 ? 20 : 16;
}

- (void)setDk_defaultFixSpace:(CGFloat)dk_defaultFixSpace {
    _dk_defaultFixSpace = dk_defaultFixSpace;
    _dk_defaultFixLeftSpace = dk_defaultFixSpace;
    _dk_defaultFixRightSpace = dk_defaultFixSpace;
}

@end

@implementation UINavigationItem (DKFixSpace)

+(void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (@available(iOS 11.0, *)) {} else {
            NSArray <NSString *>*oriSels = @[@"setLeftBarButtonItem:",
                                             @"setLeftBarButtonItem:animated:",
                                             @"setLeftBarButtonItems:",
                                             @"setLeftBarButtonItems:animated:",
                                             @"setRightBarButtonItem:",
                                             @"setRightBarButtonItem:animated:",
                                             @"setRightBarButtonItems:",
                                             @"setRightBarButtonItems:animated:"];
            
            [oriSels enumerateObjectsUsingBlock:^(NSString * _Nonnull oriSel, NSUInteger idx, BOOL * _Nonnull stop) {
                dk_swizzle(self, oriSel, self);
            }];
        }
    });
}

-(void)dk_setLeftBarButtonItem:(UIBarButtonItem *)leftBarButtonItem {
    [self setLeftBarButtonItem:leftBarButtonItem animated:NO];
}

-(void)dk_setLeftBarButtonItem:(UIBarButtonItem *)leftBarButtonItem animated:(BOOL)animated {
    if (!UINavigationConfig.shared.dk_disableFixSpace && leftBarButtonItem) {//存在按钮且需要调节
        [self setLeftBarButtonItems:@[leftBarButtonItem] animated:animated];
    } else {//不存在按钮,或者不需要调节
        [self dk_setLeftBarButtonItem:leftBarButtonItem animated:animated];
    }
}


-(void)dk_setLeftBarButtonItems:(NSArray<UIBarButtonItem *> *)leftBarButtonItems {
    [self setLeftBarButtonItems:leftBarButtonItems animated:NO];
}

-(void)dk_setLeftBarButtonItems:(NSArray<UIBarButtonItem *> *)leftBarButtonItems animated:(BOOL)animated {
    if (!UINavigationConfig.shared.dk_disableFixSpace && leftBarButtonItems.count) {//存在按钮且需要调节
        UIBarButtonItem *firstItem = leftBarButtonItems.firstObject;
        CGFloat width = UINavigationConfig.shared.dk_defaultFixLeftSpace - UINavigationConfig.shared.dk_systemSpace;
        if (firstItem.width == width) {//已经存在space
            [self dk_setLeftBarButtonItems:leftBarButtonItems animated:animated];
        } else {
            NSMutableArray *items = [NSMutableArray arrayWithArray:leftBarButtonItems];
            [items insertObject:[self fixedSpaceWithWidth:width] atIndex:0];
            [self dk_setLeftBarButtonItems:items animated:animated];
        }
    } else {//不存在按钮,或者不需要调节
        [self dk_setLeftBarButtonItems:leftBarButtonItems animated:animated];
    }
}

-(void)dk_setRightBarButtonItem:(UIBarButtonItem *)rightBarButtonItem{
    [self setRightBarButtonItem:rightBarButtonItem animated:NO];
}

- (void)dk_setRightBarButtonItem:(UIBarButtonItem *)rightBarButtonItem animated:(BOOL)animated {
    if (![UINavigationConfig shared].dk_disableFixSpace && rightBarButtonItem) {//存在按钮且需要调节
        [self setRightBarButtonItems:@[rightBarButtonItem] animated:animated];
    } else {//不存在按钮,或者不需要调节
        [self dk_setRightBarButtonItem:rightBarButtonItem animated:animated];
    }
}

-(void)dk_setRightBarButtonItems:(NSArray<UIBarButtonItem *> *)rightBarButtonItems{
    [self setRightBarButtonItems:rightBarButtonItems animated:NO];
}

- (void)dk_setRightBarButtonItems:(NSArray<UIBarButtonItem *> *)rightBarButtonItems animated:(BOOL)animated {
    if (!UINavigationConfig.shared.dk_disableFixSpace && rightBarButtonItems.count) {//存在按钮且需要调节
        UIBarButtonItem *firstItem = rightBarButtonItems.firstObject;
        CGFloat width = UINavigationConfig.shared.dk_defaultFixRightSpace - UINavigationConfig.shared.dk_systemSpace;
        if (firstItem.width == width) {//已经存在space
            [self dk_setRightBarButtonItems:rightBarButtonItems animated:animated];
        } else {
            NSMutableArray *items = [NSMutableArray arrayWithArray:rightBarButtonItems];
            [items insertObject:[self fixedSpaceWithWidth:width] atIndex:0];
            [self dk_setRightBarButtonItems:items animated:animated];
        }
    } else {//不存在按钮,或者不需要调节
        [self dk_setRightBarButtonItems:rightBarButtonItems animated:animated];
    }
}

-(UIBarButtonItem *)fixedSpaceWithWidth:(CGFloat)width {
    UIBarButtonItem *fixedSpace = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    fixedSpace.width = width;
    return fixedSpace;
}

@end

@implementation NSObject (DKFixSpace)

+(void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (@available(iOS 11.0, *)) {
            NSDictionary <NSString *, NSString *>*oriSels = @{@"_UINavigationBarContentView": @"layoutSubviews",
                                                              @"_UINavigationBarContentViewLayout": @"_updateMarginConstraints"};
            [oriSels enumerateKeysAndObjectsUsingBlock:^(NSString * _Nonnull cls, NSString * _Nonnull oriSel, BOOL * _Nonnull stop) {
                dk_swizzle(NSClassFromString(cls), oriSel, NSObject.class);
            }];
        }
    });
}

- (void)dk_layoutSubviews {
    [self dk_layoutSubviews];
    if (UINavigationConfig.shared.dk_disableFixSpace) return;
    if (![self isMemberOfClass:NSClassFromString(@"_UINavigationBarContentView")]) return;
    id layout = [self valueForKey:@"_layout"];
    if (!layout) return;
    SEL selector = NSSelectorFromString(@"_updateMarginConstraints");
    IMP imp = [layout methodForSelector:selector];
    void (*func)(id, SEL) = (void *)imp;
    func(layout, selector);
}

- (void)dk__updateMarginConstraints {
    [self dk__updateMarginConstraints];
    if (UINavigationConfig.shared.dk_disableFixSpace) return;
    if (![self isMemberOfClass:NSClassFromString(@"_UINavigationBarContentViewLayout")]) return;
    [self dk_adjustLeadingBarConstraints];
    [self dk_adjustTrailingBarConstraints];
}

- (void)dk_adjustLeadingBarConstraints {
    if (UINavigationConfig.shared.dk_disableFixSpace) return;
    NSArray<NSLayoutConstraint *> *leadingBarConstraints = [self valueForKey:@"_leadingBarConstraints"];
    if (!leadingBarConstraints) return;
    CGFloat constant = UINavigationConfig.shared.dk_defaultFixLeftSpace - UINavigationConfig.shared.dk_systemSpace;
    for (NSLayoutConstraint *constraint in leadingBarConstraints) {
        if (constraint.firstAttribute == NSLayoutAttributeLeading &&
            constraint.secondAttribute == NSLayoutAttributeLeading) {
            constraint.constant = constant;
        }
    }
}

- (void)dk_adjustTrailingBarConstraints {
    if (UINavigationConfig.shared.dk_disableFixSpace) return;
    NSArray<NSLayoutConstraint *> *trailingBarConstraints = [self valueForKey:@"_trailingBarConstraints"];
    if (!trailingBarConstraints) return;
    CGFloat constant = UINavigationConfig.shared.dk_systemSpace - UINavigationConfig.shared.dk_defaultFixRightSpace;
    for (NSLayoutConstraint *constraint in trailingBarConstraints) {
        if (constraint.firstAttribute == NSLayoutAttributeTrailing &&
            constraint.secondAttribute == NSLayoutAttributeTrailing) {
            constraint.constant = constant;
        }
    }
}

@end
