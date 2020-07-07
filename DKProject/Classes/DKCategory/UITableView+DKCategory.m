//
//  UITableView+DKCategory.m
//  GardenManager
//
//  Created by 王 on 2019/7/21.
//  Copyright © 2019 wisezone. All rights reserved.
//

#import "UITableView+DKCategory.h"
#import <DKProject/DKBaseEmptyView.h>
#import <objc/runtime.h>
#import <MJRefresh/MJRefresh.h>
#import "UIScrollView+DKCategory.h"

@interface UITableView ()
@property (nonatomic, assign, getter=isEndHeaderRefreshing) BOOL endHeaderRefreshing;
@end

@implementation UITableView (DKCategory)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Class targetClass = [self class];
        SEL originalReloadSelector = @selector(reloadData);
        SEL swizzledReloadSelector = @selector(dk_reloadData);
        SEL originalReloadSectionSelector = @selector(reloadSections:withRowAnimation:);
        SEL swizzledReloadSectionSelector = @selector(dk_reloadSections:withRowAnimation:);
        SEL originalReloadRowsSelector = @selector(reloadRowsAtIndexPaths:withRowAnimation:);
        SEL swizzledReloadRowsSelector = @selector(dk_reloadRowsAtIndexPaths:withRowAnimation:);
        SEL originalUpdatesSelector = @selector(endUpdates);
        SEL swizzledUpdatesSelector = @selector(dk_endUpdates);
        dk_tableView_swizzleMethod(targetClass, originalReloadSelector, swizzledReloadSelector);
        dk_tableView_swizzleMethod(targetClass, originalReloadSectionSelector, swizzledReloadSectionSelector);
        dk_tableView_swizzleMethod(targetClass, originalReloadRowsSelector, swizzledReloadRowsSelector);
        dk_tableView_swizzleMethod(targetClass, originalUpdatesSelector, swizzledUpdatesSelector);
    });
}

void dk_tableView_swizzleMethod(Class class, SEL originalSelector, SEL swizzledSelector) {
    Method originalMethod = class_getInstanceMethod(class, originalSelector);
    Method swizzledMethod = class_getInstanceMethod(class, swizzledSelector);
    
    IMP swizzledImp = method_getImplementation(swizzledMethod);
    char *swizzledTypes = (char *)method_getTypeEncoding(swizzledMethod);
    
    IMP originalImp = method_getImplementation(originalMethod);
    char *originalTypes = (char *)method_getTypeEncoding(originalMethod);
    
    BOOL success = class_addMethod(class, originalSelector, swizzledImp, swizzledTypes);
    if (success) {
        class_replaceMethod(class, swizzledSelector, originalImp, originalTypes);
    }else {
        // 添加失败，表明已经有这个方法，直接交换
        method_exchangeImplementations(originalMethod, swizzledMethod);
    }
}

- (void)dk_reloadData {
    [self dk_reloadData];
    dispatch_async(dispatch_get_main_queue(), ^{
        if (self.autoHideMjFooter) {
            [self setFooterShow];
        }
        [self setShowEmptyView];
    });
}

- (void)dk_reloadSections:(NSIndexSet *)sections withRowAnimation:(UITableViewRowAnimation)animation {
    [self dk_reloadSections:sections withRowAnimation:animation];
    dispatch_async(dispatch_get_main_queue(), ^{
        if (self.autoHideMjFooter) {
            [self setFooterShow];
        }
        [self setShowEmptyView];
    });
}

- (void)dk_reloadRowsAtIndexPaths:(NSArray<NSIndexPath *> *)indexPaths withRowAnimation:(UITableViewRowAnimation)animation {
    [self dk_reloadRowsAtIndexPaths:indexPaths withRowAnimation:animation];
    dispatch_async(dispatch_get_main_queue(), ^{
        if (self.autoHideMjFooter) {
            [self setFooterShow];
        }
        [self setShowEmptyView];
    });
}

- (void)dk_endUpdates {
    [self dk_endUpdates];
    dispatch_async(dispatch_get_main_queue(), ^{
        
    });
}

#pragma mark - 添加属性
static const char *autoHideMjFooterKey = "autoHideMjFooter";
- (void)setAutoHideMjFooter:(BOOL)autoHideMjFooter {
    objc_setAssociatedObject(self, autoHideMjFooterKey, @(autoHideMjFooter), OBJC_ASSOCIATION_ASSIGN);
}

- (BOOL)autoHideMjFooter{
    return [objc_getAssociatedObject(self, autoHideMjFooterKey) boolValue];
}

static const char *autoShowEmptyKey = "autoShowEmpty";
- (void)setAutoShowEmpty:(BOOL)autoShowEmpty {
    objc_setAssociatedObject(self, autoShowEmptyKey, @(autoShowEmpty), OBJC_ASSOCIATION_ASSIGN);
}

- (BOOL)isAutoShowEmpty{
    return [objc_getAssociatedObject(self, autoShowEmptyKey) boolValue];
}

static const char *emptyDatasKey = "emptyDatas";
- (void)setEmptyDatas:(BOOL)emptyDatas {
    objc_setAssociatedObject(self, emptyDatasKey, @(emptyDatas), OBJC_ASSOCIATION_ASSIGN);
}

- (BOOL)isEmptyDatas{
    return [objc_getAssociatedObject(self, emptyDatasKey) boolValue];
}

static const char *dk_endHeaderRefreshingKey = "dk_endHeaderRefreshing";
- (void)setEndHeaderRefreshing:(BOOL)endHeaderRefreshing {
    objc_setAssociatedObject(self, dk_endHeaderRefreshingKey, @(endHeaderRefreshing), OBJC_ASSOCIATION_ASSIGN);
}

- (BOOL)isEndHeaderRefreshing {
    return [objc_getAssociatedObject(self, dk_endHeaderRefreshingKey) boolValue];
}

static NSString * const dk_EmptyView = @"emptyView";
#pragma mark - Getter & Setter
- (DKBaseEmptyView *)dk_emptyView {
    return objc_getAssociatedObject(self, &dk_EmptyView);
}

- (void)setDk_emptyView:(DKBaseEmptyView *)dk_emptyView {
    dk_emptyView.tag = 999;
    objc_setAssociatedObject(self, &dk_EmptyView, dk_emptyView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

/**
 数据不满一页的话就自动隐藏下面的“上拉加载更多”或是"没有更多数据" 。
 */
- (void)setFooterShow {
    dispatch_async(dispatch_get_main_queue(), ^{
        CGFloat heightOfContentSize = self.contentSize.height; // 内容高度
        // 计算tableView实际显示范围
        // 先拿到tableView实际的contentInset (因为下拉刷新时mj会重设contentInset)
        UIEdgeInsets originContentInset = self.mj_header.scrollViewOriginalInset;
        CGFloat actualHeight = self.frame.size.height - originContentInset.top - originContentInset.bottom;
        // 修正footer对contenInset的影响
        if (!self.mj_footer.hidden) { // 没有隐藏
            actualHeight = actualHeight + self.mj_footer.frame.size.height + 10; // 默认的mj_footer高度为44  默认实际偏移了54
        }
        if (actualHeight >= heightOfContentSize) { // 实际显示高度大于内容高度 代表第一页都没有占满
            self.mj_footer.hidden = YES;
        } else {
            self.mj_footer.hidden = NO;
        }
    });
    
}

- (void)setShowEmptyView {
    if (!self.dk_emptyView) return;
    if (!self.isEndHeaderRefreshing && self.isAutoShowEmpty) return;
    UIView *view = [self viewWithTag:999];
    [view removeFromSuperview];

    if ((self.isAutoShowEmpty && [self emptyData_itemCount] == 0) || (!self.isAutoShowEmpty && self.isEmptyDatas)) {
        self.dk_emptyView.hidden = NO;
        [self insertSubview:self.dk_emptyView atIndex:0];
        self.dk_emptyView.frame = CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height);
    } else {
        self.dk_emptyView.hidden = YES;
        [self.dk_emptyView removeFromSuperview];
    }
}

- (NSInteger)emptyData_itemCount
{
    NSInteger items = 0;
    
    NSInteger sections = 1;
    if ([self.dataSource respondsToSelector:@selector(numberOfSectionsInTableView:)]) {
        sections = [self.dataSource numberOfSectionsInTableView:self];
    }
    
    for (NSInteger i = 0; i < sections; i++) {
        items += [self.dataSource tableView:self numberOfRowsInSection:i];
    }
    return items;
}

- (void)endHeaderRefresh {
    [super endHeaderRefresh];
    self.endHeaderRefreshing = YES;
    [self setShowEmptyView];
}

@end
