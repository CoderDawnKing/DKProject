//
//  QDNormalButtonViewController.m
//  qmuidemo
//
//  Created by QMUI Team on 16/10/12.
//  Copyright (c) 2016年 QMUI Team. All rights reserved.
//

#import "QDNormalButtonViewController.h"

@interface QDNormalButtonViewController ()

@property(nonatomic, strong) QMUIButton *normalButton;
@property(nonatomic, strong) QMUIButton *borderedButton;
@property(nonatomic, strong) QMUIButton *imagePositionButton1;
@property(nonatomic, strong) QMUIButton *imagePositionButton2;
@property(nonatomic, strong) QMUIButton *imagePositionButton3;
@property(nonatomic, strong) QMUIButton *imagePositionButton4;
@property(nonatomic, strong) CALayer *separatorLayer;
@property(nonatomic, strong) CAShapeLayer *imageButtonSeparatorLayer;
@property(nonatomic, strong) CAShapeLayer *imageButtonSeparatorLayer2;
@property(nonatomic, strong) DKCustomButton *loadingButton;
@property(nonatomic, strong) CAShapeLayer *imageButtonSeparatorLayer3;
@property(nonatomic, strong) DKCustomButton *verificationCodeButton;

@end

@implementation QDNormalButtonViewController

- (void)initSubviews {
    [super initSubviews];
    
    // 普通按钮
    self.normalButton = [DKUIHelper generateDarkFilledButton];
    [self.normalButton setTitle:NSLocalizedString(@"QMUIButton_Normal_Button_Title", @"按钮，支持高亮背景色") forState:UIControlStateNormal];
    [self.view addSubview:self.normalButton];
    
    self.separatorLayer = [CALayer qmui_separatorLayer];
    [self.view.layer addSublayer:self.separatorLayer];
    
    // 边框按钮
    self.borderedButton = [DKUIHelper generateLightBorderedButton];
    [self.borderedButton setTitle:NSLocalizedString(@"QMUIButton_Bordered_Button_Title", @"边框支持高亮的按钮") forState:UIControlStateNormal];
    [self.view addSubview:self.borderedButton];
    
    // 图片+文字按钮
    self.imagePositionButton1 = [[QMUIButton alloc] init];
    self.imagePositionButton1.tintColorAdjustsTitleAndImage = UIColor.dk_tintColor;
    self.imagePositionButton1.imagePosition = QMUIButtonImagePositionTop;// 将图片位置改为在文字上方
    self.imagePositionButton1.spacingBetweenImageAndTitle = 8;
    [self.imagePositionButton1 setImage:UIImageMake(@"icon_emotion") forState:UIControlStateNormal];
    [self.imagePositionButton1 setTitle:NSLocalizedString(@"QMUIButton_Image_Position_Button_Title_1", @"Text below image") forState:UIControlStateNormal];
    self.imagePositionButton1.titleLabel.font = UIFontMake(11);
    self.imagePositionButton1.qmui_borderPosition = QMUIViewBorderPositionTop | QMUIViewBorderPositionBottom;
    [self.view addSubview:self.imagePositionButton1];
    
    self.imagePositionButton2 = [[QMUIButton alloc] init];
    self.imagePositionButton2.tintColorAdjustsTitleAndImage = UIColor.dk_tintColor;
    self.imagePositionButton2.imagePosition = QMUIButtonImagePositionBottom;// 将图片位置改为在文字下方
    self.imagePositionButton2.spacingBetweenImageAndTitle = 8;
    [self.imagePositionButton2 setImage:UIImageMake(@"icon_emotion") forState:UIControlStateNormal];
    [self.imagePositionButton2 setTitle:NSLocalizedString(@"QMUIButton_Image_Position_Button_Title_2", @"Text above image") forState:UIControlStateNormal];
    self.imagePositionButton2.titleLabel.font = UIFontMake(11);
    self.imagePositionButton2.qmui_borderPosition = QMUIViewBorderPositionTop | QMUIViewBorderPositionBottom;
    [self.view addSubview:self.imagePositionButton2];
    
    
    self.imagePositionButton3 = [[QMUIButton alloc] init];
    self.imagePositionButton3.tintColorAdjustsTitleAndImage = UIColor.dk_tintColor;
    self.imagePositionButton3.imagePosition = QMUIButtonImagePositionLeft;// 将图片位置改为在文字左方
    self.imagePositionButton3.spacingBetweenImageAndTitle = 8;
    [self.imagePositionButton3 setImage:UIImageMake(@"icon_emotion") forState:UIControlStateNormal];
    [self.imagePositionButton3 setTitle:NSLocalizedString(@"QMUIButton_Image_Position_Button_Title_3", @"Text left image") forState:UIControlStateNormal];
    self.imagePositionButton3.titleLabel.font = UIFontMake(11);
    self.imagePositionButton3.qmui_borderPosition = QMUIViewBorderPositionTop | QMUIViewBorderPositionBottom;
    [self.view addSubview:self.imagePositionButton3];
    
    self.imagePositionButton4 = [[QMUIButton alloc] init];
    self.imagePositionButton4.tintColorAdjustsTitleAndImage = UIColor.dk_tintColor;
    self.imagePositionButton4.imagePosition = QMUIButtonImagePositionRight;// 将图片位置改为在文字右方
    self.imagePositionButton4.spacingBetweenImageAndTitle = 8;
    [self.imagePositionButton4 setImage:UIImageMake(@"icon_emotion") forState:UIControlStateNormal];
    [self.imagePositionButton4 setTitle:NSLocalizedString(@"QMUIButton_Image_Position_Button_Title_4", @"Text right image") forState:UIControlStateNormal];
    self.imagePositionButton4.titleLabel.font = UIFontMake(11);
    self.imagePositionButton4.qmui_borderPosition = QMUIViewBorderPositionTop | QMUIViewBorderPositionBottom;
    [self.view addSubview:self.imagePositionButton4];
    
    self.imageButtonSeparatorLayer = [CAShapeLayer qmui_separatorDashLayerWithLineLength:3 lineSpacing:2 lineWidth:PixelOne lineColor:UIColorSeparator.CGColor isHorizontal:NO];
    [self.view.layer addSublayer:self.imageButtonSeparatorLayer];
    self.imageButtonSeparatorLayer2 = [CAShapeLayer qmui_separatorDashLayerWithLineLength:3 lineSpacing:2 lineWidth:PixelOne lineColor:UIColorSeparator.CGColor isHorizontal:NO];
    [self.view.layer addSublayer:self.imageButtonSeparatorLayer2];
    
    self.loadingButton = [[DKCustomButton alloc] qmui_initWithSize:CGSizeMake(200, 40)];
    self.loadingButton.adjustsButtonWhenHighlighted = YES;
    self.loadingButton.titleLabel.font = UIFontBoldMake(14);
    [self.loadingButton setTitleColor:UIColorWhite forState:UIControlStateNormal];
    self.loadingButton.backgroundColor = UIColor.dk_tintColor;
    self.loadingButton.highlightedBackgroundColor = [UIColor.dk_tintColor qmui_transitionToColor:UIColorBlack progress:.15];// 高亮时的背景色
    self.loadingButton.layer.cornerRadius = 4;
    self.loadingButton.backgroundColor = UIColor.dk_tintColor;
    [self.loadingButton setTitle:NSLocalizedString(@"QMUIButton_Normal_Button_Title", @"按钮，支持高亮背景色") forState:UIControlStateNormal];
    self.loadingButton.loadingText = @"loading";
    @weakify(self);
    [self.loadingButton addEventType:DKCustomButtonEventTypeLoading clickBlock:^(DKCustomButton * _Nonnull sender) {
        @strongify(self);
        [self.loadingButton startLoadingAnimation];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self.loadingButton endAnimation];
        });
    }];
    [self.view addSubview:self.loadingButton];
    self.imageButtonSeparatorLayer3 = [CAShapeLayer qmui_separatorDashLayerWithLineLength:3 lineSpacing:2 lineWidth:PixelOne lineColor:UIColorSeparator.CGColor isHorizontal:NO];
    [self.view.layer addSublayer:self.imageButtonSeparatorLayer3];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    CGFloat contentMinY = self.qmui_navigationBarMaxYInViewCoordinator;
    CGFloat buttonSpacingHeight = DKButtonSpacingHeight;
    
    // 普通按钮
    self.normalButton.frame = CGRectSetXY(self.normalButton.frame, CGFloatGetCenter(CGRectGetWidth(self.view.bounds), CGRectGetWidth(self.normalButton.frame)), contentMinY + CGFloatGetCenter(buttonSpacingHeight, CGRectGetHeight(self.normalButton.frame)));
    self.separatorLayer.frame = CGRectFlatMake(0, contentMinY + buttonSpacingHeight - PixelOne, CGRectGetWidth(self.view.bounds), PixelOne);
    
    // 边框按钮
    self.borderedButton.frame = CGRectSetY(self.normalButton.frame, CGRectGetMaxY(self.separatorLayer.frame) + CGFloatGetCenter(buttonSpacingHeight, CGRectGetHeight(self.normalButton.frame)));
    
    // 图片+文字按钮
    self.imagePositionButton1.frame = CGRectFlatMake(0, contentMinY + buttonSpacingHeight * 2, CGRectGetWidth(self.view.bounds) / 2.0, buttonSpacingHeight);
    self.imagePositionButton2.frame = CGRectSetX(self.imagePositionButton1.frame, CGRectGetMaxX(self.imagePositionButton1.frame));
    self.imagePositionButton3.frame = CGRectFlatMake(0, contentMinY + buttonSpacingHeight * 3, CGRectGetWidth(self.view.bounds) / 2.0, buttonSpacingHeight);
    self.imagePositionButton4.frame = CGRectSetX(self.imagePositionButton3.frame, CGRectGetMaxX(self.imagePositionButton3.frame));
    
    self.imageButtonSeparatorLayer.frame = CGRectFlatMake(CGRectGetMaxX(self.imagePositionButton1.frame), CGRectGetMinY(self.imagePositionButton1.frame), PixelOne, buttonSpacingHeight);
    self.imageButtonSeparatorLayer2.frame = CGRectFlatMake(CGRectGetMaxX(self.imagePositionButton3.frame), CGRectGetMinY(self.imagePositionButton3.frame), PixelOne, buttonSpacingHeight);
    
    self.loadingButton.frame = CGRectFlatMake(dk_leftMargin, contentMinY + buttonSpacingHeight * 4 + CGFloatGetCenter(buttonSpacingHeight, CGRectGetHeight(self.loadingButton.frame)), CGRectGetWidth(self.view.bounds) - dk_leftMargin - dk_rightMargin, 40);
    
    self.imageButtonSeparatorLayer2.frame = CGRectFlatMake(CGRectGetMaxX(self.loadingButton.frame), CGRectGetMinY(self.loadingButton.frame), PixelOne, buttonSpacingHeight);
}

@end
