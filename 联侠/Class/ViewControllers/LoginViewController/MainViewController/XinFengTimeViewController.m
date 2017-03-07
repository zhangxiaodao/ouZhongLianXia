//
//  XinFengTimeViewController.m
//  联侠
//
//  Created by 杭州阿尔法特 on 2017/2/21.
//  Copyright © 2017年 张海昌. All rights reserved.
//

#import "XinFengTimeViewController.h"
#import "TimeModel.h"
#import "CustomPickerView.h"
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
@property (strong, nonatomic) UIView *markView;
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
//   self.firstPickerBgView = [self creatPickView];
    self.firstPickerBgView  =[[CustomPickerView alloc]createPickerViewWithBackGroundColor:kMainColor withFrame:kScreenFrame andDelegate:self andDataSource:self  andEnsureDelegate:self andEnsureAtcion:@selector(ensureXinFengPickView) andCancleTarget:self andCancleAtcion:@selector(hideXinFengPickView) andTapAtcion:@selector(hideXinFengPickView)];
    [kWindowRoot.view addSubview:self.firstPickerBgView];
    self.markView = self.firstPickerBgView.subviews[0];
    self.pickerBgView = self.markView.subviews[0];
    self.myPicker = self.pickerBgView.subviews[0];
}

- (void)closeAtcion:(UITapGestureRecognizer *)tap {
//    self.secondPickerBgView = [self creatPickView];
    self.secondPickerBgView = [[CustomPickerView alloc]createPickerViewWithBackGroundColor:kMainColor withFrame:kScreenFrame andDelegate:self andDataSource:self  andEnsureDelegate:self andEnsureAtcion:@selector(ensureXinFengPickView) andCancleTarget:self andCancleAtcion:@selector(hideXinFengPickView) andTapAtcion:@selector(hideXinFengPickView)];
    [kWindowRoot.view addSubview:self.secondPickerBgView];
    self.markView = self.secondPickerBgView.subviews[0];
    self.pickerBgView = self.markView.subviews[0];
    self.myPicker = self.pickerBgView.subviews[0];
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
    
    NSDictionary *parames = @{@"devSn" : self.serviceModel.devSn , @"task.fSwitchOn" : @(self.openSwitch.on) , @"task.fSwitchOff" : @(self.closeSwitch.on) , @"task.onJobTime" : openTime , @"task.offJobTime" : closeTime ,  @"task.runWeek" : repeatStr};
//    NSLog(@"%@ , %@" , self.openTimeLabel.text , self.closeLabel.text);
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

- (void)ensureXinFengPickView {
    
    UIPickerView *openPickerView = nil;
    UIPickerView *offPickerView = nil;
    if (self.firstPickerBgView) {
        openPickerView = [self.pickerBgView viewWithTag:1];
    } else {
        offPickerView = [self.pickerBgView viewWithTag:1];
    }
    
    
    _hourTime = [NSString stringWithFormat:@"%@" , [self.hourArray[[self.myPicker selectedRowInComponent:0]] substringWithRange:NSMakeRange(0, 2)]];
    _minuteTime = [NSString stringWithFormat:@"%@" , [self.minuteArray[[self.myPicker selectedRowInComponent:1]] substringWithRange:NSMakeRange(0, 2)]];
    
    if ([self.myPicker isEqual:openPickerView]) {
        self.openTimeLabel.text = [NSString stringWithFormat:@"%@:%@" , _hourTime , _minuteTime];
    } else if ([self.myPicker isEqual:offPickerView]) {
        self.closeLabel.text = [NSString stringWithFormat:@"%@:%@" , _hourTime , _minuteTime];
    }
    
    [self hideXinFengPickView];
}


- (void)hideXinFengPickView {
    
    [UIView animateWithDuration:0.3 animations:^{
        self.pickerBgView.top = self.markView.bottom;
        self.markView.alpha = 0;
    } completion:^(BOOL finished) {
        [self.pickerBgView removeFromSuperview];
        [self.markView removeFromSuperview];
        [self.firstPickerBgView removeFromSuperview];
        [self.secondPickerBgView removeFromSuperview];
        self.firstPickerBgView = nil;
        self.secondPickerBgView = nil;
    }];
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
