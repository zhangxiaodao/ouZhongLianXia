//
//  UIImage+Extension.m
//  联侠
//
//  Created by 杭州阿尔法特 on 16/7/19.
//  Copyright © 2016年 张海昌. All rights reserved.
//

#import "UIImage+Extension.h"

@implementation UIImage (Extension)


/**
 *  颜色转换为图片
 *
 *
 */
+ (UIImage *)imageWithColor:(UIColor *)color {
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

@end
