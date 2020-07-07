//
//  DKBaseEmptyView.m
//  GardenManager
//
//  Created by 王 on 2019/7/22.
//  Copyright © 2019 wisezone. All rights reserved.
//

#import "DKBaseEmptyView.h"
#import <DKProject/DKProject.h>

@interface DKBaseEmptyView (){
}
@property (nonatomic, strong) UIImageView *emptyImageV;
@property (nonatomic, strong) UILabel *emptyLab;
@property (nonatomic, strong) UIButton *emptyBtn;

@end

@implementation DKBaseEmptyView

@synthesize emptyImage = _emptyImage;

- (void)__addSubViews {
    [self addSubview:self.emptyImageV];
    [self addSubview:self.emptyLab];
    [self addSubview:self.emptyBtn];
}

- (void)__makeConstraints {
    [self.emptyImageV mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(0);
        make.centerY.mas_equalTo(-100);
        make.width.mas_equalTo(self.emptyImage?235:0);
        make.height.mas_equalTo(self.emptyImage?150:0);
    }];
    
    [self.emptyLab mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.emptyImageV.mas_bottom).offset(15);
        make.centerX.mas_equalTo(self.emptyImageV.mas_centerX);
        make.left.mas_greaterThanOrEqualTo(20);
        make.right.mas_lessThanOrEqualTo(-20);
    }];
    
    [self.emptyBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.emptyLab.mas_bottom).offset(30);
        make.centerX.mas_equalTo(self.emptyImageV.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(120, 40));
    }];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [self.emptyBtn dk_radius];
}

#pragma - mark setter
- (void)setEmptyImage:(UIImage *)emptyImage {
    _emptyImage = emptyImage;
    self.emptyImageV.image = emptyImage;
}

- (void)setEmptyPrompt:(NSString *)emptyPrompt {
    _emptyPrompt = emptyPrompt;
    self.emptyLab.text = emptyPrompt;
}

- (void)setEmptyButtonTitle:(NSString *)emptyButtonTitle {
    _emptyButtonTitle = emptyButtonTitle;
    [self.emptyBtn setTitle:_emptyButtonTitle forState:UIControlStateNormal];
}

- (void)setShowButton:(BOOL)showButton {
    _showButton = showButton;
    self.emptyBtn.hidden = !_showButton;
}

- (void)setEmptyOffset:(CGPoint)emptyOffset {
    _emptyOffset = emptyOffset;
    [self.emptyImageV mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(emptyOffset.x);
        make.centerY.mas_equalTo(-100+emptyOffset.y);
        make.width.mas_equalTo(self.emptyImage?235:0);
        make.height.mas_equalTo(self.emptyImage?150:0);
    }];
}

- (void)setEmptyTop:(CGFloat)emptyTop {
    _emptyTop = emptyTop;
    [self.emptyImageV mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(0);
        make.top.mas_equalTo(_emptyTop);
        make.width.mas_equalTo(self.emptyImage?235:0);
        make.height.mas_equalTo(self.emptyImage?150:0);
    }];
}

#pragma - mark lazy
- (UIImageView *)emptyImageV {
    if (!_emptyImageV) {
        _emptyImageV = [[UIImageView alloc] init];
        _emptyImageV.image = dk_BundleImage(@"default_img_default");
        _emptyImageV.layer.cornerRadius = 50;
        _emptyImageV.layer.masksToBounds = YES;
    }
    return _emptyImageV;
}

- (UIImage *)emptyImage {
    return dk_BundleImage(@"default_img_default");
}

- (UILabel *)emptyLab {
    if (!_emptyLab) {
        _emptyLab = [[UILabel alloc] init];
        _emptyLab.font = [UIFont pfRegularWithSize:15];
        _emptyLab.textColor = dk_HexColorWithAlpha(DK_COLOR_APPMAIN, .5);
        _emptyLab.numberOfLines = 0;
        _emptyLab.textAlignment = NSTextAlignmentCenter;
        _emptyLab.text = @"啊哦～此地暂时空空如也～";
    }
    return _emptyLab;
}

- (UIButton *)emptyBtn {
    if (!_emptyBtn) {
        _emptyBtn = [[UIButton alloc] initWithTitle:@"" color:dk_HexColor(DK_COLOR_WHITE) font:[UIFont pfMediumWithSize:15]];
        [_emptyBtn addTarget:self action:@selector(emptyBtnClick) forControlEvents:UIControlEventTouchUpInside];
        [_emptyBtn setBackgroundColor:dk_HexColor(DK_COLOR_APPMAIN) forState:UIControlStateNormal];
        _emptyBtn.hidden = YES;
    }
    return _emptyBtn;
}

- (void)emptyBtnClick {
    if (self.buttonBlock) {
        self.buttonBlock(self.emptyBtn);
    }
}

@end
