//
//  LvWangJieDuTableViewCell.m
//  AEFT冷风扇
//
//  Created by 杭州阿尔法特 on 16/3/31.
//  Copyright © 2016年 阿尔法特. All rights reserved.
//

#import "LvWangJieDuTableViewCell.h"



@interface LvWangJieDuTableViewCell ()<HelpFunctionDelegate>

@property (nonatomic , assign) NSInteger index;

@end

@implementation LvWangJieDuTableViewCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.selectionStyle = UITableViewCellSeparatorStyleNone;
    }
    return self;
}

- (NSArray *)creatViewWithLable:(UIColor *)color andIndex:(NSInteger)i{
    NSArray *nameArray = [NSArray arrayWithObjects:@"重度污染" , @"中度污染" , @"轻度污染" , @"清洁" , nil];
    UIView *view = [[UIView alloc]init];
    view.backgroundColor = color;
    [self.contentView addSubview:view];
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(kScreenW / 15 + ((kScreenW - kScreenW * 2 /15) / 4) * i);
        make.size.mas_equalTo(CGSizeMake((kScreenW - kScreenW * 2 /15) / 4 , kScreenH / 100));
        make.centerY.mas_equalTo(self.contentView.mas_centerY);
    }];
    
    UILabel *lable = [UILabel creatLableWithTitle:[NSString stringWithFormat:@"%@" , nameArray[i]] andSuperView:self.contentView andFont:k15 andTextAligment:NSTextAlignmentCenter];
    lable.layer.borderWidth = 0;
    lable.textColor = [UIColor grayColor];
    [lable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(view.mas_centerX);
        make.top.mas_equalTo(view.mas_bottom).offset(kScreenW / 30);
        make.size.mas_equalTo(CGSizeMake((kScreenW - kScreenW * 2 /15) / 4, kScreenW / 20));
    }];
    NSArray *array = [NSArray arrayWithObjects:view, lable,  nil];
    return array;
}

- (void)setZhiZhenView:(NSInteger)index andViewController:(UIViewController *)viewController{
    
    
    NSArray *array = [NSArray arrayWithArray:self.contentView.subviews];
    for (int i = 0; i < array.count; i++) {
        [array[i] removeFromSuperview];
    }

    self.index = index;

    if (self.index >= 0 && self.index < kSumLvWangJieDu / 4) {
        self.index = 0;
    } else if (self.index >= kSumLvWangJieDu / 4 && self.index < kSumLvWangJieDu / 2) {
        self.index = 1;
    } else if (self.index >= kSumLvWangJieDu / 2 && self.index < kSumLvWangJieDu * 3 / 4) {
        self.index = 2;
    } else if (self.index >= kSumLvWangJieDu * 3 / 4 && self.index <= kSumLvWangJieDu) {
        self.index = 3;
    }
    
    
    
    self.yanZhongView = [[self creatViewWithLable:kACOLOR(251, 114, 34, 1.0) andIndex:0] objectAtIndex:0];
    self.zhongDuView = [[self creatViewWithLable:kACOLOR(253, 198, 46, 1.0) andIndex:1] objectAtIndex:0];
    self.qingDuView = [[self creatViewWithLable:kACOLOR(182, 225, 46, 1.0) andIndex:2] objectAtIndex:0];
    self.qingJieView = [[self creatViewWithLable:kMainColor andIndex:3] objectAtIndex:0];
    
    self.zhiBiaoView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"滤网洁度指针"]];
    [self.contentView addSubview:self.zhiBiaoView];

    [self.zhiBiaoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kScreenW / 20, kScreenW / 20));
        make.centerX.mas_equalTo(self.yanZhongView.mas_centerX).offset(((kScreenW - kScreenW * 2 /15) / 4) * (3 - self.index));
        make.bottom.mas_equalTo(self.yanZhongView.mas_top);
    }];
    
    
    UILabel *tiShiLable = [UILabel creatLableWithTitle:@"滤网需要清洗了" andSuperView:self.contentView andFont:k20 andTextAligment:NSTextAlignmentCenter];
    tiShiLable.layer.borderWidth = 0;
    
    tiShiLable.textColor = kACOLOR(181, 156, 221, 1.0);
    [tiShiLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kScreenW, kScreenW / 10));
        make.centerX.mas_equalTo(self.contentView.mas_centerX);
        make.bottom.mas_equalTo(self.zhiBiaoView.mas_top);
    }];
    tiShiLable.hidden = YES;

  
    if (index > kSumLvWangJieDu * 0.9) {
        tiShiLable.hidden = NO;
    }
    
    
    self.vc = viewController;
    UIButton *offBtn = [UIButton initWithTitle:@"复位" andColor:kMainColor andSuperView:self.contentView];
    offBtn.tag = 3;
    offBtn.layer.cornerRadius = kScreenH / 80;

    [offBtn addTarget:self action:@selector(fuWeiAtcion222:) forControlEvents:UIControlEventTouchUpInside];
    
    offBtn.titleLabel.font = [UIFont systemFontOfSize:k14];
    
    //注册按钮的约束
    [offBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kScreenW / 7, kScreenH / 40));
        make.right.mas_equalTo(-kScreenW / 15);
        make.top.mas_equalTo(self.contentView.mas_top).offset(kScreenW / 30);
    }];
    
    if ([_isKongJingLvWang isEqualToString:@"YES"]) {
        [offBtn removeFromSuperview];
    }

}

- (void)fuWeiAtcion222:(UIButton *)btn {

    
    [UIAlertController creatCancleAndRightAlertControllerWithHandle:^{
        [[NSNotificationCenter defaultCenter] postNotification:[NSNotification notificationWithName:@"lvWang" object:self userInfo:[NSDictionary dictionaryWithObject:@"YES" forKey:@"lvWang"]]];
        
        NSDictionary *parames = @{@"devSn" : self.devSn, @"devTypeSn" : @"A" , @"reset" : @(3)};
        
        [HelpFunction requestDataWithUrlString:kLengFengShanFuWi andParames:parames andDelegate:self];
    } andSuperViewController:self.vc Title:@"点击复位后，数据将会被清空，重新计数"];
   
    
}

- (void)requestFuWeiShuJu:(HelpFunction *)request didYes:(NSDictionary *)dic {
    NSLog(@"%@" , dic);
}

- (void)requestData:(HelpFunction *)request didFailLoadData:(NSError *)error {
    NSLog(@"%@" , error);
}

@end
