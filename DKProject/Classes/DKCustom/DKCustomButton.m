//
//  DKCustomButton.m
//  GardenManager
//
//  Created by 王 on 2019/6/24.
//  Copyright © 2019 wisezone. All rights reserved.
//

#import "DKCustomButton.h"
#import <DKProject/UIView+DKCategory.h>
#import <DKProject/UIButton+DKCategory.h>
#import <DKProject/DKColorConfigure.h>

@interface DKCustomButton (){
    DKCustomButtonType _type;
    DKCustomButtonEventType _eventType;
}
@property (nonatomic, copy) DKCustomButtonClickBlock block;
@property (nonatomic, strong) CAGradientLayer *gradientLayer;
@property (nonatomic, strong) CALayer *baseLayer;
@property (nonatomic, copy) NSString *normalText;
@property (nonatomic, assign) CGFloat margin;

@end

@implementation DKCustomButton

///验证码倒计时
static NSInteger const timecount = 60;

static const CGFloat loadingRadius = 13;
static const CGFloat loadingLineWidth = 2;

- (instancetype)initWithType:(DKCustomButtonType)type {
    _type = type;
    return [self init];
}

- (instancetype)initWithType:(DKCustomButtonType)type title:(nullable NSString *)title image:(nullable UIImage *)image color:(nullable UIColor *)color font:(nullable UIFont *)font {
    return [self initWithType:type title:title image:image color:color font:font margin:0];
}

- (instancetype)initWithType:(DKCustomButtonType)type title:(nullable NSString *)title image:(nullable UIImage *)image color:(nullable UIColor *)color font:(nullable UIFont *)font margin:(CGFloat)margin {
    _margin = margin;
    _type = type;
    return [self initWithTitle:title image:image color:color font:font];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    if (_type == DKCustomButtonTypeRightImage) {
        self.titleLabel.x = 0;
        self.imageView.x = self.width - self.imageView.width + self.margin;
    }
    if (_type == DKCustomButtonTypeTopImage) {
        self.imageView.y = self.imageTop;
        self.imageView.centerX = self.width/2;
        self.titleLabel.y = self.imageView.height + self.imageView.y;
        self.titleLabel.width = self.width;
        self.titleLabel.centerX = self.width/2;
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
    }
    self.baseLayer.position = CGPointMake(self.titleLabel.x - 25, self.titleLabel.center.y);
}

- (void)addEventType:(DKCustomButtonEventType)eventType clickBlock:(DKCustomButtonClickBlock)clickBlock {
    self.block = clickBlock;
    _eventType = eventType;
    [self addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)buttonClick:(DKCustomButton *)sender {
    if (self.block) {
        self.block(sender);
    }
    if (_eventType == DKCustomButtonEventTypeValidateCode) {
        __block NSInteger second = timecount;
        __block NSString *normalTitle = sender.titleLabel.text;
        dispatch_queue_t quene = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
        dispatch_source_t timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, quene);
        dispatch_source_set_timer(timer, DISPATCH_TIME_NOW, 1 * NSEC_PER_SEC, 0 * NSEC_PER_SEC);
        dispatch_source_set_event_handler(timer, ^{
            dispatch_async(dispatch_get_main_queue(), ^{
                if (second == 0) {
                    sender.enabled = YES;
                    [sender setTitle:[NSString stringWithFormat:@"%@", normalTitle] forState:UIControlStateNormal];
                    second = timecount;
                    dispatch_cancel(timer);
                } else {
                    sender.enabled = NO;
                    [sender setTitle:[NSString stringWithFormat:@"%ld秒",second] forState:UIControlStateNormal];
                    second--;
                }
            });
        });
        dispatch_resume(timer);
    }
    if (_eventType == DKCustomButtonEventTypeLoading) {
        self.normalText = [self titleForState:UIControlStateNormal];
        [self startLoadingAnimation];
    }
}

#pragma - mark 按钮等待动画
- (void)startLoadingAnimation {
    self.userInteractionEnabled = NO;
    if (self.loadingText) {
        [self setTitle:self.loadingText forState:UIControlStateNormal];
    }
    
    self.baseLayer = [CALayer layer];
    self.baseLayer.backgroundColor = [UIColor whiteColor].CGColor; //圆环底色
    self.baseLayer.bounds = CGRectMake(0, 0, loadingRadius * 2, loadingRadius * 2);
    
    //创建一个圆环
    UIBezierPath *bezierPath = [UIBezierPath bezierPathWithArcCenter:CGPointMake(loadingRadius, loadingRadius) radius:loadingRadius-loadingLineWidth startAngle:0 endAngle:M_PI*2 clockwise:YES];
    
    //圆环遮罩
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.fillColor = [UIColor clearColor].CGColor;
    shapeLayer.strokeColor = [UIColor whiteColor].CGColor;
    shapeLayer.lineWidth = loadingLineWidth;
    shapeLayer.strokeStart = 0;
    shapeLayer.strokeEnd = 0.8;
    shapeLayer.lineCap = @"round";
    shapeLayer.lineDashPhase = 0.8;
    shapeLayer.path = bezierPath.CGPath;
    
    //颜色渐变 由白变红
    NSMutableArray *colors = [NSMutableArray arrayWithObjects:(id)dk_HexColor(DK_COLOR_WHITE).CGColor,(id)self.backgroundColor.CGColor, nil];
    self.gradientLayer = [CAGradientLayer layer];
    self.gradientLayer.shadowPath = bezierPath.CGPath;
    //x=0,y=0,头部渐变
    self.gradientLayer.frame = CGRectMake(loadingRadius-5, loadingRadius-5, loadingRadius+5, loadingRadius+5);
    self.gradientLayer.startPoint = CGPointMake(0, 1);
    self.gradientLayer.endPoint = CGPointMake(1, 0);
    [self.gradientLayer setColors:[NSArray arrayWithArray:colors]];
    [self.baseLayer addSublayer:self.gradientLayer]; //设置颜色渐变
    [self.baseLayer setMask:shapeLayer]; //设置圆环遮罩
    
    CABasicAnimation *rotationAnimation2 = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    rotationAnimation2.fromValue = [NSNumber numberWithFloat:0];
    rotationAnimation2.toValue = [NSNumber numberWithFloat:6.0*M_PI];
    rotationAnimation2.repeatCount = MAXFLOAT;
    rotationAnimation2.duration = 2;
    
    [self.baseLayer addAnimation:rotationAnimation2 forKey:@"transform.rotation.z"];
    
    [self.layer addSublayer:self.baseLayer];
}

#pragma - mark 结束动画
- (void)endAnimation {
    self.userInteractionEnabled = YES;
    if (self.normalText) {
        [self setTitle:self.normalText forState:UIControlStateNormal];
    }
    [self.baseLayer removeFromSuperlayer];
}

@end
