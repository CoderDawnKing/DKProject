//
//  DKBaseTableViewController.m
//  GardenManager
//
//  Created by 王 on 2019/7/13.
//  Copyright © 2019 wisezone. All rights reserved.
//

#import "DKBaseTableViewController.h"
#import <DKProject/DKProject.h>

@interface DKBaseTableViewController ()

@property (nonatomic, strong) UIView *navigationBarLargeTitleView;
@property (nonatomic, strong) UIView *barBackgroundView;
@property (nonatomic, strong) UILabel *largeTitleLabel;

@end

@implementation DKBaseTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = dk_HexColor(COLOR_WHITE);
    DKBaseTableView *baseTableView = [[DKBaseTableView alloc] initWithFrame:self.tableView.frame style:self.tableViewStyle];
    self.tableView = baseTableView;
    [self __addSubViews];
    [self __makeConstraints];
    [self __addViewModel];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.dk_Navi.navigationBarHidden = NO;
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    if (@available (iOS 13.0, *)) {
        if (self.showBigTitle && !self.largeTitleLabel) {
            for (UIView *view in self.dk_Navi.navigationBar.subviews) {
                if ([view isKindOfClass:NSClassFromString(@"_UINavigationBarLargeTitleView")]) {
                    for (UIView *largeTitleLabel1 in view.subviews) {
                        if ([largeTitleLabel1 isKindOfClass:[UILabel class]]) {
                            largeTitleLabel1.hidden = NO;
                            self.largeTitleLabel = (UILabel *)largeTitleLabel1;
                        } else {
                            for (UIView *largeTitleLabel2 in largeTitleLabel1.subviews) {
                                if ([largeTitleLabel2 isKindOfClass:[UILabel class]]) {
                                    largeTitleLabel2.hidden = NO;
                                    self.largeTitleLabel = (UILabel *)largeTitleLabel2;
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    self.navigationBarLargeTitleView.backgroundColor = dk_ClearColor;
    self.barBackgroundView.backgroundColor = dk_ClearColor;
    self.largeTitleLabel.hidden = YES;
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    if (@available (iOS 13.0, *)) {
        // iOS 13 将背景色改成透明了
        if (self.showBigTitle) {
            for (UIView *view in self.dk_Navi.navigationBar.subviews) {
                if ([view isKindOfClass:NSClassFromString(@"_UINavigationBarLargeTitleView")]) {
                    view.backgroundColor = dk_HexColor(COLOR_WHITE);
                    self.navigationBarLargeTitleView = view;
                    for (UIView *largeTitleLabel1 in view.subviews) {
                        if ([largeTitleLabel1 isKindOfClass:[UILabel class]]) {
                            largeTitleLabel1.hidden = NO;
                            self.largeTitleLabel = (UILabel *)largeTitleLabel1;
                        } else {
                            for (UIView *largeTitleLabel2 in largeTitleLabel1.subviews) {
                                if ([largeTitleLabel2 isKindOfClass:[UILabel class]]) {
                                    largeTitleLabel2.hidden = NO;
                                    self.largeTitleLabel = (UILabel *)largeTitleLabel2;
                                }
                            }
                        }
                    }
                }
                if ([view isKindOfClass:NSClassFromString(@"_UIBarBackground")]) {
                    view.backgroundColor = dk_HexColor(COLOR_WHITE);
                    self.barBackgroundView = view;
                }
            }
            for (UIView *transitionView in self.dk_Navi.view.subviews) {
                if ([transitionView isKindOfClass:NSClassFromString(@"UINavigationTransitionView")]) {
                    for (UIView * wrapperView in transitionView.subviews) {
                        if ([wrapperView isKindOfClass:NSClassFromString(@"UIViewControllerWrapperView")]) {
                            for (UIView *view in wrapperView.subviews) {
                                view.backgroundColor = dk_HexColor(COLOR_WHITE);
                            }
                        }
                    }
                }
            }
        }
    }
}

- (instancetype)initWithViewModel:(id<DKBaseViewModelProtocol>)viewModel {
    if (self = [super init]) {}
    return self;
}

- (instancetype)initWithModel:(DKBaseModel *)model {
    if (self = [super init]) {}
    return self;
}

/** 加载子视图 */
- (void)__addSubViews {}

/** 添加模型 */
- (void)__addViewModel {}

/** 布置约束 */
- (void)__makeConstraints {}

/** 更新约束 */
- (void)__updateConstraints{}

#pragma - mark method

#pragma - mark 添加手势
- (void)addLongPressWithCell:(DKBaseTableViewCell *)cell indexPath:(NSIndexPath *)indexPath {
    [cell.contentView addGestureRecognizer:self.longPress];
}

#pragma mark - 对cell进行截图，并且隐藏
-(void)snapshotCellAtIndexPath:(NSIndexPath *)indexPath{
    DKBaseTableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
    /// 截图
    UIView *snapshot = [self snapshotView:cell];
    /// 添加在UITableView上
    [self.tableView addSubview:snapshot];
    self.snapshotView = snapshot;
    /// 隐藏cell
    cell.hidden = YES;
    CGPoint center = self.snapshotView.center;
    center.y = self.longLocation.y;
    /// 移动截图
    [UIView animateWithDuration:0.3 animations:^{
        self.snapshotView.transform = CGAffineTransformMakeScale(1.03, 1.03);
        self.snapshotView.alpha = 0.98;
        self.snapshotView.center = center;
    }];
}

#pragma mark - 截图对应的cell
- (UIView *)snapshotView:(UIView *)inputView {
    // Make an image from the input view.
    UIGraphicsBeginImageContextWithOptions(inputView.bounds.size, NO, 0);
    [inputView.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    // Create an image view.
    UIView *snapshot = [[UIImageView alloc] initWithImage:image];
    snapshot.center = inputView.center;
    snapshot.layer.masksToBounds = NO;
    snapshot.layer.cornerRadius = 0.0;
    snapshot.layer.shadowOffset = CGSizeMake(-5.0, 0.0);
    snapshot.layer.shadowRadius = 5.0;
    snapshot.layer.shadowOpacity = 0.4;
    
    return snapshot;
}

#pragma mark - 长按手势
-(void)longPressGestureRecognized:(UILongPressGestureRecognizer *)longPress {
    UIGestureRecognizerState longPressState = longPress.state;
    //长按的cell在tableView中的位置
    self.longLocation = [longPress locationInView:self.tableView];
    //手指按住位置对应的indexPath，可能为nil
    self.newestIndexPath = [self.tableView indexPathForRowAtPoint:self.longLocation];
    switch (longPressState) {
        case UIGestureRecognizerStateBegan:{
            //手势开始，对被选中cell截图，隐藏原cell
            self.oldIndexPath = [self.tableView indexPathForRowAtPoint:self.longLocation];
            if (self.oldIndexPath) {
                [self snapshotCellAtIndexPath:self.oldIndexPath];
            }
            break;
        }
        case UIGestureRecognizerStateChanged:{//点击位置移动，判断手指按住位置是否进入其它indexPath范围，若进入则更新数据源并移动cell
            //截图跟随手指移动
            CGPoint center = _snapshotView.center;
            center.y = self.longLocation.y;
            self.snapshotView.center = center;
            if ([self checkIfSnapshotMeetsEdge]) {
                [self startAutoScrollTimer];
            }else{
                [self stopAutoScrollTimer];
            }
            //手指按住位置对应的indexPath，可能为nil
            self.newestIndexPath = [self.tableView indexPathForRowAtPoint:self.longLocation];
            if (self.newestIndexPath && ![self.newestIndexPath isEqual:self.oldIndexPath]) {
                [self cellRelocatedToNewIndexPath:self.newestIndexPath];
            }
            break;
        }
        default: {
            //长按手势结束或被取消，移除截图，显示cell
            [self stopAutoScrollTimer];
            [self didEndDraging];
            break;
        }
    }
}

#pragma mark - 检查截图是否到达边缘，并作出响应
- (BOOL)checkIfSnapshotMeetsEdge{
    CGFloat minY = CGRectGetMinY(self.snapshotView.frame);
    CGFloat maxY = CGRectGetMaxY(self.snapshotView.frame);
    if (minY < self.tableView.contentOffset.y) {
        self.scrollType = DKTableViewScrollTypeTop;
        return YES;
    }
    if (maxY > self.tableView.bounds.size.height + self.tableView.contentOffset.y) {
        self.scrollType = DKTableViewScrollTypeBottom;
        return YES;
    }
    return NO;
}

#pragma mark - 当截图到了新的位置，先改变数据源，然后将cell移动过去
- (void)cellRelocatedToNewIndexPath:(NSIndexPath *)indexPath{
    //判断是否头部锁定
    if (!indexPath.section && !indexPath.row && self.lockHead) {
        self.newestIndexPath = indexPath = [NSIndexPath indexPathForRow:1 inSection:0];
    }
    //判断是否脚部锁定
    if ((indexPath.section == self.datasArrM.count - 1) && (indexPath.row == [self.datasArrM[indexPath.section] count] - 1) && self.lockFoot) {
        self.newestIndexPath = indexPath = [NSIndexPath indexPathForRow:[self.datasArrM[indexPath.section] count] - 2 inSection:self.datasArrM.count - 1];
    }
    //更新数据源并返回给外部
    [self updateData];
    //交换移动cell位置
    [self.tableView moveRowAtIndexPath:self.oldIndexPath toIndexPath:indexPath];
    //更新cell的原始indexPath为当前indexPath
    self.oldIndexPath = indexPath;
    
    DKBaseTableViewCell *cell = [self.tableView cellForRowAtIndexPath:_oldIndexPath];
    cell.hidden = YES;
}

#pragma mark - 更新数据源
-(void)updateData {
    //通过DataSource代理获得原始数据源数组
    NSMutableArray *tempArray = self.datasArrM;
    //判断原始数据源是否为多重数组
    if ([self arrayCheck:tempArray]) {//是嵌套数组
        if (self.oldIndexPath.section == self.newestIndexPath.section) {//在同一个section内
            [self moveObjectInMutableArray:tempArray[self.oldIndexPath.section] fromIndex:self.oldIndexPath.row toIndex:self.newestIndexPath.row];
        }else{                                                          //不在同一个section内
            id originalObj = tempArray[self.oldIndexPath.section][self.oldIndexPath.item];
            [tempArray[self.newestIndexPath.section] insertObject:originalObj atIndex:self.newestIndexPath.item];
            [tempArray[self.oldIndexPath.section] removeObjectAtIndex:self.oldIndexPath.item];
        }
    }else{                                  //不是嵌套数组
        [self moveObjectInMutableArray:tempArray fromIndex:self.oldIndexPath.row toIndex:self.newestIndexPath.row];
    }
}

#pragma mark - 检测是否是多重数组
- (BOOL)arrayCheck:(NSArray *)array{
    for (id obj in array) {
        if ([obj isKindOfClass:[NSArray class]]) {
            return YES;
        }
    }
    return NO;
}

#pragma mark - 将可变数组中的一个对象移动到该数组中的另外一个位置
- (void)moveObjectInMutableArray:(NSMutableArray *)array fromIndex:(NSInteger)fromIndex toIndex:(NSInteger)toIndex{
    if (fromIndex < toIndex) {
        for (NSInteger i = fromIndex; i < toIndex; i ++) {
            [array exchangeObjectAtIndex:i withObjectAtIndex:i + 1];
        }
    }else{
        for (NSInteger i = fromIndex; i > toIndex; i --) {
            [array exchangeObjectAtIndex:i withObjectAtIndex:i - 1];
        }
    }
}

#pragma mark - 开始自动滚动
- (void)startAutoScroll {
    CGFloat pixelSpeed = 4;
    if (self.scrollType == DKTableViewScrollTypeTop) {//向下滚动
        if (self.tableView.contentOffset.y > 0) {//向下滚动最大范围限制
            [self.tableView setContentOffset:CGPointMake(0, self.tableView.contentOffset.y - pixelSpeed)];
            self.snapshotView.center = CGPointMake(self.snapshotView.center.x, self.snapshotView.center.y - pixelSpeed);
        }
    }else{                                               //向上滚动
        if (self.tableView.contentOffset.y + self.tableView.bounds.size.height < self.tableView.contentSize.height) {//向下滚动最大范围限制
            [self.tableView setContentOffset:CGPointMake(0, self.tableView.contentOffset.y + pixelSpeed)];
            self.snapshotView.center = CGPointMake(self.snapshotView.center.x, self.snapshotView.center.y + pixelSpeed);
        }
    }
    
    ///  当把截图拖动到边缘，开始自动滚动，如果这时手指完全不动，则不会触发‘UIGestureRecognizerStateChanged’，对应的代码就不会执行，导致虽然截图在tableView中的位置变了，但并没有移动那个隐藏的cell，用下面代码可解决此问题，cell会随着截图的移动而移动
    self.newestIndexPath = [self.tableView indexPathForRowAtPoint:self.snapshotView.center];
    if (self.newestIndexPath && ![self.newestIndexPath isEqual:self.oldIndexPath]) {
        [self cellRelocatedToNewIndexPath:self.newestIndexPath];
    }
}

#pragma mark - 拖拽结束，显示cell，并移除截图
- (void)didEndDraging{
    DKBaseTableViewCell *cell = [self.tableView cellForRowAtIndexPath:self.oldIndexPath];
    cell.hidden = NO;
    cell.alpha = 0;
    [UIView animateWithDuration:0.3 animations:^{
        self.snapshotView.center = cell.center;
        self.snapshotView.alpha = 0;
        self.snapshotView.transform = CGAffineTransformIdentity;
        cell.alpha = 1;
    } completion:^(BOOL finished) {
        cell.hidden = NO;
        [self.snapshotView removeFromSuperview];
        self.snapshotView = nil;
        self.oldIndexPath = nil;
        self.newestIndexPath = nil;
        
        [self.tableView reloadData];
    }];
}

#pragma mark - 创建定时器
- (void)startAutoScrollTimer {
    if (!self.scrollTimer) {
        self.scrollTimer = [CADisplayLink displayLinkWithTarget:self selector:@selector(startAutoScroll)];
        [self.scrollTimer addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
    }
}

#pragma mark - 销毁定时器
- (void)stopAutoScrollTimer {
    if (self.scrollTimer) {
        [self.scrollTimer invalidate];
        self.scrollTimer = nil;
    }
}

#pragma - mark lazy
- (DKBaseNaviController *)dk_Navi {
    if (!_dk_Navi) {
        _dk_Navi = (DKBaseNaviController *)self.navigationController;
    }
    return _dk_Navi;
}

- (UILongPressGestureRecognizer *)longPress {
    return [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressGestureRecognized:)];
}

- (void)setShowBigTitle:(BOOL)showBigTitle {
    
    DKBaseNaviController *navi = (DKBaseNaviController *)self.navigationController;
    navi.hiddenShadowImage = _showBigTitle = showBigTitle;
    
    
    if (@available(iOS 11.0, *)) {
        self.navigationController.navigationBar.prefersLargeTitles = _showBigTitle;
        self.navigationItem.largeTitleDisplayMode = _showBigTitle ? UINavigationItemLargeTitleDisplayModeAlways : UINavigationItemLargeTitleDisplayModeNever;
    } else {
        // Fallback on earlier versions
    }
}

@end
