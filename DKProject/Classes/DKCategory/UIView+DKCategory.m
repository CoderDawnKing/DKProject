//
//  UIView+DKCategory.m
//  GardenManager
//
//  Created by 王 on 2019/6/23.
//  Copyright © 2019 wisezone. All rights reserved.
//

#import "UIView+DKCategory.h"
#import <objc/runtime.h>
#import <DKProject/DKColorConfigure.h>

static const NSString *dk_borderColorKey = @"dk_borderColor";
static const NSString *dk_borderWidthKey = @"dk_borderWidth";
static const NSString *dk_borderTypeKey = @"dk_borderType";
static const NSString *dk_tapBlockKey = @"dk_tapBlockKey";
static const NSString *dk_panBlockKey = @"dk_panBlockKey";
static const NSString *dk_longPressBlockKey = @"dk_longPressBlockKey";

@interface UIView ()
@property (nonatomic, copy) TapGestureRecognizerBlock tapGestureRecognizerBlock;
@property (nonatomic, copy) PanGestureRecognizerBlock panGestureRecognizerBlock;
@property (nonatomic, copy) LongPressGestureRecognizerBlock longPressGestureRecognizerBlock;
@end

@implementation UIView (DKCategory)
- (CGFloat)left{
    return self.frame.origin.x;
}

- (void)setLeft:(CGFloat)left{
    CGRect frame = self.frame;
    frame.origin.x = left;
    self.frame = frame;
}

- (CGFloat)right{
    return CGRectGetMaxX(self.frame);
}

-(void)setRight:(CGFloat)right{
    CGRect frame = self.frame;
    frame.origin.x = right - frame.size.width;
    self.frame = frame;
}

- (CGFloat)top{
    return self.frame.origin.y;
}

- (void)setTop:(CGFloat)top{
    CGRect frame = self.frame;
    frame.origin.y = top;
    self.frame = frame;
}

- (CGFloat)bottom{
    return CGRectGetMaxY(self.frame);
}

- (void)setBottom:(CGFloat)bottom{
    CGRect frame = self.frame;
    frame.origin.y = bottom - frame.size.height;
    self.frame = frame;
}

- (void)setX:(CGFloat)x
{
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}

- (void)setY:(CGFloat)y
{
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}

- (CGFloat)x
{
    return self.frame.origin.x;
}

- (CGFloat)y
{
    return self.frame.origin.y;
}

- (void)setCenterX:(CGFloat)centerX
{
    CGPoint center = self.center;
    center.x = centerX;
    self.center = center;
}

- (CGFloat)centerX
{
    return self.center.x;
}

- (void)setCenterY:(CGFloat)centerY
{
    CGPoint center = self.center;
    center.y = centerY;
    self.center = center;
}

- (CGFloat)centerY
{
    return self.center.y;
}

- (void)setWidth:(CGFloat)width
{
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}

- (void)setHeight:(CGFloat)height
{
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}

- (CGFloat)height
{
    return self.frame.size.height;
}

- (CGFloat)width
{
    return self.frame.size.width;
}

- (void)setSize:(CGSize)size
{
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
}

- (CGSize)size
{
    return self.frame.size;
}

- (void)setOrigin:(CGPoint)origin
{
    CGRect frame = self.frame;
    frame.origin = origin;
    self.frame = frame;
}

- (CGPoint)origin
{
    return self.frame.origin;
}

- (CGPoint)boundsCenter{
    return CGPointMake(self.width / 2.f, self.height / 2.f);
}

- (CGFloat)boundsCenterX{
    return self.width / 2.f;
}

- (CGFloat)boundsCenterY{
    return self.height / 2.f;
}

- (NSDictionary *)returnFontDicWith:(CGFloat)first{
    NSMutableParagraphStyle*paragraph = [[NSMutableParagraphStyle alloc]init
                                         ];
    paragraph.firstLineHeadIndent = first;//首行缩进
    paragraph.lineSpacing = 0;//行间距
    NSDictionary*attributes4 =@{NSParagraphStyleAttributeName: paragraph};
    return attributes4;
}

- (void)setRadius {
    [self setRoundingCorners:UIRectCornerAllCorners cornerRadii:0];
}

- (void)setRadiusWithCornerRadii:(CGFloat)cornerRadii {
    [self setRoundingCorners:UIRectCornerAllCorners cornerRadii:cornerRadii];
}

- (void)setRoundingCorners:(UIRectCorner)corners cornerRadii:(CGFloat)cornerRadii {
    [self layoutIfNeeded];
    if (@available(iOS 11.0, *)) {
        self.layer.cornerRadius = cornerRadii?:self.height/2;
        self.layer.maskedCorners = (CACornerMask)corners;
        self.layer.masksToBounds = YES;
    } else {
        //绘制圆角 要设置的圆角 使用“|”来组合
        cornerRadii = cornerRadii?:self.height/2;
        UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds byRoundingCorners:corners cornerRadii:CGSizeMake(cornerRadii, cornerRadii)];
        CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
        //设置大小
        maskLayer.frame = self.bounds;
        //设置图形样子
        maskLayer.path = maskPath.CGPath;
        self.layer.mask = maskLayer;
    }
}

- (void)addShadowDefault {
    [self addShadowRadius:10];
}

- (void)addShadowRadius:(CGFloat)shadowRadius {
    [self addShadowRadius:shadowRadius cornerRadius:shadowRadius];
}

- (void)addShadowRadius:(CGFloat)shadowRadius cornerRadius:(CGFloat)cornerRadius {
    [self addShadowWithColor:[UIColor blackColor] shadowOffset:CGSizeMake(0, 2) shadowOpacity:0.05 shadowRadius:shadowRadius cornerRadius:cornerRadius];
}

- (void)addShadowWithColor:(UIColor *)shadowColor shadowOffset:(CGSize)shadowOffset shadowOpacity:(CGFloat)shadowOpacity shadowRadius:(CGFloat)shadowRadius {
    [self addShadowWithColor:[UIColor blackColor] shadowOffset:CGSizeMake(0, 2) shadowOpacity:0.05 shadowRadius:shadowRadius cornerRadius:shadowRadius];
}

- (void)addShadowWithColor:(UIColor *)shadowColor shadowOffset:(CGSize)shadowOffset shadowOpacity:(CGFloat)shadowOpacity shadowRadius:(CGFloat)shadowRadius cornerRadius:(CGFloat)cornerRadius {
    [self addShadowWithColor:shadowColor shadowOffset:shadowOffset shadowOpacity:shadowOpacity shadowRadius:shadowRadius cornerRadius:cornerRadius roundingCorners:UIRectCornerAllCorners];
}

- (void)addShadowWithColor:(UIColor *)shadowColor shadowOffset:(CGSize)shadowOffset shadowOpacity:(CGFloat)shadowOpacity shadowRadius:(CGFloat)shadowRadius cornerRadius:(CGFloat)cornerRadius roundingCorners:(UIRectCorner)corners {
    // 阴影颜色
    self.layer.shadowColor = shadowColor.CGColor;
    // 阴影偏移，系统默认(0, -3)
    self.layer.shadowOffset = shadowOffset;
    // 阴影透明度，系统默认0
    self.layer.shadowOpacity = shadowOpacity;
    // 阴影半径，系统默认3
    self.layer.shadowRadius = shadowRadius;
    
    if (cornerRadius) {
        self.layer.masksToBounds = NO;
        
        if (@available(iOS 11.0, *)) {
            self.layer.maskedCorners = (CACornerMask)corners;
        } else {
            // Fallback on earlier versions
        }
        
        self.layer.cornerRadius = cornerRadius;
    }
}

- (void)viewShadowPathWithColor:(UIColor *)shadowColor shadowOpacity:(CGFloat)shadowOpacity shadowRadius:(CGFloat)shadowRadius shadowPathType:(DKShadowPathType)shadowPathType shadowPathWidth:(CGFloat)shadowPathWidth{
    
    self.layer.masksToBounds = NO;//必须要等于NO否则会把阴影切割隐藏掉
    self.layer.shadowColor = shadowColor.CGColor;// 阴影颜色
    self.layer.shadowOpacity = shadowOpacity;// 阴影透明度，默认0
    self.layer.shadowOffset = CGSizeZero;//shadowOffset阴影偏移，默认(0, -3),这个跟shadowRadius配合使用
    self.layer.shadowRadius = shadowRadius;//阴影半径，默认3
    CGRect shadowRect = CGRectZero;
    CGFloat originX,originY,sizeWith,sizeHeight;
    originX = 0;
    originY = 0;
    sizeWith = self.bounds.size.width;
    sizeHeight = self.bounds.size.height;
    
    if (shadowPathType == DKShadowPathTop) {
        shadowRect = CGRectMake(originX, originY-shadowPathWidth/2, sizeWith, shadowPathWidth);
    }else if (shadowPathType == DKShadowPathBottom){
        shadowRect = CGRectMake(originY, sizeHeight-shadowPathWidth/2, sizeWith, shadowPathWidth);
    }else if (shadowPathType == DKShadowPathLeft){
        shadowRect = CGRectMake(originX-shadowPathWidth/2, originY, shadowPathWidth, sizeHeight);
    }else if (shadowPathType == DKShadowPathRight){
        shadowRect = CGRectMake(sizeWith-shadowPathWidth/2, originY, shadowPathWidth, sizeHeight);
    }else if (shadowPathType == DKShadowPathCommon){
        shadowRect = CGRectMake(originX-shadowPathWidth/2, 2, sizeWith+shadowPathWidth, sizeHeight+shadowPathWidth/2);
    }else if (shadowPathType == DKShadowPathAround){
        shadowRect = CGRectMake(originX-shadowPathWidth/2, originY-shadowPathWidth/2, sizeWith+shadowPathWidth, sizeHeight+shadowPathWidth);
    }
    UIBezierPath *bezierPath = [UIBezierPath bezierPathWithRect:shadowRect];
    self.layer.shadowPath = bezierPath.CGPath;//阴影路径
}

- (void)addBorderDefault {
    [self addBorderWithColor:HexColor(COLOR_DDDDDD) width:.5f];
}

- (void)addBorderWithColor:(UIColor *)borderColor width:(CGFloat)borderWidth {
    self.layer.borderColor = borderColor.CGColor;
    self.layer.borderWidth = borderWidth;
}

- (void)setDk_borderColor:(UIColor *)dk_borderColor {
    for (CALayer *layer in self.layer.sublayers) {
        if ([layer isKindOfClass:[CAShapeLayer class]]) {
            layer.backgroundColor = dk_borderColor.CGColor;
        }
    }
    objc_setAssociatedObject(self, &dk_borderColorKey, dk_borderColor, OBJC_ASSOCIATION_COPY);
}

- (UIColor *)dk_borderColor {
    UIColor *color = objc_getAssociatedObject(self, &dk_borderColorKey);
    if (color) {
        return color;
    }
    return HexColor(COLOR_LINE);
}

- (void)setDk_borderType:(DKViewBorderType)dk_borderType {
    objc_setAssociatedObject(self, &dk_borderTypeKey, @(dk_borderType), OBJC_ASSOCIATION_ASSIGN);
    NSArray<CALayer *> *subLayers = self.layer.sublayers;
    NSArray<CALayer *> *removedLayers = [subLayers filteredArrayUsingPredicate:[NSPredicate predicateWithBlock:^BOOL(id  _Nullable evaluatedObject, NSDictionary<NSString *,id> * _Nullable bindings) {
        return [evaluatedObject isKindOfClass:[CAShapeLayer class]];
    }]];
    [removedLayers enumerateObjectsUsingBlock:^(CALayer * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [obj removeFromSuperlayer];
    }];
    if (self.dk_borderType == 0) return;
    
    if ((self.dk_borderType & DKViewBorderTypeNone) == DKViewBorderTypeNone) return;
    
    if (self.dk_borderWidth == 0) return;
    
    if ((self.dk_borderType & DKViewBorderTypeAll) == DKViewBorderTypeAll) {
        [self addBorderWithColor:self.dk_borderColor width:self.dk_borderWidth];
        return;
    }
    
    if ((self.dk_borderType & DKViewBorderTypeTop) == DKViewBorderTypeTop) {
        [self addBorderLayerWithType:DKViewBorderTypeTop];
    }
    
    if ((self.dk_borderType & DKViewBorderTypeLeft) == DKViewBorderTypeLeft) {
        [self addBorderLayerWithType:DKViewBorderTypeLeft];
    }
    
    if ((self.dk_borderType & DKViewBorderTypeBottom) == DKViewBorderTypeBottom) {
        [self addBorderLayerWithType:DKViewBorderTypeBottom];
    }
    
    if ((self.dk_borderType & DKViewBorderTypeRight) == DKViewBorderTypeRight) {
        [self addBorderLayerWithType:DKViewBorderTypeRight];
    }
}

- (DKViewBorderType)dk_borderType {
    DKViewBorderType type = [objc_getAssociatedObject(self, &dk_borderTypeKey) unsignedIntegerValue];
    return type?type:DKViewBorderTypeNone;
}

- (void)setDk_borderWidth:(CGFloat)dk_borderWidth {
    objc_setAssociatedObject(self, &dk_borderWidthKey, @(dk_borderWidth), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (CGFloat)dk_borderWidth {
    return [objc_getAssociatedObject(self, &dk_borderWidthKey) floatValue];
}

- (void)addBorderLayerWithType:(DKViewBorderType)type {
    [self layoutIfNeeded];
    CAShapeLayer *border = [CAShapeLayer layer];
    CGRect frame = CGRectMake(0.0f, 0.0f, 0.0f, 0.0f);
    switch (type) {
        case DKViewBorderTypeTop:
            frame = CGRectMake(0.0f, 0.0f, self.bounds.size.width, self.dk_borderWidth);
            break;
        case DKViewBorderTypeLeft:
            frame = CGRectMake(0.0f, 0.0f, self.dk_borderWidth, self.bounds.size.height);
            break;
        case DKViewBorderTypeBottom:
            frame = CGRectMake(0.0f, self.bounds.size.height - self.dk_borderWidth, self.bounds.size.width, self.dk_borderWidth);
            break;
        case DKViewBorderTypeRight:
            frame = CGRectMake(self.bounds.size.width - self.dk_borderWidth, 0.0f, self.dk_borderWidth, self.bounds.size.height);
            break;
        default:
            break;
    }
    border.frame = frame;
    border.backgroundColor = self.dk_borderColor.CGColor;
    [self.layer addSublayer:border];
}

/**
 *  通过 CAShapeLayer 方式绘制虚线
 *
 *  param lineLength:     虚线的宽度
 *  param lineSpacing:    虚线的间距
 *  param lineColor:      虚线的颜色
 *  param lineDirection   虚线的方向  YES 为水平方向， NO 为垂直方向
 **/
- (void)addDottedLineWithLineWidth:(CGFloat)lineWidth
                        lineSpacing:(CGFloat)lineSpacing
                          lineColor:(UIColor *)lineColor
                      lineDirection:(BOOL)isHorizonal {
    [self layoutIfNeeded];
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    [shapeLayer setBounds:self.bounds];
    if (isHorizonal) {
        [shapeLayer setPosition:CGPointMake(CGRectGetWidth(self.frame) / 2, CGRectGetHeight(self.frame))];
    } else{
        [shapeLayer setPosition:CGPointMake(CGRectGetWidth(self.frame) / 2, CGRectGetHeight(self.frame)/2)];
    }
    
    [shapeLayer setFillColor:[UIColor clearColor].CGColor];
    //  设置虚线颜色为blackColor
    [shapeLayer setStrokeColor:lineColor.CGColor];
    //  设置虚线宽度
    if (isHorizonal) {
        [shapeLayer setLineWidth:CGRectGetHeight(self.frame)];
    } else {

        [shapeLayer setLineWidth:CGRectGetWidth(self.frame)];
    }
    [shapeLayer setLineJoin:kCALineJoinRound];
    //  设置线宽，线间距
    [shapeLayer setLineDashPattern:[NSArray arrayWithObjects:[NSNumber numberWithFloat:lineWidth], [NSNumber numberWithFloat:lineSpacing], nil]];
    //  设置路径
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, NULL, 0, 0);

    if (isHorizonal) {
        CGPathAddLineToPoint(path, NULL,CGRectGetWidth(self.frame), 0);
    } else {
        CGPathAddLineToPoint(path, NULL, 0, CGRectGetHeight(self.frame));
    }

    [shapeLayer setPath:path];
    CGPathRelease(path);
    //  把绘制好的虚线添加上来
    [self.layer addSublayer:shapeLayer];
}

- (void)addDottedLineBorderWithColor:(UIColor *)borderColor width:(CGFloat)borderWidth cornerRadii:(CGFloat)cornerRadii {
    [self layoutIfNeeded];
    CAShapeLayer *border = [CAShapeLayer layer];
    //虚线的颜色
    border.strokeColor = borderColor.CGColor;
    //填充的颜色
    border.fillColor = [UIColor clearColor].CGColor;
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:self.bounds cornerRadius:cornerRadii];
    //设置路径
    border.path = path.CGPath;
    border.frame = self.bounds;
    //虚线的宽度
    border.lineWidth = borderWidth;
    
    //设置线条的样式
    //    border.lineCap = @"square";
    //虚线的间隔
    border.lineDashPattern = @[@4, @2];
    [self.layer addSublayer:border];
}

/**
 将 UIView 转换成 UIImage
 
 @param view 将要转换的View
 @return 新生成的 UIImage 对象
 */
- (UIImage *)dk_convertCreateImage {
    /*
     UIGraphicsBeginImageContextWithOptions(CGSize size, BOOL opaque, CGFloat scale)
     opaque 透明度，不透明设为YES；
     scale 缩放因子，设0时系统自动设置缩放比例图片清晰；设1.0时模糊
     */
    [self layoutIfNeeded];
    UIGraphicsBeginImageContextWithOptions(self.bounds.size, NO, 0.0);
    [self drawViewHierarchyInRect:self.bounds afterScreenUpdates:NO];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return newImage;
}

#pragma - mark 添加点击手势
- (void)setTapGestureRecognizerBlock:(TapGestureRecognizerBlock)tapGestureRecognizerBlock {
    objc_setAssociatedObject(self, &dk_tapBlockKey, tapGestureRecognizerBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
}
- (TapGestureRecognizerBlock)tapGestureRecognizerBlock {
    return objc_getAssociatedObject(self, &dk_tapBlockKey);
}
- (void)addTapGestureRecognizer:(TapGestureRecognizerBlock)tapGestureRecognizerBlock {
    self.tapGestureRecognizerBlock = tapGestureRecognizerBlock;
    self.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapClick:)];
    [self addGestureRecognizer:tap];
}
- (void)tapClick:(UITapGestureRecognizer *)tap {
    if (self.tapGestureRecognizerBlock) {
        self.tapGestureRecognizerBlock(tap);
    }
}

#pragma - mark 添加拖动手势
- (void)setPanGestureRecognizerBlock:(PanGestureRecognizerBlock)panGestureRecognizerBlock {
    objc_setAssociatedObject(self, &dk_panBlockKey, panGestureRecognizerBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
}
- (PanGestureRecognizerBlock)panGestureRecognizerBlock {
    return objc_getAssociatedObject(self, &dk_panBlockKey);
}
- (void)addPanGestureRecognizer:(PanGestureRecognizerBlock)panGestureRecognizerBlock {
    self.panGestureRecognizerBlock = panGestureRecognizerBlock;
    self.userInteractionEnabled = YES;
    UIPanGestureRecognizer *tap = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panClick:)];
    [self addGestureRecognizer:tap];
}
- (void)panClick:(UIPanGestureRecognizer *)pan {
    if (self.panGestureRecognizerBlock) {
        self.panGestureRecognizerBlock(pan);
    }
}

#pragma - mark 添加长按手势
- (void)setLongPressGestureRecognizerBlock:(LongPressGestureRecognizerBlock)longPressGestureRecognizerBlock {
    objc_setAssociatedObject(self, &dk_longPressBlockKey, longPressGestureRecognizerBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
}
- (LongPressGestureRecognizerBlock)longPressGestureRecognizerBlock {
    return objc_getAssociatedObject(self, &dk_longPressBlockKey);
}
- (void)addLongPressGestureRecognizer:(LongPressGestureRecognizerBlock)longPressGestureRecognizerBlock {
    self.longPressGestureRecognizerBlock = longPressGestureRecognizerBlock;
    self.userInteractionEnabled = YES;
    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressClick:)];
    [self addGestureRecognizer:longPress];
}
- (void)longPressClick:(UILongPressGestureRecognizer *)longPress {
    if (self.longPressGestureRecognizerBlock) {
        self.longPressGestureRecognizerBlock(longPress);
    }
}

- (void)removeAllGestureRecognizer {
    NSMutableArray *arrayM = [NSMutableArray arrayWithArray:self.gestureRecognizers];
    for (UIGestureRecognizer *ges in arrayM) {
        [self removeGestureRecognizer:ges];
    }
}

@end
