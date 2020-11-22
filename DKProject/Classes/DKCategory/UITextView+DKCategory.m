//
//  UITextView+DKCategory.m
//  GardenManager
//
//  Created by 王 on 2019/7/4.
//  Copyright © 2019 wisezone. All rights reserved.
//

#import "UITextView+DKCategory.h"
#import <objc/runtime.h>

@interface UITextView (){
}

@property (nonatomic,assign) CGFloat originalHeight;

@end

@implementation UITextView (DKCategory)

@dynamic placeholder_text;
@dynamic placeholder_attributed;
@dynamic placeholder_color;
@dynamic placeholder_font;
@dynamic isAutoHeight;
@dynamic maxAutoHeight;
@dynamic minAutoHeight;

#pragma mark - Swizzle Dealloc

+ (void)load {
    [super load];
    
    // is this the best solution?
    method_exchangeImplementations(class_getInstanceMethod(self.class, NSSelectorFromString(@"dealloc")),
                                   class_getInstanceMethod(self.class, @selector(swizzledDealloc)));
}

- (void)swizzledDealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    UILabel *label = objc_getAssociatedObject(self, @selector(placeholderLabel));
    if (label) {
        for (NSString *key in self.class.observingKeys) {
            @try {
                [self removeObserver:self forKeyPath:key];
            }
            @catch (NSException *exception) {
                // Do nothing
            }
        }
    }
    [self swizzledDealloc];
}

- (CGFloat)originalHeight {
    static CGFloat originalHeight;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [self.superview layoutIfNeeded];
        originalHeight = self.bounds.size.height;
    });
    return originalHeight;
}



#pragma mark - Class Methods
#pragma mark `defaultPlaceholderColor`

+ (UIColor *)defaultPlaceholderColor {
    static UIColor *color = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        UITextField *textField = [[UITextField alloc] init];
        textField.placeholder = @" ";
        color = [textField valueForKeyPath:@"_placeholderLabel.textColor"];
    });
    return color;
}


#pragma mark - `observingKeys`

+ (NSArray *)observingKeys {
    return @[@"attributedText",
             @"bounds",
             @"font",
             @"frame",
             @"text",
             @"textAlignment",
             @"textContainerInset"];
}


#pragma mark - Properties
#pragma mark `placeholderLabel`

- (UILabel *)placeholderLabel {
    UILabel *label = objc_getAssociatedObject(self, @selector(placeholderLabel));
    if (!label) {
        NSAttributedString *originalText = self.attributedText;
        self.text = @""; // lazily set font of `UITextView`.
        self.attributedText = originalText;
        
        label = [[UILabel alloc] init];
        label.textColor = [self.class defaultPlaceholderColor];
        label.numberOfLines = 0;
        label.userInteractionEnabled = NO;
        objc_setAssociatedObject(self, @selector(placeholderLabel), label, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(updatePlaceholderLabel)
                                                     name:UITextViewTextDidChangeNotification
                                                   object:self];
        
        for (NSString *key in self.class.observingKeys) {
            [self addObserver:self forKeyPath:key options:NSKeyValueObservingOptionNew context:nil];
        }
        
        self.enablesReturnKeyAutomatically = YES;
        self.scrollsToTop = NO;
    }
    return label;
}


#pragma mark `placeholder`

- (NSString *)placeholder_text {
    return (NSString *)objc_getAssociatedObject(self, _cmd);
}

- (void)setPlaceholder_text:(NSString *)placeholder_text {
    objc_setAssociatedObject(self, @selector(placeholder_text), placeholder_text, OBJC_ASSOCIATION_COPY_NONATOMIC);
    self.placeholderLabel.text = placeholder_text;
    [self updatePlaceholderLabel];
}

- (NSAttributedString *)placeholder_attributed {
    return (NSAttributedString *)objc_getAssociatedObject(self, _cmd);
}

- (void)setPlaceholder_attributed:(NSAttributedString *)placeholder_attributed {
    objc_setAssociatedObject(self, @selector(placeholder_attributed), placeholder_attributed, OBJC_ASSOCIATION_COPY_NONATOMIC);
    self.placeholderLabel.attributedText = placeholder_attributed;
    [self updatePlaceholderLabel];
}

#pragma mark `placeholderColor`

- (UIColor *)placeholder_color {
    return (UIColor *)objc_getAssociatedObject(self, _cmd);
}

- (void)setPlaceholder_color:(UIColor *)placeholder_color {
    objc_setAssociatedObject(self, @selector(placeholder_color), placeholder_color, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    self.placeholderLabel.textColor = placeholder_color;
}

#pragma mark `placeholderFont`
- (void)setPlaceholder_font:(UIFont *)placeholder_font {
    objc_setAssociatedObject(self, @selector(placeholder_font), placeholder_font, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    self.placeholderLabel.font = placeholder_font;
    [self.placeholderLabel sizeToFit];
}

- (UIFont *)placeholder_font {
    return (UIFont *)objc_getAssociatedObject(self, _cmd) ;
}

- (NSUInteger)dk_maxNumberOfLines {
    return [objc_getAssociatedObject(self, @selector(dk_maxNumberOfLines)) integerValue];
    
}

- (void)setDk_maxNumberOfLines:(NSUInteger)dk_maxNumberOfLines {
    
    objc_setAssociatedObject(self, @selector(dk_maxNumberOfLines), @(dk_maxNumberOfLines), OBJC_ASSOCIATION_ASSIGN);
    [self updatePlaceholderLabel];
    
}

- (BOOL)dk_autoLineBreak {
    
    return [objc_getAssociatedObject(self, @selector(dk_autoLineBreak)) boolValue];
    
}

- (void)setDk_autoLineBreak:(BOOL)dk_autoLineBreak {
    
    objc_setAssociatedObject(self, @selector(dk_autoLineBreak), @(dk_autoLineBreak), OBJC_ASSOCIATION_ASSIGN);
    [self updatePlaceholderLabel];
    
}

#pragma - mark 自动高度
- (BOOL)isAutoHeight
{
    return [objc_getAssociatedObject(self, _cmd) boolValue];
}

- (void)setIsAutoHeight:(BOOL)isAutoHeight {
    [self setNeedsLayout];
    objc_setAssociatedObject(self, @selector(isAutoHeight), @(isAutoHeight), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

#pragma - mark 最大高度
- (CGFloat)maxAutoHeight
{
    return [objc_getAssociatedObject(self, _cmd) floatValue];
}

- (void)setMaxAutoHeight:(CGFloat)maxAutoHeight {
    objc_setAssociatedObject(self, @selector(maxAutoHeight), @(maxAutoHeight), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

#pragma - mark 最小高度
- (CGFloat)minAutoHeight
{
    return [objc_getAssociatedObject(self, _cmd) floatValue];
}

- (void)setMinAutoHeight:(CGFloat)minAutoHeight {
    objc_setAssociatedObject(self, @selector(minAutoHeight), @(minAutoHeight), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

#pragma mark - KVO

- (void)observeValueForKeyPath:(NSString *)keyPath
                      ofObject:(id)object
                        change:(NSDictionary *)change
                       context:(void *)context {
    [self updatePlaceholderLabel];
}


#pragma mark - Update

- (void)updatePlaceholderLabel {
    if (self.text.length) {
        [self.placeholderLabel removeFromSuperview];
        return;
    }
    
    [self insertSubview:self.placeholderLabel atIndex:0];
    
    self.placeholderLabel.font = self.font;
    self.placeholderLabel.textAlignment = self.textAlignment;
    
    // `NSTextContainer` is available since iOS 7
    CGFloat lineFragmentPadding;
    UIEdgeInsets textContainerInset;
    
#pragma deploymate push "ignored-api-availability"
    // iOS 7+
    if (NSFoundationVersionNumber > NSFoundationVersionNumber_iOS_6_1) {
        lineFragmentPadding = self.textContainer.lineFragmentPadding;
        textContainerInset = self.textContainerInset;
    }
#pragma deploymate pop
    
    // iOS 6
    else {
        lineFragmentPadding = 5;
        textContainerInset = UIEdgeInsetsMake(8, 5, 8, 0);
    }
    
    CGFloat x = lineFragmentPadding + textContainerInset.left;
    CGFloat y = textContainerInset.top;
    CGFloat width = CGRectGetWidth(self.bounds) - x - lineFragmentPadding - textContainerInset.right;
    CGFloat height = [self.placeholderLabel sizeThatFits:CGSizeMake(width, 0)].height;
    self.placeholderLabel.frame = CGRectMake(x, y, width, height);
    [self updateHight];
}

#pragma - mark 视图布局
- (void)updateHight {
    
    CGFloat maxHeight = ceil(self.font.lineHeight * self.dk_maxNumberOfLines +  self.textContainerInset.top + self.textContainerInset.bottom);
    NSInteger height = self.text.length ? ceil([self sizeThatFits:CGSizeMake(self.frame.size.width, MAXFLOAT)].height) : self.originalHeight;
    
    self.scrollEnabled = !self.dk_autoLineBreak;
    
    if (self.dk_autoLineBreak && !self.dk_maxNumberOfLines && height > self.originalHeight) {
        CGRect newFrame = self.frame;
        
        newFrame.size.height = height;
        
        self.frame = newFrame;
        
    }
    
    self.scrollEnabled = height > maxHeight && self.dk_maxNumberOfLines;
    if (maxHeight >= height && height >= self.originalHeight) {
        
        CGRect newFrame = self.frame;
        
        newFrame.size.height = height;
        
        self.frame = newFrame;
        
    }
    
}

@end
