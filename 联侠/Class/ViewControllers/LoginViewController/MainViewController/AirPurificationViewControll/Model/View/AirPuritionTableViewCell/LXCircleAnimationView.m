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

@interface LXCircleAnimationView ()

@property (nonatomic, strong) CAShapeLayer *bottomLayer; // 进度条底色
@property (nonatomic, strong) CAShapeLayer *progressLayer;
@property (nonatomic, strong) CAGradientLayer *gradientLayer; // 渐变进度条
@property (nonatomic, strong) UILabel *commentLabel; // 中间文字label

@property (nonatomic, assign) CGFloat circelRadius; //圆直径
@property (nonatomic, assign) CGFloat lineWidth; // 弧线宽度
@property (nonatomic, assign) CGFloat stareAngle; // 开始角度
@property (nonatomic, assign) CGFloat endAngle; // 结束角度
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
        
        [self addSubview:self.commentLabel];
        [self.commentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(self.mas_centerX);
            make.centerY.mas_equalTo(self.mas_centerY);
        }];
        
        
        UILabel *danWeiLable = [UILabel creatLableWithTitle:@"ug/m³" andSuperView:self andFont:k30 andTextAligment:NSTextAlignmentCenter];
        [danWeiLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(self.mas_centerX);
            make.top
            .mas_equalTo(self.commentLabel.mas_bottom);
        }];
        danWeiLable.textColor = kKongJingYanSe;

        [self initSubView];
    }
    return self;
}

- (void)initSubView {
    // 圆形路径
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(self.width / 2, self.height / 2)  radius:(self.circelRadius - self.lineWidth) / 2 startAngle:kDegreesToRadians(self.stareAngle) endAngle:kDegreesToRadians(self.endAngle) clockwise:YES];
    
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
}

#pragma mark - Setters / Getters
- (void)setText:(NSString *)text {
    _text = text;
    self.commentLabel.text = _text;
    [self setPercent:_text.floatValue / 3];
}

- (void)setPercent:(CGFloat)percent {
    _percent = percent;
    self.progressLayer.strokeEnd = _percent / 100.0;
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
