//
//  FirstSectionView.m
//  AEFT冷风扇
//
//  Created by 杭州阿尔法特 on 16/3/10.
//  Copyright © 2016年 阿尔法特. All rights reserved.
//

#import "FirstSectionView.h"

@implementation FirstSectionView

+ (UIView *)creatViewWithFenChen:(CGFloat)text andTemperature:(CGFloat)temperature andTime:(CGFloat )time{
    
    UIView *view = [[UIView alloc]init];
    view.backgroundColor = [UIColor purpleColor];
    view.frame = CGRectMake(0, 0, kScreenW, kScreenH / 2.767634);
    
    UIImageView *imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"主页背景2.jpg"]];
    [view addSubview:imageView];
    imageView.frame = view.frame;
    
    UILabel *fenChenLable = [UILabel creatLableWithTitle:@"" andSuperView:view andFont:k15 andTextAligment:NSTextAlignmentCenter];
    fenChenLable.textColor = [UIColor blackColor];
    fenChenLable.layer.borderWidth = 0;


    CGFloat text1 = (text / 600000) * 0.1158 / 6;

    NSMutableAttributedString *str = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%.2fmg" , text1]];
    [str addAttribute:NSFontAttributeName value:[UIFont fontWithName:kFontWithName size:k20] range:NSMakeRange(0, [NSString stringWithFormat:@"%.2f", text1].length)];
    fenChenLable.attributedText = str;
    
    
    [fenChenLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kScreenW / 3, kScreenW / 14));
        make.centerX.mas_equalTo(view.mas_centerX).offset(- kScreenW / 3.4090909);
        make.top.mas_equalTo(view.mas_top).offset(kScreenH / 22.23333);
    }];
    
    UIView *fenGeXianView = [[UIView alloc]init];
    [view addSubview:fenGeXianView];
    fenGeXianView.backgroundColor = kMainColor;
    [fenGeXianView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kScreenW / 4, 1));
        make.centerX.mas_equalTo(fenChenLable.mas_centerX);
        make.top.mas_equalTo(fenChenLable.mas_bottom);
    }];
    
    UILabel *yiGuoLvFenChenLable = [UILabel creatLableWithTitle:@"已过滤粉尘" andSuperView:view andFont:k12 andTextAligment:NSTextAlignmentCenter];
    yiGuoLvFenChenLable.layer.borderWidth = 0;
    yiGuoLvFenChenLable.textColor = [UIColor grayColor];
    [yiGuoLvFenChenLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kScreenW / 3, kScreenW / 14));
        make.centerX.mas_equalTo(fenChenLable.mas_centerX);
        make.top.mas_equalTo(fenGeXianView.mas_bottom);
    }];
    
    UIView *fenGeXianView3 = [[UIView alloc]init];
    [view addSubview:fenGeXianView3];
    fenGeXianView3.backgroundColor = [UIColor grayColor];
    [fenGeXianView3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(1, kScreenH / 9));
        make.centerX.mas_equalTo(view.mas_centerX);
        make.top.mas_equalTo(view.mas_top).offset(kScreenH / 44.4666666);
    }];
    
    UILabel *timeLable1 = [UILabel creatLableWithTitle:@"" andSuperView:view andFont:k14 andTextAligment:NSTextAlignmentCenter];
    timeLable1.layer.borderWidth = 0;
    timeLable1.textColor = [UIColor blackColor];

    CGFloat time1 = time / 3600000;
    NSMutableAttributedString *str2 = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%.2f小时" , time1]];
    [str2 addAttribute:NSFontAttributeName value:[UIFont fontWithName:kFontWithName size:k20] range:NSMakeRange(0, [NSString stringWithFormat:@"%.2f", time1].length)];
    timeLable1.attributedText = str2;
    
    [timeLable1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kScreenW / 3, kScreenW / 14));
        make.centerX.mas_equalTo(view.mas_centerX).offset( kScreenW / 3.4090909);
        make.top.mas_equalTo(view.mas_top).offset(kScreenH / 22.23333);
    }];
    
    UIView *fenGeXianView2 = [[UIView alloc]init];
    [view addSubview:fenGeXianView2];
    fenGeXianView2.backgroundColor = kMainColor;
    
    [fenGeXianView2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kScreenW / 4, 1));
        make.centerX.mas_equalTo(timeLable1.mas_centerX);
        make.top.mas_equalTo(timeLable1.mas_bottom);
    }];
    
    UILabel *sumTimeLable = [UILabel creatLableWithTitle:@"累计运行时间" andSuperView:view andFont:k12 andTextAligment:NSTextAlignmentCenter];
    sumTimeLable.textColor = [UIColor grayColor];
    sumTimeLable.layer.borderWidth = 0;
    [sumTimeLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kScreenW / 3, kScreenW / 14));
        make.centerX.mas_equalTo(timeLable1.mas_centerX);
        make.top.mas_equalTo(fenGeXianView2.mas_bottom);

    }];
    
    UILabel *leiJiJiangWenLable = [UILabel creatLableWithTitle:@"累计降温" andSuperView:view andFont:k12 andTextAligment:NSTextAlignmentCenter];
    leiJiJiangWenLable.layer.borderWidth = 0;
    leiJiJiangWenLable.backgroundColor = [UIColor blackColor];
    leiJiJiangWenLable.textColor = [UIColor whiteColor];
    leiJiJiangWenLable.layer.cornerRadius = kScreenW / 36;
    [leiJiJiangWenLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kScreenW / 6, kScreenW / 18));
        make.centerX.mas_equalTo(view.mas_centerX);
        make.top.mas_equalTo(fenGeXianView3.mas_bottom).offset(kScreenH / 22.23333);
    }];
    
    UILabel *timeLable = [UILabel creatLableWithTitle:@"" andSuperView:view andFont:k20 andTextAligment:NSTextAlignmentCenter];
    timeLable.layer.borderWidth = 0;

    
    CGFloat temperature1 = (temperature / 3600000) * 6 + ((text - temperature) / 3600000) * 2;
//    NSLog(@"%f , %f" , temperature1 , temperature / 3600000 );
    NSMutableAttributedString *str3 = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%.2f°C" , temperature1]];
    [str3 addAttribute:NSForegroundColorAttributeName value:kMainColor range:NSMakeRange(0,[NSString stringWithFormat:@"%.2f", temperature1].length)];
   [str3 addAttribute:NSFontAttributeName value:[UIFont fontWithName:kFontWithName size:k60] range:NSMakeRange(0, [NSString stringWithFormat:@"%.2f", temperature1].length)];
    timeLable.attributedText = str3;
    [timeLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kScreenW * 2 / 3, kScreenW / 8));
        make.centerX.mas_equalTo(view.mas_centerX);
        make.top.mas_equalTo(leiJiJiangWenLable.mas_bottom).offset(kScreenH / 33.35);
    }];
    
    UILabel *xiaBiaoLable = [UILabel creatLableWithTitle:[NSString stringWithFormat:@"可以煮熟%.2f个鸡蛋" , (temperature1) / 90] andSuperView:view andFont:k12 andTextAligment:NSTextAlignmentCenter];
    xiaBiaoLable.layer.borderWidth = 0;
    [xiaBiaoLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(view.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(kScreenW / 2, kScreenW / 15));
        make.top.mas_equalTo(timeLable.mas_bottom);
    }];
    
    return view;
}
     
@end
