//
//  UIButton+Custom.m
//  AEFT冷风扇
//
//  Created by 杭州阿尔法特 on 16/3/8.
//  Copyright © 2016年 阿尔法特. All rights reserved.
//

#import "UIButton+Custom.h"

@implementation UIButton (Custom)
+ (UIButton *)initWithTitle:(NSString *)title andColor:(UIColor *)color andSuperView:(UIView *)view{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(100, 100,90, 90);
    btn.layer.cornerRadius = 5;
    btn.layer.masksToBounds = YES;
    [btn setTitle:title forState:UIControlStateNormal];
    
    btn.titleLabel.textAlignment = NSTextAlignmentCenter;
    //button文字自适应button的高度
    btn.titleLabel.adjustsFontSizeToFitWidth = YES;
    btn.backgroundColor = color;
    
    [view addSubview:btn];
    return btn;
}

+ (instancetype)creatBtnWithLable:(NSString *)title andImageView:(UIImage *)image andSuperView:(UIView *)view andHeight:(CGFloat)height andWidth:(CGFloat)width andDoneAtcion:(nonnull SEL)doneAtcion andAgainDoneAtcion:(nonnull SEL)againAtcion {
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, 0, width, height);
    btn.layer.cornerRadius = 5;
    btn.layer.masksToBounds = YES;
    
    UILabel *lable = [UILabel creatLableWithTitle:@"xxxxxxxxx" andSuperView:btn andFont:14 andTextAligment:NSTextAlignmentLeft];
    [lable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(btn.height, btn.height));
        make.left.mas_equalTo(btn.mas_centerX);
        make.centerY.mas_equalTo(btn.centerY);
    }];
    
    UIImageView *imageView = [[UIImageView alloc]initWithImage:image];
    [btn.imageView addSubview:imageView];
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(btn.height, btn.height));
        make.right.mas_equalTo(btn.mas_centerX);
        make.centerY.mas_equalTo(btn.centerY);
    }];

    [view addSubview:btn];
    
    return btn;
}

- (void) setImage:(UIImage *)image withTitle:(NSString *)title forState:(UIControlState)stateType {
    //UIEdgeInsetsMake(CGFloat top, CGFloat left, CGFloat bottom, CGFloat right)
    
    CGSize titleSize = [title sizeWithFont:[UIFont fontWithName:kFontWithName size:14]];

    
    [self.imageView setContentMode:UIViewContentModeCenter];
    [self setImageEdgeInsets:UIEdgeInsetsMake(-8.0,
                                              0.0,
                                              0.0,
                                              0.0)];
    [self setImage:image forState:stateType];
    
    [self.titleLabel setContentMode:UIViewContentModeCenter];
    [self.titleLabel setBackgroundColor:[UIColor clearColor]];
//    [self.titleLabel setFont:HELVETICANEUEMEDIUM_FONT(12.0f)];
//    [self.titleLabel setTextColor:COLOR_ffffff];
    [self setTitleEdgeInsets:UIEdgeInsetsMake(30.0,
                                              0.0,
                                              0.0,
                                              0.0)];
    [self setTitle:title forState:stateType];
}


+ (UIButton *)creatBtnWithTitle:(NSString *)title andImage:(UIImage *)image andImageColor:(UIColor *)imageColor andWidth:(CGFloat)width andHeight:(CGFloat)height andSuperView:(UIView *)superView WithTarget:(nullable id)delegate andDoneAtcion:(nonnull SEL)doneAtcion andTag:(NSInteger)tag {
    
    UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, width, height)];
    button.tag = tag;
    button.backgroundColor = [UIColor clearColor];
    [superView addSubview:button];

    button.layer.borderWidth = 1;
    button.layer.borderColor = [UIColor colorWithRed:222/255.0 green:222/255.0 blue:222/255.0 alpha:1.0].CGColor;
    [button addTarget:delegate action:doneAtcion forControlEvents:UIControlEventTouchUpInside];
    
    
    UILabel *lable = [UILabel creatLableWithTitle:title andSuperView:button andFont:k12 andTextAligment:NSTextAlignmentCenter];
    lable.textColor = [UIColor lightGrayColor];
    lable.layer.borderWidth = 0;
    [lable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(width, height / 4));
        make.centerX.mas_equalTo(button.mas_centerX);
        make.bottom.mas_equalTo(button.mas_bottom).offset(- button.height / 10);
    }];
    
    UIImageView *imageView = [[UIImageView alloc]initWithImage:image];
    [button addSubview:imageView];

    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(height / 3, height / 3));
        make.centerX.mas_equalTo(button.mas_centerX);
        make.centerY.mas_equalTo(button.mas_centerY).offset(- button.height / 10);
    }];
    imageView.image = [imageView.image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    imageView.tintColor = imageColor;
    
    return button;
}

+ (void)setBtnOfImageAndLableWithSelected:(UIButton *)btn andBackGroundColor:(UIColor *)backgroundColor{
    btn.backgroundColor = backgroundColor;
    btn.subviews[1].tintColor = [UIColor whiteColor];
    UILabel *lable = btn.subviews[0];
    lable.textColor = [UIColor whiteColor];

}

+ (void)setBtnOfImageAndLableWithUnSelected:(UIButton *)btn andTintColor:(UIColor *)tintColor{
    btn.backgroundColor = [UIColor whiteColor];
    btn.subviews[1].tintColor = tintColor;
    UILabel *lable = btn.subviews[0];
    lable.textColor = [UIColor lightGrayColor];
}


+ (UIButton *)creatBtnWithTitle:(NSString *)title withLabelFont:(NSInteger)font withLabelTextColor:(UIColor *)textColor andSuperView:(UIView *)superView andBackGroundColor:(UIColor *)backGroundColor andHighlightedBackGroundColor:(UIColor *)highlightedBackGroundColor andwhtherNeendCornerRadius:(BOOL)cornerRadius WithTarget:(nullable id)delegate andDoneAtcion:(nonnull SEL)doneAtcion{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    if (backGroundColor) {
        [btn setBackgroundImage:[UIImage imageWithColor:backGroundColor] forState:UIControlStateNormal];
    }
    if (highlightedBackGroundColor) {
        [btn setBackgroundImage:[UIImage imageWithColor:highlightedBackGroundColor] forState:UIControlStateHighlighted];
    }
    
    [superView addSubview:btn];
    [btn addTarget:delegate action:doneAtcion forControlEvents:UIControlEventTouchUpInside];
    if (cornerRadius) {
        btn.layer.cornerRadius = kScreenW / 20;
    }
    btn.layer.masksToBounds = YES;
    
    btn.titleLabel.font = [UIFont systemFontOfSize:font];
//    btn.titleLabel.textColor = textColor;
    [btn setTitleColor:textColor forState:UIControlStateNormal];
    [btn setTitle:title forState:UIControlStateNormal];
    
    return btn;
}


@end
