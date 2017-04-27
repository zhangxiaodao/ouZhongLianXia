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
    
    UIImageView *weatherImageView = [[UIImageView alloc]init];
    [superView addSubview:weatherImageView];
    [weatherImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kScreenW / 2.34275, kScreenH / 4.75));
        make.left.mas_equalTo(superView.mas_left);
        make.top.mas_equalTo(superView.mas_top).offset(kScreenW / 50);
    }];
    weatherImageView.image = image;
//    weatherImageView.backgroundColor = [UIColor redColor];
    
    UILabel *wenDu = [UILabel creatLableWithTitle:@"" andSuperView:superView andFont:k30 andTextAligment:NSTextAlignmentLeft];
    wenDu.layer.borderWidth = 0;
    wenDu.textColor = color;
    
    NSString *temperature = dic[@"temp_curr"];
    
    [NSString setNSMutableAttributedString:temperature.floatValue andSuperLabel:wenDu andDanWei:@"°C" andSize:k60 andTextColor:color isNeedTwoXiaoShuo:@"NO"];
    [wenDu mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kScreenW / 2, kScreenW / 6.8));
        make.left.mas_equalTo(weatherImageView.mas_right);
        make.centerY.mas_equalTo(weatherImageView.mas_centerY).offset(-kScreenH / 25.6);
    }];
    
    UILabel *shiDu = [UILabel creatLableWithTitle:[NSString stringWithFormat:@"湿度: %@%%" , dic[@"humidity"]] andSuperView:superView andFont:k13 andTextAligment:NSTextAlignmentLeft];
    shiDu.layer.borderWidth = 0;
    [NSString setAttributedString:shiDu.text WithSubString:3 andSize:k21 andTextColor:color isNeedTwoXiaoShuo:@"NO" andSuperLabel:shiDu];
    [shiDu mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kScreenW / 4, kScreenW / 15));
        make.left.mas_equalTo(wenDu.mas_left);
        make.centerY.mas_equalTo(weatherImageView.mas_centerY).offset(kScreenH / 25.6);
    }];
    
    NSString *quality = dic[@"quality"];
    
    
    if ([quality isEqualToString:@"中度污染"] || [quality isEqualToString:@"严重污染"]) {
        quality = @"差";
    } else if ([quality isEqualToString:@"轻度污染"]) {
        quality = @"中";
    }
    
    UILabel *kongQiZhiLiang = [UILabel creatLableWithTitle:[NSString stringWithFormat:@"空气质量: %@", quality] andSuperView:superView andFont:k13 andTextAligment:NSTextAlignmentLeft];
    [NSString setAttributedString:kongQiZhiLiang.text WithSubString:5 andSize:k21 andTextColor:color isNeedTwoXiaoShuo:@"NO" andSuperLabel:kongQiZhiLiang];
    kongQiZhiLiang.layer.borderWidth = 0;
    [kongQiZhiLiang mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kScreenW / 2, kScreenW / 15));
        make.left.mas_equalTo(shiDu.mas_right).offset(kScreenW / 60);
        make.centerY.mas_equalTo(shiDu.mas_centerY);
    }];
    
    UILabel *weather = [UILabel creatLableWithTitle:dic[@"weather_curr"] andSuperView:superView andFont:k13 andTextAligment:NSTextAlignmentCenter];
    weather.layer.borderWidth = 0;
    [weather mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kScreenW / 3, kScreenW / 15));
        make.centerX.mas_equalTo(weatherImageView.mas_centerX);
        make.bottom.mas_equalTo(weatherImageView.mas_bottom);
    }];
    weather.textColor = [UIColor whiteColor];
    
    UILabel *winp = [UILabel creatLableWithTitle:dic[@"winp"] andSuperView:superView andFont:k13 andTextAligment:NSTextAlignmentLeft];
    winp.layer.borderWidth = 0;
    [winp mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kScreenW / 8, kScreenW / 15));
        make.left.mas_equalTo(wenDu.mas_left);
        make.centerY.mas_equalTo(weather.mas_centerY);
    }];
    
    UIImageView *localImageView = [[UIImageView alloc]init];
    [superView addSubview:localImageView];
    [localImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kScreenW / 37.5, kScreenW / 25));
        make.left.mas_equalTo(winp.mas_right).offset(kScreenW / 50);
        make.centerY.mas_equalTo(weather.mas_centerY);
    }];
    
    localImageView.image = [UIImage imageNamed:@"localImage"];
//    localImageView.backgroundColor = [UIColor redColor];
    
    UILabel *cityName = [UILabel creatLableWithTitle:dic[@"cityName"] andSuperView:superView andFont:k13 andTextAligment:NSTextAlignmentLeft];
    cityName.layer.borderWidth = 0;
    [cityName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kScreenW / 6, kScreenW / 15));
        make.left.mas_equalTo(localImageView.mas_right).offset(5);
        make.centerY.mas_equalTo(weather.mas_centerY);
    }];
    winp.textColor = [UIColor whiteColor];
    cityName.textColor = [UIColor whiteColor];
}

@end
