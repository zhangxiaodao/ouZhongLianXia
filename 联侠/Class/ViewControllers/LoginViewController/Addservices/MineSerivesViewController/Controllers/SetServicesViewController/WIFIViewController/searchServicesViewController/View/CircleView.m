//
//  CircleView.m
//  联侠
//
//  Created by 杭州阿尔法特 on 2017/1/11.
//  Copyright © 2017年 张海昌. All rights reserved.
//

#import "CircleView.h"

#define klineWidth 3
@implementation CircleView

- (void)setProgress:(CGFloat)progress {
    _progress = progress;
    
    //如果我们手动调用drawRect,系统不会给我们生成相关的上下文的
    //系统调用draw的时候，才会生成跟view相关连得上下文
    [self drawRect:self.bounds];
    //setNeedsDisplay 底层就会调用drawRect
    [self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect {
    UIBezierPath *backPath = [UIBezierPath bezierPathWithArcCenter:CGPointMake(rect.size.width / 2 , rect.size.width / 2) radius:rect.size.width / 2 - klineWidth startAngle:-M_PI_2 endAngle:M_PI * 3 / 2 clockwise:YES];
    backPath.lineWidth = klineWidth;
    backPath.lineCapStyle = kCGLineCapRound;
    [kFenGeXianYanSe set];
    [backPath stroke];
    
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(rect.size.width / 2 , rect.size.width / 2) radius:rect.size.width / 2 - klineWidth startAngle:-M_PI_2 endAngle:-M_PI_2 + _progress * M_PI * 2 clockwise:YES];
    path.lineWidth = klineWidth;
    path.lineCapStyle = kCGLineCapRound;
    [kMainColor set];
    [path setLineWidth:klineWidth];
    [path stroke];
}

@end
