//
//  UILabel+Custom.m
//  AEFT冷风扇
//
//  Created by 杭州阿尔法特 on 16/3/8.
//  Copyright © 2016年 阿尔法特. All rights reserved.
//

#import "UILabel+Custom.h"

@implementation UILabel (Custom)

+ (UILabel *)initWithTitle:(NSString *)title andSuperView:(UIView *)view andFont:(NSInteger)value andtextAlignment:(NSTextAlignment)modle andMas_Left:(NSInteger)left{
    UILabel *lable = [[UILabel alloc]init];
    lable.textColor = [UIColor grayColor];
    lable.textAlignment = modle;
    lable.numberOfLines = 0;
    
    //根据文字的大小计算lable的宽高
    CGSize size1 = [title sizeWithFont:lable.font constrainedToSize:CGSizeMake(lable.frame.size.width, MAXFLOAT) lineBreakMode:NSLineBreakByWordWrapping];
    //根据计算结果重新设置UILabel的尺寸
    [lable setFrame:CGRectMake(0, 10, 200, size1.height)];
    lable.text = title;
    
    [view addSubview:lable];
    lable.font = [UIFont systemFontOfSize:value];
    [lable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(left);
    }];
    return lable;
}

+ (UILabel *)creatLableWithTitle:(NSString *)title andSuperView:(id)superView andFont:(NSInteger)value andTextAligment:(NSTextAlignment)modle{
    UILabel *lable = [[UILabel alloc]init];
    lable.textAlignment = modle;
   
    lable.text = title;
    [superView addSubview:lable];
    lable.font = [UIFont fontWithName:kFontWithName size:value];
    lable.layer.cornerRadius = 5;
    lable.layer.masksToBounds = YES;
    lable.layer.borderWidth = 1;
    lable.layer.borderColor = [UIColor whiteColor].CGColor;
    lable.textColor = [UIColor blackColor];
    lable.numberOfLines = 0;
    lable.font = [UIFont fontWithName:kFontWithName size:value];
    return lable;
}



@end
