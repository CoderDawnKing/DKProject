//
//  DKBaseGroupListViewController.h
//  AFNetworking
//
//  Created by DawnKing on 2020/7/17.
//

#import "DKBaseTableViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface DKBaseGroupListViewController : DKBaseTableViewController

@property(nonatomic, strong) QMUIOrderedDictionary *dataSource;

- (NSString *)titleForSection:(NSInteger)section;
- (NSString *)keyNameAtIndexPath:(NSIndexPath *)indexPath;

@end

@interface DKBaseGroupListViewController (UISubclassingHooks)

// 子类继承，可以不调 super
- (void)initDataSource;
- (void)didSelectCellWithTitle:(NSString *)title;

@end

NS_ASSUME_NONNULL_END
