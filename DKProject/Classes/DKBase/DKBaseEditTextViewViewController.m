//
//  DKBaseEditTextViewViewController.m
//  GardenManager
//
//  Created by 王 on 2020/1/7.
//  Copyright © 2020 wisezone. All rights reserved.
//

#import "DKBaseEditTextViewViewController.h"
#import <DKProject/DKProject.h>

@interface DKBaseEditTextViewViewController ()
@property (nonatomic, strong) DKBaseTextView *textView;
@end

@implementation DKBaseEditTextViewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = dk_HexColor(DK_COLOR_TABLEVIEW_BACKGROUND);
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithTarget:self action:@selector(saveClick) title:@"保存"];
}

- (void)__addSubViews {
    [self.view addSubview:self.textView];
}

- (void)__makeConstraints {
    [self.textView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.mas_equalTo(0);
        make.height.mas_equalTo(110);
    }];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self.textView.textView becomeFirstResponder];
}

#pragma - mark lazy

- (DKBaseTextView *)textView {
    if (!_textView) {
        _textView = [[DKBaseTextView alloc] initWithlimitNumber:self.limitNumber];
        _textView.placeholder = self.placeholder;
        _textView.text = self.context;
        _textView.textContainerInset = UIEdgeInsetsMake(10, 15, 0, 15);
        _textView.font = [UIFont pfRegularWithSize:14];
        _textView.backgroundColor = dk_HexColor(DK_COLOR_WHITE);
    }
    return _textView;
}

#pragma - mark action
- (void)saveClick {
    [self.textView.textView resignFirstResponder];
    if (self.backBlock) {
        self.backBlock(self.textView.text);
    }
    [self dk_backToSuperViewController];
}


@end
