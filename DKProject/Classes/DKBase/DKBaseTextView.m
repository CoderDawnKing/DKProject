//
//  DKBaseTextView.m
//  GardenManager
//
//  Created by 王 on 2019/7/8.
//  Copyright © 2019 wisezone. All rights reserved.
//

#import "DKBaseTextView.h"
#import <DKProject/DKProject.h>

@interface DKBaseTextView (){
    NSInteger _limitNumber;
    NSInteger _leastNumber;
}
@property (nonatomic, strong) UILabel *limitLab;
@end

@implementation DKBaseTextView

@synthesize text = _text;
@synthesize attributedText = _attributedText;

- (instancetype)initWithlimitNumber:(NSInteger)limitNumber {
    return [self initWithLeastNumber:0 andLimitNumber:limitNumber];
}

- (instancetype)initWithLeastNumber:(NSInteger)leastNumber andLimitNumber:(NSInteger)limitNumber {
    _limitNumber = limitNumber;
    _leastNumber = leastNumber;
    self.limitLab.hidden = NO;
    return [self init];
}

- (void)__addSubViews {
    [self addSubview:self.textView];
    [self addSubview:self.limitLab];
    self.textContainerInset = UIEdgeInsetsMake(10, 5, 0, 5);
}

- (void)__makeConstraints {
    [self.textView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.mas_equalTo(0);
        make.bottom.mas_equalTo(self.limitLab.mas_top);
    }];
    [self.limitLab mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.textContainerInset.left);
        make.right.mas_equalTo(-self.textContainerInset.right);
        make.bottom.mas_equalTo(-10);
        make.height.mas_equalTo(self.limitLab.isHidden?0:15);
    }];
}

- (void)setFont:(UIFont *)font {
    _font = font;
    self.textView.font = _font;
}

- (void)setText:(NSString *)text {
    _text = text;
    self.textView.text = _text;
    if (_leastNumber > 0) {
        self.limitLab.text = [NSString stringWithFormat:@"%ld", text.length];
    } else {
        _limitLab.text = [NSString stringWithFormat:@"%ld/%ld", text.length, _limitNumber];
    }
}

- (NSString *)text {
    return self.textView.text;
}

- (void)setAttributedText:(NSAttributedString *)attributedText {
    _attributedText = attributedText;
    self.textView.attributedText = _attributedText;
    if (_leastNumber > 0) {
        self.limitLab.text = [NSString stringWithFormat:@"%ld", _attributedText.length];
    } else {
        _limitLab.text = [NSString stringWithFormat:@"%ld/%ld", _attributedText.length, _limitNumber];
    }
}

- (NSAttributedString *)attributedText {
    return self.textView.attributedText;
}

- (void)setTextContainerInset:(UIEdgeInsets)textContainerInset {
    _textContainerInset = textContainerInset;
    [self.limitLab mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.textContainerInset.left);
        make.right.mas_equalTo(-self.textContainerInset.right);
    }];
    if (_textContainerInset.left >= 5) {
        _textContainerInset.left = _textContainerInset.left - 5;
    }
    if (_textContainerInset.right >= 5) {
        _textContainerInset.right = _textContainerInset.right - 5;
    }
    if (_textContainerInset.top >= 5) {
        _textContainerInset.top = _textContainerInset.top - 5;
    }
    if (_textContainerInset.bottom >= 5) {
        _textContainerInset.bottom = _textContainerInset.bottom - 5;
    }
    ///textContainerInset 默认有 5 的边距 所以需要 -5
    self.textView.textContainerInset = textContainerInset;
}

- (void)setPlaceholder:(NSString *)placeholder {
    _placeholder = placeholder;
    self.textView.placeholder_text = _placeholder;
}

- (void)setPlaceholder_color:(UIColor *)placeholder_color {
    _placeholder_color = placeholder_color;
    self.textView.placeholder_color = placeholder_color;
}

- (UILabel *)limitLab {
    if (!_limitLab) {
        _limitLab = [[UILabel alloc] init];
        if (_leastNumber > 0) {
            _limitLab.text = [NSString stringWithFormat:@"0"];
        } else {
            _limitLab.text = [NSString stringWithFormat:@"0/%ld", _limitNumber];
        }
        _limitLab.hidden = YES;
        _limitLab.textColor = dk_HexColor(COLOR_888888);
        _limitLab.font = [UIFont systemFontOfSize:12];
        _limitLab.textAlignment = NSTextAlignmentRight;
    }
    return _limitLab;
}

- (UITextView *)textView {
    if (!_textView) {
        _textView = [[UITextView alloc] init];
        _textView.backgroundColor = [UIColor clearColor];
        _textView.delegate = self;
    }
    return _textView;
}

- (void)textViewDidChange:(UITextView *)textView {
    if (_leastNumber) {
        if (textView.text.length >= _leastNumber) {
            self.limitLab.textColor = dk_HexColor(COLOR_333333);
        }
        if (textView.text.length < _leastNumber) {
            self.limitLab.textColor = dk_HexColor(COLOR_AAAAAA);
        }
        if (textView.text.length > _limitNumber && _limitNumber) {
            UITextRange *markedRange = [textView markedTextRange];
            if (!markedRange) {
                NSRange range = [self.textView.text rangeOfComposedCharacterSequenceAtIndex:_limitNumber];
                textView.text = [textView.text substringToIndex:range.location];
                self.limitLab.text = [NSString stringWithFormat:@"%ld", _limitNumber];
            }
        }
        self.limitLab.text = [NSString stringWithFormat:@"%ld", textView.text.length];
    } else {
        if (textView.text.length > _limitNumber && _limitNumber) {
            UITextRange *markedRange = [self.textView markedTextRange];
            if (!markedRange) {
                NSRange range = [self.textView.text rangeOfComposedCharacterSequenceAtIndex:_limitNumber];
                self.textView.text = [self.textView.text substringToIndex:range.location];
                self.limitLab.text = [NSString stringWithFormat:@"%ld/%ld", _limitNumber, _limitNumber];
            }
        }
        self.limitLab.text = [NSString stringWithFormat:@"%ld/%ld", textView.text.length, _limitNumber];
    }
    [textView setContentInset:UIEdgeInsetsZero];
    [textView setTextAlignment:NSTextAlignmentLeft];
    if (self.textViewDidChangeBlock) {
        self.textViewDidChangeBlock(textView.text);
    }
}

@end
