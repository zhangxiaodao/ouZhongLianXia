//
//  LengFengShanMainBaseCell.m
//  联侠
//
//  Created by 杭州阿尔法特 on 2017/10/13.
//  Copyright © 2017年 张海昌. All rights reserved.
//

#import "LengFengShanMainBaseCell.h"

@interface LengFengShanMainBaseCell ()
@property (nonatomic , strong) UILabel *timeLabel;
@property (nonatomic , strong) UILabel *tiShiLable;
@property (nonatomic , strong) UIView *firstSeparateView;
@property (nonatomic , strong) UILabel *lastTimeLabel;
@property (nonatomic , strong) UIView *sumView;
@property (nonatomic , strong) UIView *nowView;
@property (nonatomic , strong) UIButton *offBtn;

@property (nonatomic , strong) UIImageView *zhiBiaoView;
@property (nonatomic , strong) UIView *yanZhongView;
@property (nonatomic , strong) UIView *zhongDuView;
@property (nonatomic , strong) UIView *qingDuView;
@property (nonatomic , strong) UIView *qingJieView;

@property (nonatomic , strong) NSArray *imageArray;
@property (nonatomic , strong) UIImageView *waterImageView;
@property (nonatomic , strong) UILabel *waterLastLabel;

@property (nonatomic , strong) UIView *bingJingView;
@property (nonatomic , strong) UIView *waterView;
@property (nonatomic , strong) UIView *lvWangView;
@end

@implementation LengFengShanMainBaseCell

- (NSArray *)imageArray {
    if (!_imageArray) {
        _imageArray = @[[UIImage imageNamed:@"shuiWei1.png"] , [UIImage imageNamed:@"shuiWei2.png"] , [UIImage imageNamed:@"shuiWei3.png"] , [UIImage imageNamed:@"shuiWei4.png"] , [UIImage imageNamed:@"shuiWei5.png"] , [UIImage imageNamed:@"shuiWei6.png"]];
    }
    return _imageArray;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self customUI];
    }
    return self;
}

- (void)addOffBtnSuperView:(UIView *)view {
    UIButton *offBtn = [UIButton initWithTitle:@"复位" andColor:kMainColor andSuperView:view];
    offBtn.tag = 1;
    offBtn.layer.cornerRadius = kScreenH / 80;
    [offBtn addTarget:self action:@selector(fuWeiAtcion) forControlEvents:UIControlEventTouchUpInside];
    offBtn.titleLabel.font = [UIFont systemFontOfSize:k14];
    [offBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kScreenW / 7, kScreenH / 40));
        make.right.mas_equalTo(-kScreenW / 15);
        make.top.mas_equalTo(view.mas_top).offset(kScreenW / 30);
    }];
    self.offBtn = offBtn;
}

- (void)addBingJingViewSuperView:(UIView *)view  {
    UIView *bingJingView = [[UIView alloc]initWithFrame:view.bounds];
    bingJingView.backgroundColor = [UIColor clearColor];
    [view addSubview:bingJingView];
    self.bingJingView = bingJingView;
    
    UILabel *timeLable = [UILabel creatLableWithTitle:@"" andSuperView:bingJingView andFont:k14 andTextAligment:NSTextAlignmentCenter];
    timeLable.textColor = kMainColor;
    [timeLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(bingJingView.mas_centerX);
        make.top.mas_equalTo(bingJingView.mas_top)
        .offset(kScreenH / 22);
    }];
    self.timeLabel = timeLable;
    
    UILabel *tiShiLable = [UILabel creatLableWithTitle:@"滤网即将到期，请更换滤网" andSuperView:bingJingView andFont:k20 andTextAligment:NSTextAlignmentCenter];
    tiShiLable.textColor = kACOLOR(181, 156, 221, 1.0);
    [tiShiLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(bingJingView.mas_centerX);
        make.bottom.mas_equalTo(timeLable.mas_top);
    }];
    tiShiLable.hidden = YES;
    self.tiShiLable = tiShiLable;
    
    
    UIView *firstSeparateView = [UIView creatMiddleFenGeView:bingJingView andBackGroundColor:kMainColor andHeight:1 andWidth:kScreenW / 3 andConnectId:timeLable];
    self.firstSeparateView = firstSeparateView;
    
    UILabel *lastTimeLabel = [UILabel creatLableWithTitle:@"冰晶使用寿命" andSuperView:bingJingView andFont:k12 andTextAligment:NSTextAlignmentCenter];
    lastTimeLabel.textColor = [UIColor grayColor];
    [lastTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(timeLable.mas_centerX);
        make.top.mas_equalTo(firstSeparateView.mas_bottom);
    }];
    self.lastTimeLabel = lastTimeLabel;
    
    UIView *sumView = [[UIView alloc]init];
    sumView.backgroundColor = kACOLOR(233, 233, 233, 1.0);
    [bingJingView addSubview:sumView];
    [sumView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(20);
        make.top.mas_equalTo(lastTimeLabel.mas_bottom);
        make.size.mas_equalTo(CGSizeMake(kScreenW - kScreenW / 10, kScreenH / 45));
    }];
    self.sumView = sumView;
    
    UIView *nowView = [[UIView alloc]init];
    nowView.backgroundColor = kMainColor;
    [bingJingView addSubview:nowView];
    [nowView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(20);
        make.top.mas_equalTo(lastTimeLabel.mas_bottom);
        make.size.mas_equalTo(CGSizeMake(kScreenW - kScreenW / 10, kScreenH / 45));
    }];
    self.nowView = nowView;
}


- (void)addLvWangViewSuperView:(UIView *)view {
    UIView *lvWangView = [[UIView alloc]initWithFrame:view.bounds];
    lvWangView.backgroundColor = [UIColor clearColor];
    [view addSubview:lvWangView];
    self.lvWangView = lvWangView;
    
    NSArray *nameArray = [NSArray arrayWithObjects:@"重度污染" , @"中度污染" , @"轻度污染" , @"清洁" , nil];
    NSArray *colorArray = @[kACOLOR(251, 114, 34, 1.0) , kACOLOR(253, 198, 46, 1.0) , kACOLOR(182, 225, 46, 1.0) , kMainColor];
    for (NSInteger i = nameArray.count - 1; i >= 0; i--) {
        UIView *colorView = [[UIView alloc]init];
        colorView.backgroundColor = colorArray[i];
        [lvWangView addSubview:colorView];
        [colorView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(kScreenW / 15 + ((kScreenW - kScreenW * 2 /15) / 4) * i);
            make.size.mas_equalTo(CGSizeMake((kScreenW - kScreenW * 2 /15) / 4 , kScreenH / 100));
            make.centerY.mas_equalTo(lvWangView.mas_centerY);
        }];
        
        UILabel *lable = [UILabel creatLableWithTitle:[NSString stringWithFormat:@"%@" , nameArray[i]] andSuperView:lvWangView andFont:k15 andTextAligment:NSTextAlignmentCenter];
        lable.textColor = [UIColor grayColor];
        [lable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(colorView.mas_centerX);
            make.top.mas_equalTo(colorView.mas_bottom)
            .offset(kScreenW / 30);
        }];
        
        switch (i) {
            case 3:
                self.qingJieView = colorView;
                break;
            case 2:
                self.qingDuView = colorView;
                break;
            case 1:
                self.zhongDuView = colorView;
                break;
            case 0:
                self.yanZhongView = colorView;
                break;
            default:
                break;
        }
    }
    
    [self.lvWangView addSubview:self.zhiBiaoView];
    [self.zhiBiaoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kScreenW / 20, kScreenW / 20));
        make.centerX
        .mas_equalTo(self.qingJieView.mas_centerX);
        make.bottom.mas_equalTo(self.yanZhongView.mas_top);
    }];
}

- (UIImageView *)zhiBiaoView {
    if (!_zhiBiaoView) {
        _zhiBiaoView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"滤网洁度指针"]];
    }
    return _zhiBiaoView;
}

- (void)addShuiWeiViewSuperView:(UIView *)view {
    UIView *waterView = [[UIView alloc]initWithFrame:view.bounds];
    waterView.backgroundColor = [UIColor clearColor];
    [view addSubview:waterView];
    self.waterView = waterView;
    
    UIImageView *waterImageView = [[UIImageView alloc]init];
    [waterView addSubview:waterImageView];
    [waterImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kScreenW / 3, (kScreenH / 3) * 3 / 5));
        make.centerY.mas_equalTo(waterView.mas_centerY);
        make.centerX.mas_equalTo(waterView.mas_centerX)
        .offset(-kScreenW / 6);
    }];
    self.waterImageView = waterImageView;
    
    UILabel *waterLastLabel = [UILabel creatLableWithTitle:@"" andSuperView:waterView andFont:k15 andTextAligment:NSTextAlignmentCenter];
    waterLastLabel.textColor = kMainColor;
    [waterLastLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(waterView.mas_centerX)
        .offset(kScreenW / 6);
        make.top.mas_equalTo(waterView.mas_top)
        .offset(kScreenH / 22.23333);
    }];
    self.waterLastLabel = waterLastLabel;
    
    UIView *fenGeXianView = [[UIView alloc]init];
    [waterView addSubview:fenGeXianView];
    fenGeXianView.backgroundColor = kMainColor;
    [fenGeXianView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kScreenW / 3, 1));
        make.centerX.mas_equalTo(waterLastLabel.mas_centerX);
        make.top.mas_equalTo(waterLastLabel.mas_bottom);
    }];
    
    UILabel *yiGuoLvFenChenLable = [UILabel creatLableWithTitle:@"剩余水位状态" andSuperView:waterView andFont:k12 andTextAligment:NSTextAlignmentCenter];
    yiGuoLvFenChenLable.textColor = [UIColor grayColor];
    [yiGuoLvFenChenLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(waterLastLabel.mas_centerX);
        make.top.mas_equalTo(waterLastLabel.mas_bottom);
    }];
}

- (void)customUI {
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenW, kScreenH / 5)];
    view.backgroundColor = kWhiteColor;
    [self.contentView addSubview:view];
    [self addBingJingViewSuperView:view];
    [self addShuiWeiViewSuperView:view];
    [self addLvWangViewSuperView:view];
    
    [self addOffBtnSuperView:view];
    
    self.bingJingView.hidden = YES;
    self.waterView.hidden = YES;
    self.lvWangView.hidden = YES;
    
}


- (void)fuWeiAtcion {
    [UIAlertController creatCancleAndRightAlertControllerWithHandle:^{
        
        NSMutableDictionary *parames = [NSMutableDictionary dictionaryWithObjectsAndKeys:self.serviceModel.devSn, @"devSn" , self.serviceModel.devTypeSn , @"devTypeSn" , nil];
        
        if (self.cellType == CellTypeBingJing) {
            [parames setObject:@(2) forKey:@"reset"];
            [[NSNotificationCenter defaultCenter] postNotification:[NSNotification notificationWithName:@"bingJing" object:self userInfo:[NSDictionary dictionaryWithObject:@"YES" forKey:@"bingJing"]]];
        } else if (self.cellType == CellTypeShuiWei) {
            [parames setObject:@(1) forKey:@"reset"];
            [[NSNotificationCenter defaultCenter] postNotification:[NSNotification notificationWithName:@"ShuiWei" object:self userInfo:[NSDictionary dictionaryWithObject:@"YES" forKey:@"ShuiWei"]]];
        } else if (self.cellType == CellTypeLvWang) {
            [[NSNotificationCenter defaultCenter] postNotification:[NSNotification notificationWithName:@"lvWang" object:self userInfo:[NSDictionary dictionaryWithObject:@"YES" forKey:@"lvWang"]]];
            [parames setObject:@(3) forKey:@"reset"];
        }
        
        [kNetWork requestPOSTUrlString:kLengFengShanFuWi parameters:parames isSuccess:^(NSDictionary * _Nullable responseObject) {
            NSLog(@"%@" , responseObject);
        } failure:nil];
    } andSuperViewController:self.alertVC Title:@"点击复位后，数据将会被清空，重新计数"];
}

- (void)setNowUserTime:(CGFloat)nowUserTime {
    _nowUserTime = nowUserTime / 3600000;
    
    CGFloat time = (CGFloat)kLengFengShanBingJing -  _nowUserTime;
    if (time <= 0) {
        time = 0;
    }
    if ([_isKongJing isEqualToString:@"YES"]) {
        time = nowUserTime;
        [NSString setNSMutableAttributedString:time andSuperLabel:self.timeLabel andDanWei:@"小时" andSize:k30 andTextColor:kKongJingYanSe isNeedTwoXiaoShuo:@"YES"];
    } else {
        [NSString setNSMutableAttributedString:time andSuperLabel:self.timeLabel andDanWei:@"小时" andSize:k30 andTextColor:kMainColor isNeedTwoXiaoShuo:@"YES"];
    }
    
    if (time < kKongJingLvXinShouMing / 10) {
        self.tiShiLable.hidden = NO;
    }
    
    if ([self.isKongJing isEqualToString:@"YES"]) {
        self.nowView.size = CGSizeMake(((kScreenW - kScreenW / 10 )- ((kScreenW - kScreenW  / 10) / kKongJingLvXinShouMing * (kKongJingLvXinShouMing - time))), kScreenH / 45);
    } else {
        self.nowView.size = CGSizeMake(((kScreenW - kScreenW / 10 )- ((kScreenW - kScreenW  / 10) / kLengFengShanBingJing * (kLengFengShanBingJing - time))), kScreenH / 45);
    }
}

- (void)setIsKongJing:(NSString *)isKongJing {
    _isKongJing = isKongJing;
    if ([_isKongJing isEqualToString:@"YES"]) {
        _lastTimeLabel.text = @"剩余滤网寿命";
        _timeLabel.textColor = kKongJingYanSe;
        [self.offBtn removeFromSuperview];
        _nowView.backgroundColor = kKongJingYanSe;
        _firstSeparateView.backgroundColor = kKongJingYanSe;
    }
}

- (void)setServiceModel:(ServicesModel *)serviceModel {
    _serviceModel = serviceModel;
}

- (void)setCellType:(CellType)cellType {
    _cellType = cellType;
    
    if (_cellType == CellTypeBingJing) {
        self.bingJingView.hidden = NO;
    } else if (_cellType == CellTypeShuiWei) {
        self.waterView.hidden = NO;
    } else if (_cellType == CellTypeLvWang) {
        self.lvWangView.hidden = NO;
    }
    
}

- (void)setUserWaterData:(CGFloat)userWaterData {
    _userWaterData = userWaterData / 3600000;
    
    CGFloat waterLastData = kLengFengShanShuiWei - _userWaterData;
    
    if (waterLastData <= 0) {
        waterLastData = 0;
    }
    
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%.1f分钟" , waterLastData]];
    [str addAttribute:NSFontAttributeName value:[UIFont fontWithName:kFontWithName size:k30] range:NSMakeRange(0, [NSString stringWithFormat:@"%.1f" , waterLastData].length)];
    self.waterLastLabel.attributedText = str;
    
    if (_userWaterData > kLengFengShanShuiWei) {
        self.waterImageView.image = self.imageArray[5];
    } else if (_userWaterData <= kLengFengShanShuiWei  && _userWaterData >= kLengFengShanShuiWei * 5 / 6) {
        self.waterImageView.image = self.imageArray[5];
    } else if (_userWaterData < kLengFengShanShuiWei * 5 / 6 && _userWaterData >= kLengFengShanShuiWei * 4 / 6) {
        self.waterImageView.image = self.imageArray[4];
    } else if (_userWaterData < kLengFengShanShuiWei * 4 / 6  && _userWaterData >= kLengFengShanShuiWei * 3 / 6) {
        self.waterImageView.image = self.imageArray[3];
    } else if (_userWaterData < kLengFengShanShuiWei * 3 / 6  && _userWaterData >= kLengFengShanShuiWei * 2 / 6) {
        self.waterImageView.image = self.imageArray[2];
    } else if (_userWaterData < kLengFengShanShuiWei * 2 / 6  && _userWaterData >= kLengFengShanShuiWei * 1 / 6) {
        self.waterImageView.image = self.imageArray[1];
    } else if (_userWaterData < kLengFengShanShuiWei * 1 / 6  && _userWaterData >= 0) {
        self.waterImageView.image = self.imageArray[0];
    }
}

- (void)setTotalTime:(CGFloat)totalTime {
    _totalTime = totalTime;
    
    NSInteger index = _totalTime / ((NSInteger)kLengFengShanSumLvWang * 3600000);
    index = index - 1;
    CGFloat width = (kScreenW - kScreenW * 2 /15) / 4;
    
    [self.zhiBiaoView removeFromSuperview];
    [self.lvWangView addSubview:self.zhiBiaoView];
    [self.zhiBiaoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kScreenW / 20, kScreenW / 20));
        make.centerX
        .mas_equalTo(self.qingJieView.mas_centerX).offset(-width * index);
        make.bottom.mas_equalTo(self.yanZhongView.mas_top);
    }];
    
}

@end
