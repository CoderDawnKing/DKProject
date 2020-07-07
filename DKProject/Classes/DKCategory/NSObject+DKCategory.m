//
//  NSObject+DKCategory.m
//  GardenManager
//
//  Created by 王 on 2019/7/10.
//  Copyright © 2019 wisezone. All rights reserved.
//

#import "NSObject+DKCategory.h"
#import <objc/message.h>
@interface __DKKVOAutoremove: NSObject {
@public
    char _key;
}
@property (nonatomic, unsafe_unretained, nullable) id target;
@property (nonatomic, unsafe_unretained, nullable) id observer;
@property (nonatomic, weak, nullable) __DKKVOAutoremove *factor;
@property (nonatomic, copy, nullable) NSString *keyPath;
@end

@implementation __DKKVOAutoremove
- (void)dealloc {
    if ( _factor ) {
        [_target removeObserver:_observer forKeyPath:_keyPath];
        _factor = nil;
    }
}
@end

@implementation NSObject (DKCategory)

- (BOOL)dk_notEmpty {
    return !([self isKindOfClass:[NSNull class]] ||
             ([self respondsToSelector:@selector(length)] && [self performSelector:@selector(length)] == 0) ||
             ([self respondsToSelector:@selector(count)] && [self performSelector:@selector(count)] == 0));
}

- (UIViewController *)dk_getCurrentController {
    UIViewController *currentViewController = [self dk_getRootController];//获取根视图UIWindow.rootViewController
    
    while (1) {
        //使控制器呈现的方法有两种：UINavigationController的push 、 UIViewController的present
        if (currentViewController.presentedViewController){//判断当前控制器是否t以present方式呈现
            
            currentViewController = currentViewController.presentedViewController;
        } else if ([currentViewController isKindOfClass:[UITabBarController class]]){//判断是否为UITabBarController对象
            
            UITabBarController *tabBarController =(UITabBarController *)currentViewController;
            currentViewController = tabBarController.selectedViewController;
        } else if ([currentViewController isKindOfClass:[UINavigationController class]]){//判断是否为UINavigationControler对象
            UINavigationController* navigationController = (UINavigationController* )currentViewController;
            currentViewController = navigationController.visibleViewController;
        } else {
            NSUInteger childViewControllerCount = currentViewController.childViewControllers.count;
            if(childViewControllerCount > 0){//判断当前控制器是否有子控制器
                currentViewController = currentViewController.childViewControllers.lastObject;//取其子控制器栈顶对象
            }
            break;
        }
    }
    
    return currentViewController;
}

- (UIViewController *)dk_getRootController{
    UIWindow *window = [[[UIApplication sharedApplication] delegate] window];
    NSAssert(window, @"The window is empty");
    return window.rootViewController;
}

- (void)dk_addObserver:(NSObject *)observer forKeyPath:(NSString *)keyPath {
    [self dk_addObserver:observer forKeyPath:keyPath context:NULL];
}

- (void)dk_addObserver:(NSObject *)observer forKeyPath:(NSString *)keyPath context:(nullable void *)context {
    [self dk_addObserver:observer forKeyPath:keyPath options:NSKeyValueObservingOptionOld | NSKeyValueObservingOptionNew context:context];
}

- (void)dk_addObserver:(NSObject *)observer forKeyPath:(NSString *)keyPath options:(NSKeyValueObservingOptions)options context:(nullable void *)context {
    NSParameterAssert(observer);
    NSParameterAssert(keyPath);
    
    if ( !observer || !keyPath ) return;
    
    NSString *hashstr = [NSString stringWithFormat:@"%lu-%@", (unsigned long)[observer hash], keyPath];
    
    @synchronized (self) {
        if ( [[self dk_observerhashSet] containsObject:hashstr] ) return;
        else [[self dk_observerhashSet] addObject:hashstr];
    }
    
    [self addObserver:observer forKeyPath:keyPath options:options context:context];
    
    __DKKVOAutoremove *helper = [__DKKVOAutoremove new];
    __DKKVOAutoremove *sub = [__DKKVOAutoremove new];
    
    sub.target = helper.target = self;
    sub.observer = helper.observer = observer;
    sub.keyPath = helper.keyPath = keyPath;
    
    helper.factor = sub;
    sub.factor = helper;
    
    __weak typeof(self) _self = self;
    [observer dk_addDeallocCallbackTask:^(id  _Nonnull obj) {
        __strong typeof(_self) self = _self;
        if ( !self ) return;
        @synchronized (self) {
            [[self dk_observerhashSet] removeObject:hashstr];
        }
    }];
    
    objc_setAssociatedObject(self, &helper->_key, helper, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    objc_setAssociatedObject(observer, &sub->_key, sub, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSMutableSet<NSString *> *)dk_observerhashSet {
    NSMutableSet<NSString *> *set = objc_getAssociatedObject(self, _cmd);
    if ( set ) return set;
    set = [NSMutableSet set];
    objc_setAssociatedObject(self, _cmd, set, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    return set;
}

@end

#pragma mark - Notification
@implementation NSObject (DKNotificationHelper)
- (void)dk_observeWithNotification:(NSNotificationName)notification target:(id _Nullable)target usingBlock:(void(^)(id self, NSNotification *note))block {
    [self dk_observeWithNotification:notification target:target queue:NSOperationQueue.mainQueue usingBlock:block];
}
- (void)dk_observeWithNotification:(NSNotificationName)notification target:(id _Nullable)target queue:(NSOperationQueue *_Nullable)queue usingBlock:(void(^)(id self, NSNotification *note))block {
    __weak typeof(self) _self = self;
    id token = [NSNotificationCenter.defaultCenter addObserverForName:notification object:target queue:queue usingBlock:^(NSNotification * _Nonnull note) {
        __strong typeof(_self) self = _self;
        if ( !self ) return;
        if ( block ) block(self, note);
    }];
    
    [self dk_addDeallocCallbackTask:^(id  _Nonnull obj) {
        [NSNotificationCenter.defaultCenter removeObserver:token];
    }];
}
@end


#pragma mark - DKDeallocCallback
@interface __DKDeallockCallback : NSObject {
@public
    char _key;
}
@property (nonatomic, unsafe_unretained, nullable) id target;
@property (nonatomic, copy, nullable) DKDeallockCallbackTask task;
@end

@implementation __DKDeallockCallback
- (void)dealloc {
    if ( _task ) _task(_target);
}
@end

@implementation NSObject (DKDeallocCallback)
- (void)dk_addDeallocCallbackTask:(DKDeallockCallbackTask)block {
    __DKDeallockCallback *callback = [__DKDeallockCallback new];
    callback.target = self;
    callback.task = block;
    objc_setAssociatedObject(self, &callback->_key, callback, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
@end

@interface __DKKVOObserver : NSObject {
@public
    char _key;
}
@property (nonatomic, unsafe_unretained, readonly) id target;
@property (nonatomic, copy, readonly) NSString *keyPath;
@property (nonatomic, readonly) NSKeyValueObservingOptions options;
@property (nonatomic, copy, readonly) DKKVOObservedChangeHandler hanlder;
@end
@implementation __DKKVOObserver
- (instancetype)initWithTarget:(__unsafe_unretained id)target
                    forKeyPath:(NSString *)keyPath
                       options:(NSKeyValueObservingOptions)options
                        change:(DKKVOObservedChangeHandler)hanlder {
    self = [super init];
    if ( !self ) return nil;
    _target = target;
    _keyPath = [keyPath copy];
    _hanlder = hanlder;
    [_target addObserver:self forKeyPath:keyPath options:options context:NULL];
    return self;
}
- (void)dealloc {
    @try {
        [_target removeObserver:self forKeyPath:_keyPath];
    } @catch (NSException *__unused exception) { }
}
- (void)observeValueForKeyPath:(nullable NSString *)keyPath ofObject:(nullable id)object change:(nullable NSDictionary<NSKeyValueChangeKey,id> *)change context:(nullable void *)context {
    if ( _hanlder ) _hanlder(object, change);
}
@end

DKKVOObserverToken
dkkvo_observe(id target, NSString *keyPath, DKKVOObservedChangeHandler handler) {
    return dkkvo_observe(target, keyPath, NSKeyValueObservingOptionInitial | NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld, handler);
}

DKKVOObserverToken __attribute__((overloadable))
dkkvo_observe(id target, NSString *keyPath, NSKeyValueObservingOptions options, DKKVOObservedChangeHandler handler) {
    if ( !target )
        return 0;
    __DKKVOObserver *observer = [[__DKKVOObserver alloc] initWithTarget:target forKeyPath:keyPath options:options change:handler];
    objc_setAssociatedObject(target, &observer->_key, observer, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    return (DKKVOObserverToken)&observer->_key;
}

void
dkkvo_remove(id target, DKKVOObserverToken token) {
    objc_setAssociatedObject(target, (void *)token, nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
