//
//  NSObject+DKCategory.h
//  GardenManager
//
//  Created by 王 on 2019/7/10.
//  Copyright © 2019 wisezone. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^DKDeallockCallbackTask)(id obj);
typedef void(^DKKVOObservedChangeHandler)(id target, NSDictionary<NSKeyValueChangeKey,id> *_Nullable change);
typedef NSInteger DKKVOObserverToken;

/// - KVO -
/// Add Observer (autoremove) [target, keyPath, change]
extern DKKVOObserverToken
dkkvo_observe(id target, NSString *keyPath, DKKVOObservedChangeHandler handler);

/// Add Observer (autoremove) [target, keyPath, options, change]
extern DKKVOObserverToken __attribute__((overloadable))
dkkvo_observe(id target, NSString *keyPath, NSKeyValueObservingOptions options, DKKVOObservedChangeHandler handler);

/// Remove Observer
extern void
dkkvo_remove(id target, DKKVOObserverToken token);

@interface NSObject (DKCategory)

///判断是不是空对象（字符串或二进制数据长度为0，集合的元素数量为0）
- (BOOL)dk_notEmpty;

///获取当前控制器
- (UIViewController *)dk_getCurrentController;

/// Add an observer, you don't need to remove observer (autoremove)
/// 添加观察者, 无需移除 (将会自动移除)
- (void)dk_addObserver:(NSObject *)observer forKeyPath:(NSString *)keyPath;

/// Add an observer, you don't need to remove observer (autoremove)
/// 添加观察者, 无需移除 (将会自动移除)
- (void)dk_addObserver:(NSObject *)observer forKeyPath:(NSString *)keyPath context:(nullable void *)context;

/// Add an observer, you don't need to remove observer (autoremove)
/// 添加观察者, 无需移除 (将会自动移除)
- (void)dk_addObserver:(NSObject *)observer forKeyPath:(NSString *)keyPath options:(NSKeyValueObservingOptions)options context:(nullable void *)context;

@end

/// - Notification -
@interface NSObject (DKNotificationHelper)
/// Autoremove
- (void)dk_observeWithNotification:(NSNotificationName)notification target:(id _Nullable)sender usingBlock:(void(^)(id self, NSNotification *note))block;

/// Autoremove
- (void)dk_observeWithNotification:(NSNotificationName)notification target:(id _Nullable)sender queue:(NSOperationQueue *_Nullable)queue usingBlock:(void(^)(id self, NSNotification *note))block;
@end

/// - DeallocCallback -
@interface NSObject (DKDeallocCallback)
/// Add a task that will be executed when the object is destroyed
/// 添加一个任务, 当对象销毁时将会执行这些任务
- (void)dk_addDeallocCallbackTask:(DKDeallockCallbackTask)callback;
@end

NS_ASSUME_NONNULL_END
