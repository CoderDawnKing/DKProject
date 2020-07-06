//
//  BaseViewController.h
//  GardenManager
//
//  Created by 王 on 2019/6/17.
//  Copyright © 2019 wisezone. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol DKBaseViewModelProtocol;
@class DKBaseModel;
@class DKBaseNaviController;
@class DKBaseTableView;

NS_ASSUME_NONNULL_BEGIN


typedef enum : NSUInteger {
    /// 顶部
    DKTableViewScrollTypeTop,
    /// 底部
    DKTableViewScrollTypeBottom
} DKTableViewScrollType;

@protocol DKBaseViewControllerProtocol <NSObject>

- (instancetype)initWithModel:(DKBaseModel *)model;
- (instancetype)initWithViewModel:(id <DKBaseViewModelProtocol>)viewModel;

- (void)__addSubViews;

- (void)__addViewModel;

- (void)__makeConstraints;
/** 更新约束 */
- (void)__updateConstraints;

@end

@interface DKBaseViewController : UIViewController<DKBaseViewControllerProtocol>

@property (nonatomic, strong) DKBaseNaviController *dk_Navi;

/** TableView */
@property (nonatomic, strong, nullable) DKBaseTableView *tableView;
/** 数据源 */
@property (nonatomic, strong) NSMutableArray *datasArrM;

///展示大标题
@property (nonatomic, assign, getter=isShowBigTitle) BOOL showBigTitle;

@end

NS_ASSUME_NONNULL_END
