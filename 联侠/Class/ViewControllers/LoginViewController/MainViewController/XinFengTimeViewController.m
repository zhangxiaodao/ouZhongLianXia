//
//  XinFengTimeViewController.m
//  联侠
//
//  Created by 杭州阿尔法特 on 2017/2/21.
//  Copyright © 2017年 张海昌. All rights reserved.
//

#import "XinFengTimeViewController.h"
#import "TimeModel.h"
@interface XinFengTimeViewController ()<UIPickerViewDataSource , UIPickerViewDelegate , HelpFunctionDelegate>
@property (nonatomic , strong) UILabel *openTimeLabel;
@property (nonatomic , strong) UILabel *closeLabel;
@property (nonatomic , strong) UISwitch *openSwitch;
@property (nonatomic , strong) UISwitch *closeSwitch;
@property (nonatomic , strong) UISwitch *repeatSwitch;
@property (nonatomic , strong) UILabel *weakLabel;
@property (nonatomic , strong) UIView *navView;
@property (nonatomic , strong) NSMutableArray *hourArray;
@property (nonatomic , strong) NSMutableArray *minuteArray;

@property (nonatomic  ,strong) UIView *pickerBgView;
@property (nonatomic , strong) UIPickerView *myPicker;
@property (strong, nonatomic) UIView *maskView;
@property (nonatomic , strong) UIView *firstPickerBgView;
@property (nonatomic , strong) UIView *secondPickerBgView;

@property (nonatomic , copy) NSString *minuteTime;
@property (nonatomic , copy) NSString *hourTime;
@end

@implementation XinFengTimeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.navView = [UIView creatNavView:self.view WithTarget:self action:@selector(backTap:) andTitle:@"定时设置"];
    [self setUI];
    
}

- (void)backTap:(UITapGestureRecognizer *)tap {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)setUI {
    
    UIView *firstView = [UIView createViewWithOneLabelAndBottomViewWithSuperView:self.view withLabelTitle:@"时间设置"];
    [firstView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kCommonW, kScreenW / 8));
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.top.mas_equalTo(kScreenW / 5);
    }];
    
    UIView *openView = [UIView createViewWithTwoLabelAndBottomAndSwitchViewWithSuperView:self.view withFirstLabelTitle:@"开启时间" withFirstLabelTextColor:[UIColor blackColor] withSecondLabelTitle:@"10:00" withSecondLabelTextColor:kMainColor andSecondLabelAtcion:@selector(openAtcion:) andSecondLabelTarget:self andSwitchAtcion:@selector(openSwitchAtcion:) andSwitchTarget:self ];
    [openView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kCommonW, kScreenW / 8));
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.top.mas_equalTo(firstView.mas_bottom);
    }];
    self.openTimeLabel = openView.subviews[1];
    self.openSwitch = openView.subviews[2];
    
    UIView *closeView = [UIView createViewWithTwoLabelAndBottomAndSwitchViewWithSuperView:self.view withFirstLabelTitle:@"关闭时间" withFirstLabelTextColor:[UIColor blackColor] withSecondLabelTitle:@"20:00" withSecondLabelTextColor:kMainColor andSecondLabelAtcion:@selector(closeAtcion:) andSecondLabelTarget:self andSwitchAtcion:@selector(closeSwitchAtcion:) andSwitchTarget:self];
    [closeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kCommonW, kScreenW / 8));
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.top.mas_equalTo(openView.mas_bottom);
    }];
    self.closeLabel = closeView.subviews[1];
    self.closeSwitch = closeView.subviews[2];
    
    UIView *secondView = [UIView createViewWithOneLabelAndBottomViewWithSuperView:self.view withLabelTitle:@"重复设置"];
    [secondView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kCommonW, kScreenW / 8));
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.top.mas_equalTo(closeView.mas_bottom).offset(kScreenW / 20);
    }];
    
    UIView *repeatView = [UIView createViewWithTwoLabelAndBottomAndSwitchViewWithSuperView:self.view withFirstLabelTitle:@"是否每天重复" withFirstLabelTextColor:[UIColor blackColor] withSecondLabelTitle:@"20:00" withSecondLabelTextColor:kMainColor andSecondLabelAtcion:@selector(openAtcion:) andSecondLabelTarget:self andSwitchAtcion:@selector(repeatSwitchAtcion:) andSwitchTarget:self];
    [repeatView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kCommonW, kScreenW / 8));
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.top.mas_equalTo(secondView.mas_bottom);
    }];
    UILabel *weakLabel = repeatView.subviews[1];
    weakLabel.hidden = YES;
    self.repeatSwitch = repeatView.subviews[2];
    
    
    UIButton *submitBtn = [UIButton creatBtnWithTitle:@"提交定时" withLabelFont:k15 withLabelTextColor:[UIColor whiteColor] andSuperView:self.view andBackGroundColor:kCOLOR(86, 188, 252) andHighlightedBackGroundColor:kKongJingHuangSe andwhtherNeendCornerRadius:YES WithTarget:self andDoneAtcion:@selector(submitXinFengTimeBtnAtcion)];
    [submitBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kStandardW, kScreenW / 10));
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.top.mas_equalTo(repeatView.mas_bottom).offset(kScreenW / 10);
    }];
    
}


- (void)requestServicesTimeing:(NSDictionary *)dic {
    
    NSLog(@"%@" , dic);
    if ([dic[@"data"] isKindOfClass:[NSNull class]]) {
        return ;
    }
    
    NSDictionary *data = dic[@"data"];
    TimeModel *timeModel = [[TimeModel alloc]init];
    
    for (NSString *key in [data allKeys]) {
        [timeModel setValue:data[key] forKey:key];
    }
    
    if (timeModel.hasRunOnOnce == 0 || timeModel.hasRunOn == 0) {
        if ([timeModel.runWeek isEqualToString:@"0000000"]) {
            self.repeatSwitch.on = NO;
        }
        
        if (timeModel.fSwitchOn == 1) {
            self.openSwitch.on = YES;
        }
        
        if (timeModel.fSwitchOff == 1) {
            self.closeSwitch.on = NO;
        }
        
        if (![timeModel.onJobTime isKindOfClass:[NSNull class]]) {
            self.openTimeLabel.text = timeModel.onJobTime;
        }
        
        if (![timeModel.offJobTime isKindOfClass:[NSNull class]]) {
            self.closeLabel.text = timeModel.offJobTime;
        }
    }
        
}


- (void)openAtcion:(UITapGestureRecognizer *)tap {
   self.firstPickerBgView = [self creatPickView];
}

- (void)closeAtcion:(UITapGestureRecognizer *)tap {
    self.secondPickerBgView = [self creatPickView];
}

- (void)openSwitchAtcion:(UISwitch *)rightSwitch {
//    [self creatPickView];
}

- (void)closeSwitchAtcion:(UISwitch *)rightSwitch {
//    [self creatPickView];
}

- (void)repeatSwitchAtcion:(UISwitch *)rightSwitch {
    NSLog(@"%s" , __func__);
}

- (void)submitXinFengTimeBtnAtcion {
    
    [self setTiming];
}


- (void)setTiming {
    
    NSString *openTime = self.openTimeLabel.text;
    NSString *closeTime = self.closeLabel.text;
    
    NSMutableArray *array = [NSMutableArray array];
    
    [array addObject:openTime];
    [array addObject:closeTime];
    [array addObject:@(self.openSwitch.on)];
    [array addObject:@(self.closeSwitch.on)];
    [array addObject:@(self.repeatSwitch.on)];
    
    if (_delegate && [_delegate respondsToSelector:@selector(xinFengTimeVCSendTimeToParentVCDelegate:)]) {
        [_delegate xinFengTimeVCSendTimeToParentVCDelegate:array];
    }
    
    
    NSString *repeatStr = @"0000000";
    if (self.repeatSwitch.on) {
        repeatStr = @"1111111";
    }
    
    
    NSString *openHour = [openTime substringToIndex:2];
    NSString *openMinute = [openTime substringFromIndex:3];
    NSString *closeHour = [closeTime substringToIndex:2];
    NSString *closeMinute = [closeTime substringFromIndex:3];
    
    NSMutableArray *openArray = [NSMutableArray array];
    NSMutableArray *closeArray = [NSMutableArray array];
    openArray = [NSString nowTimeAndAfterHour:openHour andAfterMinutes:openMinute andIsNeedTimeInterval:@"YES"];
    closeArray = [NSString nowTimeAndAfterHour:closeHour andAfterMinutes:closeMinute andIsNeedTimeInterval:@"YES"];
        
    NSInteger durTime = 0;
    NSInteger openTimeInteger = [openArray[1] integerValue];
    NSInteger closeTimeInteger = [closeArray[1] integerValue];
    if (openTimeInteger > closeTimeInteger) {
        durTime = openTimeInteger - closeTimeInteger;
    } else {
        durTime = closeTimeInteger - openTimeInteger;
    }
    
    NSDictionary *parames = @{@"devSn" : self.serviceModel.devSn , @"task.fSwitchOn" : @(self.openSwitch.on) , @"task.fSwitchOff" : @(self.closeSwitch.on) , @"task.onJobTime" : openTime , @"task.offJobTime" : closeTime , @"task.durTime" : [NSString stringWithFormat:@"%ld" , durTime] , @"task.runWeek" : repeatStr};

    NSLog(@"%@" , parames);
    [HelpFunction requestDataWithUrlString:kKongJingDingShiYuYue andParames:parames andDelegate:self];
}

- (void)requestServicesData:(HelpFunction *)request didOK:(NSDictionary *)dic {
//    NSLog(@"%@" , dic);
    
    if (![dic[@"state"] isKindOfClass:[NSNull class]]) {
        
        NSInteger state = [dic[@"state"] integerValue];
        
        if (state == 0) {
            [UIAlertController creatRightAlertControllerWithHandle:^{
                [self.navigationController popViewControllerAnimated:YES];
            } andSuperViewController:kWindowRoot Title:@"定时成功"];
        }
    }
    
}

- (void)ensurePickView {
    
    _hourTime = [NSString stringWithFormat:@"%@" , [self.hourArray[[self.myPicker selectedRowInComponent:0]] substringWithRange:NSMakeRange(0, 2)]];
    _minuteTime = [NSString stringWithFormat:@"%@" , [self.minuteArray[[self.myPicker selectedRowInComponent:1]] substringWithRange:NSMakeRange(0, 2)]];
    
    if ([self.myPicker isEqual:self.firstPickerBgView.subviews[0]]) {
        self.openTimeLabel.text = [NSString stringWithFormat:@"%@:%@" , _hourTime , _minuteTime];
    } else if ([self.myPicker isEqual:self.secondPickerBgView.subviews[0]]) {
        self.closeLabel.text = [NSString stringWithFormat:@"%@:%@" , _hourTime , _minuteTime];
    }
    
    [self hidePickView];
}


- (void)hidePickView {
    
    [UIView animateWithDuration:0.3 animations:^{
        self.maskView.alpha = 0;
        self.pickerBgView.top = self.view.height;
    } completion:^(BOOL finished) {
        [self.maskView removeFromSuperview];
        [self.pickerBgView removeFromSuperview];
    }];
}


#pragma mark - 创建UIPickView
- (UIView *)creatPickView{
    
    self.maskView = [[UIView alloc] initWithFrame:kScreenFrame];
    self.maskView.backgroundColor = [UIColor clearColor];
    //    self.maskView.alpha = 0;
    self.maskView.userInteractionEnabled = YES;
    //    [self.view addSubview:self.maskView];
    [self.maskView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hidePickView)]];
    
    
    self.pickerBgView = [[UIView alloc]initWithFrame:CGRectMake(0, kScreenH - kScreenH / 2.61568, kScreenW, kScreenH / 2.61568)];
    
    self.pickerBgView.backgroundColor = [UIColor whiteColor];
    
    self.myPicker = [[UIPickerView alloc]init];
    [self.pickerBgView addSubview:self.myPicker];
    [self.myPicker mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kScreenW, kScreenH / 3.08796));
        make.left.mas_equalTo(0);
        make.top.mas_equalTo(kScreenH / 17.1025);
    }];
    self.myPicker.tag = 1;
    self.myPicker.delegate = self;
    self.myPicker.dataSource = self;
    
    [UIView animateWithDuration:0.3 animations:^{
        self.pickerBgView.alpha = 1.0;
    }];
    
    
    UIView *view  =[[UIView alloc]init];
    view.backgroundColor = kACOLOR(86, 188, 252, 1.0);
    [self.pickerBgView addSubview:view];
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kScreenW, kScreenH / 17.1025));
        make.left.mas_equalTo(0);
        make.top.mas_equalTo(0);
    }];
    
    UIButton *cancleBtn = [UIButton initWithTitle:@"取消" andColor:[UIColor clearColor] andSuperView:view]
    ;
    [cancleBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [cancleBtn addTarget:self action:@selector(hidePickView) forControlEvents:UIControlEventTouchUpInside];
    [cancleBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.size.mas_equalTo(CGSizeMake(kScreenW / 4, kScreenH / 17.1025));
        make.top.mas_equalTo(0);
    }];
    
    UIButton *sureBtn = [UIButton initWithTitle:@"确定" andColor:[UIColor clearColor] andSuperView:view]
    ;
    [sureBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [sureBtn addTarget:self action:@selector(ensurePickView) forControlEvents:UIControlEventTouchUpInside];
    [sureBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(0);
        make.size.mas_equalTo(CGSizeMake(kScreenW / 4, kScreenH / 17.1025));
        make.top.mas_equalTo(0);
    }];
    
    [self.view addSubview:self.maskView];
    [self.view addSubview:self.pickerBgView];
    
    self.pickerBgView.top = self.view.height;
    
    [UIView animateWithDuration:0.3 animations:^{
        
        self.myPicker.alpha = 1.0;
        self.pickerBgView.bottom = self.view.height;
    }];
    
    return self.pickerBgView;
    
}

#pragma mark - UIPickView的代理
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 2;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    
    if (component == 0) {
        return self.hourArray.count;
    } else  {
        return self.minuteArray.count;
    }
    
}
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    
    if (component == 0) {
        return [self.hourArray objectAtIndex:row];
    } else {
        return [self.minuteArray objectAtIndex:row];
    }
}

- (void)setServiceModel:(ServicesModel *)serviceModel{
    _serviceModel = serviceModel;
    
    if (_serviceModel.devSn) {
        [HelpFunction requestDataWithUrlString:kGetKongJingTiming andParames:@{@"devSn" : _serviceModel.devSn} andDelegate:self];
    }
    
}


- (NSMutableArray *)minuteArray {
    if (!_minuteArray) {
        _minuteArray = [NSMutableArray array];
        for (int i = 0; i < 60; i++) {
            if (i < 10) {
                [_minuteArray addObject:[NSString stringWithFormat:@"0%d分" , i]];
            } else {
                [_minuteArray addObject:[NSString stringWithFormat:@"%d分" , i]];
            }
        }
    }
    return _minuteArray;
}

- (NSMutableArray *)hourArray {
    if (!_hourArray) {
        _hourArray = [NSMutableArray array];
        for (int i = 0; i < 24; i++) {
            if (i < 10) {
                [_hourArray addObject:[NSString stringWithFormat:@"0%d时" , i]];
            } else {
                [_hourArray addObject:[NSString stringWithFormat:@"%d时" , i]];
            }
        }
    }
    return _hourArray;
}


@end
