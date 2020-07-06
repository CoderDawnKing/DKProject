//
//  DKBaseTableView.h
//  GardenManager
//
//  Created by 王 on 2019/6/19.
//  Copyright © 2019 wisezone. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol DKBaseViewModelProtocol;

NS_ASSUME_NONNULL_BEGIN

@protocol DKBaseTableViewProtocol <NSObject>

- (instancetype)initWithViewModel:(id<DKBaseViewModelProtocol>)viewModel style:(UITableViewStyle)style;

- (void)__addSubViews;

- (void)__addViewModel;

- (void)__makeConstraints;
/** 更新约束 */
- (void)__updateConstraints;

@end

@interface DKBaseTableView : UITableView<DKBaseTableViewProtocol>

@property (nonatomic, copy) void (^tableViewTouchsBeginBlock) (NSSet<UITouch *> *touches, UIEvent *event);

@end

NS_ASSUME_NONNULL_END
