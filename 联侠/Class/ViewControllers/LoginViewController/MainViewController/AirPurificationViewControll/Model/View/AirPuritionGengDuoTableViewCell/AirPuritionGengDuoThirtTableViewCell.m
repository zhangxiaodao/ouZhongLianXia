//
//  AirPuritionGengDuoThirtTableViewCell.m
//  联侠
//
//  Created by 杭州阿尔法特 on 16/6/14.
//  Copyright © 2016年 张海昌. All rights reserved.
//

#import "AirPuritionGengDuoThirtTableViewCell.h"

@interface AirPuritionGengDuoThirtTableViewCell (){
    CGFloat shengYuTime;
    UILabel *rightLable;
    UIView *nowView;
    UIView *thirtView;
}

@end

@implementation AirPuritionGengDuoThirtTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self customUI];
    }
    return self;
}

- (void)customUI {
    
    thirtView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenW, kScreenH / 7.7558139)];
    [self.contentView addSubview:thirtView];
    
    
    UILabel *shuiWeiZhuangTaiLable = [UILabel creatLableWithTitle:@"滤芯剩余寿命" andSuperView:thirtView andFont:k14 andTextAligment:NSTextAlignmentLeft];
    shuiWeiZhuangTaiLable.textColor = [UIColor blackColor];
    shuiWeiZhuangTaiLable.layer.borderWidth = 0;
    [shuiWeiZhuangTaiLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(20);
        make.right.mas_equalTo(-kScreenW / 2);
        make.top.mas_equalTo(10);
        make.bottom.mas_equalTo(thirtView.mas_bottom).offset(- kScreenH / 16);
    }];
    
    
    shengYuTime = 1000;
    
    
    
    rightLable = [UILabel creatLableWithTitle:@"" andSuperView:thirtView andFont:k14 andTextAligment:NSTextAlignmentRight];
    rightLable.textColor = [UIColor blackColor];
    [rightLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(kScreenW / 2);
        make.right.mas_equalTo(-20);
        make.top.mas_equalTo(10);
        make.bottom.mas_equalTo(thirtView.mas_bottom).offset(- kScreenH / 16);
    }];
    rightLable.layer.borderWidth = 0;
    
    
    [NSString setNSMutableAttributedString:shengYuTime andSuperLabel:rightLable andDanWei:@"小时" andSize:k20 andTextColor:kKongJingYanSe isNeedTwoXiaoShuo:@"NO"];
    
    
    UIView *sumView = [[UIView alloc]init];
    sumView.backgroundColor = kACOLOR(233, 233, 233, 1.0);
    
    [thirtView addSubview:sumView];
    [sumView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(20);
        make.top.mas_equalTo(rightLable.mas_bottom);
        make.size.mas_equalTo(CGSizeMake(kScreenW - kScreenW / 10, thirtView.height / 5));
        
    }];
    
    
    nowView = [[UIView alloc]init];
    nowView.backgroundColor = kKongJingYanSe;
    [thirtView addSubview:nowView];
    [nowView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(20);
        make.size.mas_equalTo(CGSizeMake(((kScreenW - kScreenW / 10) - (((kScreenW - kScreenW  / 10) / kKongJingLvXinShouMing) * 6000000 / 3600000)), thirtView.height / 5));
        make.top.mas_equalTo(rightLable.mas_bottom);
        
    }];
    
    UIView *fenGeView5 = [[UIView alloc]init];
    [thirtView addSubview:fenGeView5];
    fenGeView5.backgroundColor = kACOLOR(233, 233, 233, 1.0);
    [fenGeView5 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kScreenW , 1));
        make.centerX.mas_equalTo(thirtView.mas_centerX);
        make.top.mas_equalTo(thirtView.mas_bottom);
    }];
}

- (void)setStateModel:(StateModel *)stateModel {
    _stateModel = stateModel;
    if (_stateModel.sChangeFilterScreen) {
        shengYuTime = _stateModel.sChangeFilterScreen;
        
        [NSString setNSMutableAttributedString:shengYuTime andSuperLabel:rightLable andDanWei:@"小时" andSize:k20 andTextColor:kKongJingYanSe isNeedTwoXiaoShuo:@"NO"];
        
        [nowView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(20);
            make.size.mas_equalTo(CGSizeMake(((kScreenW - kScreenW / 10) - (((kScreenW - kScreenW  / 10) / kKongJingLvXinShouMing) * (kKongJingLvXinShouMing - shengYuTime))), thirtView.height / 5));
            make.top.mas_equalTo(rightLable.mas_bottom);
            
        }];
    }

}

@end
