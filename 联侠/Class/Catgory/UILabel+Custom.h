//
//  UILabel+Custom.h
//  AEFT冷风扇
//
//  Created by 杭州阿尔法特 on 16/3/8.
//  Copyright © 2016年 阿尔法特. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (Custom)
#pragma mark - 创建UIlable
+ (UILabel *)initWithTitle:(NSString *)title andSuperView:(UIView *)view andFont:(NSInteger)value andtextAlignment:(NSTextAlignment)modle andMas_Left:(NSInteger)left;

+ (UILabel *)creatLableWithTitle:(NSString *)title andSuperView:(id)superView andFont:(NSInteger)value andTextAligment:(NSTextAlignment)modle;

@end
