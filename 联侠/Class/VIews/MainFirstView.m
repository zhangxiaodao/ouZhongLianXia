//
//  MainFirstView.m
//  AEFT冷风扇
//
//  Created by 杭州阿尔法特 on 16/3/10.
//  Copyright © 2016年 阿尔法特. All rights reserved.
//

#import "MainFirstView.h"

@implementation MainFirstView

+ (void)creatViewWeatherDic:(NSMutableDictionary *)dic andSuperView:(UIImageView *)superView andWearthImage:(UIImage *)image{

    UIImageView *weatherImageView = [[UIImageView alloc]init];
    weatherImageView.tag = 1001;
    weatherImageView.image = image;
    [superView addSubview:weatherImageView];
    [weatherImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kScreenW / 8, (kScreenW / 8) / 1.143));
        make.centerX.mas_equalTo(superView.mas_centerX).offset(-(kScreenW /2 - kScreenW / 16 - kScreenW / 30));
        make.bottom.mas_equalTo(superView.mas_bottom).offset(- kScreenW / 30);
    }];
//    [UIImageView setImageViewColor:weatherImageView andColor:[UIColor whiteColor]];
    
    NSString *quality = dic[@"quality"];
    
    UILabel *kongQiZhiLiang = [UILabel creatLableWithTitle:[NSString stringWithFormat:@"空气质量 %@", quality] andSuperView:superView andFont:k14 andTextAligment:NSTextAlignmentLeft];
    kongQiZhiLiang.tag = 1002;
    kongQiZhiLiang.textColor = [UIColor whiteColor];
    kongQiZhiLiang.layer.borderWidth = 0;
   
    [kongQiZhiLiang mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kScreenW / 3, kScreenW / 15));

        make.left.mas_equalTo(weatherImageView.mas_right).offset(kScreenW / 30);
        make.bottom.mas_equalTo(weatherImageView.mas_centerY);
    }];
    
    UILabel *wenDu = [UILabel creatLableWithTitle:@"" andSuperView:superView andFont:k14 andTextAligment:NSTextAlignmentLeft];
    wenDu.tag = 1003;
    wenDu.layer.borderWidth = 0;
    wenDu.textColor = [UIColor whiteColor];
    
    NSString *temperature = dic[@"temp_curr"];

    NSMutableAttributedString *str3 = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"温度 %@°C", temperature]];
    [str3 addAttribute:NSFontAttributeName value:[UIFont fontWithName:kFontWithName size:k20] range:NSMakeRange(3, temperature.length)];
    wenDu.attributedText = str3;
    [wenDu mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kScreenW / 5, kScreenW / 15));
        make.left.mas_equalTo(weatherImageView.mas_right).offset(kScreenW / 30);
        make.top.mas_equalTo(weatherImageView.mas_centerY);
    }];
    
    UIView *fenGenView = [[UIView alloc]init];
    fenGenView.backgroundColor = [UIColor whiteColor];
    [superView addSubview:fenGenView];
    [fenGenView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(1, kScreenW / 15));
        make.left.mas_equalTo(wenDu.mas_right).offset(kScreenW / 30);
        make.top.mas_equalTo(weatherImageView.mas_centerY);
    }];
    
    UILabel *shiDu = [UILabel creatLableWithTitle:@"" andSuperView:superView andFont:k14 andTextAligment:NSTextAlignmentLeft];
    shiDu.tag = 1004;
    shiDu.layer.borderWidth = 0;
    shiDu.textColor = [UIColor whiteColor];
    
    NSString *humidity = dic[@"humidity"];

    NSMutableAttributedString *str2 = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"湿度 %@" , humidity]];
    [str2 addAttribute:NSFontAttributeName value:[UIFont fontWithName:kFontWithName size:k20] range:NSMakeRange(3, humidity.length)];
    shiDu.attributedText = str2;
    [shiDu mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kScreenW / 4, kScreenW / 15));
        make.left.mas_equalTo(fenGenView.mas_right).offset(kScreenW / 30);
        make.top.mas_equalTo(weatherImageView.mas_centerY);
    }];
    
    UILabel *cityName = [UILabel creatLableWithTitle:@"" andSuperView:superView andFont:k20 andTextAligment:NSTextAlignmentCenter];
    cityName.tag = 1005;
    cityName.layer.borderWidth = 0;
    cityName.textColor = [UIColor whiteColor];
    
    NSString *cityName11 = dic[@"cityName"];

    NSMutableAttributedString *str = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@" , cityName11]];
    [str addAttribute:NSFontAttributeName value:[UIFont fontWithName:kFontWithName size:k20] range:NSMakeRange(0, cityName11.length)];
    cityName.attributedText = str;
    [cityName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kScreenW / 5, kScreenW / 15));
        make.centerX.mas_equalTo(superView.mas_centerX).offset(kScreenW / 2.435064);
        make.top.mas_equalTo(weatherImageView.mas_centerY);
    }];
    
}

+ (void)setDataWeatherDic:(NSMutableDictionary *)dic andSuperView:(UIImageView *)superView andWearthImage:(UIImage *)image {
    UIImageView *imageView = [superView viewWithTag:1001];
    imageView.image = image;
    imageView.image = [imageView.image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    imageView.tintColor = [UIColor whiteColor];
    
    UILabel *lable1 = [superView viewWithTag:1002];
    NSString *quality = dic[@"quality"];
    lable1.text = [NSString stringWithFormat:@"空气质量 %@", quality];
  
    
    UILabel *lable2 = [superView viewWithTag:1003];
    NSString *temperature = dic[@"temperature"];

    NSMutableAttributedString *str3 = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"温度 %@°C", temperature]];
    [str3 addAttribute:NSFontAttributeName value:[UIFont fontWithName:kFontWithName size:k20] range:NSMakeRange(3, temperature.length)];
    lable2.attributedText = str3;
    
    
    UILabel *lable3 = [superView viewWithTag:1004];
    NSString *humidity = dic[@"humidity"];
    
    NSMutableAttributedString *str2 = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"湿度 %@%%" , humidity]];
    [str2 addAttribute:NSFontAttributeName value:[UIFont fontWithName:kFontWithName size:k20] range:NSMakeRange(3, humidity.length)];
    lable3.attributedText = str2;
    
    UILabel *lable4 = [superView viewWithTag:1005];
    NSString *cityName11 = dic[@"cityName"];
    
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@" , cityName11]];
    [str addAttribute:NSFontAttributeName value:[UIFont fontWithName:kFontWithName size:k20] range:NSMakeRange(0, cityName11.length)];
    lable4.attributedText = str;
}

@end
