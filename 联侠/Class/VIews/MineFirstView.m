//
//  MineFirstView.m
//  AEFT冷风扇
//
//  Created by 杭州阿尔法特 on 16/3/12.
//  Copyright © 2016年 阿尔法特. All rights reserved.
//

#import "MineFirstView.h"

@implementation MineFirstView

+ (UIView *)creatViewWithHead:(UIImage *)image  andUserName:(NSString *)name andSuperView:(UIView *)superView{
    UIView *view = [[UIView alloc]init];
    [superView addSubview:view];
    
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kScreenW + 2, kScreenH / 6.682352));
        make.top.mas_equalTo(kScreenH / 16.70588 + kScreenH / 28.4);
        make.left.mas_equalTo(-1);
    }];
    view.userInteractionEnabled = YES;
    view.layer.borderWidth = 1;
    view.layer.borderColor = kCOLOR(244, 244, 244).CGColor;
    view.backgroundColor = [UIColor whiteColor];
    
    UIImageView *headImageView = [[UIImageView alloc]initWithImage:image];
    [view addSubview:headImageView];
    headImageView.tag = 2;
    [headImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kScreenW / 5, kScreenW / 5));
        make.centerY.mas_equalTo(view.mas_centerY);
        make.left.mas_equalTo(view.mas_left).offset(kScreenW / 21.3333333);
    }];
    headImageView.layer.cornerRadius = kScreenW / 10;
    headImageView.layer.masksToBounds = YES;
    

    
    UILabel *lable = [UILabel creatLableWithTitle:@"用户名" andSuperView:view andFont:k14 andTextAligment:NSTextAlignmentLeft];
    lable.textColor = kMainColor;
    lable.layer.borderWidth = 0;
    [lable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kScreenW / 2, kScreenW / 14));
        make.left.mas_equalTo(headImageView.mas_right).offset(kScreenW / 32);
        make.bottom.mas_equalTo(view.mas_centerY);
    }];
    
    UILabel *nameLable = [UILabel creatLableWithTitle:name andSuperView:view andFont:k14 andTextAligment:NSTextAlignmentLeft];
    nameLable.textColor = kMainColor;
    nameLable.layer.borderWidth = 0;
    [nameLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kScreenW / 2, kScreenW / 14));
        make.left.mas_equalTo(headImageView.mas_right).offset(kScreenW / 32);
        make.top.mas_equalTo(view.mas_centerY);
    }];
    
    return view;
}

@end
