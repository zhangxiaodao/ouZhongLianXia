//
//  UIImageView+Extension.m
//  联侠
//
//  Created by 杭州阿尔法特 on 16/9/16.
//  Copyright © 2016年 张海昌. All rights reserved.
//

#import "UIImageView+Extension.h"

@implementation UIImageView (Extension)

+ (UIImageView *)setImageViewColor:(UIImageView *)imageView andColor:(UIColor *)color {
    imageView.image = [imageView.image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    imageView.tintColor = color;
    return imageView;
}


@end
