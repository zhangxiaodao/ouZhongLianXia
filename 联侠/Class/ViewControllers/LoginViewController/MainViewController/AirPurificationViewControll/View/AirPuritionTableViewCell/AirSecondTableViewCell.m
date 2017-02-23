//
//  AirSecondTableViewCell.m
//  联侠
//
//  Created by 杭州阿尔法特 on 16/5/31.
//  Copyright © 2016年 张海昌. All rights reserved.
//

#import "AirSecondTableViewCell.h"


#define kBtnW (((kScreenW - kScreenW / 8) / 4) - 5)
#define kContentViewHeight kBtnW * 2 + kBtnW * 2 / 3
@interface AirSecondTableViewCell ()

@end

@implementation AirSecondTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self customUI];
    }
    return self;
}

- (void)customUI {
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    UIView *view = [[UIView alloc]init];
    view.backgroundColor = [UIColor whiteColor];
    view.frame = CGRectMake(0, 0, kScreenW, kBtnW * 2 + kBtnW * 3 / 4);
    [self.contentView addSubview:view];
    
    UIImageView *imageView = [[UIImageView alloc]init];
    imageView.image = [UIImage imageNamed:@"主页背景2.jpg"];
    [view addSubview:imageView];
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kScreenW, view.height));
        make.centerX.mas_equalTo(view.mas_centerX);
        make.top.mas_equalTo(view.mas_top);
    }];
    
    UIImageView *daMiImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"shuiWei1"]];
    [view addSubview:daMiImageView];
    [daMiImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kScreenH / 6.063, kScreenH / 6.063));
        make.centerX.mas_equalTo(view.mas_centerX);
        make.top.mas_equalTo(view.mas_top);
    }];
    
    UILabel *yiJingHua = [UILabel creatLableWithTitle:@"已净化" andSuperView:view andFont:k14 andTextAligment:NSTextAlignmentCenter];
    yiJingHua.textColor = [UIColor blackColor];
    yiJingHua.layer.borderWidth = 0;
    [view addSubview:yiJingHua];
    [yiJingHua mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kScreenH / 6.063, 13));
        make.centerX.mas_equalTo(view.mas_centerX);
        make.bottom.mas_equalTo(daMiImageView.mas_bottom).offset(-20);
    }];
    UILabel *timeLable = [UILabel creatLableWithTitle:@"" andSuperView:view andFont:k15 andTextAligment:NSTextAlignmentCenter];
    timeLable.layer.borderWidth = 0;
    
    
    CGFloat temperature1 = 100;
    NSMutableAttributedString *str3 = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%.1f mg" , temperature1]];
    [str3 addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:46/255.0 green:191/255.0 blue:103/255.0 alpha:1.0] range:NSMakeRange(0,[NSString stringWithFormat:@"%.1f", temperature1].length)];
    [str3 addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"Helvetica" size:k40] range:NSMakeRange(0, [NSString stringWithFormat:@"%.1f", temperature1].length)];
    timeLable.attributedText = str3;
    [timeLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kScreenW * 2 / 3, kScreenW / 8));
        make.centerX.mas_equalTo(view.mas_centerX);
        make.top.mas_equalTo(daMiImageView.mas_bottom).offset(kScreenH / 33.35);
    }];
    
    UILabel *xiaBiaoLable = [UILabel creatLableWithTitle:@"" andSuperView:view andFont:k12 andTextAligment:NSTextAlignmentCenter];
    xiaBiaoLable.layer.borderWidth = 0;
    NSMutableAttributedString *str4 = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"相当于%.2f颗大米" , (temperature1) / 90]];
    [str4 addAttribute:NSForegroundColorAttributeName value:kLvSe range:NSMakeRange(3,[NSString stringWithFormat:@"%.2f", (temperature1) / 90].length)];
    [str4 addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"Helvetica" size:k20] range:NSMakeRange(3, [NSString stringWithFormat:@"%.2f", (temperature1) / 90].length)];
    xiaBiaoLable.attributedText = str4;
    [xiaBiaoLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(view.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(kScreenW / 2, kScreenW / 15));
        make.top.mas_equalTo(timeLable.mas_bottom);
    }];
    
}

@end
