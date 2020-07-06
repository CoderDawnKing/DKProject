//
//  DKBaseTableViewController.h
//  GardenManager
//
//  Created by 王 on 2019/7/13.
//  Copyright © 2019 wisezone. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DKBaseViewController.h"

@class DKBaseTableViewCell;
@class DKBaseNaviController;
@class DKBaseModel;
@protocol DKBaseViewModelProtocol;

NS_ASSUME_NONNULL_BEGIN

@protocol DKBaseTableViewControllerProtocol <NSObject>

- (instancetype)initWithModel:(DKBaseModel *)model;
- (instancetype)initWithViewModel:(id <DKBaseViewModelProtocol>)viewModel;

- (void)__addSubViews;

- (void)__addViewModel;

- (void)__makeConstraints;
/** 更新约束 */
- (void)__updateConstraints;

@end

@interface DKBaseTableViewController : UITableViewController<DKBaseTableViewControllerProtocol>

@property (nonatomic, strong) DKBaseNaviController *dk_Navi;

@property (nonatomic, assign) UITableViewStyle tableViewStyle;
/** 数据源 添加长按拖动，分区元素必须为可变数组，最好 */
@property (nonatomic, strong) NSMutableArray *datasArrM;
/** 记录手指所在的位置 */
@property (nonatomic, assign) CGPoint longLocation;
/** 对被选中的cell的截图 */
@property (nonatomic, strong, nullable) UIView *snapshotView;
/** 被选中的cell的原始位置 */
@property (nonatomic, strong, nullable) NSIndexPath *oldIndexPath;
/** 被选中的cell的新位置 */
@property (nonatomic, strong, nullable) NSIndexPath *newestIndexPath;
/** 定时器 */
@property (nonatomic, strong, nullable) CADisplayLink *scrollTimer;
/** 长按手势 */
@property (nonatomic, strong) UILongPressGestureRecognizer *longPress;
/** 滚动方向 */
@property (nonatomic, assign) DKTableViewScrollType scrollType;
/** 锁定头不能拖动,且cell无法拖动到头部以上 */
@property (nonatomic, assign, getter=isLockHead) BOOL lockHead;
/** 锁定脚不能拖动,且cell无法拖动到脚部以下 */
@property (nonatomic, assign, getter=isLockFoot) BOOL lockFoot;

///展示大标题
@property (nonatomic, assign, getter=isShowBigTitle) BOOL showBigTitle;

/**
 给 cell 添加长按手势
 */
- (void)addLongPressWithCell:(DKBaseTableViewCell *)cell indexPath:(NSIndexPath *)indexPath;
-(void)showAlertTitleMessage:(NSString *)Message;//加粗，标题显示
-(void)showAlertMessage:(NSString *)Message;
-(void)RequestCamera:(void(^)(BOOL success))block;

- (void)tapDismissAction:(UITapGestureRecognizer *)tap;


@end

NS_ASSUME_NONNULL_END
