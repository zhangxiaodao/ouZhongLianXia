//
//  CircleAnimation.m
//  联侠
//
//  Created by 杭州阿尔法特 on 16/10/10.
//  Copyright © 2016年 张海昌. All rights reserved.
//

#import "CircleAnimation.h"


static const CGFloat kMarkerRadius = 5.f; // 光标直径
static const CGFloat kAnimationTime = 10.0;
@interface CircleAnimation ()<CAAnimationDelegate>
//进度条底色
@property (nonatomic , strong) CAShapeLayer *bottomLayer;

@property (nonatomic , strong) CAShapeLayer *secondLayer;
@property (nonatomic , strong) CAShapeLayer *thirtLayer;
//光标1
@property (nonatomic , strong) UIImageView *markImageView;
//光标2
@property (nonatomic , strong) UIImageView *markerImageView2;

//圆直径
@property (nonatomic , assign) CGFloat circleRadius;
//弧线宽度
@property (nonatomic , assign) CGFloat lineWidth;
//开始角度
@property (nonatomic , assign) CGFloat startAngle;
//结束角度
@property (nonatomic , assign) CGFloat endAngle;
@end

@implementation CircleAnimation

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.circleRadius = self.width * 2 / 3;
        self.lineWidth = 1.f;
        self.startAngle = 0.f;
        self.endAngle = 360.f;
        
        [self initSubView];
    }
    return self;
}

- (void)initSubView{

    self.bottomLayer = [self setLayerWithRadiues:(self.circleRadius - self.lineWidth) andStrokeColor:kACOLOR(206, 241, 227, 1.0) andOperCity:1.0];
    
    self.secondLayer = [self setLayerWithRadiues:self.width * 5 / 6 andStrokeColor:[UIColor whiteColor] andOperCity:0.3];
    
    self.thirtLayer = [self setLayerWithRadiues:self.width andStrokeColor:[UIColor whiteColor] andOperCity:0.3];
    
    //将layser添加到图层
    [self.layer addSublayer:self.bottomLayer];
    [self.layer addSublayer:self.secondLayer];
    [self.layer addSublayer:self.thirtLayer];
}

- (CAShapeLayer *)setLayerWithRadiues:(CGFloat)rediues andStrokeColor:(UIColor *)color andOperCity:(CGFloat)opercity{
    //圆形路径
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(self.width / 2, self.height / 2) radius:rediues / 2 startAngle:degreesToRadians(self.startAngle) endAngle:degreesToRadians(self.endAngle) clockwise:YES];
    
    //底色
    //创建一个shapeLayer
    CAShapeLayer *layer = [CAShapeLayer layer];
    layer.frame = self.bounds;
    //闭环填充颜色
    layer.fillColor = [UIColor clearColor].CGColor;
    //边缘线颜色
    layer.strokeColor = color.CGColor;
    layer.opacity = opercity;
    //边缘线类型
    layer.lineCap = kCALineCapRound;
    //边缘线款度
    layer.lineWidth = self.lineWidth;
    //从贝塞尔曲线中获取形状
    layer.path = [path CGPath];
    
    return layer;
}

- (void)setIsAnimation:(NSString *)isAnimation{
    _isAnimation = isAnimation;
    if ([_isAnimation isEqualToString:@"YES"]) {
        [self createAnimationWithStartAngle:degreesToRadians(self.startAngle) endAngle:degreesToRadians(self.endAngle)];
    } else{
//        [self addMarkImageView];
    }

}

/**
 *  光标动画
 *
 *  @param startAngle 开始角度
 *  @param endAngle   结束角度
 */
- (void)createAnimationWithStartAngle:(CGFloat)startAngle endAngle:(CGFloat)endAngle{
    
    [self addMarkImageView];
    
    CAKeyframeAnimation *pathAnimation1 = [self setAnimationWithStartAngle:startAngle endAngle:endAngle andIsClockWise:YES];
    [self.markImageView.layer addAnimation:pathAnimation1 forKey:@"moveMarker"];
    
    CAKeyframeAnimation *pathAnimation2 = [self setAnimationWithStartAngle:startAngle endAngle:endAngle andIsClockWise:NO];
    [self.markerImageView2.layer addAnimation:pathAnimation2 forKey:@"moveMarker"];
    
    
    NSLog(@"_markImageView---%f , %f , _markImageView2---%f , %f" , _markerImageView2.layer.position.x , _markerImageView2.layer.position.y ,_markerImageView2.x , _markerImageView2.y);
    
}

- (void)addMarkImageView{
    
    self.markImageView.frame = CGRectMake((self.width - self.circleRadius) / 2 + self.circleRadius - kMarkerRadius / 2, self.height / 2, kMarkerRadius, kMarkerRadius);
    self.markImageView.layer.cornerRadius = self.markImageView.height / 2;
    [self addSubview:self.markImageView];
    
    self.markerImageView2.frame = CGRectMake((self.width - self.circleRadius) / 2 - kMarkerRadius / 2, self.height / 2, kMarkerRadius, kMarkerRadius);
    self.markerImageView2.layer.cornerRadius = self.markerImageView2.frame.size.height / 2;
    [self addSubview:self.markerImageView2];
}

- (CAKeyframeAnimation *)setAnimationWithStartAngle:(CGFloat)startAngle endAngle:(CGFloat)endAngle andIsClockWise:(BOOL)isClockWise {
    CAKeyframeAnimation *pathAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    pathAnimation.calculationMode = kCAAnimationPaced;
    pathAnimation.fillMode = kCAFillModeForwards;
    pathAnimation.removedOnCompletion = NO;
    pathAnimation.duration = kAnimationTime;
    pathAnimation.repeatCount = MAXFLOAT;
    pathAnimation.delegate = self;
    
    //设置动画路径
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathAddArc(path, NULL, self.width / 2, self.height / 2, (self.circleRadius - kMarkerRadius / 2) / 2, startAngle, endAngle, isClockWise);
    pathAnimation.path = path;
    CGPathRelease(path);
    
    return pathAnimation;
}

- (void)animationDidStart:(CAAnimation *)anim{
    
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag{
    
}

- (UIImageView *)markImageView{
    if (_markImageView == nil) {
        _markImageView = [[UIImageView alloc]init];
        _markImageView.backgroundColor = kKongJingYanSe;
    }
    
    return _markImageView;
}


- (UIImageView *)markerImageView2{
    if (_markerImageView2 == nil) {
        _markerImageView2 = [[UIImageView alloc] init];
        _markerImageView2.backgroundColor = [UIColor redColor];
    }
    return _markerImageView2;
}


@end
