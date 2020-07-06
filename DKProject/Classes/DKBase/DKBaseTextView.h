//
//  DKBaseTextView.h
//  GardenManager
//
//  Created by 王 on 2019/7/8.
//  Copyright © 2019 wisezone. All rights reserved.
//

#import "DKBaseView.h"

NS_ASSUME_NONNULL_BEGIN

@interface DKBaseTextView : DKBaseView<UITextViewDelegate>
@property (nonatomic, strong) UITextView *textView;
@property (nonatomic, strong) NSString *placeholder;
@property (nonatomic, strong) UIColor *placeholder_color;
@property (null_resettable,nonatomic,copy) NSString *text;
@property (null_resettable,nonatomic,copy) NSAttributedString *attributedText;
@property (nullable, nonatomic, strong) UIFont *font;
@property (nonatomic, assign) UIEdgeInsets textContainerInset;
@property (nonatomic, copy) void (^textViewDidChangeBlock) (NSString *text);
- (instancetype)initWithlimitNumber:(NSInteger)limitNumber;
- (instancetype)initWithLeastNumber:(NSInteger)leastNumber andLimitNumber:(NSInteger)limitNumber;
@end

NS_ASSUME_NONNULL_END
