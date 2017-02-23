//
//  WeatherView.m
//  联侠
//
//  Created by 杭州阿尔法特 on 2017/1/10.
//  Copyright © 2017年 张海昌. All rights reserved.
//

#import "WeatherView.h"

@implementation WeatherView
+ (void)creatViewWeatherDic:(NSMutableDictionary *)dic andSuperView:(UIImageView *)superView andWearthImage:(UIImage *)image andMainColor:(UIColor *)color{
    
    
    
    NSString *quality = dic[@"quality"];
    
    UILabel *kongQiZhiLiang = [UILabel creatLableWithTitle:[NSString stringWithFormat:@"空气质量: %@", quality] andSuperView:superView andFont:k17 andTextAligment:NSTextAlignmentLeft];
    kongQiZhiLiang.textColor = color;
    kongQiZhiLiang.layer.borderWidth = 0;
    [kongQiZhiLiang mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kScreenW / 2, kScreenW / 15));
        make.left.mas_equalTo(superView.mas_left).offset(kScreenW / 60);
        make.bottom.mas_equalTo(superView.mas_bottom).offset(- kScreenW / 60);
    }];
    
    UILabel *wenDu = [UILabel creatLableWithTitle:@"" andSuperView:superView andFont:k30 andTextAligment:NSTextAlignmentLeft];
    wenDu.layer.borderWidth = 0;
    wenDu.textColor = color;
    
    NSString *temperature = dic[@"temperature"];
    
    [NSString setNSMutableAttributedString:temperature.floatValue andSuperLabel:wenDu andDanWei:@"°C" andSize:k110 andTextColor:color isNeedTwoXiaoShuo:@"NO"];
    [wenDu mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kScreenW / 2, kScreenW / 3));
        make.left.mas_equalTo(kongQiZhiLiang.mas_left);
        make.top.mas_equalTo(superView.mas_top).offset(kScreenW / 60);
    }];

    
    UILabel *shiDu = [UILabel creatLableWithTitle:[NSString stringWithFormat:@"湿度: %@%%" , dic[@"humidity"]] andSuperView:superView andFont:k17 andTextAligment:NSTextAlignmentLeft];
    shiDu.layer.borderWidth = 0;
    shiDu.textColor = color;
    
    [shiDu mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kScreenW / 3, kScreenW / 15));
        make.left.mas_equalTo(kongQiZhiLiang.mas_right);
        make.centerY.mas_equalTo(kongQiZhiLiang.mas_centerY);
    }];
    
    UIImageView *weatherImageView = [[UIImageView alloc]init];
    weatherImageView.image = image;
    [superView addSubview:weatherImageView];
    
    [UIImageView setImageViewColor:weatherImageView andColor:color];
    [weatherImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kScreenW / 8, kScreenW / 8));
        make.right.mas_equalTo(superView.mas_right).offset(-kScreenW / 60);
        make.bottom.mas_equalTo(superView.mas_bottom).offset(-kScreenW / 80);
//        make.centerY.mas_equalTo(kongQiZhiLiang.mas_centerY);
    }];
}

@end
