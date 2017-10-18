//
//  EnterWorkTowerFirsetView.m
//  AEFT冷风扇
//
//  Created by 杭州阿尔法特 on 16/3/11.
//  Copyright © 2016年 阿尔法特. All rights reserved.
//

#import "EnterWorkTowerFirsetView.h"

@interface EnterWorkTowerFirsetView ()

@end

@implementation EnterWorkTowerFirsetView

- (instancetype)initWithSize:(CGSize)size color:(UIColor *)color superView:(UIView *)superView
{
    self = [super initWithFrame:CGRectMake(0, 0, size.width, size.height)];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        [superView addSubview:self];
        [self addSubviewColor:color];
    }
    return self;
}

- (void)addSubviewColor:(UIColor *)color {
    
    UILabel *nowStateLable = [UILabel creatLableWithTitle:@"当前状态" andSuperView:self andFont:k17 andTextAligment:NSTextAlignmentLeft];
    nowStateLable.textColor = color;
    [nowStateLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(kScreenW / 20);
        make.top.mas_equalTo(self.mas_top).offset(10);
    }];
    
    NSArray *arr = [NSArray arrayWithObjects:@"模式", @"风速" , @"摆风" , @"制冷",  nil];
    for (int i = 0; i < 4; i ++) {
        
        UILabel *arrayLable = [UILabel creatLableWithTitle:@"==" andSuperView:self andFont:k19 andTextAligment:NSTextAlignmentCenter];
        arrayLable.tag = i + 100;
        arrayLable.textColor = color;
        [arrayLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(kScreenW / 20 + i * (kScreenW * 2 / 3 - kScreenW / 20) / 4);
            make.top
            .mas_equalTo(nowStateLable.mas_bottom).offset(kScreenW / 15);
        }];
        
        
        UILabel *downLable = [UILabel creatLableWithTitle:[NSString stringWithFormat:@"%@" , arr[i]] andSuperView:self andFont:k14 andTextAligment:NSTextAlignmentCenter];
        downLable.textColor = color;
        [downLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(arrayLable.mas_centerX);
            make.top.mas_equalTo(arrayLable.mas_bottom)
            .offset(5);
        }];
    }
    
    UIButton *btn = [UIButton initWithTitle:@"" andColor:[UIColor clearColor] andSuperView:self];
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(self.height * 2 / 3, self.height * 2 / 3));
        make.right.mas_equalTo(- kScreenW / 15);
        make.top.mas_equalTo(self.mas_top)
        .offset(kScreenW / 15);
    }];
    
    UIImageView *iamgeVIew = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"btnClose"]];
    [btn addSubview:iamgeVIew];
    [iamgeVIew mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(self.height * 2 / 3, self.height * 2 / 3));
        make.centerX.mas_equalTo(btn.mas_centerX);
        make.centerY.mas_equalTo(btn.mas_centerY);
    }];
    [UIImageView setImageViewColor:iamgeVIew andColor:kWhiteColor];
    
    UIView *separateView = [[UIView alloc]init];
    separateView.backgroundColor = kWhiteColor;
    [self addSubview:separateView];
    [separateView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kScreenW, 1));
        make.bottom.mas_equalTo(self.mas_bottom);
        make.centerX.mas_equalTo(self.mas_centerX);
    }];
    
}

- (void)setStateArray:(NSArray *)stateArray {
    _stateArray = stateArray;
    
    NSLog(@"%@" , _stateArray);
    
    if (_stateArray) {
        UILabel *firstLabel = [self viewWithTag:100];
        firstLabel.text = [NSString stringWithFormat:@"%@" , _stateArray[0]];
        
        UILabel *secondLabel = [self viewWithTag:101];
        secondLabel.text = [NSString stringWithFormat:@"%@" , _stateArray[1]];
        
        UILabel *thirtLabel = [self viewWithTag:102];
        thirtLabel.text = [NSString stringWithFormat:@"%@" , _stateArray[2]];
        
        UILabel *forthLabel = [self viewWithTag:103];
        forthLabel.text = [NSString stringWithFormat:@"%@" , _stateArray[3]];
    }
}

@end
