//
//  DKBaseCollectionViewCell.m
//  GardenManager
//
//  Created by 王 on 2019/6/23.
//  Copyright © 2019 wisezone. All rights reserved.
//

#import "DKBaseCollectionViewCell.h"
#import <DKProject/DKProject.h>
@implementation DKBaseCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self __addSubViews];
        [self __makeConstraints];
        [self __addViewModel];
    }
    return self;
}

- (void)__addSubViews{
    switch (self.dk_type) {
        case DKBaseCollectionViewCellTypeImage:
        {
            [self.contentView addSubview:self.imageV];
        }
            break;
        case DKBaseCollectionViewCellTypeTitle:
        {
            [self.contentView addSubview:self.title];
        }
            break;
        case DKBaseCollectionViewCellTypeRightTitleLeftImage:
        case DKBaseCollectionViewCellTypeBottomTitleTopImage:
        {
            [self.contentView addSubview:self.title];
            [self.contentView addSubview:self.imageV];
        }
            break;
            
        default:
            break;
    }
}
- (void)__makeConstraints{
    switch (self.dk_type) {
        case DKBaseCollectionViewCellTypeImage:
        {
            [self.imageV mas_makeConstraints:^(MASConstraintMaker *make) {
                make.edges.mas_equalTo(0);
            }];
        }
            break;
        case DKBaseCollectionViewCellTypeTitle:
        {
            [self.title mas_makeConstraints:^(MASConstraintMaker *make) {
                make.edges.mas_equalTo(0);
            }];
        }
            break;
        case DKBaseCollectionViewCellTypeRightTitleLeftImage:
        {
            [self.imageV mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(0);
                make.centerY.mas_equalTo(0);
            }];
            
            [self.title mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self.imageV.mas_right).offset(5);
                make.top.mas_equalTo(0);
                make.right.mas_equalTo(0);
                make.bottom.mas_equalTo(0);
                make.height.mas_equalTo(17);
            }];
        }
            break;
        case DKBaseCollectionViewCellTypeBottomTitleTopImage:
        {
            [self.imageV mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.top.right.mas_equalTo(0);
            }];
            
            [self.title mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self.imageV.mas_bottom).offset(10);
                make.left.mas_equalTo(0);
                make.right.mas_equalTo(0);
                make.bottom.mas_equalTo(-15);
                make.height.mas_equalTo(17);
            }];
        }
            break;
            
        default:
            break;
    }
}
- (void)__addViewModel{}
/** 更新约束 */
- (void)__updateConstraints {}

- (void)setDk_type:(DKBaseCollectionViewCellType)dk_type {
    _dk_type = dk_type;
    [self __addSubViews];
    [self __makeConstraints];
}

- (void)setLabelInsets:(UIEdgeInsets)labelInsets {
    _labelInsets = labelInsets;
    switch (self.dk_type) {
        case DKBaseCollectionViewCellTypeBottomTitleTopImage:
            {
                [self.title mas_updateConstraints:^(MASConstraintMaker *make) {
                    make.top.equalTo(self.imageV.mas_bottom).offset(10+labelInsets.top);
                    make.left.mas_equalTo(0+labelInsets.left);
                    make.right.mas_equalTo(0-labelInsets.right);
                    make.bottom.mas_equalTo(-15-labelInsets.bottom);
                }];
            }
            break;
            
        default:
            break;
    }
}

#pragma - mark lazy

- (UIImageView *)imageV {
    if (!_imageV) {
        _imageV = [[UIImageView alloc] init];
        _imageV.backgroundColor = dk_HexColor(DK_COLOR_DDDDDD);
        _imageV.contentMode = UIViewContentModeScaleAspectFill;
        _imageV.layer.masksToBounds = YES;
    }
    return _imageV;
}

- (UILabel *)title {
    if (!_title) {
        _title = [[UILabel alloc] init];
        _title.text = @"";
        _title.font = [UIFont pfRegularWithSize:12];
        _title.textColor = dk_HexColor(DK_COLOR_333333);
        _title.textAlignment = NSTextAlignmentCenter;
    }
    return _title;
}


@end
