//
//  AirPurificationThirtTableViewCell.m
//  联侠
//
//  Created by 杭州阿尔法特 on 16/6/7.
//  Copyright © 2016年 张海昌. All rights reserved.
//

#import "AirPurificationThirtTableViewCell.h"
#import "AirgengDuoViewController.h"


@interface AirPurificationThirtTableViewCell ()<HelpFunctionDelegate>{
    UILabel *leiJiGuoLvFenChenLable;
    UILabel *timeLable1;
    UILabel *xiaBiaoLable;
    UILabel *fenChenLable;
}

@property (nonatomic , strong) NSMutableArray *shiWaipm25Key;
@property (nonatomic , strong) NSMutableArray *shiWaiPm25Value;

@property (nonatomic , strong) NSMutableArray *shiNeiPm25Value;
@property (nonatomic , strong) NSMutableArray *shiNeiPm25Key;

@end

@implementation AirPurificationThirtTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        
        [self customUI];
    }
    return self;
}

- (void)customUI {
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    UIView *view = [[UIView alloc]init];
    view.backgroundColor = [UIColor redColor];
    view.frame = CGRectMake(0, 0, kScreenW, kScreenH / 2.767634 - 5);
    [self.contentView addSubview:view];
    
    
    UIImageView *imageView = [[UIImageView alloc]init];
    imageView.image = [UIImage imageNamed:@"主页背景2.jpg"];
    [view addSubview:imageView];
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kScreenW, view.height));
        make.centerX.mas_equalTo(view.mas_centerX);
        make.top.mas_equalTo(view.mas_top);
    }];

    
    fenChenLable = [UILabel creatLableWithTitle:@"" andSuperView:view andFont:k14 andTextAligment:NSTextAlignmentCenter];
    fenChenLable.textColor = kKongJingYanSe;
    fenChenLable.layer.borderWidth = 0;
    [fenChenLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kScreenW / 3, kScreenW / 14));
        make.centerX.mas_equalTo(view.mas_centerX).offset(- kScreenW / 3.4090909);
        make.top.mas_equalTo(view.mas_top).offset(kScreenH / 22.23333);
    }];
    
//    CGFloat text1 = 59;
//    [NSString setNSMutableAttributedString:text1 andSuperLabel:fenChenLable andDanWei:@"%" andSize:k30 andTextColor:kKongJingYanSe isNeedTwoXiaoShuo:@"NO"];
    
    fenChenLable.text = @"请开窗";
    
    
    UIView *fenGeXianView = [UIView creatMiddleFenGeView:view andBackGroundColor:kKongJingYanSe andHeight:1 andWidth:kScreenW / 4 andConnectId:fenChenLable];
    
    UILabel *yiGuoLvFenChenLable = [UILabel creatLableWithTitle:@"优于室外空气质量" andSuperView:view andFont:k12 andTextAligment:NSTextAlignmentCenter];
    yiGuoLvFenChenLable.layer.borderWidth = 0;
    yiGuoLvFenChenLable.textColor = kKongJingYanSe;
    [yiGuoLvFenChenLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kScreenW / 3, kScreenW / 14));
        make.centerX.mas_equalTo(fenChenLable.mas_centerX);
        make.top.mas_equalTo(fenGeXianView.mas_bottom);
    }];
    
    UIView *fenGeXianView3 = [[UIView alloc]init];
    [view addSubview:fenGeXianView3];
    fenGeXianView3.backgroundColor = kFenGeXianYanSe;
    
    [fenGeXianView3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(1, kScreenH / 9));
        make.centerX.mas_equalTo(view.mas_centerX);
        make.top.mas_equalTo(view.mas_top).offset(kScreenH / 44.4666666);
    }];
    
    
    
    timeLable1 = [UILabel creatLableWithTitle:@"" andSuperView:view andFont:k14 andTextAligment:NSTextAlignmentCenter];
    timeLable1.layer.borderWidth = 0;
    timeLable1.textColor = kKongJingYanSe;
    [timeLable1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kScreenW / 3, kScreenW / 14));
        make.centerX.mas_equalTo(view.mas_centerX).offset( kScreenW / 3.4090909);
        make.top.mas_equalTo(view.mas_top).offset(kScreenH / 22.23333);
    }];
    
    CGFloat time1 = 100;

    [NSString setNSMutableAttributedString:time1 andSuperLabel:timeLable1 andDanWei:@"小时" andSize:k30 andTextColor:kKongJingYanSe isNeedTwoXiaoShuo:@"NO"];
    
    
    UIView *fenGeXianView2 = [UIView creatMiddleFenGeView:view andBackGroundColor:kKongJingYanSe andHeight:1 andWidth:kScreenW / 4 andConnectId:timeLable1];
    
    UILabel *sumTimeLable = [UILabel creatLableWithTitle:@"累计运行时间" andSuperView:view andFont:k12 andTextAligment:NSTextAlignmentCenter];
    sumTimeLable.textColor = kKongJingYanSe;
    sumTimeLable.layer.borderWidth = 0;
    [sumTimeLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kScreenW / 3, kScreenW / 14));
        make.centerX.mas_equalTo(timeLable1.mas_centerX);
        make.top.mas_equalTo(fenGeXianView2.mas_bottom);
        
    }];
    
    
    UILabel *leiJiJingHua = [UILabel creatLableWithTitle:@"累计过滤粉尘" andSuperView:view andFont:k12 andTextAligment:NSTextAlignmentCenter];
    leiJiJingHua.layer.borderWidth = 0;

    leiJiJingHua.backgroundColor = kACOLOR(250, 201, 77, 1.0);
    leiJiJingHua.textColor = [UIColor whiteColor];
    leiJiJingHua.layer.cornerRadius = kScreenW / 36;
    [leiJiJingHua mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kScreenW / 3, kScreenW / 18));
        make.centerX.mas_equalTo(view.mas_centerX);
        make.top.mas_equalTo(fenGeXianView3.mas_bottom).offset(kScreenW / 22.23333);
    }];

    
    leiJiGuoLvFenChenLable = [UILabel creatLableWithTitle:@"" andSuperView:view andFont:k15 andTextAligment:NSTextAlignmentCenter];
    leiJiGuoLvFenChenLable.layer.borderWidth = 0;
    [leiJiGuoLvFenChenLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kScreenW * 2 / 3, kScreenW / 7));
        make.centerX.mas_equalTo(view.mas_centerX);
        make.top.mas_equalTo(leiJiJingHua.mas_bottom).offset(kScreenW / 33.35);
    }];
    
    
    CGFloat temperature2 = 100;
    
    [NSString setNSMutableAttributedString:temperature2 andSuperLabel:leiJiGuoLvFenChenLable andDanWei:@"mg" andSize:k60 andTextColor:kKongJingYanSe isNeedTwoXiaoShuo:@"NO"];

    
    
    xiaBiaoLable = [UILabel creatLableWithTitle:[NSString stringWithFormat:@"%d" , 1] andSuperView:view andFont:k12 andTextAligment:NSTextAlignmentCenter];
    xiaBiaoLable.layer.borderWidth = 0;
    [xiaBiaoLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(view.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(kScreenW / 2, kScreenW / 15));
        make.top.mas_equalTo(leiJiGuoLvFenChenLable.mas_bottom);
    }];
    xiaBiaoLable.textColor = kKongJingYanSe;
    
}

- (void)setServiceDataModel:(ServicesDataModel *)serviceDataModel {
    _serviceDataModel = serviceDataModel;
    
    
    CGFloat time1 = 100;
    if (_serviceDataModel.totalTime) {
        time1 = _serviceDataModel.totalTime / 3600000;
    }
    
    [NSString setNSMutableAttributedString:time1 andSuperLabel:timeLable1 andDanWei:@"小时" andSize:k30 andTextColor:kKongJingYanSe isNeedTwoXiaoShuo:@"YES"];
    
    
    CGFloat temperature2 =  (_serviceDataModel.totalTime / 3600000) * 0.3575;
    
    [NSString setNSMutableAttributedString:temperature2 andSuperLabel:leiJiGuoLvFenChenLable andDanWei:@"mg" andSize:k60 andTextColor:kKongJingYanSe isNeedTwoXiaoShuo:@"YES"];
    
    xiaBiaoLable.text = [NSString stringWithFormat:@"相当于 %.2f 颗大米" , (temperature2 / kDaMi)];
    
}


- (void)setServiceModel:(ServicesModel *)serviceModel {
    _serviceModel = serviceModel;
    
    if ([kStanderDefault objectForKey:@"cityName"]) {
        NSString *city = [kStanderDefault objectForKey:@"cityName"];
        NSDictionary *parames2 = @{@"city" : city , @"times" : @12};
        NSLog(@"%@" , parames2);
        [HelpFunction requestDataWithUrlString:kDangTianKongQiZhiLiang andParames:parames2 andDelegate:self];
    }
    
}


- (void)requestKongQiZhiLiangShuJu:(HelpFunction *)request didYes:(NSDictionary *)dic {
//    NSLog(@"室外%@" , dic);
    
    
    [self shiWaipm25Key];
    [self shiWaiPm25Value];
    if ([dic[@"data"] isKindOfClass:[NSDictionary class]]) {
        NSDictionary *data = dic[@"data"];
        NSDictionary *pm25 = data[@"pm25"];
        NSArray *pm25AllKeys = [pm25 allKeys];
        NSMutableArray *timeArray = [self get24TimesFromNowTime];
        
        
        [_shiWaipm25Key removeAllObjects];
        [_shiWaiPm25Value removeAllObjects];
        for (NSString *times in timeArray) {
            for (NSString *key in pm25AllKeys) {
                if ([times isEqualToString:key]) {
                    
                    if (![pm25[times] isKindOfClass:[NSNull class]]) {
                        [_shiWaipm25Key addObject:times];
                        [_shiWaiPm25Value addObject:@([pm25[times] integerValue])];
                    }
                    
                }
            }
        }
        
        if (timeArray.count > 0) {
            
            NSString *lastTime = [timeArray lastObject];
            NSDictionary *parames = @{@"devTypeSn" : _serviceModel.devTypeSn , @"devSn" : _serviceModel.devSn , @"times" : @12  , @"lastTime" : @(lastTime.integerValue)};
            [HelpFunction requestDataWithUrlString:kKongJingPM25State andParames:parames andDelegate:self];
        }
    }
    
}

- (void)requestData:(HelpFunction *)request didSuccess:(NSDictionary *)dddd {
//    NSLog(@"室内%@" , dddd);
    
    [self shiNeiPm25Key];
    [self shiNeiPm25Value];
    
    if ([dddd[@"data"] isKindOfClass:[NSDictionary class]]) {
        NSDictionary *data = dddd[@"data"];
        
        NSMutableArray *keys = [[data allKeys] mutableCopy];
        
        NSMutableArray *timeArray = [self get24TimesFromNowTime];
        
        
        [_shiNeiPm25Key removeAllObjects];
        [_shiNeiPm25Value removeAllObjects];
        for (NSString *times in timeArray) {
            for (NSString *key in keys) {
                if ([times isEqualToString:key]) {
                    
                    [_shiNeiPm25Key addObject:times];
                    if (![data[times] isKindOfClass:[NSNull class]]) {
                        
                        [_shiNeiPm25Value addObject:@([data[times] integerValue] / 4) ];
                    } else{
                        [_shiNeiPm25Value addObject:data[times]];
                    }
                    
                }
            }
        }
        
        NSInteger length = _shiNeiPm25Value.count;
        for (NSInteger i = length - 1; i >= 0; i--) {
            
            if ([_shiNeiPm25Value[length - 1] isKindOfClass:[NSNull class]]) {
                [_shiNeiPm25Key removeAllObjects];

            } else {
                
                if ([_shiNeiPm25Value[i] isKindOfClass:[NSNull class]] ) {
                    
                    _shiNeiPm25Value[i] = _shiNeiPm25Value[i + 1];
                }
            }
            
            
        }
        
        if (_shiNeiPm25Key.count > 0 && _shiNeiPm25Value.count > 0) {
            [self shiNeiShiWaiAqiDuiBi];
        }
        
    }
}

- (void)requestData:(HelpFunction *)request didFailLoadData:(NSError *)error {
    NSLog(@"%@" , error);
}

- (void)setStateModel:(StateModel *)stateModel {
    _stateModel = stateModel;
    
}

- (void)shiNeiShiWaiAqiDuiBi{
    
    
     NSString *lastValue = [_shiWaiPm25Value lastObject];
     NSString *shiNeiLastValue = [_shiNeiPm25Value lastObject];
    if (lastValue && _stateModel.sPm25) {
       
        CGFloat lastShiWaiValue = lastValue.floatValue;
        CGFloat shiNeiValue = shiNeiLastValue.floatValue;
        CGFloat text1 = (lastShiWaiValue - shiNeiValue) / lastShiWaiValue;
        
//        NSLog(@"CCCCC%f , %.2f , %.2f" , text1 , lastShiWaiValue , shiNeiValue);
        if (text1 <= 0) {
            fenChenLable.text = @"请开窗";
        } else {
            
            [NSString setNSMutableAttributedString:text1 * 100 andSuperLabel:fenChenLable andDanWei:@"%" andSize:k30 andTextColor:kKongJingYanSe isNeedTwoXiaoShuo:@"YES"];
        }
    } else {
            fenChenLable.text = @"请开窗";
    }
    
}

- (NSMutableArray *)get24TimesFromNowTime{
    
    NSMutableArray *timeArray = [NSMutableArray array];
    for (int i = 24; i > 0; i = i - 2) {
        
        NSString *time = [NSString timeAndAfterHours:@(i) andAfterDays:nil andMonth:nil];
        time = [time substringToIndex:time.length - 1];
        
        if (time.intValue < 10) {
            time = [time substringFromIndex:1];
        }
        if (time.intValue % 2 != 0 ) {
            time = [NSString stringWithFormat:@"%d" , time.intValue - 1];
        }
        [timeArray addObject:time];
    }
    return timeArray;
    
}

- (NSMutableArray *)shiWaipm25Key {
    if (!_shiWaipm25Key) {
        _shiWaipm25Key = [NSMutableArray array];
    }
    return _shiWaipm25Key;
}

- (NSMutableArray *)shiWaiPm25Value {
    if (!_shiWaiPm25Value) {
        _shiWaiPm25Value = [NSMutableArray array];
    }
    return _shiWaiPm25Value;
}


- (NSMutableArray *)shiNeiPm25Key {
    if (!_shiNeiPm25Key) {
        _shiNeiPm25Key = [NSMutableArray array];
    }
    return _shiNeiPm25Key;
}

- (NSMutableArray *)shiNeiPm25Value {
    if (!_shiNeiPm25Value) {
        _shiNeiPm25Value = [NSMutableArray array];
    }
    return _shiNeiPm25Value;
}



@end
