//
//  DKBaseEditTextFieldViewController.m
//  GardenManager
//
//  Created by 王 on 2019/7/11.
//  Copyright © 2019 wisezone. All rights reserved.
//

#import "DKBaseEditTextFieldViewController.h"
#import <DKProject/DKProject.h>

@interface DKBaseEditTextFieldViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITextField *tf;
@end

@implementation DKBaseEditTextFieldViewController

@synthesize tableView = _tableView;

- (instancetype)init {
    if (self = [super init]) {
        self.headerHeight = 0.0001;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithTarget:self action:@selector(saveClick) title:@"保存"];
}

- (void)__addSubViews {
    [self.view addSubview:self.tableView];
}

- (void)__makeConstraints {
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(0);
    }];
}

- (void)__addViewModel {}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self.tf becomeFirstResponder];
}


#pragma UITableView DataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *ident = @"DKBaseTableViewCell";
    DKBaseTableViewCellType type = DKBaseTableViewCellTypeTextField;
    DKBaseTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ident];
    if (!cell) {
        cell = [DKBaseTableViewCell cellWithType:type ident:ident];
        cell.bottomLine.hidden = YES;
    }
    
    cell.textField.text = self.context;
    cell.textField.placeholder = self.placeholder;
    cell.textField.keyboardType = self.keyboardType;
    self.tf = cell.textField;
    return cell;
}

#pragma UITableView Delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *header = [UIView new];
    return header;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return self.headerHeight;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    UIView *footer = [UIView new];
    if (self.prompt.dk_notEmpty) {
        UILabel *label = [UILabel new];
        label.font = [UIFont pfRegularWithSize:12];
        label.textColor = dk_HexColor(DK_COLOR_888888);
        label.numberOfLines = 0;
        label.text = self.prompt;
        [footer addSubview:label];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(UIEdgeInsetsMake(10, dk_leftMargin, 10, dk_rightMargin));
        }];
    }
    return footer;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return UITableViewAutomaticDimension;
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForFooterInSection:(NSInteger)section {
    return 0.0001;
}

#pragma - mark lazy
- (DKBaseTableView *)tableView {
    if (!_tableView) {
        _tableView = [[DKBaseTableView alloc] initWithFrame:CGRectMake(0, 0, 0, 0) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.scrollEnabled = NO;
    }
    return _tableView;
}

- (void)setTf:(UITextField *)tf {
    _tf = tf;
    @weakify(self);
    [self.tf.rac_textSignal subscribeNext:^(NSString * _Nullable x) {
        @strongify(self);
        if (self.isCanEmpty) {
            self.navigationItem.rightBarButtonItem.enabled = ![x isEqualToString:self.context];
        } else {
            self.navigationItem.rightBarButtonItem.enabled = ![x isEqualToString:self.context] && x.dk_notEmpty;
        }
    }];
}

#pragma - mark action
- (void)saveClick {
    [self.tf resignFirstResponder];
    BOOL back = YES;
    if (self.backClickBlock) {
        back = self.backClickBlock(self.tf.text);
    }
    if (self.backBlock) {
        self.backBlock(self.tf.text);
    }
    if (back) {
        [self dk_backToSuperViewController];
    }
}

@end
