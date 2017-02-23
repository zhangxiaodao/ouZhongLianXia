//
//  EnterWorkTowerFirsetView.m
//  AEFT冷风扇
//
//  Created by 杭州阿尔法特 on 16/3/11.
//  Copyright © 2016年 阿尔法特. All rights reserved.
//

#import "EnterWorkTowerFirsetView.h"

@implementation EnterWorkTowerFirsetView

+ (UIView *)creatViewWithState:(NSArray *)stateArray withColor:(UIColor *)color withSuperView:(UIView *)superView{
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenW, kScreenH / 5.558333)];
    view.backgroundColor = color;
    [superView addSubview:view];
    
    
    UILabel *nowStateLable = [UILabel creatLableWithTitle:@"当前状态" andSuperView:view andFont:k17 andTextAligment:NSTextAlignmentLeft];
    nowStateLable.textColor = [UIColor whiteColor];
    nowStateLable.layer.borderWidth = 0;
    [nowStateLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kScreenW / 5.3571, kScreenH / 33.35));
        make.left.mas_equalTo(kScreenW / 20);
        make.top.mas_equalTo(view.mas_top).offset(10);
    }];
    
    NSArray *arr = [NSArray arrayWithObjects:@"模式", @"风速" , @"摆风" , @"制冷",  nil];
    for (int i = 0; i < 4; i ++) {
        
        NSString *text = stateArray[i];
        if (text.length == 0) {
            text = @"==";
        }
        UILabel *arrayLable = [UILabel creatLableWithTitle:[NSString stringWithFormat:@"%@" , text] andSuperView:view andFont:k19 andTextAligment:NSTextAlignmentCenter];
        arrayLable.tag = i;
        arrayLable.textColor = [UIColor whiteColor];
        arrayLable.layer.borderWidth = 0;
        [arrayLable mas_makeConstraints:^(MASConstraintMaker *make) {
            
            
            make.size.mas_equalTo(CGSizeMake((kScreenW * 2 / 3 - kScreenW / 20) / 4, kScreenH / 26.68));
            
            make.left.mas_equalTo(kScreenW / 20 + i * (kScreenW * 2 / 3 - kScreenW / 20) / 4);
            make.top.mas_equalTo(nowStateLable.mas_bottom).offset(kScreenH / 26.68);
        }];
        
        
        
        
        UILabel *downLable = [UILabel creatLableWithTitle:[NSString stringWithFormat:@"%@" , arr[i]] andSuperView:view andFont:k14 andTextAligment:NSTextAlignmentCenter];
        downLable.textColor = [UIColor whiteColor];
        downLable.layer.borderWidth = 0;
        [downLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake((kScreenW * 2 / 3 - kScreenW / 20) / 3, kScreenH / 26.68));
            make.centerX.mas_equalTo(arrayLable.mas_centerX);
            make.top.mas_equalTo(arrayLable.mas_bottom).offset(5);
        }];
    }
    
    UIButton *btn = [UIButton initWithTitle:@"" andColor:[UIColor clearColor] andSuperView:view];
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(view.height * 2 / 3, view.height * 2 / 3));
        make.right.mas_equalTo(- kScreenW / 15);
        make.top.mas_equalTo(view.mas_top).offset(kScreenW / 15);
    }];
    
    UIImageView *iamgeVIew = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"iconfont-kaiguan222"]];
    iamgeVIew.image = [iamgeVIew.image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    iamgeVIew.tintColor = [UIColor whiteColor];
    [btn addSubview:iamgeVIew];
    [iamgeVIew mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(view.height * 2 / 3, view.height * 2 / 3));
        make.centerX.mas_equalTo(btn.mas_centerX);
        make.centerY.mas_equalTo(btn.mas_centerY);
    }];
    
    return view;
}

@end
