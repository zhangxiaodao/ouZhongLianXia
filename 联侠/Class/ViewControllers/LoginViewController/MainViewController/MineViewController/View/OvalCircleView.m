//
//  OvalCircleView.m
//  联侠
//
//  Created by 杭州阿尔法特 on 2017/4/19.
//  Copyright © 2017年 张海昌. All rights reserved.
//

#import "OvalCircleView.h"

@implementation OvalCircleView
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextAddEllipseInRect(context, rect);
    [[UIColor whiteColor]set];
    
}

@end
