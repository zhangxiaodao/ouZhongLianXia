//
//  AirPuritionGengDuoSecondTableViewCell.m
//  联侠
//
//  Created by 杭州阿尔法特 on 16/6/14.
//  Copyright © 2016年 张海昌. All rights reserved.
//

#import "AirPuritionGengDuoSecondTableViewCell.h"
#import "LiShiModel.h"

@interface AirPuritionGengDuoSecondTableViewCell () {
    UILabel *timeLable1;
    UILabel *fenChenLable;
}

@end

@implementation AirPuritionGengDuoSecondTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self customUI];
    }
    return self;
}

- (void)customUI {
    
    UIView *secondView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenW, kScreenH / 6.94791666)];
    [self.contentView addSubview:secondView];
    secondView.backgroundColor = [UIColor whiteColor];
    
    
    fenChenLable = [UILabel creatLableWithTitle:@"" andSuperView:secondView andFont:k15 andTextAligment:NSTextAlignmentCenter];
    fenChenLable.textColor = kKongJingYanSe;
    fenChenLable.layer.borderWidth = 0;
    
    fenChenLable.text = @"请开窗";
    
    
    [fenChenLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kScreenW / 3, kScreenW / 14));
        make.centerX.mas_equalTo(secondView.mas_centerX).offset(- kScreenW / 3.4090909);
        make.top.mas_equalTo(secondView.mas_top).offset(kScreenH / 22.23333);
    }];
    
    
    UIView *fenGeXianView = [UIView creatMiddleFenGeView:secondView andBackGroundColor:kKongJingYanSe andHeight:1 andWidth:kScreenW / 4 andConnectId:fenChenLable];
    
    UILabel *yiGuoLvFenChenLable = [UILabel creatLableWithTitle:@"优于室外空气" andSuperView:secondView andFont:k12 andTextAligment:NSTextAlignmentCenter];
    yiGuoLvFenChenLable.layer.borderWidth = 0;
    yiGuoLvFenChenLable.textColor = [UIColor grayColor];
    [yiGuoLvFenChenLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kScreenW / 3, kScreenW / 14));
        make.centerX.mas_equalTo(fenChenLable.mas_centerX);
        make.top.mas_equalTo(fenGeXianView.mas_bottom);
    }];
    
    UIView *fenGeXianView3 = [[UIView alloc]init];
    [secondView addSubview:fenGeXianView3];
    fenGeXianView3.backgroundColor = kFenGeXianYanSe;
    [fenGeXianView3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(1, kScreenH / 9));
        make.centerX.mas_equalTo(secondView.mas_centerX);
        make.top.mas_equalTo(secondView.mas_top).offset(kScreenH / 44.4666666);
    }];
    
    timeLable1 = [UILabel creatLableWithTitle:@"" andSuperView:secondView andFont:k14 andTextAligment:NSTextAlignmentCenter];
    timeLable1.layer.borderWidth = 0;
    timeLable1.textColor = kKongJingYanSe;
    [timeLable1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kScreenW / 3, kScreenW / 14));
        make.centerX.mas_equalTo(secondView.mas_centerX).offset( kScreenW / 3.4090909);
        make.top.mas_equalTo(secondView.mas_top).offset(kScreenH / 22.23333);
    }];
    
    
    UIView *fenGeXianView2 = [UIView creatMiddleFenGeView:secondView andBackGroundColor:kKongJingYanSe andHeight:1 andWidth:kScreenW / 4 andConnectId:timeLable1];

    UILabel *sumTimeLable = [UILabel creatLableWithTitle:@"累计运行时间" andSuperView:secondView andFont:k12 andTextAligment:NSTextAlignmentCenter];
    sumTimeLable.textColor = [UIColor grayColor];
    sumTimeLable.layer.borderWidth = 0;
    [sumTimeLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kScreenW / 3, kScreenW / 14));
        make.centerX.mas_equalTo(timeLable1.mas_centerX);
        make.top.mas_equalTo(fenGeXianView2.mas_bottom);
        
    }];
    
    UIView *fenGeXianView4 = [[UIView alloc]init];
    [secondView addSubview:fenGeXianView4];
    fenGeXianView4.backgroundColor = kFenGeXianYanSe;
    
    [fenGeXianView4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kScreenW , 1));
        make.centerX.mas_equalTo(secondView.mas_centerX);
        make.top.mas_equalTo(secondView.mas_bottom);
    }];
    
}

- (void)setServiceDataModel:(ServicesDataModel *)serviceDataModel {
    _serviceDataModel = serviceDataModel;
    
    CGFloat leiJiYunXingShiJian = 6000000;
    if (_serviceDataModel.totalTime) {
        leiJiYunXingShiJian = _serviceDataModel.totalTime;
    }
    
    leiJiYunXingShiJian =  leiJiYunXingShiJian / 3600000;
    
    [NSString setNSMutableAttributedString:leiJiYunXingShiJian andSuperLabel:timeLable1 andDanWei:@"小时" andSize:k20 andTextColor:kKongJingYanSe isNeedTwoXiaoShuo:@"YES"];
}

- (void)setStateModel:(StateModel *)stateModel {
    _stateModel = stateModel;
    
    CGFloat fenChenText =  0.59;
    CGFloat lastShiWaiValue , lastShiNeiValue;
    
    if (![_shiNeiPm25 isKindOfClass:[NSNull class]] && ![_shiWaiPm25 isKindOfClass:[NSNull class]]) {
        lastShiWaiValue = _shiWaiPm25.floatValue;
        lastShiNeiValue = _shiNeiPm25.floatValue;
        fenChenText = (lastShiWaiValue - lastShiNeiValue) / lastShiWaiValue;
        if (fenChenText <= 0) {
            fenChenLable.text = @"请开窗";
        } else if (fenChenText > 0) {
            
            [NSString setNSMutableAttributedString:fenChenText * 100 andSuperLabel:fenChenLable andDanWei:@"%" andSize:k20 andTextColor:kKongJingYanSe isNeedTwoXiaoShuo:@"YES"];
        }
        
    } else{
        fenChenLable.text = @"请开窗";
    }
}

@end
