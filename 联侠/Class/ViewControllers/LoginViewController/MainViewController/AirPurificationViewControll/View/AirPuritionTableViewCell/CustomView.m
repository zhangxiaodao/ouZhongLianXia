//
//  CustomView.m
//  联侠
//
//  Created by 杭州阿尔法特 on 16/5/31.
//  Copyright © 2016年 张海昌. All rights reserved.
//

#import "CustomView.h"

@implementation CustomView
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
    //一个不透明类型的Quartz 2D绘画环境,相当于一个画布,你可以在上面任意绘画
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetLineWidth(context, 0);//线的宽度
   UIColor *aColor = self.color;//blue蓝色
    CGContextSetFillColorWithColor(context, aColor.CGColor);//填充颜色
    
    /*画三角形*/
    //只要三个点就行跟画一条线方式一样，把三点连接起来
    CGPoint sPoints[3];//坐标点
    sPoints[0] =CGPointMake(0, 0);//坐标1
    sPoints[1] =CGPointMake(self.width / 2, self.height);//坐标2
    sPoints[2] =CGPointMake(self.width, 0);//坐标3
    CGContextAddLines(context, sPoints, 3);//添加线
    CGContextClosePath(context);//封起来
    CGContextDrawPath(context, kCGPathFillStroke); //根据坐标绘制路径
}
@end
