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
    
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:view.bounds];
    [view addSubview:imageView];
    imageView.contentMode = UIViewContentModeScaleToFill;
    imageView.image = [UIImage imageNamed:@"主页背景2.jpg"];
    
    UILabel *fenChenLable = [UILabel creatLableWithTitle:@"" andSuperView:view andFont:k15 andTextAligment:NSTextAlignmentCenter];
    fenChenLable.textColor = [UIColor blackColor];
    [fenChenLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(view.mas_centerX).offset(- kScreenW / 3.4);
        make.top.mas_equalTo(view.mas_top).offset(kScreenW / 12.5);
    }];
    
    CGFloat text1 = (text / 600000) * 0.1158 / 6;
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%.2fmg" , text1]];
    [str addAttribute:NSFontAttributeName value:[UIFont fontWithName:kFontWithName size:k20] range:NSMakeRange(0, [NSString stringWithFormat:@"%.2f", text1].length)];
    fenChenLable.attributedText = str;
    
    UIView *fenGeXianView = [[UIView alloc]init];
    [view addSubview:fenGeXianView];
    fenGeXianView.backgroundColor = kMainColor;
    [fenGeXianView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kScreenW / 4, 1));
        make.centerX.mas_equalTo(fenChenLable.mas_centerX);
        make.top.mas_equalTo(fenChenLable.mas_bottom);
    }];
    
    UILabel *yiGuoLvFenChenLable = [UILabel creatLableWithTitle:@"已过滤粉尘" andSuperView:view andFont:k12 andTextAligment:NSTextAlignmentCenter];
    yiGuoLvFenChenLable.textColor = [UIColor grayColor];
    [yiGuoLvFenChenLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(fenChenLable.mas_centerX);
        make.top.mas_equalTo(fenGeXianView.mas_bottom);
    }];
    
    UIView *fenGeXianView3 = [[UIView alloc]init];
    [view addSubview:fenGeXianView3];
    fenGeXianView3.backgroundColor = [UIColor grayColor];
    [fenGeXianView3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(1, kScreenW / 5.2));
        make.centerX.mas_equalTo(view.mas_centerX);
        make.top.mas_equalTo(view.mas_top).offset(kScreenW / 15);
    }];
    
    UILabel *timeLable1 = [UILabel creatLableWithTitle:@"" andSuperView:view andFont:k14 andTextAligment:NSTextAlignmentCenter];
    timeLable1.layer.borderWidth = 0;
    timeLable1.textColor = [UIColor blackColor];

    CGFloat time1 = time / 3600000;
    NSMutableAttributedString *str2 = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%.2f小时" , time1]];
    [str2 addAttribute:NSFontAttributeName value:[UIFont fontWithName:kFontWithName size:k20] range:NSMakeRange(0, [NSString stringWithFormat:@"%.2f", time1].length)];
    timeLable1.attributedText = str2;
    [timeLable1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(view.mas_centerX)
        .offset(kScreenW / 3.4);
        make.centerY.mas_equalTo(fenChenLable.mas_centerY);
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
    [sumTimeLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(timeLable1.mas_centerX);
        make.top.mas_equalTo(fenGeXianView2.mas_bottom);
    }];
    
    UILabel *leiJiJiangWenLable = [UILabel creatLableWithTitle:@"累计降温" andSuperView:view andFont:k12 andTextAligment:NSTextAlignmentCenter];
    leiJiJiangWenLable.backgroundColor = [UIColor blackColor];
    leiJiJiangWenLable.textColor = [UIColor whiteColor];
    [leiJiJiangWenLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(view.mas_centerX);
        make.top.mas_equalTo(fenGeXianView3.mas_bottom)
        .offset(kScreenW / 15);
    }];
    leiJiJiangWenLable.layer.cornerRadius = [leiJiJiangWenLable contentSize].height / 2;
    
    UILabel *timeLable = [UILabel creatLableWithTitle:@"" andSuperView:view andFont:k20 andTextAligment:NSTextAlignmentCenter];
    [timeLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(view.mas_centerX);
        make.top.mas_equalTo(leiJiJiangWenLable.mas_bottom)
        ;
    }];
    CGFloat temperature1 = (temperature / 3600000) * 6 + ((text - temperature) / 3600000) * 2;
    [NSString setNSMutableAttributedString:temperature1
                             andSuperLabel:timeLable andDanWei:@"°C"
                                   andSize:k60
                              andTextColor:kMainColor
                         isNeedTwoXiaoShuo:@"YES"];
    
    UILabel *xiaBiaoLable = [UILabel creatLableWithTitle:[NSString stringWithFormat:@"可以煮熟%.2f个鸡蛋" , (temperature1) / 90] andSuperView:view andFont:k12 andTextAligment:NSTextAlignmentCenter];
    [xiaBiaoLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(view.mas_centerX);
        make.top.mas_equalTo(timeLable.mas_bottom)
        .offset(-10);
    }];
    
    return view;
}
     
@end
