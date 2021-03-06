//
//  UITableView+DKCategory.h
//  GardenManager
//
//  Created by 王 on 2019/7/21.
//  Copyright © 2019 wisezone. All rights reserved.
//



NS_ASSUME_NONNULL_BEGIN

@interface UITableView (DKCategory)

/**是否开启<数据不满一页的话就自动隐藏下面的mj_footer>功能*/
@property (nonatomic, assign, getter=isAutoHideMjFooter) BOOL autoHideMjFooter;
/** 是否开启自动显示空界面 */
@property (nonatomic, assign, getter=isAutoShowEmpty) BOOL autoShowEmpty;

@end

NS_ASSUME_NONNULL_END
