//
//  XinFengFirstTableViewCell.m
//  联侠
//
//  Created by 杭州阿尔法特 on 16/10/10.
//  Copyright © 2016年 张海昌. All rights reserved.
//

#import "XinFengFirstTableViewCell.h"
//#import "CircleAnimation.h"

#define kRadiuesW kScreenW / 1.23
#define kDuration 4.0

static CGFloat angle = 0.0;
static CGFloat speed = 0.0;

@interface XinFengFirstTableViewCell ()<HelpFunctionDelegate>
@property (nonatomic , strong) UILabel *temperatureLabel;
@property (nonatomic , strong) UILabel *humidityLabel;

@property (nonatomic , strong) UILabel *methanalLabel;
@property (nonatomic , strong) UILabel *pm25Label;
@property (nonatomic , strong) UILabel *lvXinLastTime;
@property (nonatomic , strong) UILabel *modelLabel;
@property (nonatomic , strong) UIImageView *fengSuBiaoShiImageView;

@property (nonatomic , strong) UIImageView *spinImageView;
@property (nonatomic , copy) NSString *isPlay;
@property (nonatomic , assign) NSInteger isAnimation;
@property (nonatomic , copy) NSString *wind;

@property (nonatomic , strong) StateModel *stateModel;
@end

@implementation XinFengFirstTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self customUI];
//        speed = 0.0;
//        angle = 0.0;
        [_myTimer invalidate];
        _myTimer = nil;
        _myTimer = [NSTimer scheduledTimerWithTimeInterval:1.0 / 60.0 target:self selector:@selector(aircleImageAtcion) userInfo:nil repeats:YES];
        
            
    }
    return self;
}



- (void)aircleImageAtcion {
    angle = angle + speed;
    self.spinImageView.transform = CGAffineTransformMakeRotation(angle * M_PI / 180.0);
//    NSLog(@"%.2f , %.2f" , angle , speed);
}

- (void)getBottomBtnSelected:(NSNotification *)post {
    NSString *selected = post.userInfo[@"BottomBtnSelected"];
//    NSLog(@"-----%@ , %@" , selected , _wind);
    self.isAnimation = selected.integerValue;
    
    if (self.isAnimation == 0) {
        angle = 0;
        speed = 0;
        
    } else if (self.isAnimation == 1){
        if ([_wind isEqualToString:@"01"]) {            speed = 0.5;
        } else if ([_wind isEqualToString:@"02"]) {            speed = 1.0;
        } else if ([_wind isEqualToString:@"03"]) {
            speed = 1.5;
        } else if ([_wind isEqualToString:@"04"]) {            speed = 2.0;
        }
        
    }
}

- (void)getXinFengModelState:(NSNotification *)post {
    NSString *xinFengModelStr = post.userInfo[@"XinFengModelState"];
    _modelLabel.text = xinFengModelStr;
}

- (void)customUI {
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getXinFengKongJingDataMessageFunction:) name:kServiceOrder object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getBottomBtnSelected:) name:@"BottomBtnSelected" object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getXinFengModelState:) name:@"XinFengModelState" object:nil];
    
    _isPlay = @"NO";
    
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenW, kScreenW * 1.216 + kScreenW / 10 - kScreenW / 25 + 5)];
    [self.contentView addSubview:view];
    view.backgroundColor = kACOLOR(28, 157, 247, 1.0);
    
    
    UIImageView *circleImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"xinFengCircle"]];
    [view addSubview:circleImageView];
    circleImageView.frame = CGRectMake((kScreenW - kRadiuesW) / 2, (kScreenW - kRadiuesW) / 2, kRadiuesW, kRadiuesW);
    
    _spinImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"xinFengSpin"]];
    [circleImageView addSubview:_spinImageView];
    
    _spinImageView.frame = CGRectMake(0, 0, kRadiuesW, kRadiuesW);
    
    
    _fengSuBiaoShiImageView = [[UIImageView alloc]initWithImage:[UIImage new]];
    [view addSubview:_fengSuBiaoShiImageView];
    [_fengSuBiaoShiImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kStandardW / 3, kScreenW / 15));
        make.left.mas_equalTo(view.mas_left).offset(kScreenW / 20);
        make.top.mas_equalTo(circleImageView.mas_bottom);
    }];
    _fengSuBiaoShiImageView.contentMode = UIViewContentModeScaleAspectFit;
    
    UILabel *modelLabel = [UILabel creatLableWithTitle:@"" andSuperView:view andFont:k14 andTextAligment:NSTextAlignmentCenter];
    [modelLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kStandardW / 3, kScreenW / 15));
        make.centerY.mas_equalTo(_fengSuBiaoShiImageView.mas_centerY);
        make.right.mas_equalTo(view.mas_right).offset(-kScreenW / 20);
    }];
    modelLabel.textColor = [UIColor whiteColor];
    modelLabel.layer.borderWidth = 0;
    _modelLabel = modelLabel;
    
    UILabel *pm25TitleLabel = [UILabel creatLableWithTitle:@"PM2.5" andSuperView:view andFont:k15 andTextAligment:NSTextAlignmentCenter];
    [pm25TitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kScreenW / 3, kScreenW / 15));
        make.centerX.mas_equalTo(view.mas_centerX);
        make.top.mas_equalTo(circleImageView.mas_top).offset(circleImageView.height / 4);
    }];
    pm25TitleLabel.textColor = [UIColor whiteColor];
    pm25TitleLabel.layer.borderWidth = 0;
    
    UILabel *pm25Label = [UILabel creatLableWithTitle:@"40" andSuperView:view andFont:k40 andTextAligment:NSTextAlignmentCenter];
    [pm25Label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(view.mas_centerX);
        make.top.mas_equalTo(pm25TitleLabel.mas_bottom)
        .offset(kScreenW / 35);
    }];
    pm25Label.textColor = [UIColor whiteColor];
    self.pm25Label = pm25Label;
    
    UILabel *lvXinLastTimeTitleLabel = [UILabel creatLableWithTitle:@"滤芯设定剩余" andSuperView:view andFont:k15 andTextAligment:NSTextAlignmentCenter];
    [lvXinLastTimeTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kScreenW / 3, kScreenW / 15));
        make.centerX.mas_equalTo(view.mas_centerX);
        make.top.mas_equalTo(pm25Label.mas_bottom)
        .offset(kScreenW / 35);
    }];
    lvXinLastTimeTitleLabel.textColor = [UIColor whiteColor];
    lvXinLastTimeTitleLabel.layer.borderWidth = 0;
    
    _lvXinLastTime = [UILabel creatLableWithTitle:@"1000小时" andSuperView:view andFont:k15 andTextAligment:NSTextAlignmentCenter];
    [_lvXinLastTime mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kScreenW / 3, kScreenW / 12));
        make.centerX.mas_equalTo(view.mas_centerX);
        make.top.mas_equalTo(lvXinLastTimeTitleLabel.mas_bottom);
    }];
    _lvXinLastTime.textColor = [UIColor whiteColor];
    _lvXinLastTime.layer.borderWidth = 0;
    
    
    NSArray *titleArray = @[@"室内温度" , @"室内湿度"  , @"VOC"];
    NSArray *valueArray = @[@"24" , @"66" , @"24"];
    
    for (int i = 0; i < titleArray.count; i++) {
        UIView *forthView = [[UIView alloc]init];
        [view addSubview:forthView];
        [forthView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(kScreenW / titleArray.count - 1, view.height - circleImageView.height - circleImageView.y - kScreenW / 15));
            make.left.mas_equalTo(view.mas_left).offset(kScreenW * i / titleArray.count);
            make.top.mas_equalTo(_fengSuBiaoShiImageView.mas_bottom);
        }];
        [self creatUpAndDownLabelWith:titleArray[i] andUpFont:k15 andTextColor:[UIColor whiteColor] andDownTitle:valueArray[i] andDownFont:k30 andDownTextColor:[UIColor whiteColor] andSuperView:forthView];
        
        UIView *jianGeView = [[UIView alloc]init];
        [view addSubview:jianGeView];
        jianGeView.backgroundColor = kFenGeXianYanSe;
        [jianGeView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(1, (view.height - circleImageView.height - circleImageView.y - kScreenW / 15)  / 2));
            make.left.mas_equalTo(forthView.mas_right);
            make.centerY.mas_equalTo(forthView.mas_centerY);
        }];
        jianGeView.alpha = 0.3;
        
        switch (i) {
            case 0:
                _temperatureLabel = forthView.subviews[1];
                break;
            case 1:
                _humidityLabel = forthView.subviews[1];
                break;
            case 2:
                _methanalLabel = forthView.subviews[1];
                break;
            default:
                break;
        }
        
    }
    
    
    UIView *bottomView = [[UIView alloc]init];
    bottomView.backgroundColor = kFenGeXianYanSe;
    [view addSubview:bottomView];
    [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(view.mas_bottom);
        make.centerX.mas_equalTo(view.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(kScreenW, 5));
    }];
}


- (void)creatUpAndDownLabelWith:(NSString *)upTitle andUpFont:(CGFloat)upFont andTextColor:(UIColor *)upColor andDownTitle:(NSString *)downTitle andDownFont:(CGFloat)downFont andDownTextColor:(UIColor *)downColor andSuperView:(UIView *)superView{
    UILabel *upLable = [UILabel creatLableWithTitle:upTitle andSuperView:superView andFont:upFont andTextAligment:NSTextAlignmentCenter];
    [upLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kScreenW / 4, kScreenW / 10));
        make.centerX.mas_equalTo(superView.mas_centerX);
        make.top.mas_equalTo(superView.mas_top);
    }];
    upLable.textColor = upColor;
    upLable.layer.borderWidth = 0;
    
    UILabel *downLable = [UILabel creatLableWithTitle:downTitle andSuperView:superView andFont:downFont andTextAligment:NSTextAlignmentCenter];
    [downLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kScreenW / 4, kScreenW / 10));
        make.centerX.mas_equalTo(superView.mas_centerX);
        make.top.mas_equalTo(upLable.mas_bottom);
    }];
    downLable.textColor = downColor;
    downLable.layer.borderWidth = 0;
    
}

- (void)getXinFengKongJingDataMessageFunction:(NSNotification *)post {
    NSString *messsage = post.userInfo[@"Message"];
    if (messsage.length != 78) {
        return;
    }
    
    NSString *kaiGuan = [messsage substringWithRange:NSMakeRange(28, 2)];
    NSString *temprature = [messsage substringWithRange:NSMakeRange(36, 2)];
    NSString *humidity = [messsage substringWithRange:NSMakeRange(38, 2)];
    
    _wind = [messsage substringWithRange:NSMakeRange(40, 2)];
    NSString *pm25 = [messsage substringWithRange:NSMakeRange(42, 4)];
    
    NSString *methanal = [messsage substringWithRange:NSMakeRange(50, 2)];
    NSString *lvXinLastTimeBig = [messsage substringWithRange:NSMakeRange(52, 2)];
    NSString *lvXinLastTimeLittle = [messsage substringWithRange:NSMakeRange(54, 2)];
    NSString *pm25Order = [messsage substringWithRange:NSMakeRange(62, 2)];
    
    temprature = [NSString turnHexToInt:temprature];
    humidity = [NSString turnHexToInt:humidity];
    pm25 = [NSString turnHexToInt:pm25];
    methanal = [NSString turnHexToInt:methanal];
    lvXinLastTimeBig = [NSString turnHexToInt:lvXinLastTimeBig];
    lvXinLastTimeLittle = [NSString turnHexToInt:lvXinLastTimeLittle];
    NSInteger sumTime = lvXinLastTimeBig.integerValue + lvXinLastTimeLittle.integerValue * 10;
    
    _temperatureLabel.text = temprature;
    _humidityLabel.text = humidity;
    
    _methanalLabel.text = methanal;
    
    _lvXinLastTime.text = [NSString stringWithFormat:@"%ld小时" , (long)sumTime];
    
    if ([kaiGuan isEqualToString:@"01"]) {
        UIImage *image = nil;

        if ([_wind isEqualToString:@"01"]) {
            image = [UIImage imageNamed:@"xinFengWindDi"];

            speed = 0.5;
        } else if ([_wind isEqualToString:@"02"]) {
            image = [UIImage imageNamed:@"xinFengWindZhong"];

            speed = 1.0;
        } else if ([_wind isEqualToString:@"03"]) {
            image = [UIImage imageNamed:@"xinFengWindGao"];

            speed = 1.5;
        } else if ([_wind isEqualToString:@"04"]) {
            image = [UIImage imageNamed:@"xinFengWindZuiGao"];

            speed = 2.0;
        } else if ([_wind isEqualToString:@"00"]) {
            image = [UIImage imageNamed:@"xinFengWindZuiGao"];

            speed = 0.5;
        }
        
        _fengSuBiaoShiImageView.image = image;
        
        self.pm25Label.text = pm25;
        self.pm25Label.font = [UIFont systemFontOfSize:k40];
        
        if ([pm25Order isEqualToString:@"02"]) {
            self.pm25Label.text = @"立即检测";
            self.pm25Label.font = [UIFont systemFontOfSize:k30];
        }
        
    } else {
        self.pm25Label.text = @"立即检测";
        self.pm25Label.font = [UIFont systemFontOfSize:k30];
    }
    
}

- (void)setServiceModel:(ServicesModel *)serviceModel {
    _serviceModel = serviceModel;
    
    if (_serviceModel) {
        NSDictionary *parames = @{@"devSn" : _serviceModel.devSn , @"devTypeSn" : _serviceModel.devTypeSn};
        [HelpFunction requestDataWithUrlString:kChaXunKongJingDangQianZhuangTai andParames:parames andDelegate:self];
    }
    
}


#pragma mark - 获取设备的状态
- (void)requestData:(HelpFunction *)request didSuccess:(NSDictionary *)dddd{
//        NSLog(@"%@" , dddd);
    if ([dddd[@"data"] isKindOfClass:[NSDictionary class]]) {
        NSDictionary *dataDic = dddd[@"data"];
        
        StateModel *stateModel = [[StateModel alloc]init];
        
        for (NSString *key in [dataDic allKeys]) {
            [stateModel setValue:dataDic[key] forKey:key];
        }
        
        [self setStateModel:stateModel];
    }
    
}

- (void)requestData:(HelpFunction *)request didFailLoadData:(NSError *)error {
    NSLog(@"%@" , error);
}

- (void)setServiceDataModel:(ServicesDataModel *)serviceDataModel{
    
    _serviceDataModel = serviceDataModel;
}

- (void)setStateModel:(StateModel *)stateModel{
    _stateModel = stateModel;
    NSLog(@"第一个--%@ " , _stateModel);
    
    if (_stateModel) {
        
        _temperatureLabel.text = [NSString stringWithFormat:@"%@" , _stateModel.sCurrentC];
        _humidityLabel.text = [NSString stringWithFormat:@"%ld" , (long)_stateModel.sCurrentH];
        _methanalLabel.text = [NSString stringWithFormat:@"%ld" , (long)_stateModel.sMethanal];
        _lvXinLastTime.text = [NSString stringWithFormat:@"%.2ld小时" , (long)_stateModel.sChangeFilterScreen];
        
        if (_stateModel.fSwitch == 1) {
           self.pm25Label.text = [NSString stringWithFormat:@"%@" , _stateModel.sPm25];
            self.pm25Label.font = [UIFont systemFontOfSize:k40];
            UIImage *image = nil;

            if (_stateModel.fWind == 1) {
                image = [UIImage imageNamed:@"xinFengWindDi"];

                speed = 0.5;
            } else if (_stateModel.fWind == 2) {
                image = [UIImage imageNamed:@"xinFengWindZhong"];

                speed = 1.0;
            } else if (_stateModel.fWind == 3) {
                image = [UIImage imageNamed:@"xinFengWindGao"];

                speed = 1.5;
            } else if (_stateModel.fWind == 4) {
                image = [UIImage imageNamed:@"xinFengWindZuiGao"];

                speed = 2.0;
            }
            _fengSuBiaoShiImageView.image = image;

            if (_stateModel.fWind == 0) {

                angle = 0;
                speed = 0.0;
            }
        } else {
            angle = 0;
            speed = 0.0;
            self.pm25Label.text = @"立即检测";
            self.pm25Label.font = [UIFont systemFontOfSize:k30];
        }
    }
    
    
}
- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
@end
