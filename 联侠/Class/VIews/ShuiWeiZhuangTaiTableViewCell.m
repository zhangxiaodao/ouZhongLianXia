//
//  ShuiWeiZhuangTaiTableViewCell.m
//  AEFT冷风扇
//
//  Created by 杭州阿尔法特 on 16/3/31.
//  Copyright © 2016年 阿尔法特. All rights reserved.
//

#import "ShuiWeiZhuangTaiTableViewCell.h"

@interface ShuiWeiZhuangTaiTableViewCell ()<HelpFunctionDelegate>


@end

@implementation ShuiWeiZhuangTaiTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.selectionStyle = UITableViewCellSeparatorStyleNone;
        
        
    }
    return self;
    
}



- (void)setUIBuJuWith:(CGFloat)shengYuTimeText andSumShuiWei:(CGFloat)sumShuiWei andImage:(UIImage *)image andViewController:(UIViewController *)viewContrller{
    
    self.shengYuTime = shengYuTimeText / 60000;
    
    NSArray *array = [NSArray arrayWithArray:self.contentView.subviews];
    for (int i = 0; i < array.count; i++) {
        [array[i] removeFromSuperview];
    }
    
    
    NSArray *imaegArray = @[[UIImage imageNamed:@"shuiWei1.png"] , [UIImage imageNamed:@"shuiWei2.png"] , [UIImage imageNamed:@"shuiWei3.png"] , [UIImage imageNamed:@"shuiWei4.png"] , [UIImage imageNamed:@"shuiWei5.png"] , [UIImage imageNamed:@"shuiWei6.png"]];
    
    self.imageVV = [[UIImageView alloc]init];
    [self.contentView addSubview:self.imageVV];
    
    [self.imageVV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kScreenW / 3, (kScreenH / 3) * 3 / 5));
        make.centerY.mas_equalTo(self.contentView.mas_centerY);
        make.centerX.mas_equalTo(self.contentView.mas_centerX).offset(-kScreenW / 6);
    }];
    
    if (self.shengYuTime > sumShuiWei) {
        self.imageVV.image = imaegArray[5];
    } else if (self.shengYuTime <= sumShuiWei  && self.shengYuTime >= sumShuiWei * 5 / 6) {
        self.imageVV.image = imaegArray[5];
    } else if (self.shengYuTime < sumShuiWei * 5 / 6 && self.shengYuTime >= sumShuiWei * 4 / 6) {
        self.imageVV.image = imaegArray[4];
    } else if (self.shengYuTime < sumShuiWei * 4 / 6  && self.shengYuTime >= sumShuiWei * 3 / 6) {
        self.imageVV.image = imaegArray[3];
    } else if (self.shengYuTime < sumShuiWei * 3 / 6  && self.shengYuTime >= sumShuiWei * 2 / 6) {
        self.imageVV.image = imaegArray[2];
    } else if (self.shengYuTime < sumShuiWei * 2 / 6  && self.shengYuTime >= sumShuiWei * 1 / 6) {
        self.imageVV.image = imaegArray[1];
    } else if (self.shengYuTime < sumShuiWei * 1 / 6  && self.shengYuTime >= 0) {
        self.imageVV.image = imaegArray[0];
    }

    
    
    self.shengYuLable = [UILabel creatLableWithTitle:@"" andSuperView:self.contentView andFont:k15 andTextAligment:NSTextAlignmentCenter];
    self.shengYuLable.textColor = kMainColor;
    self.shengYuLable.layer.borderWidth = 0;
    
    CGFloat shengYuTime1 = sumShuiWei - self.shengYuTime;
    
    if (shengYuTime1 <= 0) {
        shengYuTime1 = 0;
    }
    
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%.1f分钟" , shengYuTime1]];
    
    [str addAttribute:NSFontAttributeName value:[UIFont fontWithName:kFontWithName size:k30] range:NSMakeRange(0, [NSString stringWithFormat:@"%.1f" , shengYuTime1].length)];
    self.shengYuLable.attributedText = str;
    
    
    [self.shengYuLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kScreenW / 3, kScreenW / 9));
        make.centerX.mas_equalTo(self.contentView.mas_centerX).offset(kScreenW / 6);
        make.top.mas_equalTo(self.contentView.mas_top).offset(kScreenH / 22.23333);
    }];
    
    UIView *fenGeXianView = [[UIView alloc]init];
    [self.contentView addSubview:fenGeXianView];
    fenGeXianView.backgroundColor = kMainColor;
    [fenGeXianView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kScreenW / 3, 1));
        make.centerX.mas_equalTo(self.shengYuLable.mas_centerX);
        make.top.mas_equalTo(self.shengYuLable.mas_bottom);
    }];
    
    UILabel *yiGuoLvFenChenLable = [UILabel creatLableWithTitle:@"剩余水位状态" andSuperView:self.contentView andFont:k12 andTextAligment:NSTextAlignmentCenter];
    yiGuoLvFenChenLable.layer.borderWidth = 0;
    yiGuoLvFenChenLable.textColor = [UIColor grayColor];
    [yiGuoLvFenChenLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kScreenW / 3, kScreenW / 14));
        make.centerX.mas_equalTo(self.shengYuLable.mas_centerX);
        make.top.mas_equalTo(self.shengYuLable.mas_bottom);
    }];
    
    
    self.vc = viewContrller;
    
    UIButton *offBtn = [UIButton initWithTitle:@"复位" andColor:kMainColor andSuperView:self.contentView];
    offBtn.layer.cornerRadius = kScreenH / 80;
    
    [offBtn addTarget:self action:@selector(fuWeiAtcion111:) forControlEvents:UIControlEventTouchUpInside];
    
    offBtn.titleLabel.font = [UIFont systemFontOfSize:k14];
    
    //注册按钮的约束
    [offBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kScreenW / 7, kScreenH / 40));
        make.right.mas_equalTo(-kScreenW / 15);
        make.top.mas_equalTo(self.contentView.mas_top).offset(kScreenW / 30);
    }];
}

- (void)fuWeiAtcion111:(UIButton *)btn {
    
    [UIAlertController creatRightAlertControllerWithHandle:^{
        
        [[NSNotificationCenter defaultCenter] postNotification:[NSNotification notificationWithName:@"ShuiWei" object:self userInfo:[NSDictionary dictionaryWithObject:@"YES" forKey:@"ShuiWei"]]];
        NSDictionary *parames = @{@"devSn" : self.devSn, @"devTypeSn" : @"A" , @"reset" : @(1)};
        
        [HelpFunction requestDataWithUrlString:kLengFengShanFuWi andParames:parames andDelegate:self];
    } andSuperViewController:kWindowRoot Title:@"点击复位后，数据将会被清空，重新计数"];
    
    
}

- (void)requestFuWeiShuJu:(HelpFunction *)request didYes:(NSDictionary *)dic {
    NSLog(@"%@" , dic);
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end
