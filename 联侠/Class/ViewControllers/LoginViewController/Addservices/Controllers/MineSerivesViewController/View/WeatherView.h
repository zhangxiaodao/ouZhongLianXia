//
//  WeatherView.h
//  联侠
//
//  Created by 杭州阿尔法特 on 2017/1/10.
//  Copyright © 2017年 张海昌. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WeatherView : UIView
+ (void)creatViewWeatherDic:(NSMutableDictionary *)dic andSuperView:(UIImageView *)superView andWearthImage:(UIImage *)image andMainColor:(UIColor *)color;

@property (nonatomic , strong) NSDictionary *weatherDic;
@property (nonatomic , copy) UIImage *weartherImage;

@end
