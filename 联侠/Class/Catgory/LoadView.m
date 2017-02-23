//
//  LoadView.m
//  联侠
//
//  Created by 杭州阿尔法特 on 2017/1/18.
//  Copyright © 2017年 张海昌. All rights reserved.
//

#import "LoadView.h"

@implementation LoadView

+ (UIView *)loadViewWithSuperView:(UIView *)superView andImage:(UIImage *)image andImageColor:(UIColor *)imageColor {
    UIView *view = [[UIView alloc]initWithFrame:superView.bounds];
    view.backgroundColor = [UIColor clearColor];
    [superView addSubview:view];
    
    UIImageView *imageView = [[UIImageView alloc]initWithImage:image];
    [view addSubview:imageView];
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kScreenW / 10, kScreenW / 10));
        make.centerX.mas_equalTo(view.mas_centerX);
        make.centerY.mas_equalTo(view.mas_centerY);
    }];
    [UIImageView setImageViewColor:imageView andColor:imageColor];
    
    CABasicAnimation *anim = [CABasicAnimation animation];
    anim.keyPath = @"";
    
    return view;
    
}

@end
