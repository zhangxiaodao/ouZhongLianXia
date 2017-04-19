//
//  BingJingShouMingTableViewCell.m
//  AEFT冷风扇
//
//  Created by 杭州阿尔法特 on 16/4/4.
//  Copyright © 2016年 阿尔法特. All rights reserved.
//

#import "BingJingShouMingTableViewCell.h"

@interface BingJingShouMingTableViewCell ()<HelpFunctionDelegate>
@end

@implementation BingJingShouMingTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {

        self.selectionStyle = UITableViewCellSeparatorStyleNone;
    }
    return self;
}

- (void)setUIbuJuWithNowUesrTime:(CGFloat)nowUserTime  andViewController:(UIViewController *)viewController {
    
    NSLog(@"AAAAEEEEE%f" , nowUserTime);
    
    NSArray *array = [NSArray arrayWithArray:self.contentView.subviews];
    for (int i = 0; i < array.count; i++) {
        [array[i] removeFromSuperview];
    }
    
    
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenW, kScreenH / 5)];
    view.backgroundColor = [UIColor clearColor];
    [self.contentView addSubview:view];
    
    UILabel *timeLable1 = [UILabel creatLableWithTitle:@"" andSuperView:view andFont:k14 andTextAligment:NSTextAlignmentCenter];
    timeLable1.layer.borderWidth = 0;
    timeLable1.textColor = kMainColor;
    if ([_isKongJing isEqualToString:@"YES"]) {
        timeLable1.textColor = kKongJingYanSe;
    }
    
    CGFloat timeText1 = (CGFloat)kLengFengShanBingJing -  nowUserTime / 3600000;
    
    if ([_isKongJing isEqualToString:@"YES"]) {
        timeText1 = nowUserTime;
        [NSString setNSMutableAttributedString:timeText1 andSuperLabel:timeLable1 andDanWei:@"小时" andSize:k30 andTextColor:kKongJingYanSe isNeedTwoXiaoShuo:@"YES"];
    } else {
        [NSString setNSMutableAttributedString:timeText1 andSuperLabel:timeLable1 andDanWei:@"小时" andSize:k30 andTextColor:kMainColor isNeedTwoXiaoShuo:@"YES"];
    }
    
    
    
    [timeLable1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kScreenW / 2, kScreenW / 10));
        make.centerX.mas_equalTo(view.mas_centerX);
        make.top.mas_equalTo(view.mas_top).offset(kScreenH / 22.23333);
    }];
    
    
    UILabel *tiShiLable = [UILabel creatLableWithTitle:@"滤网即将到期，请更换滤网" andSuperView:view andFont:k20 andTextAligment:NSTextAlignmentCenter];
    tiShiLable.layer.borderWidth = 0;

    tiShiLable.textColor = kACOLOR(181, 156, 221, 1.0);
    [tiShiLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kScreenW, kScreenW / 10));
        make.centerX.mas_equalTo(view.mas_centerX);
        make.bottom.mas_equalTo(timeLable1.mas_top);
    }];
    tiShiLable.hidden = YES;
    if (timeText1 < kKongJingLvXinShouMing / 10) {
        tiShiLable.hidden = NO;
    }
    
    UIView *fenGeXianView2 = [UIView creatMiddleFenGeView:view andBackGroundColor:kMainColor andHeight:1 andWidth:kScreenW / 3 andConnectId:timeLable1];
    if ([_isKongJing isEqualToString:@"YES"]) {
        fenGeXianView2.backgroundColor = kKongJingYanSe;
    }
    
    UILabel *sumTimeLable = [UILabel creatLableWithTitle:@"" andSuperView:view andFont:k12 andTextAligment:NSTextAlignmentCenter];
    if ([self.isKongJing isEqualToString:@"YES"]) {
        sumTimeLable.text = @"剩余滤网寿命";
    } else {
        sumTimeLable.text = @"冰晶使用寿命";
    }
    sumTimeLable.textColor = [UIColor grayColor];
    sumTimeLable.layer.borderWidth = 0;
    [sumTimeLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kScreenW / 3, kScreenW / 14));
        make.centerX.mas_equalTo(timeLable1.mas_centerX);
        make.top.mas_equalTo(fenGeXianView2.mas_bottom);
        
    }];
    
    UIView *sumView = [[UIView alloc]init];

    sumView.backgroundColor = kACOLOR(233, 233, 233, 1.0);
    
    [self.contentView addSubview:sumView];
    [sumView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(20);
        make.top.mas_equalTo(sumTimeLable.mas_bottom);
        make.size.mas_equalTo(CGSizeMake(kScreenW - kScreenW / 10, kScreenH / 45));
    }];
    
    UIView *nowView = [[UIView alloc]init];
    nowView.backgroundColor = kMainColor;
    if ([_isKongJing isEqualToString:@"YES"]) {
        nowView.backgroundColor = kKongJingYanSe;
    }
    [self.contentView addSubview:nowView];
    
    
    [nowView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(20);
        
        
        if ([_isKongJing isEqualToString:@"YES"]) {
            make.size.mas_equalTo(CGSizeMake(((kScreenW - kScreenW / 10 )- ((kScreenW - kScreenW  / 10) / kKongJingLvXinShouMing * (kKongJingLvXinShouMing - timeText1))), kScreenH / 45));
        } else {
            make.size.mas_equalTo(CGSizeMake(((kScreenW - kScreenW / 10 )- ((kScreenW - kScreenW  / 10) / kLengFengShanBingJing * (kLengFengShanBingJing - timeText1))), kScreenH / 45));
        }
        make.top.mas_equalTo(sumTimeLable.mas_bottom);
    }];
    
    self.vc = viewController;
    
    UIButton *offBtn = [UIButton initWithTitle:@"复位" andColor:kMainColor andSuperView:view];
    offBtn.tag = 1;
    offBtn.layer.cornerRadius = kScreenH / 80;

    [offBtn addTarget:self action:@selector(fuWeiAtcion333:) forControlEvents:UIControlEventTouchUpInside];
    offBtn.titleLabel.font = [UIFont systemFontOfSize:k14];
    
    //注册按钮的约束
    [offBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kScreenW / 7, kScreenH / 40));
        make.right.mas_equalTo(-kScreenW / 15);
        make.top.mas_equalTo(view.mas_top).offset(kScreenW / 30);
    }];
    
    if ([_isKongJing isEqualToString:@"YES"]) {
        [offBtn removeFromSuperview];
    }

    
}


- (void)fuWeiAtcion333:(UIButton *)btn {

    
    [UIAlertController creatCancleAndRightAlertControllerWithHandle:^{
        
        [[NSNotificationCenter defaultCenter] postNotification:[NSNotification notificationWithName:@"bingJing" object:self userInfo:[NSDictionary dictionaryWithObject:@"YES" forKey:@"bingJing"]]];
        
        NSDictionary *parames = @{@"devSn" : self.devSn, @"devTypeSn" : @"A" , @"reset" : @(2)};
        
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
