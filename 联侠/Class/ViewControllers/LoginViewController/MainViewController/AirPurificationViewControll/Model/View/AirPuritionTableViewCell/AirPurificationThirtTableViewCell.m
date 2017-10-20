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
    UILabel *dustLabel;
    UILabel *timeLable;
    UILabel *xiaBiaoLable;
    UILabel *contrastLabel;
}

@property (nonatomic , strong) NSMutableArray *shiWaipm25Key;
@property (nonatomic , strong) NSMutableArray *shiWaiPm25Value;

@property (nonatomic , strong) NSMutableArray *shiNeiPm25Value;
@property (nonatomic , strong) NSMutableArray *shiNeiPm25Key;

@end

@implementation AirPurificationThirtTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self customUI];
    }
    return self;
}

- (void)customUI {
    
    UIView *view = [[UIView alloc]init];
    view.backgroundColor = [UIColor whiteColor];
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
    
    contrastLabel = [UILabel creatLableWithTitle:@"请开窗" andSuperView:view andFont:k14 andTextAligment:NSTextAlignmentCenter];
    contrastLabel.textColor = kKongJingYanSe;
    [contrastLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(view.mas_centerX).offset(- kScreenW / 3.4);
        make.top.mas_equalTo(view.mas_top).offset(kScreenH / 22);
    }];
    
    UIView *fenGeXianView = [UIView creatMiddleFenGeView:view andBackGroundColor:kKongJingYanSe andHeight:1 andWidth:kScreenW / 4 andConnectId:contrastLabel];
    
    UILabel *betterContrastLabel = [UILabel creatLableWithTitle:@"优于室外空气质量" andSuperView:view andFont:k12 andTextAligment:NSTextAlignmentCenter];
    betterContrastLabel.textColor = kKongJingYanSe;
    [betterContrastLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(contrastLabel.mas_centerX);
        make.top.mas_equalTo(fenGeXianView.mas_bottom);
    }];
    
    UIView *fenGeXianView3 = [[UIView alloc]init];
    [view addSubview:fenGeXianView3];
    fenGeXianView3.backgroundColor = kFenGeXianYanSe;
    [fenGeXianView3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(1, kScreenH / 9));
        make.centerX.mas_equalTo(view.mas_centerX);
        make.top.mas_equalTo(view.mas_top).offset(kScreenH / 45);
    }];
    
    timeLable = [UILabel creatLableWithTitle:@"" andSuperView:view andFont:k14 andTextAligment:NSTextAlignmentCenter];
    timeLable.textColor = kKongJingYanSe;
    [timeLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(view.mas_centerX)
        .offset( kScreenW / 3.4);
        make.top.mas_equalTo(view.mas_top)
        .offset(kScreenH / 22);
    }];
    
    [NSString setNSMutableAttributedString:100 andSuperLabel:timeLable andDanWei:@"小时" andSize:k30 andTextColor:kKongJingYanSe isNeedTwoXiaoShuo:@"NO"];
    
    UIView *fenGeXianView2 = [UIView creatMiddleFenGeView:view andBackGroundColor:kKongJingYanSe andHeight:1 andWidth:kScreenW / 4 andConnectId:timeLable];
    
    UILabel *sumTimeLable = [UILabel creatLableWithTitle:@"累计运行时间" andSuperView:view andFont:k12 andTextAligment:NSTextAlignmentCenter];
    sumTimeLable.textColor = kKongJingYanSe;
    [sumTimeLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(timeLable.mas_centerX);
        make.top.mas_equalTo(fenGeXianView2.mas_bottom);
    }];
    
    UILabel *sumFilterLabel = [UILabel creatLableWithTitle:@"累计过滤粉尘" andSuperView:view andFont:k12 andTextAligment:NSTextAlignmentCenter];
    sumFilterLabel.backgroundColor = kACOLOR(250, 201, 77, 1.0);
    sumFilterLabel.textColor = [UIColor whiteColor];
    sumFilterLabel.layer.cornerRadius = kScreenW / 36;
    [sumFilterLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kScreenW / 3, kScreenW / 18));
        make.centerX.mas_equalTo(view.mas_centerX);
        make.top.mas_equalTo(fenGeXianView3.mas_bottom)
        .offset(kScreenW / 22);
    }];

    dustLabel = [UILabel creatLableWithTitle:@"" andSuperView:view andFont:k15 andTextAligment:NSTextAlignmentCenter];
    dustLabel.layer.borderWidth = 0;
    [dustLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(view.mas_centerX);
        make.top.mas_equalTo(sumFilterLabel.mas_bottom)
        .offset(kScreenW / 33.35);
    }];
    
    [NSString setNSMutableAttributedString:100 andSuperLabel:dustLabel andDanWei:@"mg" andSize:k60 andTextColor:kKongJingYanSe isNeedTwoXiaoShuo:@"NO"];

    xiaBiaoLable = [UILabel creatLableWithTitle:@"1" andSuperView:view andFont:k12 andTextAligment:NSTextAlignmentCenter];
    [xiaBiaoLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(view.mas_centerX);
        make.top.mas_equalTo(dustLabel.mas_bottom);
    }];
    xiaBiaoLable.textColor = kKongJingYanSe;
    
}

- (void)setServiceDataModel:(ServicesDataModel *)serviceDataModel {
    _serviceDataModel = serviceDataModel;
    
    CGFloat time = 100;
    if (_serviceDataModel.totalTime) {
        time = _serviceDataModel.totalTime / 3600000;
    }
    [NSString setNSMutableAttributedString:time andSuperLabel:timeLable andDanWei:@"小时" andSize:k30 andTextColor:kKongJingYanSe isNeedTwoXiaoShuo:@"YES"];
    
    CGFloat dust =  time * 0.3575;
    
    [NSString setNSMutableAttributedString:dust andSuperLabel:dustLabel andDanWei:@"mg" andSize:k60 andTextColor:kKongJingYanSe isNeedTwoXiaoShuo:@"YES"];
    xiaBiaoLable.text = [NSString stringWithFormat:@"相当于 %.2f 颗大米" , (dust / kDaMi)];
}

- (void)setServiceModel:(ServicesModel *)serviceModel {
    _serviceModel = serviceModel;
    
    if ([kStanderDefault objectForKey:@"cityName"]) {
        NSString *city = [kStanderDefault objectForKey:@"cityName"];
        NSDictionary *parames = @{@"city" : city , @"times" : @12};
        NSLog(@"%@" , parames);
        
        [kNetWork requestPOSTUrlString:kDangTianKongQiZhiLiang parameters:parames isSuccess:^(NSDictionary * _Nullable responseObject) {
            [self requestOutDoorPM25:responseObject];
            
        } failure:nil];
        
    }
}

- (void)requestOutDoorPM25:(NSDictionary *)dic {
    if ([dic[@"data"] isKindOfClass:[NSDictionary class]]) {
        NSDictionary *data = dic[@"data"];
        NSDictionary *pm25 = data[@"pm25"];
        NSArray *pm25AllKeys = [pm25 allKeys];
        NSMutableArray *timeArray = [self get24TimesFromNowTime];
        
        [self.shiWaipm25Key removeAllObjects];
        [self.shiWaiPm25Value removeAllObjects];
        for (NSString *times in timeArray) {
            for (NSString *key in pm25AllKeys) {
                if ([times isEqualToString:key]) {
                    
                    if (![pm25[times] isKindOfClass:[NSNull class]]) {
                        [self.shiWaipm25Key addObject:times];
                        [self.shiWaiPm25Value addObject:@([pm25[times] integerValue])];
                    }
                }
            }
        }
        if (timeArray.count > 0) {
            
            NSString *lastTime = [timeArray lastObject];
            NSDictionary *parames = @{@"devTypeSn" : _serviceModel.devTypeSn , @"devSn" : _serviceModel.devSn , @"times" : @12  , @"lastTime" : @(lastTime.integerValue)};
            
            [kNetWork requestPOSTUrlString:kKongJingPM25State parameters:parames isSuccess:^(NSDictionary * _Nullable responseObject) {
                [self requestIndoorPM25:responseObject];
            } failure:nil];
        }
    }
}

- (void)requestIndoorPM25:(NSDictionary *)dic {
    
    if ([dic[@"data"] isKindOfClass:[NSDictionary class]]) {
        NSDictionary *data = dic[@"data"];
        
        NSMutableArray *keys = [[data allKeys] mutableCopy];
        
        NSMutableArray *timeArray = [self get24TimesFromNowTime];
        
        [self.shiNeiPm25Key removeAllObjects];
        [self.shiNeiPm25Value removeAllObjects];
        for (NSString *times in timeArray) {
            for (NSString *key in keys) {
                if ([times isEqualToString:key]) {
                    
                    [self.shiNeiPm25Key addObject:times];
                    if (![data[times] isKindOfClass:[NSNull class]]) {
                        
                        [self.shiNeiPm25Value addObject:@([data[times] integerValue] / 4) ];
                    } else{
                        [self.shiNeiPm25Value addObject:data[times]];
                    }
                }
            }
        }
        
        NSInteger length = self.shiNeiPm25Value.count;
        for (NSInteger i = length - 1; i >= 0; i--) {
            
            if ([self.shiNeiPm25Value[length - 1] isKindOfClass:[NSNull class]]) {
                [self.shiNeiPm25Key removeAllObjects];
                
            } else {
                
                if ([self.shiNeiPm25Value[i] isKindOfClass:[NSNull class]] ) {
                    
                    self.shiNeiPm25Value[i] = self.shiNeiPm25Value[i + 1];
                }
            }
        }
        if (self.shiNeiPm25Key.count > 0 && self.shiNeiPm25Value.count > 0) {
            [self shiNeiShiWaiAqiDuiBi];
        }
    }
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
        
        if (text1 <= 0) {
            contrastLabel.text = @"请开窗";
        } else {
            [NSString setNSMutableAttributedString:text1 * 100 andSuperLabel:contrastLabel andDanWei:@"%" andSize:k30 andTextColor:kKongJingYanSe isNeedTwoXiaoShuo:@"YES"];
        }
    } else {
            contrastLabel.text = @"请开窗";
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
