//
//  DKMainListViewController.h
//  DKProject_Example
//
//  Created by DawnKing on 2020/7/15.
//  Copyright © 2020 wangshaoyu. All rights reserved.
//

#import <DKProject/DKProject.h>

NS_ASSUME_NONNULL_BEGIN

@protocol DKMainListViewControllerDelegate <NSObject>
@optional
- (void)dk_scrollViewDidScroll:(UIScrollView *)scrollView;
@end

@interface DKMainListViewController : DKBaseListViewController

@property (nonatomic, weak) id<DKMainListViewControllerDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
