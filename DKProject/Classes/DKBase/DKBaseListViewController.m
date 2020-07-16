//
//  DKBaseListViewController.m
//  AFNetworking
//
//  Created by DawnKing on 2020/7/17.
//

#import "DKBaseListViewController.h"

@interface DKBaseListViewController ()

@end

@implementation DKBaseListViewController

- (instancetype)initWithStyle:(UITableViewStyle)style {
    if (self = [super initWithStyle:style]) {
        [self initDataSource];
    }
    return self;
}

#pragma mark - UITableView Delegate & DataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSourceWithDetailText ? self.dataSourceWithDetailText.count : self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *identifier = nil;
    QMUITableViewCell *cell = nil;
    if (self.dataSourceWithDetailText) {
        identifier = @"subtitle";
    } else {
        identifier = @"normal";
    }
    cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        if ([identifier isEqualToString:@"subtitle"]) {
            cell = [[QMUITableViewCell alloc] initForTableView:tableView withStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
        } else {
            cell = [[QMUITableViewCell alloc] initForTableView:tableView withStyle:UITableViewCellStyleValue1 reuseIdentifier:identifier];
        }
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    if ([identifier isEqualToString:@"subtitle"]) {
        NSString *keyName = self.dataSourceWithDetailText.allKeys[indexPath.row];
        cell.textLabel.text = keyName;
        cell.detailTextLabel.text = (NSString *)[self.dataSourceWithDetailText objectForKey:keyName];
    } else {
        cell.textLabel.text = [self.dataSource objectAtIndex:indexPath.row];
    }
    cell.textLabel.font = UIFontMake(15);
    cell.detailTextLabel.font = UIFontMake(13);
    [cell updateCellAppearanceWithIndexPath:indexPath];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.dataSourceWithDetailText && ((NSString *)[self.dataSourceWithDetailText objectForKey:self.dataSourceWithDetailText.allKeys[indexPath.row]]).length) {
        return 64;
    }
    return TableViewCellNormalHeight;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *title = nil;
    if (self.dataSourceWithDetailText) {
        title = self.dataSourceWithDetailText.allKeys[indexPath.row];
    } else {
        title = [self.dataSource objectAtIndex:indexPath.row];
    }
    [self didSelectCellWithTitle:title];
}

@end

@implementation DKBaseListViewController (UISubclassingHooks)

- (void)initDataSource {
}

- (void)didSelectCellWithTitle:(NSString *)title {
}

@end
