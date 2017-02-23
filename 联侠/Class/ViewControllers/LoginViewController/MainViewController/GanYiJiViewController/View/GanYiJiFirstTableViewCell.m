//
//  GanYiJiFirstTableViewCell.m
//  联侠
//
//  Created by 杭州阿尔法特 on 16/6/27.
//  Copyright © 2016年 张海昌. All rights reserved.
//

#import "GanYiJiFirstTableViewCell.h"

@interface GanYiJiFirstTableViewCell (){
    UILabel *totalTimeChenLable;
}
@property (nonatomic , strong) NSMutableDictionary *ganYiJiHongGanDic;
@property (nonatomic , strong) UILabel *leiJiJingHua;
@property (nonatomic , assign) CGFloat overPlusTime;

@property (nonatomic , strong) NSTimer *myTimer;
@end

@implementation GanYiJiFirstTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self customUI];
    }
    return self;
}


- (NSMutableDictionary *)ganYiJiHongGanDic {
    if (!_ganYiJiHongGanDic) {
        _ganYiJiHongGanDic = [NSMutableDictionary dictionary];
    }
    return _ganYiJiHongGanDic;
}

- (void)initGanYiJiHongGanDic {
    
    [self ganYiJiHongGanDic];
    
    if ([kStanderDefault objectForKey:@"ganYiJiHongGanDic"] || [kStanderDefault objectForKey:@"GanYiJiData"]) {
       
        NSInteger date2;
        if ([kStanderDefault objectForKey:@"ganYiJiHongGanDic"]) {
            _ganYiJiHongGanDic = [[kStanderDefault objectForKey:@"ganYiJiHongGanDic"] mutableCopy];
            date2 = [_ganYiJiHongGanDic[@"date2"] integerValue];
        } else if([kStanderDefault objectForKey:@"GanYiJiData"]) {
            _ganYiJiHongGanDic = [[kStanderDefault objectForKey:@"GanYiJiData"] mutableCopy];
            date2 = [_ganYiJiHongGanDic[@"date2"] integerValue];
        }
        
        NSTimeInterval currentInterval = [NSString getNowTimeInterval];
       
        if (currentInterval > date2) {
            [kStanderDefault removeObjectForKey:@"ganYiJiHongGanDic"];
            [kStanderDefault removeObjectForKey:@"GanYiJiIsWork"];
            [kStanderDefault removeObjectForKey:@"GanYiJiData"];
            _ganYiJiHongGanDic = [NSMutableDictionary dictionary];
            self.isWork = @"NO";
        } else {
            
            self.isWork = @"YES";
            [kStanderDefault setObject:self.isWork forKey:@"GanYiJiIsWork"];
            
            _overPlusTime = date2 - currentInterval;
            
            [_myTimer invalidate];
           _myTimer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(daoJiShiAtcion) userInfo:nil repeats:YES];
        }
    }
}

- (void)daoJiShiAtcion {
    
    _overPlusTime--;
    if (![_leiJiJingHua.text isEqualToString:@"工作剩余时长"]) {
        _leiJiJingHua.text = @"工作剩余时长";
    }
    NSString *straa = nil;
    
    straa = [NSString turnTimeIntervalToString:_overPlusTime];
    
    totalTimeChenLable.text = [straa substringFromIndex:14];
    totalTimeChenLable.textColor = kKongJingYanSe;
    totalTimeChenLable.font = [UIFont systemFontOfSize:k60];
    
    if (_overPlusTime <= 0) {
        [_myTimer invalidate];
        [kStanderDefault removeObjectForKey:@"ganYiJiHongGanDic"];
        [kStanderDefault removeObjectForKey:@"GanYiJiIsWork"];
        [kStanderDefault removeObjectForKey:@"GanYiJiData"];
        [self setGongZuoShiJianLable];
        self.isWork = @"NO";
        
        
        if (self.delegate || [self.delegate respondsToSelector:@selector(getGanYiJiIsWorking:andIswork:)]) {
            [self.delegate getGanYiJiIsWorking:self andIswork:self.isWork];
        }
        
    }
}

- (void)ganYiJiBeginWork:(NSNotification *)post {
    if ([post.userInfo[@"GanYiJiBeginWork"] isEqualToString:@"YES"]) {
        [self initGanYiJiHongGanDic];
    }
}

- (void)getGanYiJiIsChongZhi22:(NSNotification *)post {
    if ([post.userInfo[@"GanYiJiChongZhi"] isEqualToString:@"YES"]) {
        [_myTimer invalidate];
        [self setGongZuoShiJianLable];
        
    }
}

- (void)customUI {
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(ganYiJiBeginWork:) name:@"GanYiJiBeginWork" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getGanYiJiIsChongZhi22:) name:@"GanYiJiChongZhi" object:nil];
    
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenW, (kScreenH - kScreenH / 12.3518518) / 4 + kScreenH / 32)];
    [self.contentView addSubview:view];
    view.backgroundColor = [UIColor whiteColor];
    
    UIImageView *imageView = [[UIImageView alloc]init];
    imageView.image = [UIImage imageNamed:@"主页背景2.jpg"];
    [view addSubview:imageView];
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kScreenW, view.height));
        make.centerX.mas_equalTo(view.mas_centerX);
        make.top.mas_equalTo(view.mas_top);
    }];
    
    _leiJiJingHua = [UILabel creatLableWithTitle:@"累计运行时间" andSuperView:view andFont:k12 andTextAligment:NSTextAlignmentCenter];
    _leiJiJingHua.layer.borderWidth = 0;
    _leiJiJingHua.backgroundColor = kKongJingHuangSe;
    _leiJiJingHua.textColor = [UIColor whiteColor];
    _leiJiJingHua.layer.cornerRadius = kScreenW / 36;
    [_leiJiJingHua mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kScreenW / 3, kScreenW / 18));
        make.centerX.mas_equalTo(view.mas_centerX);
        make.centerY.mas_equalTo(view.mas_centerY).offset(- kScreenW / 16);
    }];
    
    
    totalTimeChenLable = [UILabel creatLableWithTitle:@"" andSuperView:view andFont:k15 andTextAligment:NSTextAlignmentCenter];
    totalTimeChenLable.layer.borderWidth = 0;
    [totalTimeChenLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kScreenW * 2 / 3, kScreenW / 8));
        make.centerX.mas_equalTo(view.mas_centerX);
        make.centerY.mas_equalTo(view.mas_centerY).offset(kScreenW / 16);
    }];
    
    

    UIView *bottomView = [[UIView alloc]init];
    bottomView.backgroundColor = kFenGeXianYanSe;
    [view addSubview:bottomView];
    [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kScreenW, 5));
        make.bottom.mas_equalTo(view.mas_bottom);
        make.centerX.mas_equalTo(view.mas_centerX);
    }];
    
}

- (void)setServiceDataModel:(ServicesDataModel *)serviceDataModel {
    _serviceDataModel = serviceDataModel;
    
    if ([_isWork isEqualToString:@"YES"] || [kStanderDefault objectForKey:@"GanYiJiIsWork"] ) {
        [self initGanYiJiHongGanDic];
    } else {
        [self setGongZuoShiJianLable];
    }
    
}

- (void)setIsWork:(NSString *)isWork {
    _isWork = isWork;
}

- (void)setGongZuoShiJianLable{

    [kStanderDefault removeObjectForKey:@"GanYiJiIsWork"];
    
    totalTimeChenLable.font = [UIFont systemFontOfSize:k15];
    totalTimeChenLable.textColor = [UIColor blackColor];
    CGFloat temperature2 = _serviceDataModel.totalTime / 3600000;
    
    [NSMutableString setNSMutableAttributedString:temperature2 andSuperLabel:totalTimeChenLable andDanWei:@"小时" andSize:k60 andTextColor:kKongJingYanSe isNeedTwoXiaoShuo:@"YES"];
    
    _leiJiJingHua.text = @"累计运行时间";
}

@end
