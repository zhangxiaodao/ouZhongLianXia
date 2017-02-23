//
//  UIButton+Custom.h
//  AEFT冷风扇
//
//  Created by 杭州阿尔法特 on 16/3/8.
//  Copyright © 2016年 阿尔法特. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (Custom)

+ (UIButton * _Nonnull)initWithTitle:(NSString * _Nonnull)title andColor:(UIColor * _Nonnull)color andSuperView:(UIView * _Nonnull)view;

+ (UIButton * _Nonnull)creatBtnWithTitle:(NSString * _Nonnull)title withLabelFont:(NSInteger)font withLabelTextColor:(UIColor * _Nonnull)textColor andSuperView:(UIView * _Nonnull)superView andBackGroundColor:(UIColor * _Nonnull)backGroundColor andHighlightedBackGroundColor:(UIColor * _Nonnull)highlightedBackGroundColor andwhtherNeendCornerRadius:(BOOL)cornerRadius WithTarget:(nullable id)delegate andDoneAtcion:(nonnull SEL)doneAtcion;

+ (UIButton * _Nonnull)creatBtnWithTitle:(NSString * _Nonnull)title andImage:(UIImage * _Nonnull)image andImageColor:(UIColor * _Nonnull)imageColor andWidth:(CGFloat)width andHeight:(CGFloat)height andSuperView:(UIView * _Nonnull)superView WithTarget:(nullable id)delegate andDoneAtcion:(nonnull SEL)doneAtcion andTag:(NSInteger)tag;

+ (void)setBtnOfImageAndLableWithSelected:(UIButton * _Nonnull)btn andBackGroundColor:(UIColor * _Nonnull)backgroundColor;

+ (void)setBtnOfImageAndLableWithUnSelected:(UIButton * _Nonnull)btn andTintColor:(UIColor * _Nonnull)tintColor;

@end
