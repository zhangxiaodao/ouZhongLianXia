//
//  SecondView.m
//  AEFT冷风扇
//
//  Created by 杭州阿尔法特 on 16/3/10.
//  Copyright © 2016年 阿尔法特. All rights reserved.
//

#import "SecondView.h"

@implementation SecondView

+ (SecondView *)creatSecondView{
    
    SecondView *view = [[SecondView alloc]init];
    
    UILabel *lable = [UILabel creatLableWithTitle:@"请添加设备" andSuperView:view andFont:k14 andTextAligment:NSTextAlignmentCenter];
    [lable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(view.mas_right);
        make.top.mas_equalTo(view.mas_top);
        make.bottom.mas_equalTo(view.mas_bottom);
    }];
    lable.backgroundColor = [UIColor greenColor];

    return view;
}

@end
