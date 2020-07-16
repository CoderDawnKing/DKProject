//
//  DKBaseGridViewController.h
//  AFNetworking
//
//  Created by DawnKing on 2020/7/17.
//

#import "DKBaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface DKBaseGridViewController : DKBaseViewController

@property(nonatomic, strong) QMUIOrderedDictionary<NSString *, UIImage *> *dataSource;
@property(nonatomic, strong, readonly) UIScrollView *scrollView;
@property(nonatomic, strong, readonly) QMUIGridView *gridView;

@end

@interface DKBaseGridViewController (UISubclassingHooks)

// 子类继承，可以不调super
- (void)initDataSource;
- (void)didSelectCellWithTitle:(NSString *)title;
@end

NS_ASSUME_NONNULL_END
