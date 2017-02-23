//
//  AirPurificationFirstTableViewCell.m
//  联侠
//
//  Created by 杭州阿尔法特 on 16/6/6.
//  Copyright © 2016年 张海昌. All rights reserved.
//

#import "AirPurificationFirstTableViewCell.h"
#import "LXCircleAnimationView.h"

@interface AirPurificationFirstTableViewCell ()<HelpFunctionDelegate>{
    UILabel *zhaungTailLable;
    UILabel *timeLable;
    UILabel *xiaBiaoLable;
}
@property (nonatomic, strong) LXCircleAnimationView *circleProgressView;
@end

@implementation AirPurificationFirstTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self cutomUI];
    }
    return self;
}

- (void)cutomUI {
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getKongJingDataFirst:) name:@"4231" object:nil];
    
    UIView *view = [[UIView alloc]init];
    view.backgroundColor = [UIColor whiteColor];
    view.frame = CGRectMake(0, 0, kScreenW, kScreenH / 2.22333);
    [self.contentView addSubview:view];
    view.backgroundColor = [UIColor whiteColor];
    
    
    UILabel *shiNeiKongQiZhiLiang = [UILabel creatLableWithTitle:@"室内空气质量" andSuperView:view andFont:k15 andTextAligment:NSTextAlignmentCenter];
    shiNeiKongQiZhiLiang.textColor = kKongJingYanSe;
    shiNeiKongQiZhiLiang.layer.borderWidth = 0;
    [shiNeiKongQiZhiLiang mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kScreenW / 3, kScreenW / 14));
        make.centerX.mas_equalTo(view.mas_centerX);
        make.top.mas_equalTo(view.mas_top).offset(kScreenW / 20);
        
    }];
    
    
    self.circleProgressView = [[LXCircleAnimationView alloc] initWithFrame:CGRectMake(kScreenW / 2 - (view.height * 4 / 5) / 2, kScreenW / 20 + kScreenW / 14, view.height * 4 / 5, view.height * 4 / 5)];
    [view addSubview:self.circleProgressView];
    self.circleProgressView.userInteractionEnabled = NO;
//    self.circleProgressView.backgroundColor = [UIColor redColor];
    
    zhaungTailLable = [UILabel creatLableWithTitle:@"空气:优" andSuperView:view andFont:k15 andTextAligment:NSTextAlignmentCenter];
    [view addSubview:zhaungTailLable];
    [zhaungTailLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kScreenW / 5, kScreenW / 10));
        make.centerX.mas_equalTo(view.mas_centerX);
        make.top.mas_equalTo(self.circleProgressView.mas_top).offset(kScreenW / 20);
    }];
    zhaungTailLable.textColor = kKongJingYanSe;
    zhaungTailLable.layer.borderWidth = 0;
    
    
    
    
    UILabel *leiJiJingHua = [UILabel creatLableWithTitle:@"室内温度" andSuperView:view andFont:k12 andTextAligment:NSTextAlignmentCenter];
    leiJiJingHua.layer.borderWidth = 0;
    leiJiJingHua.backgroundColor = kKongJingHuangSe;
    leiJiJingHua.textColor = [UIColor whiteColor];
    leiJiJingHua.layer.cornerRadius = kScreenW / 40;
    [leiJiJingHua mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kScreenW / 6, kScreenW / 20));
        make.top.mas_equalTo(view.mas_top).offset(kScreenW / 20);
        make.left.mas_equalTo(view.mas_left).offset(kScreenW / 20);
    }];
    
    
    timeLable = [UILabel creatLableWithTitle:@"" andSuperView:view andFont:k12 andTextAligment:NSTextAlignmentCenter];
    timeLable.layer.borderWidth = 0;
    [timeLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kScreenW / 4, view.height / 10));
        make.top.mas_equalTo(leiJiJingHua.mas_bottom);
        make.centerX.mas_equalTo(leiJiJingHua.mas_centerX);
    }];
    
    
    CGFloat temperature2 = 30;
    
    [NSString setNSMutableAttributedString:temperature2 andSuperLabel:timeLable andDanWei:@"°C" andSize:k25 andTextColor:kKongJingYanSe isNeedTwoXiaoShuo:@"NO"];
    
    [UIView creatBottomFenGeView:view andBackGroundColor:[UIColor whiteColor] isOrNotAllLenth:@"YES"];
    
}

- (void)getKongJingDataFirst:(NSNotification *)post {
    NSString *mingLing = post.userInfo[@"Message"];
    
    NSString *wuRanChengDu = [mingLing substringWithRange:NSMakeRange(50, 2)];
    
    if ([wuRanChengDu isEqualToString:@"01"]) {
        zhaungTailLable.text = @"空气:优";
    } else if ([wuRanChengDu isEqualToString:@"02"]) {
        zhaungTailLable.text = @"空气:良";
    } else if ([wuRanChengDu isEqualToString:@"03"]) {
        zhaungTailLable.text = @"空气:差";
    }

}

- (void)setStateModel:(StateModel *)stateModel {
    _stateModel = stateModel;
        
    if (_stateModel.currentC) {
        
        [NSString setNSMutableAttributedString:_stateModel.currentC.floatValue andSuperLabel:timeLable andDanWei:@"°C" andSize:k25 andTextColor:kKongJingYanSe isNeedTwoXiaoShuo:@"NO"];
    }
    
    self.circleProgressView.isAnimation = _isAnimation;
    if (_stateModel.pm25) {
   
        CGFloat kongQiZhiLiang = _stateModel.pm25.floatValue / 4;
//        self.circleProgressView.text = [NSString stringWithFormat:@"%.f" , kongQiZhiLiang];
        
        [self.circleProgressView setText:[NSString stringWithFormat:@"%.f" , kongQiZhiLiang]];
        
        xiaBiaoLable.text = [NSString stringWithFormat:@"相当于 %.2f 颗大米" , (_stateModel.pm25.floatValue / kDaMi)];
    } else {
        
        self.circleProgressView.text = [NSString stringWithFormat:@"%d" , 50];
    }
    
    if (_stateModel.light == 01) {
        zhaungTailLable.text = @"空气:优";
    } else if (_stateModel.light == 02) {
        zhaungTailLable.text = @"空气:良";
    } else if (_stateModel.light == 03) {
        zhaungTailLable.text = @"空气:差";
    }
    
}

- (void)setIsAnimation:(NSString *)isAnimation {
    _isAnimation = isAnimation;
    
}

@end
