//
//  BaseTableViewCell.m
//  GardenManager
//
//  Created by 王 on 2019/6/19.
//  Copyright © 2019 wisezone. All rights reserved.
//

#import "DKBaseTableViewCell.h"
#import <DKProject/DKProject.h>

@interface DKBaseTableViewCell (){
    UIColor *_cellBackgroundViewOriginColor;
    UIEdgeInsets _backInset;
}

@end

@implementation DKBaseTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

- (void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated {
    [super setHighlighted:highlighted animated:animated];
    if (highlighted && self.dk_selectionStyle != DKBaseTableViewCellSelectionStyleNone) {
        [UIView animateWithDuration:0.3 animations:^{
            self.cellBackgroundView.backgroundColor = dk_HexColor(DK_COLOR_F2F2F2);
        }];
    } else {
        [UIView animateWithDuration:0.3 animations:^{
            self.cellBackgroundView.backgroundColor = self.cellBackgroundColor;
        }];
    }
}

- (void)setCellBackgroundColor:(UIColor *)cellBackgroundColor {
    _cellBackgroundColor = cellBackgroundColor;
    self.cellBackgroundView.backgroundColor = _cellBackgroundColor;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = [UIColor clearColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.dk_selectionStyle = UITableViewCellSelectionStyleNone;
        [self.contentView addSubview:self.cellBackgroundView];
        if (self.isHasArrow) {
            [self.contentView addSubview:self.arrow];
        }
        self.topLineInsets = UIEdgeInsetsMake(0, dk_leftMargin, 0, 0);
        self.bottomLineInsets = UIEdgeInsetsMake(0, dk_leftMargin, 0, 0);
        self.dottedLineInsets = UIEdgeInsetsMake(0, dk_leftMargin, 0, 0);
        [self.contentView addSubview:self.topLine];
        [self.contentView addSubview:self.bottomLine];
        [self.contentView addSubview:self.dottedLine];
        if (self.dk_type == DKBaseTableViewCellTypeCustom) {
            self.bottomLine.hidden = YES;
        }
        [self makeConstraints];
        [self __addSubViews];
        [self __makeConstraints];
        [self __addViewModel];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    if (self.isHasRoundedCorner) {
        [self __setRoundedCorner];
    }
    if ((self.dk_type == DKBaseTableViewCellTypeImageLeft || self.dk_type == DKBaseTableViewCellTypeImageRight || self.dk_type == DKBaseTableViewCellTypeSubtitle1)) {
        if (self.dk_type == DKBaseTableViewCellTypeSubtitle1) {

        }
        if (self.isHasImageRoundedCorner) {
            if (self.imageRoundedCorner) {
                [self.imageV dk_cornerRadii:self.imageRoundedCorner];
            } else {
                [self.imageV dk_radius];
            }
        }
    }
    
    
    if (self.topLineInsets.top || self.topLineInsets.left || self.topLineInsets.right || self.topLineInsets.bottom) {
        [self.topLine mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.cellBackgroundView.mas_top).offset(self.topLineInsets.top-self.topLineInsets.bottom);
            make.left.equalTo(self.cellBackgroundView.mas_left).offset(self.topLineInsets.left);
            make.height.mas_equalTo(dk_lineHeight);
            make.right.equalTo(self.cellBackgroundView.mas_right).offset(-self.topLineInsets.right);
        }];
    }
    if (self.bottomLineInsets.top || self.bottomLineInsets.left || self.bottomLineInsets.right || self.bottomLineInsets.bottom) {
        [self.bottomLine mas_remakeConstraints:^(MASConstraintMaker *make) { make.bottom.equalTo(self.cellBackgroundView.mas_bottom).offset(self.bottomLineInsets.top-self.bottomLineInsets.bottom);
            make.left.equalTo(self.cellBackgroundView.mas_left).offset(self.bottomLineInsets.left);
            make.height.mas_equalTo(dk_lineHeight);
            make.right.equalTo(self.cellBackgroundView.mas_right).offset(-self.bottomLineInsets.right);
        }];
    }
    
    
    if (self.dottedLineInsets.top || self.dottedLineInsets.left || self.dottedLineInsets.right || self.dottedLineInsets.bottom) {
        [self.dottedLine mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self.cellBackgroundView.mas_bottom).offset(self.dottedLineInsets.top-self.dottedLineInsets.bottom);
            make.left.equalTo(self.cellBackgroundView.mas_left).offset(self.dottedLineInsets.left);
            make.height.mas_equalTo(2);
            make.right.equalTo(self.cellBackgroundView.mas_right).offset(-self.dottedLineInsets.right);
        }];
    }
}

- (void)makeConstraints {
    [self.cellBackgroundView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(_backInset);
    }];
    
    if (self.isHasArrow) {
        [self.arrow mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.cellBackgroundView.mas_centerY).offset(0);
            make.right.equalTo(self.cellBackgroundView.mas_right).offset(-dk_rightMargin);
        }];
    }
    [self.topLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.cellBackgroundView.mas_top).offset(self.topLineInsets.top-self.topLineInsets.bottom);
        make.left.equalTo(self.cellBackgroundView.mas_left).offset(self.topLineInsets.left);
        make.height.mas_equalTo(dk_lineHeight);
        make.right.equalTo(self.cellBackgroundView.mas_right).offset(-self.topLineInsets.right);
    }];
    [self.bottomLine mas_makeConstraints:^(MASConstraintMaker *make) { make.bottom.equalTo(self.cellBackgroundView.mas_bottom).offset(self.bottomLineInsets.top-self.bottomLineInsets.bottom);
        make.left.equalTo(self.cellBackgroundView.mas_left).offset(self.bottomLineInsets.left);
        make.height.mas_equalTo(dk_lineHeight);
        make.right.equalTo(self.cellBackgroundView.mas_right).offset(-self.bottomLineInsets.right);
    }];
    
//    [self.dottedLine mas_makeConstraints:^(MASConstraintMaker *make) { make.bottom.equalTo(self.cellBackgroundView.mas_bottom).offset(self.dottedLineInsets.top-self.dottedLineInsets.bottom);
//        make.left.equalTo(self.cellBackgroundView.mas_left).offset(self.dottedLineInsets.left);
//        make.height.mas_equalTo(2);
//        make.right.equalTo(self.cellBackgroundView.mas_right).offset(-self.dottedLineInsets.right);
//    }];
    
    [self.dottedLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.cellBackgroundView.mas_left).offset(dk_leftMargin);
        make.right.equalTo(self.cellBackgroundView.mas_right).offset(-dk_rightMargin);
        make.bottom.equalTo(self.cellBackgroundView.mas_bottom).offset(0);
        make.height.mas_equalTo(2);
    }];
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style
              reuseIdentifier:(NSString *)reuseIdentifier
                         type:(DKBaseTableViewCellType)type
                       insets:(UIEdgeInsets)insets
                     hasArrow:(BOOL)hasArrow
             hasRoundedCorner:(BOOL)hasRoundedCorner {
    return [self initWithStyle:style reuseIdentifier:reuseIdentifier type:type insets:insets hasArrow:hasArrow hasRoundedCorner:hasRoundedCorner rectCorner:UIRectCornerAllCorners];
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier type:(DKBaseTableViewCellType)type insets:(UIEdgeInsets)insets hasArrow:(BOOL)hasArrow hasRoundedCorner:(BOOL)hasRoundedCorner rectCorner:(UIRectCorner)rectCorner {
    self.dk_type = type;
    _backInset = insets;
    self.hasArrow = hasArrow;
    self.hasRoundedCorner = hasRoundedCorner;
    self.rectCorner = rectCorner;
    return [self initWithStyle:style reuseIdentifier:reuseIdentifier];
}

/** 加载子视图 */
- (void)__addSubViews {
    switch (self.dk_type) {
        case DKBaseTableViewCellTypeDefault:
        {
            [self.contentView addSubview:self.title];
            self.title.numberOfLines = 0;
        }
            break;
        case DKBaseTableViewCellTypeValue1:
        case DKBaseTableViewCellTypeValue2:
        {
            [self.contentView addSubview:self.title];
            [self.contentView addSubview:self.detail];
        }
            break;
        case DKBaseTableViewCellTypeValue3:
        {
            self.title.numberOfLines = 0;
            self.title.dk_verticalAlignment = DKCustonLabelVerticalAlignmentTop;
            self.detail.dk_verticalAlignment = DKCustonLabelVerticalAlignmentTop;
            [self.contentView addSubview:self.title];
            [self.contentView addSubview:self.detail];
        }
            break;
        case DKBaseTableViewCellTypeImageLeft:
        case DKBaseTableViewCellTypeImageRight:
        {
            [self.contentView addSubview:self.title];
            [self.contentView addSubview:self.imageV];
        }
            break;
        case DKBaseTableViewCellTypeSubtitle:
        {
            [self.contentView addSubview:self.title];
            [self.contentView addSubview:self.detail];
            self.detail.numberOfLines = 0;
        }
            break;
        case DKBaseTableViewCellTypeSubtitle1:
        {
            [self.contentView addSubview:self.title];
            [self.contentView addSubview:self.detail];
            [self.contentView addSubview:self.imageV];
            self.detail.numberOfLines = 0;
        }
            break;
        case DKBaseTableViewCellTypeTextField:
        {
            [self.contentView addSubview:self.textField];
        }
            break;
        case DKBaseTableViewCellTypeTitleTextField:
        {
            self.textField.clearButtonMode = UITextFieldViewModeNever;
            self.textField.textAlignment = NSTextAlignmentRight;
            [self.contentView addSubview:self.title];
            [self.contentView addSubview:self.textField];
        }
            break;
        case DKBaseTableViewCellTypeTitleTextFieldUnit:
        {
            self.textField.clearButtonMode = UITextFieldViewModeNever;
            self.textField.textAlignment = NSTextAlignmentRight;
            self.detail.textColor = dk_HexColor(DK_COLOR_333333);
            [self.contentView addSubview:self.title];
            [self.contentView addSubview:self.textField];
            [self.contentView addSubview:self.detail];
        }
            break;
        case DKBaseTableViewCellTypeCustom:
        {
            
        }
            break;
        default:
            break;
    }
}

/** 添加模型 */
- (void)__addViewModel {
    
}

/** 布置约束 */
- (void)__makeConstraints {
    switch (self.dk_type) {
        case DKBaseTableViewCellTypeDefault:
        {
            [self.title mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self.cellBackgroundView.mas_left).offset(dk_leftMargin);
                make.top.equalTo(self.cellBackgroundView.mas_top).offset(0);
                make.bottom.equalTo(self.cellBackgroundView.mas_bottom).offset(0);
                make.right.equalTo(self.cellBackgroundView.mas_right).offset(-(self.isHasArrow?dk_rightArrowImageMargin:dk_rightMargin));
            }];
        }
            break;
        case DKBaseTableViewCellTypeValue1:
        case DKBaseTableViewCellTypeValue2:
        case DKBaseTableViewCellTypeValue3:
        {
            [self.title setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
            [self.title setContentCompressionResistancePriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
            [self.title mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self.cellBackgroundView.mas_left).offset(dk_leftMargin);
                make.top.equalTo(self.cellBackgroundView.mas_top).offset(0);
                make.bottom.equalTo(self.cellBackgroundView.mas_bottom).offset(0);
            }];
            [self.detail mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self.cellBackgroundView.mas_top).offset(0);
                make.bottom.equalTo(self.cellBackgroundView.mas_bottom).offset(0);
                if (self.dk_type == DKBaseTableViewCellTypeValue1 || self.dk_type == DKBaseTableViewCellTypeValue3) {
                    make.right.lessThanOrEqualTo(self.cellBackgroundView.mas_right).offset(-(self.isHasArrow?dk_rightArrowImageMargin:dk_rightMargin));
                    make.left.equalTo(self.title.mas_right).offset(dk_labelMargin);
                } else {
                    make.right.equalTo(self.cellBackgroundView.mas_right).offset(-(self.isHasArrow?dk_rightArrowImageMargin:dk_rightMargin));
                    make.left.greaterThanOrEqualTo(self.title.mas_right).offset(dk_labelMargin);
                }
            }];
        }
            break;
        case DKBaseTableViewCellTypeImageLeft:
        {
            [self.imageV setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
            [self.imageV setContentCompressionResistancePriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
            [self.imageV mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self.cellBackgroundView.mas_top).offset(dk_constMargin);
                make.bottom.equalTo(self.cellBackgroundView.mas_bottom).offset(-dk_constMargin);
                make.left.equalTo(self.cellBackgroundView.mas_left).offset(dk_leftMargin);
                make.height.mas_greaterThanOrEqualTo(24).priorityHigh();
                make.width.mas_lessThanOrEqualTo(120).priorityHigh();
            }];
            [self.title mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self.imageV.mas_right).offset(dk_betweenMargin);
                make.top.equalTo(self.cellBackgroundView.mas_top).offset(dk_constMargin);
                make.bottom.equalTo(self.cellBackgroundView.mas_bottom).offset(-dk_constMargin);
                make.right.equalTo(self.cellBackgroundView.mas_right).offset(-(self.isHasArrow?dk_rightArrowImageMargin:dk_rightMargin));
            }];
        }
            break;
        case DKBaseTableViewCellTypeImageRight:
        {
            [self.title mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self.cellBackgroundView.mas_left).offset(dk_leftMargin);
                make.top.equalTo(self.cellBackgroundView.mas_top).offset(dk_constMargin);
                make.bottom.equalTo(self.cellBackgroundView.mas_bottom).offset(-dk_constMargin);
                make.right.equalTo(self.imageV.mas_left).offset(-dk_betweenMargin);
            }];
            [self.imageV setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
            [self.imageV setContentCompressionResistancePriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
            [self.imageV mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self.cellBackgroundView.mas_top).offset(dk_constMargin);
                make.bottom.equalTo(self.cellBackgroundView.mas_bottom).offset(-dk_constMargin);
                make.right.equalTo(self.cellBackgroundView.mas_right).offset(-(self.isHasArrow?dk_rightArrowImageMargin:dk_rightMargin));
                make.width.mas_equalTo(self.imageV.mas_height);
                make.height.mas_greaterThanOrEqualTo(24).priorityHigh();
                make.width.mas_lessThanOrEqualTo(120).priorityHigh();
            }];
        }
            break;
        case DKBaseTableViewCellTypeSubtitle:
        {
            [self.title mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self.cellBackgroundView.mas_left).offset(dk_leftMargin);
                make.top.equalTo(self.cellBackgroundView.mas_top).offset(dk_topMargin);
                make.right.equalTo(self.cellBackgroundView.mas_right).offset(-(self.isHasArrow?dk_rightArrowImageMargin:dk_rightMargin));
                make.height.mas_equalTo(21);
            }];
            [self.detail mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self.cellBackgroundView.mas_left).offset(dk_leftMargin);
                make.top.equalTo(self.title.mas_bottom).offset(dk_labelMargin);
                make.bottom.equalTo(self.cellBackgroundView.mas_bottom).offset(-dk_bottomMargin);
                make.right.equalTo(self.cellBackgroundView.mas_right).offset(-(self.isHasArrow?dk_rightArrowImageMargin:dk_rightMargin));
            }];
        }
            break;
        case DKBaseTableViewCellTypeSubtitle1:
        {
            [self.imageV mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self.cellBackgroundView.mas_top).offset(dk_topMargin);
                make.left.equalTo(self.cellBackgroundView.mas_left).offset(dk_leftMargin);
                make.size.mas_equalTo(CGSizeMake(40, 40));
            }];
            [self.title mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self.imageV.mas_right).offset(dk_betweenMargin);
                make.top.equalTo(self.cellBackgroundView.mas_top).offset(dk_constMargin);
                make.right.equalTo(self.cellBackgroundView.mas_right).offset(-(self.isHasArrow?dk_rightArrowImageMargin:dk_rightMargin));
                make.height.mas_equalTo(21);
            }];
            [self.detail mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self.imageV.mas_right).offset(dk_betweenMargin);
                make.top.equalTo(self.title.mas_bottom).offset(2);
                make.bottom.equalTo(self.cellBackgroundView.mas_bottom).offset(-dk_constMargin);
                make.right.equalTo(self.cellBackgroundView.mas_right).offset(-(self.isHasArrow?dk_rightArrowImageMargin:dk_rightMargin));
            }];
        }
            break;
        case DKBaseTableViewCellTypeTextField:
        {
            [self.textField mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self.cellBackgroundView.mas_top).offset(0);
                make.bottom.equalTo(self.cellBackgroundView.mas_bottom).offset(0);
                make.left.equalTo(self.cellBackgroundView.mas_left).offset(dk_leftMargin);
                make.right.equalTo(self.cellBackgroundView.mas_right).offset(-(self.isHasArrow?dk_rightArrowImageMargin:dk_rightMargin));
            }];
        }
            break;
        case DKBaseTableViewCellTypeTitleTextField:
        {
            [self.title mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self.cellBackgroundView.mas_top).offset(0);
                make.bottom.equalTo(self.cellBackgroundView.mas_bottom).offset(0);
                make.left.equalTo(self.cellBackgroundView.mas_left).offset(dk_leftMargin);
            }];
            [self.textField mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self.cellBackgroundView.mas_top).offset(0);
                make.bottom.equalTo(self.cellBackgroundView.mas_bottom).offset(0);
                make.left.greaterThanOrEqualTo(self.title.mas_right).offset(dk_constMargin);
                make.right.equalTo(self.cellBackgroundView.mas_right).offset(-(self.isHasArrow?dk_rightArrowImageMargin:dk_rightMargin));
                make.width.mas_greaterThanOrEqualTo(40);
            }];
        }
            break;
        case DKBaseTableViewCellTypeTitleTextFieldUnit:
        {
            [self.title mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self.cellBackgroundView.mas_top).offset(0);
                make.bottom.equalTo(self.cellBackgroundView.mas_bottom).offset(0);
                make.left.equalTo(self.cellBackgroundView.mas_left).offset(dk_leftMargin);
            }];
            [self.textField mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self.cellBackgroundView.mas_top).offset(0);
                make.bottom.equalTo(self.cellBackgroundView.mas_bottom).offset(0);
                make.left.greaterThanOrEqualTo(self.title.mas_right).offset(dk_constMargin);
                make.width.mas_greaterThanOrEqualTo(40);
            }];
            [self.detail mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self.cellBackgroundView.mas_top).offset(0);
                make.bottom.equalTo(self.cellBackgroundView.mas_bottom).offset(0);
                make.left.equalTo(self.textField.mas_right).offset(dk_constMargin);
                make.right.equalTo(self.cellBackgroundView.mas_right).offset(-(self.isHasArrow?dk_rightArrowImageMargin:dk_rightMargin));
            }];
        }
            break;
        case DKBaseTableViewCellTypeCustom:
            break;
        default:
            break;
    }
}

/** 设置 cell 是否圆角 */
- (void)__setRoundedCorner {
    self.bottomLine.hidden = YES;
    [self.cellBackgroundView dk_roundingCorners:self.rectCorner cornerRadii:self.cornerRadii];
}

- (void)setLabelInsets:(UIEdgeInsets)labelInsets {
    _labelInsets = labelInsets;
    switch (self.dk_type) {
        case DKBaseTableViewCellTypeDefault:
            {
                [self.title mas_updateConstraints:^(MASConstraintMaker *make) {
                    make.left.equalTo(self.cellBackgroundView.mas_left).offset(dk_leftMargin+labelInsets.left);
                    make.top.equalTo(self.cellBackgroundView.mas_top).offset(labelInsets.top);
                    make.bottom.equalTo(self.cellBackgroundView.mas_bottom).offset(-labelInsets.bottom);
                    make.right.equalTo(self.cellBackgroundView.mas_right).offset(-(self.isHasArrow?dk_rightArrowImageMargin:dk_rightMargin)-labelInsets.right);
                }];
            }
            break;
        case DKBaseTableViewCellTypeValue1:
        case DKBaseTableViewCellTypeValue2:
        case DKBaseTableViewCellTypeValue3:
        {
            [self.title mas_updateConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self.cellBackgroundView.mas_left).offset(dk_leftMargin+labelInsets.left);
                make.top.equalTo(self.cellBackgroundView.mas_top).offset(labelInsets.top);
                make.bottom.equalTo(self.cellBackgroundView.mas_bottom).offset(-labelInsets.bottom);
            }];
            [self.detail mas_updateConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self.cellBackgroundView.mas_top).offset(labelInsets.top);
                make.bottom.equalTo(self.cellBackgroundView.mas_bottom).offset(-labelInsets.bottom);
                if (self.dk_type == DKBaseTableViewCellTypeValue1 || self.dk_type == DKBaseTableViewCellTypeValue3) {
                    make.right.lessThanOrEqualTo(self.cellBackgroundView.mas_right).offset(-(self.isHasArrow?dk_rightArrowImageMargin:dk_rightMargin)-labelInsets.right);
                } else {
                    make.right.equalTo(self.cellBackgroundView.mas_right).offset(-(self.isHasArrow?dk_rightArrowImageMargin:dk_rightMargin)-labelInsets.right);
                }
            }];
        }
            break;
        case DKBaseTableViewCellTypeSubtitle:
        {
            [self.title mas_updateConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self.cellBackgroundView.mas_left).offset(dk_leftMargin+labelInsets.left);
                make.top.equalTo(self.cellBackgroundView.mas_top).offset(dk_topMargin+labelInsets.top);
                make.right.equalTo(self.cellBackgroundView.mas_right).offset(-(self.isHasArrow?dk_rightArrowImageMargin:dk_rightMargin)-labelInsets.right);
                make.height.mas_equalTo(21);
            }];
            [self.detail mas_updateConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self.cellBackgroundView.mas_left).offset(dk_leftMargin+labelInsets.left);
                make.top.equalTo(self.title.mas_bottom).offset(dk_labelMargin);
                make.bottom.equalTo(self.cellBackgroundView.mas_bottom).offset(-dk_bottomMargin-labelInsets.bottom);
                make.right.equalTo(self.cellBackgroundView.mas_right).offset(-(self.isHasArrow?dk_rightArrowImageMargin:dk_rightMargin)-labelInsets.right);
            }];
        }
            break;
        default:
            break;
    }
    
}

- (void)setArrowInsets:(UIEdgeInsets)arrowInsets {
    _arrowInsets = arrowInsets;
    if (self.isHasArrow) {
        [self.arrow mas_updateConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.cellBackgroundView.mas_centerY).offset(0 + arrowInsets.top - arrowInsets.bottom);
            make.right.equalTo(self.cellBackgroundView.mas_right).offset(-dk_rightMargin - arrowInsets.right + arrowInsets.left);
        }];
    }
}

/** 更新约束 */
- (void)__updateConstraints {}

+ (instancetype)cellWithType:(DKBaseTableViewCellType)type ident:(NSString *)ident {
    return [self cellWithType:type ident:ident hasArrow:NO];
}

+ (instancetype)cellWithType:(DKBaseTableViewCellType)type ident:(NSString *)ident hasArrow:(BOOL)hasArrow {
    return [self cellWithType:type ident:ident hasArrow:hasArrow hasRoundedCorner:NO];
}

+ (instancetype)cellWithType:(DKBaseTableViewCellType)type
                       ident:(nullable NSString *)ident
                    hasArrow:(BOOL)hasArrow
            hasRoundedCorner:(BOOL)hasRoundedCorner {
    return [self cellWithType:type ident:ident hasArrow:hasArrow hasRoundedCorner:hasRoundedCorner rectCorner:UIRectCornerAllCorners];
}

+ (instancetype)cellWithType:(DKBaseTableViewCellType)type ident:(NSString *)ident hasArrow:(BOOL)hasArrow hasRoundedCorner:(BOOL)hasRoundedCorner rectCorner:(UIRectCorner)rectCorner {
    return [self cellWithType:type ident:ident hasArrow:hasArrow hasRoundedCorner:hasRoundedCorner margin:0 rectCorner:rectCorner];
}

+ (instancetype)cellWithType:(DKBaseTableViewCellType)type
                       ident:(nullable NSString *)ident
                    hasArrow:(BOOL)hasArrow
            hasRoundedCorner:(BOOL)hasRoundedCorner
                      margin:(CGFloat)margin {
    return [self cellWithType:type ident:ident hasArrow:hasArrow hasRoundedCorner:hasRoundedCorner margin:margin rectCorner:UIRectCornerAllCorners];
}

+ (instancetype)cellWithType:(DKBaseTableViewCellType)type ident:(nullable NSString *)ident hasArrow:(BOOL)hasArrow hasRoundedCorner:(BOOL)hasRoundedCorner margin:(CGFloat)margin rectCorner:(UIRectCorner)rectCorner {
    return [self cellWithType:type ident:ident hasArrow:hasArrow hasRoundedCorner:hasRoundedCorner insets:UIEdgeInsetsMake(0, margin, 0, margin) rectCorner:rectCorner];
}

+ (instancetype)cellWithType:(DKBaseTableViewCellType)type
                       ident:(nullable NSString *)ident
                    hasArrow:(BOOL)hasArrow
            hasRoundedCorner:(BOOL)hasRoundedCorner
                      insets:(UIEdgeInsets)insets {
    return [self cellWithType:type ident:ident hasArrow:hasArrow hasRoundedCorner:hasRoundedCorner insets:insets rectCorner:UIRectCornerAllCorners];
}

+ (instancetype)cellWithType:(DKBaseTableViewCellType)type ident:(NSString *)ident hasArrow:(BOOL)hasArrow hasRoundedCorner:(BOOL)hasRoundedCorner insets:(UIEdgeInsets)insets rectCorner:(UIRectCorner)rectCorner {
    return [[self alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ident type:type insets:insets hasArrow:hasArrow hasRoundedCorner:hasRoundedCorner rectCorner:rectCorner];
}

- (void)setFiedlPlaceholder:(NSString *)plecholder
                  textColor:(NSString *)textColor
                       font:(NSInteger)font {
    _textField.textColor = dk_HexColor(textColor);
    _textField.placeholder = plecholder;
    _textField.font = [UIFont pfRegularWithSize:font];
}

- (void)setHasRoundedCorner:(BOOL)hasRoundedCorner {
    _hasRoundedCorner = hasRoundedCorner;
    self.cornerRadii = 10.f;
}

- (void)setInsets:(UIEdgeInsets)insets {
    _insets = insets;
    [self.cellBackgroundView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.insets);
    }];
}

- (void)setTextFieldEstimatedWidth:(CGFloat)textFieldEstimatedWidth {
    if (self.dk_type == DKBaseTableViewCellTypeTitleTextField || self.dk_type == DKBaseTableViewCellTypeTitleTextFieldUnit) {
        [self.textField mas_updateConstraints:^(MASConstraintMaker *make) {
            make.width.mas_greaterThanOrEqualTo(textFieldEstimatedWidth);
        }];
    }
}

#pragma - mark lazy

- (UITextField *)textField {
    if (!_textField) {
        _textField = [[UITextField alloc] init];
        _textField.textColor = dk_HexColor(DK_COLOR_333333);
        _textField.clearButtonMode = UITextFieldViewModeWhileEditing;
        _textField.font = [UIFont pfRegularWithSize:14];
        [_textField setAttributedPlaceholder:[[NSAttributedString alloc] initWithString:@"" attributes:@{NSForegroundColorAttributeName:dk_HexColor(DK_COLOR_AAAAAA)}]];
    }
    return _textField;
}

- (DKBaseView *)bottomLine {
    if (!_bottomLine) {
        _bottomLine = [DKBaseView lineView];
    }
    return _bottomLine;
}

- (DKBaseView *)topLine {
    if (!_topLine) {
        _topLine = [DKBaseView lineView];
        _topLine.hidden = YES;
    }
    return _topLine;
}

- (DKCustonLabel *)title {
    if (!_title) {
        _title = [[DKCustonLabel alloc] init];
        _title.textColor = dk_HexColor(DK_COLOR_333333);
        _title.font = [UIFont pfRegularWithSize:15];
    }
    return _title;
}

- (DKCustonLabel *)detail {
    if (!_detail) {
        _detail = [[DKCustonLabel alloc] init];
        _detail.textColor = dk_HexColor(DK_COLOR_888888);
        _detail.font = [UIFont pfRegularWithSize:14];
        if (self.dk_type == DKBaseTableViewCellTypeValue2) {
            _detail.textAlignment = NSTextAlignmentRight;
        }
    }
    return _detail;
}

- (UIImageView *)imageV {
    if (!_imageV) {
        _imageV = [[UIImageView alloc] init];
        _imageV.backgroundColor = dk_HexColor(DK_COLOR_DDDDDD);
        _imageV.contentMode = UIViewContentModeScaleAspectFill;
        _imageV.layer.masksToBounds = YES;
    }
    return _imageV;
}

- (UIImageView *)arrow {
    if (!_arrow) {
        _arrow = [[UIImageView alloc] initWithImage:dk_BundleImage(@"arrow_ic_cell_more")];
        [_arrow sizeToFit];
    }
    return _arrow;
}

- (DKBaseView *)cellBackgroundView {
    if (!_cellBackgroundView) {
        _cellBackgroundView = [[DKBaseView alloc] init];
        _cellBackgroundColor = _cellBackgroundView.backgroundColor = dk_HexColor(DK_COLOR_WHITE);
    }
    return _cellBackgroundView;
}

- (UIImageView *)dottedLine {
    if (!_dottedLine) {
        _dottedLine = [[UIImageView alloc] initWithImage:dk_BundleImage(@"arrow_ic_cell_dottedLine")];
        _dottedLine.hidden = YES;
    }
    return _dottedLine;
}

- (void)dealloc {
    
}

@end
