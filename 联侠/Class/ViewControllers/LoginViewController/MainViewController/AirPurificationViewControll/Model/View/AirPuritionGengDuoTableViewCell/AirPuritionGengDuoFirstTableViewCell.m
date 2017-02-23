//
//  AirPuritionGengDuoFirstTableViewCell.m
//  联侠
//
//  Created by 杭州阿尔法特 on 16/6/14.
//  Copyright © 2016年 张海昌. All rights reserved.
//

#import "AirPuritionGengDuoFirstTableViewCell.h"

@interface AirPuritionGengDuoFirstTableViewCell (){
    UILabel *timeLable;
    UILabel *xiaBiaoLable;
}

@end

@implementation AirPuritionGengDuoFirstTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self customUI];
    }
    return self;
}

- (void)customUI {
    
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenW, kScreenH / 2.575289)];
    view.backgroundColor = [UIColor redColor];
    [self.contentView addSubview:view];
    
    
    UIImageView *imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"历史记录背景.jpg"]];
    [view addSubview:imageView];
    imageView.frame = view.frame;
    
    
    UILabel *leiJiJiangWenLable = [UILabel creatLableWithTitle:@"已过滤粉尘" andSuperView:view andFont:k12 andTextAligment:NSTextAlignmentCenter];
    leiJiJiangWenLable.layer.borderWidth = 0;
    leiJiJiangWenLable.backgroundColor = kKongJingYanSe;
    leiJiJiangWenLable.textColor = [UIColor whiteColor];
    leiJiJiangWenLable.layer.cornerRadius = kScreenW / 36;
    [leiJiJiangWenLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kScreenW / 5, kScreenW / 18));
        make.centerX.mas_equalTo(view.mas_centerX);
        make.top.mas_equalTo(view.mas_top).offset(kScreenH / 6.0425531);
    }];
    
    timeLable = [UILabel creatLableWithTitle:@"" andSuperView:view andFont:k15 andTextAligment:NSTextAlignmentCenter];
    timeLable.layer.borderWidth = 0;
    [timeLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kScreenW * 2 / 3, kScreenW / 7));
        make.centerX.mas_equalTo(view.mas_centerX);
        make.top.mas_equalTo(leiJiJiangWenLable.mas_bottom).offset(kScreenH / 50);
    }];
    
    
    CGFloat temperature =  6000000 / 600000 * 0.1158 / 6 ;
    
    [NSString setNSMutableAttributedString:temperature andSuperLabel:timeLable andDanWei:@"mg" andSize:k60 andTextColor:kKongJingYanSe isNeedTwoXiaoShuo:@"YES"];
    
    
    xiaBiaoLable = [UILabel creatLableWithTitle:[NSString stringWithFormat:@"%d" , 1] andSuperView:view andFont:k12 andTextAligment:NSTextAlignmentCenter];
    xiaBiaoLable.layer.borderWidth = 0;
    [xiaBiaoLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(view.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(kScreenW / 2, kScreenW / 15));
        make.top.mas_equalTo(timeLable.mas_bottom);
    }];
    xiaBiaoLable.textColor = kKongJingYanSe;
}

- (void)setServiceataModel:(ServicesDataModel *)serviceataModel {
    _serviceataModel = serviceataModel;
    
    CGFloat temperature = 6000000;
    CGFloat time1 = 0;
    if (_serviceataModel.totalTime) {
        time1 = _serviceataModel.totalTime / 3600000;
    }
    temperature =  _serviceataModel.totalTime / 3600000 * 0.3575 ;
    
    
    [NSString setNSMutableAttributedString:temperature andSuperLabel:timeLable andDanWei:@"mg" andSize:k60 andTextColor:kKongJingYanSe isNeedTwoXiaoShuo:@"YES"];
    
    xiaBiaoLable.text = [NSString stringWithFormat:@"相当于 %.2f 颗大米" , (temperature / kDaMi)];
}

@end
