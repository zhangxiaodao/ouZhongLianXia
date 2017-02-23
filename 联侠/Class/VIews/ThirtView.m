//
//  ThirtView.m
//  AEFT冷风扇
//
//  Created by 杭州阿尔法特 on 16/3/10.
//  Copyright © 2016年 阿尔法特. All rights reserved.
//

#import "ThirtView.h"

@implementation ThirtView

+ (UIView *)creatViewWithIconArray:(NSArray *)imageArray andNameArray:(NSArray *)nameArray andSection:(NSInteger)section{
    UIView *view = [[UIView alloc] init];
    view.frame = CGRectMake(0, 0, kScreenW, kScreenH / 13.34 );
    
    UIImageView *imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:imageArray[section]]];
    [view addSubview:imageView];
    
    [UIImageView setImageViewColor:imageView andColor:[UIColor grayColor]];
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(view.height * 1 / 3, view.height * 1 / 3));
        make.left.mas_equalTo(kScreenW / 18.75);
        make.centerY.mas_equalTo(view.mas_centerY);
    }];
    
    UILabel *label = [UILabel creatLableWithTitle:[NSString stringWithFormat:@"%@" , nameArray[section]] andSuperView:view andFont:k14 andTextAligment:NSTextAlignmentLeft];
    label.textColor  =[UIColor grayColor];
    label.layer.borderWidth = 0;
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kScreenW / 2, view.height * 1 / 3));
        make.left.mas_equalTo(imageView.mas_right).offset(kScreenW / 18.75);
        make.centerY.mas_equalTo(view.mas_centerY);
    }];
    

    UIImageView *jianTouImage = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"iconfont-qianjin"]];
    [view addSubview:jianTouImage];
    [UIImageView setImageViewColor:jianTouImage andColor:[UIColor grayColor]];
    [jianTouImage mas_makeConstraints:^(MASConstraintMaker *make) {
         make.size.mas_equalTo(CGSizeMake(view.height * 1 / 3, view.height * 1 / 3));
        make.right.mas_equalTo(view.mas_right).offset(-20);
        make.centerY.mas_equalTo(view.mas_centerY);
    }];
    return view;
}

@end
