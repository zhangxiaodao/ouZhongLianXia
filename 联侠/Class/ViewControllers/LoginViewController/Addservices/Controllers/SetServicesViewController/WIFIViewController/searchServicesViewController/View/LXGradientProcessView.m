//
//  LXGradientProcessView.m
//  LXGradientProcessView
//
//  Created by Leexin on 15/12/20.
//  Copyright © 2015年 Garden.Lee. All rights reserved.
//

#import "LXGradientProcessView.h"
//#import "UIView+Extensions.h"
#import "UIColor+Extensions.h"

static const CGFloat kProcessLineW = 8.f;
static const CGFloat kNumberMarkWidth = 80.f;
static const CGFloat kNumberMarkHeight = 80.f;


@interface LXGradientProcessView ()

//@property (nonatomic, strong) CAShapeLayer *bottomLayer; // 进度条底色
@property (nonatomic, strong) CAShapeLayer *progressLayer;
@property (nonatomic, strong) CAGradientLayer *gradientLayer;
@property (nonatomic , strong) UILabel *label;
@property (nonatomic, strong) NSArray *colorArray;
@property (nonatomic, strong) NSArray *colorLocationArray;

@end

@implementation LXGradientProcessView

- (instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.colorArray = @[(id)[[UIColor colorWithHex:0x00feff] CGColor],
                            (id)[[UIColor colorWithHex:0x007aff] CGColor],
                            (id)[[UIColor colorWithHex:0xc4c4c4] CGColor]];
        self.colorLocationArray = @[@0.1, @0.5, @1];
        
        _label = [[UILabel alloc] init];
        _label.text = [NSString stringWithFormat:@"%.0f%%" , _percent * 100];
        _label.font = [UIFont systemFontOfSize:k30];
        _label.frame = CGRectMake(frame.size.width / 2 - kNumberMarkWidth / 2, frame.size.width / 2 - kNumberMarkHeight / 2, kNumberMarkWidth, kNumberMarkHeight);
        [self addSubview:_label];
        
        
        // 疑问：label只是用来做文字裁剪，能否不添加到view上。
        // 必须要把Label添加到view上，如果不添加到view上，label的图层就不会调用drawRect方法绘制文字，也就没有文字裁剪了。
        // 如何验证，自定义Label,重写drawRect方法，看是否调用,发现不添加上去，就不会调用
        
        
        // 创建渐变层
        CAGradientLayer *gradientLayer = [CAGradientLayer layer];
        
        gradientLayer.frame = _label.frame;
        
        // 设置渐变层的颜色，随机颜色渐变
        gradientLayer.colors = self.colorArray;
        
        // 疑问:渐变层能不能加在label上
        // 不能，mask原理：默认会显示mask层底部的内容，如果渐变层放在mask层上，就不会显示了
        
        // 添加渐变层到控制器的view图层上
        [self.layer addSublayer:gradientLayer];
        
        // mask层工作原理:按照透明度裁剪，只保留非透明部分，文字就是非透明的，因此除了文字，其他都被裁剪掉，这样就只会显示文字下面渐变层的内容，相当于留了文字的区域，让渐变层去填充文字的颜色。
        // 设置渐变层的裁剪层
        gradientLayer.mask = _label.layer;
        
        // 注意:一旦把label层设置为mask层，label层就不能显示了,会直接从父层中移除，然后作为渐变层的mask层，且label层的父层会指向渐变层，这样做的目的：以渐变层为坐标系，方便计算裁剪区域，如果以其他层为坐标系，还需要做点的转换，需要把别的坐标系上的点，转换成自己坐标系上点，判断当前点在不在裁剪范围内，比较麻烦。
        
        
        // 父层改了，坐标系也就改了，需要重新设置label的位置，才能正确的设置裁剪区域。
        _label.frame = gradientLayer.bounds;
        
    }
    return self;
}

- (void)setPercent:(CGFloat)percent {
    _percent = percent;
    NSLog(@"%f" , percent);
    _label.text = [NSString stringWithFormat:@"%.0f%%" , _percent * 100];
    [self drawRect:self.bounds];
    [self setNeedsDisplay];
    
    
    if (percent == 1.0) {
        NSLog(@"%@" , self.layer.sublayers);
    }
}

- (void)drawRect:(CGRect)rect {
    NSArray *array = self.layer.sublayers ;
    
    for (int i = 0; i < array.count; i++) {
        
        if (i == 0) {
            
        } else {
            [array[i] removeFromSuperlayer];
        }
        
        
    }
    
    self.progressLayer = [CAShapeLayer layer];
    CGMutablePathRef dottePath22 =  CGPathCreateMutable();
    self.progressLayer.lineWidth = kProcessLineW;
    self.progressLayer.strokeColor = [UIColor orangeColor].CGColor;
    self.progressLayer.fillColor = [UIColor clearColor].CGColor;
    CGPathAddArc(dottePath22, nil, rect.size.width / 2, rect.size.width / 2, rect.size.width / 2 - 5, M_PI_4 * 3, M_PI_4 * 3 +  M_PI_2 * 3 * _percent, NO);
    self.progressLayer.path = dottePath22;
    NSArray *arr22 = [[NSArray alloc] initWithObjects:[NSNumber numberWithInt:2],[NSNumber numberWithInt:3], nil];
    self.progressLayer.lineDashPhase = 1.0;
    self.progressLayer.lineDashPattern = arr22;
    CGPathRelease(dottePath22);
    [self.layer setMask:self.progressLayer];
    
    
    self.gradientLayer =  [CAGradientLayer layer];
    self.gradientLayer.frame = rect;
//    self.gradientLayer.masksToBounds = YES;
    [self.gradientLayer setColors:self.colorArray];
    [self.gradientLayer setLocations:self.colorLocationArray];
    [self.gradientLayer setStartPoint:CGPointMake(0, 0)];
    [self.gradientLayer setEndPoint:CGPointMake(1, 0)];
    
    [self.gradientLayer setMask:self.progressLayer];
    [self.layer addSublayer:self.gradientLayer];
}

@end
