//
//  LXCircleAnimationView.m
//  LXCircleAnimationView
//
//  Created by Leexin on 15/12/18.
//  Copyright © 2015年 Garden.Lee. All rights reserved.
//

#import "LXCircleAnimationView.h"
#import "UIColor+Extensions.h"
#import "UIView+Extension.h"

#define kDegreesToRadians(x) (M_PI*(x)/180.0) //把角度转换成PI的方式
static const CGFloat kMarkerRadius = 10.f; // 光标直径
//static const CGFloat kAnimationTime = 1;

@interface LXCircleAnimationView ()

@property (nonatomic, strong) CAShapeLayer *bottomLayer; // 进度条底色
@property (nonatomic, strong) CAShapeLayer *progressLayer;
@property (nonatomic, strong) CAGradientLayer *gradientLayer; // 渐变进度条
@property (nonatomic, strong) UIImageView *markerImageView; // 光标
@property (nonatomic, strong) UIImageView *bgImageView; // 背景图片
@property (nonatomic, strong) UILabel *commentLabel; // 中间文字label

@property (nonatomic, assign) CGFloat circelRadius; //圆直径
@property (nonatomic, assign) CGFloat lineWidth; // 弧线宽度
@property (nonatomic, assign) CGFloat stareAngle; // 开始角度
@property (nonatomic, assign) CGFloat endAngle; // 结束角度

@property(nonatomic,strong)NSTimer *timer;
@property (nonatomic , assign) NSInteger num;

@property (nonatomic , assign) CGFloat sumTime;

@end

@implementation LXCircleAnimationView

#pragma mark - Life cycle

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        
        self.circelRadius = self.frame.size.width - 10.f;
        self.lineWidth = 8.f;
        self.stareAngle = -220.f;
        self.endAngle = 40.f;
        
        // 尺寸需根据图片进行调整
        self.bgImageView.frame = CGRectMake(6, 6, self.circelRadius, self.circelRadius * 2 / 3);
        [self addSubview:self.bgImageView];

        
        [self addSubview:self.commentLabel];
        [self.commentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(self.circelRadius, self.circelRadius / 4));
            make.centerX.mas_equalTo(self.mas_centerX);
            make.centerY.mas_equalTo(self.mas_centerY);
        }];
        
        
        UILabel *danWeiLable = [UILabel creatLableWithTitle:@"ug/m³" andSuperView:self andFont:k30 andTextAligment:NSTextAlignmentCenter];
        [danWeiLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(self.circelRadius, kScreenW / 10));
            make.centerX.mas_equalTo(self.mas_centerX);
            make.top.mas_equalTo(self.commentLabel.mas_bottom);
        }];
        danWeiLable.textColor = kKongJingYanSe;
        danWeiLable.layer.borderWidth = 0;
        

        [self initSubView];
    }
    return self;
}

- (void)initSubView {
//    self.backgroundColor = [UIColor blueColor];
    // 圆形路径
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(self.width / 2, self.height / 2)
                                                        radius:(self.circelRadius - self.lineWidth) / 2
                                                    startAngle:kDegreesToRadians(self.stareAngle)
                                                      endAngle:kDegreesToRadians(self.endAngle)
                                                     clockwise:YES];
    
    // 底色
    self.bottomLayer = [CAShapeLayer layer];
    self.bottomLayer.frame = self.bounds;
    self.bottomLayer.fillColor = [[UIColor clearColor] CGColor];
    self.bottomLayer.strokeColor = [[UIColor  colorWithRed:206.f / 256.f green:241.f / 256.f blue:227.f alpha:1.f] CGColor];
    self.bottomLayer.opacity = 0.5;
    self.bottomLayer.lineCap = kCALineCapRound;
    self.bottomLayer.lineWidth = self.lineWidth;
    self.bottomLayer.path = [path CGPath];
    [self.layer addSublayer:self.bottomLayer];
    
    self.progressLayer = [CAShapeLayer layer];
    self.progressLayer.frame = self.bounds;
    self.progressLayer.fillColor =  [[UIColor clearColor] CGColor];
    self.progressLayer.strokeColor  = [[UIColor whiteColor] CGColor];
    self.progressLayer.lineCap = kCALineCapRound;
    self.progressLayer.lineWidth = self.lineWidth;
    self.progressLayer.path = [path CGPath];
    self.progressLayer.strokeEnd = 0;
    [self.bottomLayer setMask:self.progressLayer];
    
    self.gradientLayer = [CAGradientLayer layer];
    self.gradientLayer.frame = self.bounds;
    [self.gradientLayer setColors:[NSArray arrayWithObjects:
                                   (id)[[UIColor colorWithHex:0x7FFF00] CGColor],
                                   [(id)[UIColor colorWithHex:0xFFEC8B] CGColor],
                                   (id)[[UIColor colorWithHex:0xEEEE00] CGColor],
                                   (id)[[UIColor colorWithHex:0xFF6347] CGColor],
                                   nil]];
    [self.gradientLayer setLocations:@[@0.2, @0.5, @0.7, @1]];
    [self.gradientLayer setStartPoint:CGPointMake(0, 0)];
    [self.gradientLayer setEndPoint:CGPointMake(1, 0)];
    [self.gradientLayer setMask:self.progressLayer];
    
    [self.layer addSublayer:self.gradientLayer];
    
    // 240 是用整个弧度的角度之和 |-200| + 20 = 220
    [self createAnimationWithStartAngle:kDegreesToRadians(self.stareAngle)
                               endAngle:kDegreesToRadians(self.endAngle)];
}

#pragma mark - Animation

- (void)createAnimationWithStartAngle:(CGFloat)startAngle endAngle:(CGFloat)endAngle { // 光标动画
    
    // 设置动画属性
    CAKeyframeAnimation *pathAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    pathAnimation.calculationMode = kCAAnimationPaced;
    pathAnimation.fillMode = kCAFillModeForwards;
    pathAnimation.removedOnCompletion = NO;
    pathAnimation.duration = _sumTime * 10;
    pathAnimation.repeatCount = 1;
    
    // 设置动画路径
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathAddArc(path, NULL, self.width / 2, self.height / 2, (self.circelRadius - kMarkerRadius / 2) / 2, startAngle, endAngle, 0);
    pathAnimation.path = path;
    CGPathRelease(path);
    
    self.markerImageView.frame = CGRectMake(-100, self.height, kMarkerRadius, kMarkerRadius);
    self.markerImageView.layer.cornerRadius = self.markerImageView.frame.size.height / 2;
//    [self addSubview:self.markerImageView];
    
    [self.markerImageView.layer addAnimation:pathAnimation forKey:@"moveMarker"];
}


#pragma mark - Setters / Getters

- (void)setBgImage:(UIImage *)bgImage {
    
    _bgImage = bgImage;
    self.bgImageView.image = bgImage;
}

- (void)setText:(NSString *)text {
    
    
    _text = text;

    NSLog(@"%@" , _text);
    
    _num = 0;
    if ([self.isAnimation isEqualToString:@"NO"]) {
        self.commentLabel.text = _text;
    } else {
        
        [self setPercent:_text.floatValue / 3];
        [_timer invalidate];
        _timer = nil;
        _timer = [NSTimer scheduledTimerWithTimeInterval:0.001 target:self selector:@selector(getTextToCommentLabel) userInfo:nil repeats:YES];
    }
    
}


- (void)setPercent:(CGFloat)percent {
    
    [self setPercent:percent animated:_isAnimation];
}

- (void)setPercent:(CGFloat)percent animated:(NSString *)animated {
    
    _percent = percent;
    
    NSLog(@"_percent----%f , %@" , _percent , _text);
    
    if ([animated isEqualToString:@"NO"]) {
        self.progressLayer.strokeEnd = _percent / 100.0;
    } else {
//        [NSTimer scheduledTimerWithTimeInterval:0 target:self selector:@selector(circleAnimation) userInfo:nil repeats:NO];
        [self circleAnimation];
    }
    
}


- (void)circleAnimation { // 弧形动画
    
    [CATransaction begin];
    [CATransaction setDisableActions:NO];
    [CATransaction setAnimationTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear]];
    [CATransaction setAnimationDuration:_text.floatValue / 0.001];
    self.progressLayer.strokeEnd = _percent / 100.0;
    [CATransaction commit];
    
}

- (void)getTextToCommentLabel {
    
    _num++;
//    _sumTime = _num * 0.001;
    
    
    self.commentLabel.text = [NSString stringWithFormat:@"%ld" , (long)_num];
    
    if (_num == _text.intValue) {
        
        _num = 0;
        [_timer invalidate];
        _timer = nil;
        self.commentLabel.text = _text;
        
        
//        _timer = [NSTimer scheduledTimerWithTimeInterval:0.01 target:self selector:@selector(getTextToCommentLabel222) userInfo:nil repeats:YES];
    }

}


//- (void)getTextToCommentLabel222 {
//    
//    _num++;
//
//    self.commentLabel.text = [NSString stringWithFormat:@"%ld" , (long)_num];
//    
//    if (_num == _text.intValue) {
//        [_timer invalidate];
//        _timer = nil;
//        _num = 0;
//        self.commentLabel.text = _text;
//    }
//    
//}

- (UIImageView *)markerImageView {
    
    if (nil == _markerImageView) {
        _markerImageView = [[UIImageView alloc] init];
        _markerImageView.backgroundColor = [UIColor colorWithHex:0x20B2AA];
//        _markerImageView.backgroundColor = [UIColor redColor];
        _markerImageView.alpha = 1;
        _markerImageView.layer.shadowColor = [UIColor colorWithHex:0x20B2AA].CGColor;
//        _markerImageView.layer.shadowColor = [UIColor blueColor].CGColor;
        _markerImageView.layer.shadowOffset = CGSizeMake(0, 0);
        _markerImageView.layer.shadowRadius = 3.f;
        _markerImageView.layer.shadowOpacity = 1;
    }
    return _markerImageView;
}

- (UIImageView *)bgImageView {
    
    if (nil == _bgImageView) {
        _bgImageView = [[UIImageView alloc] init];
    }
    return _bgImageView;
}

- (UILabel *)commentLabel {
    
    if (nil == _commentLabel) {
        _commentLabel = [[UILabel alloc] init];
        _commentLabel.font = [UIFont systemFontOfSize:k60];
        _commentLabel.textColor = kKongJingYanSe;
        _commentLabel.textAlignment = NSTextAlignmentCenter;
        _commentLabel.lineBreakMode = NSLineBreakByWordWrapping;
        _commentLabel.numberOfLines = 0;
    }
    return _commentLabel;
}

@end
