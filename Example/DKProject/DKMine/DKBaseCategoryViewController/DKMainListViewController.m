//
//  DKMainListViewController.m
//  DKProject_Example
//
//  Created by DawnKing on 2020/7/15.
//  Copyright © 2020 wangshaoyu. All rights reserved.
//

#import "DKMainListViewController.h"
#import "DKMainCategoryViewController.h"

@interface DKMainListViewController ()

@property(nonatomic, strong) NSArray *dataSource;

@end

@implementation DKMainListViewController

- (void)initDataSource {
    NSMutableArray *arrayM = [NSMutableArray array];
    for (int i = 0; i < 30; i ++) {
        [arrayM addObject:[NSString stringWithFormat:@"%d", i]];
    }
    self.dataSource = arrayM.mutableCopy;
}

- (instancetype)initWithStyle:(UITableViewStyle)style {
    if (self = [super initWithStyle:style]) {
        [self initDataSource];
    }
    return self;
}

#pragma mark - UITableView Delegate & DataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *identifier = @"normal";
    QMUITableViewCell *cell = nil;
    cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[QMUITableViewCell alloc] initForTableView:tableView withStyle:UITableViewCellStyleValue1 reuseIdentifier:identifier];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    cell.textLabel.text = [self.dataSource objectAtIndex:indexPath.row];
    cell.textLabel.font = UIFontMake(15);
    cell.detailTextLabel.font = UIFontMake(13);
    [cell updateCellAppearanceWithIndexPath:indexPath];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return TableViewCellNormalHeight;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
//    NSString *title = [self.dataSource objectAtIndex:indexPath.row];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if ([self.scrollDelegate respondsToSelector:@selector(dk_scrollViewDidScroll:)]) {
        [self.scrollDelegate dk_scrollViewDidScroll:scrollView];
    }
}


@end
