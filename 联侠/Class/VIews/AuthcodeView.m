//
//  AuthcodeView.m
//  AEFT冷风扇
//
//  Created by 杭州阿尔法特 on 16/3/17.
//  Copyright © 2016年 阿尔法特. All rights reserved.
//

#import "AuthcodeView.h"


#define kLineCount 4
#define kLineWidth 1.0
#define kCharCount 4
#define kFontSize [UIFont systemFontOfSize:arc4random() % 5 + 15]

@implementation AuthcodeView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.layer.cornerRadius = 5.0;
        self.layer.masksToBounds = YES;
        self.backgroundColor = kRandomColor;
        
        //获得随机验证码
        [self getAuthcode];
    }
    return self;
}

#pragma mark - 获得随机验证码
- (void)getAuthcode {
    //字符串素材
    _dataArray = [[NSArray alloc]initWithObjects:@"0", @"1", @"2" , @"3" , @"4" , @"5" , @"6" , @"7" , @"8" , @"9" ,  nil];
    _authCodeStr = [[NSMutableString alloc]initWithCapacity:kCharCount];
    
    //随即从数组中选取需要个数的字符串，拼接为验证码字符串
    for (int i = 0; i < kCharCount; i++) {
        NSInteger index = arc4random() % (_dataArray.count - 1);
        NSString *tempStr = [_dataArray objectAtIndex:index];
        _authCodeStr = (NSMutableString *)[_authCodeStr stringByAppendingString:tempStr];
    }
}

#pragma mark - 点击界面切换验证码
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self getAuthcode];
    
    //setNeedsDisplay调用drawRect方法实现view的绘制
    [self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect{
    [super drawRect:rect];
    
    //设置随机颜色
    self.backgroundColor = kRandomColor;
    //根据要显示的验证码字符串，计算长度，计算每个字符串的位置
    NSString *text = [NSString stringWithFormat:@"%@" , _authCodeStr];
    
    CGSize cSize = [@"A" sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:20]}];
    
    int width = rect.size.width / text.length - cSize.width;
    int height = rect.size.height - cSize.height;
    
    CGPoint point;
    
    //依次绘制每个字符串,可以设置现实的每个字符串的大小，颜色，样式等
    float pX , pY;
    
    for (int i = 0; i < text.length; i++) {
        pX = arc4random() % width + rect.size.width / text.length * i;
        pY = arc4random() % height;
        point = CGPointMake(pX, pY);
        
        unichar c = [text characterAtIndex:i];
        NSString *textC = [NSString stringWithFormat:@"%C" , c];
        
        [textC drawAtPoint:point withAttributes:@{NSFontAttributeName:kFontSize}];
    }
    
    //调用draw:之前，系统会向栈中亚茹一个CGContextRef，调用UIGraphicsGetCurrentContext()会取栈顶的CGContextRef
    CGContextRef context = UIGraphicsGetCurrentContext();
    //设直线条宽度
    CGContextSetLineWidth(context, kLineWidth);
    
    //绘制干扰线
    for (int i = 0; i < kLineCount; i++) {
        UIColor *color = kRandomColor;
        //设直线条填充颜色
        CGContextSetStrokeColorWithColor(context, color.CGColor);
        
        //设直线的起点
        pX = arc4random() % (int)rect.size.width;
        pY = arc4random() % (int)rect.size.height;
        CGContextMoveToPoint(context, pX, pY);
        
        //设直线的中点
        pX = arc4random() % (int)rect.size.width;
        pY = arc4random() % (int)rect.size.height;
        CGContextAddLineToPoint(context, pX, pY);
        
        //划线
        CGContextStrokePath(context);
    }
}

@end
