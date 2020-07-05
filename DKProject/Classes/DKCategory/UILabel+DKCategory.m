//
//  UILabel+Category.m
//  GardenManager
//
//  Created by 王 on 2019/6/19.
//  Copyright © 2019 wisezone. All rights reserved.
//

#import "UILabel+DKCategory.h"

@implementation UILabel (DKCategory)

+ (instancetype)labelWithColor:(UIColor *)color font:(UIFont *)font {
    UILabel *label = [[UILabel alloc] init];
    label.textColor = color;
    label.font = font;
    return label;
}

- (void)changeAttributed:(NSDictionary <NSAttributedStringKey, id> *)attributed range:(NSRange)range {
    if (self.text) {
        NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithAttributedString:self.attributedText];
        [attributedString setAttributes:attributed range:range];
        self.attributedText = attributedString;
        [self sizeToFit];
    }
}

- (void)changeLineSpaceForLabelWithSpace:(CGFloat)space {
    if (self.text) {
        NSString *labelText = self.text;
        NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:labelText];
        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
        [paragraphStyle setLineSpacing:space];
        [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [labelText length])];
        self.attributedText = attributedString;
        [self sizeToFit];
    }
}

- (void)changeWordSpaceForLabelWithSpace:(CGFloat)space {
    if (self.text) {
        NSString *labelText = self.text;
        NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:labelText attributes:@{NSKernAttributeName:@(space)}];
        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
        [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [labelText length])];
        self.attributedText = attributedString;
        [self sizeToFit];
    }
}

- (void)changeHeadIndentForLabelWithSpace:(CGFloat)space {
    if (self.text) {
        NSMutableParagraphStyle *paraStyle = [[NSMutableParagraphStyle alloc] init];
        paraStyle.headIndent = space;//行首缩进
        paraStyle.firstLineHeadIndent = space;//首行缩进
        NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithAttributedString:self.attributedText];
        [attributedString addAttribute:NSParagraphStyleAttributeName value:paraStyle range:NSMakeRange(0, [self.attributedText.string length])];
        self.attributedText = attributedString;
        [self sizeToFit];
    }
    [self changeHeadIndentForLabelWithSpace:space tailIndentForLabelWithSpace:0];
}

- (void)changeTailIndentForLabelWithSpace:(CGFloat)space {
    if (self.text) {
        NSMutableParagraphStyle *paraStyle = [[NSMutableParagraphStyle alloc] init];
        paraStyle.tailIndent = space;//行尾缩进
        NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithAttributedString:self.attributedText];
        [attributedString addAttribute:NSParagraphStyleAttributeName value:paraStyle range:NSMakeRange(0, [self.attributedText.string length])];
        self.attributedText = attributedString;
        [self sizeToFit];
    }
    [self changeHeadIndentForLabelWithSpace:0 tailIndentForLabelWithSpace:space];
}

- (void)changeIndentForLabelWithSpace:(CGFloat)space {
    [self changeHeadIndentForLabelWithSpace:space tailIndentForLabelWithSpace:space];
}

- (void)changeHeadIndentForLabelWithSpace:(CGFloat)headIndent tailIndentForLabelWithSpace:(CGFloat)tailIndent {
    if (self.text) {
        NSMutableParagraphStyle *paraStyle = [[NSMutableParagraphStyle alloc] init];
        paraStyle.headIndent = headIndent;//行首缩进
        paraStyle.firstLineHeadIndent = headIndent;//首行缩进
        paraStyle.tailIndent = tailIndent;//行尾缩进
        NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithAttributedString:self.attributedText];
        [attributedString addAttribute:NSParagraphStyleAttributeName value:paraStyle range:NSMakeRange(0, [self.attributedText.string length])];
        self.attributedText = attributedString;
        [self sizeToFit];
    }
}

- (void)changeFirstLineHeadIndentForLabelWithCharacter:(NSInteger)character {
    if (self.text) {
        NSMutableParagraphStyle *paraStyle = [[NSMutableParagraphStyle alloc] init];
        //字体大小号字乘以2 即首行空出两个字符
        CGFloat emptylen = self.font.pointSize * character;
        paraStyle.firstLineHeadIndent = emptylen;//首行缩进
        NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithAttributedString:self.attributedText];
        [attributedString addAttribute:NSParagraphStyleAttributeName value:paraStyle range:NSMakeRange(0, [self.attributedText.string length])];
        self.attributedText = attributedString;
        [self sizeToFit];
    }
}

- (void)changeLineHeightForLabelWithSpace:(CGFloat)space {
    if (self.text) {
        NSString *labelText = self.text;
        NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:labelText];
        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
        [paragraphStyle setMinimumLineHeight:space];
        [paragraphStyle setMaximumLineHeight:space];
        CGFloat baselineOffset = (28 - self.font.lineHeight) / 4;
        [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [labelText length])];
        [attributedString addAttribute:NSBaselineOffsetAttributeName value:@(baselineOffset) range:NSMakeRange(0, [labelText length])];
        self.attributedText = attributedString;
        [self sizeToFit];
    }
}

- (void)changeSpaceForLabelWithLineSpace:(CGFloat)lineSpace WordSpace:(CGFloat)wordSpace {
    if (self.text) {
        NSString *labelText = self.text;
        NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:labelText attributes:@{NSKernAttributeName:@(wordSpace)}];
        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
        [paragraphStyle setLineSpacing:lineSpace];
        [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [labelText length])];
        self.attributedText = attributedString;
        [self sizeToFit];
    }
}

- (void)changeColorWithColor:(UIColor *)color range:(NSRange)range {
    if (self.text) {
        NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithAttributedString:self.attributedText];
        [attributedString addAttributes:@{
                                          NSForegroundColorAttributeName:color,
                                          } range:range];
        self.attributedText = attributedString;
        [self sizeToFit];
    }
}

- (void)addUnderLineWithColor:(UIColor *)color range:(NSRange)range {
    if (self.text) {
        NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithAttributedString:self.attributedText];
        [attributedString addAttributes:@{
                                          NSUnderlineStyleAttributeName:[NSNumber numberWithInteger:NSUnderlineStyleSingle],
                                          NSUnderlineColorAttributeName:color,
                                          } range:range];
        self.attributedText = attributedString;
        [self sizeToFit];
    }
    
}

- (CGRect)boundingRectForCharacterRange:(NSRange)range {//范围
    NSTextStorage *textStorage = [[NSTextStorage alloc] initWithAttributedString:[self attributedText]];
    NSLayoutManager *layoutManager = [[NSLayoutManager alloc] init];
    [textStorage addLayoutManager:layoutManager];
    NSTextContainer *textContainer = [[NSTextContainer alloc] initWithSize:[self bounds] .size];
    textContainer.lineFragmentPadding = 0;
    [layoutManager addTextContainer:textContainer];
    
    NSRange glyphRange;
    
    //转换字形的范围。
    
    [layoutManager characterRangeForGlyphRange:range actualGlyphRange:&glyphRange];
    
    return [layoutManager boundingRectForGlyphRange:glyphRange inTextContainer:textContainer];
}

- (void)setAttributedString:(NSString *)attributedString withAttributesArray:(nullable NSArray<NSDictionary<NSAttributedStringKey, id> *> *)attributesArray {
    NSArray *stringArray = [attributedString componentsSeparatedByString:@"\n"];
    if (attributesArray.count == stringArray.count) {
        NSMutableAttributedString *attrString = [[NSMutableAttributedString alloc] initWithString:attributedString];
        [stringArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [attrString setAttributes:attributesArray[idx] range:[attributedString rangeOfString:obj]];
        }];
        [self setAttributedText:attrString];
    }
}

@end
