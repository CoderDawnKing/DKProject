//
//  DKBaseListViewController.h
//  AFNetworking
//
//  Created by DawnKing on 2020/7/17.
//

#import "DKBaseTableViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface DKBaseListViewController : DKBaseTableViewController

@property(nonatomic, strong) NSArray<NSString *> *dataSource;
@property(nonatomic, strong) QMUIOrderedDictionary<NSString *, NSString *> *dataSourceWithDetailText;

@end

@interface DKBaseListViewController (UISubclassingHooks)

// 子类继承，可以不调super
- (void)initDataSource;
- (void)didSelectCellWithTitle:(NSString *)title;

@end

NS_ASSUME_NONNULL_END
