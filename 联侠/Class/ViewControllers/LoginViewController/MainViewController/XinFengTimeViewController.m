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
@interface XinFengTimeViewController ()<HelpFunctionDelegate , CustomPickerViewDelegate , UINavigationControllerDelegate>
@property (nonatomic , strong) UILabel *openTimeLabel;
@property (nonatomic , strong) UILabel *closeLabel;
@property (nonatomic , strong) UISwitch *openSwitch;
@property (nonatomic , strong) UISwitch *closeSwitch;
@property (nonatomic , strong) UISwitch *repeatSwitch;
@property (nonatomic , strong) UILabel *weakLabel;
@property (nonatomic , strong) NSMutableArray *hourArray;
@property (nonatomic , strong) NSMutableArray *minuteArray;


@property (nonatomic , strong) CustomPickerView *firstPickerBgView;
@property (nonatomic , strong) CustomPickerView *secondPickerBgView;

@property (nonatomic , copy) NSString *minuteTime;
@property (nonatomic , copy) NSString *hourTime;
@end

@implementation XinFengTimeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"定时设置";
//    self.navigationController.delegate = self;
    [self setUI];
    
}

- (void)setUI {
    
    UIView *firstView = [UIView createViewWithOneLabelAndBottomViewWithSuperView:self.view withLabelTitle:@"时间设置"];
    [firstView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kCommonW, kScreenW / 8));
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.top.mas_equalTo(kScreenW / 5 - kHeight);
    }];
    
    UIView *openView = [UIView createViewWithTwoLabelAndBottomAndSwitchViewWithSuperView:self.view withFirstLabelTitle:@"开启时间" withFirstLabelTextColor:[UIColor blackColor] withSecondLabelTitle:@"10:00" withSecondLabelTextColor:kMainColor andSecondLabelAtcion:@selector(openAtcion:) andSecondLabelTarget:self andSwitchAtcion:@selector(openSwitchAtcion:) andSwitchTarget:self];
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
    
//    NSLog(@"%@" , dic);
    if ([dic[@"data"] isKindOfClass:[NSNull class]]) {
        return ;
    }
    
    NSDictionary *data = dic[@"data"];
    TimeModel *timeModel = [[TimeModel alloc]init];
    [timeModel setValuesForKeysWithDictionary:data];
    
    
    if ([timeModel.runWeek isEqualToString:@"1111111"]) {
        self.repeatSwitch.on = YES;
    } else {
        self.repeatSwitch.on = NO;
    }
    
    if (timeModel.onJobTime == nil && timeModel.offJobTime == nil) {
        self.openSwitch.on = NO;
        self.closeSwitch.on = NO;
        
    }
    
    if (timeModel.onJobTime != nil && timeModel.offJobTime != nil) {
        self.openSwitch.on = YES;
        self.closeSwitch.on = YES;
        self.openTimeLabel.text = timeModel.onJobTime;
        self.closeLabel.text = timeModel.offJobTime;
    }
    
    if (timeModel.onJobTime != nil && timeModel.offJobTime == nil) {
        self.openSwitch.on = YES;
        self.closeSwitch.on = NO;
        self.openTimeLabel.text = timeModel.onJobTime;
        
    }
    
    if (timeModel.onJobTime == nil && timeModel.offJobTime != nil) {
        self.openSwitch.on = NO;
        self.closeSwitch.on = YES;
        
        self.closeLabel.text = timeModel.offJobTime;
    }
    
}

- (void)requestData:(HelpFunction *)request didFailLoadData:(NSError *)error {
    NSLog(@"%@" , error);
}

- (void)openAtcion:(UITapGestureRecognizer *)tap {

    self.firstPickerBgView = nil;
    self.secondPickerBgView = nil;
    
    self.firstPickerBgView  = [[CustomPickerView alloc]initWithPickerViewType:1 andBackColor:kMainColor];
    self.firstPickerBgView.delegate = self;
    [self.view addSubview:self.firstPickerBgView];
}

- (void)closeAtcion:(UITapGestureRecognizer *)tap {

    self.firstPickerBgView = nil;
    self.secondPickerBgView = nil;
    
    self.secondPickerBgView = [[CustomPickerView alloc]initWithPickerViewType:1 andBackColor:kMainColor];
    self.secondPickerBgView.delegate = self;
    [self.view addSubview:self.secondPickerBgView];
}

- (void)sendPickerViewToVC:(UIPickerView *)picker {
    
    _hourTime = [NSString stringWithFormat:@"%@" , [self.hourArray[[picker selectedRowInComponent:0]] substringWithRange:NSMakeRange(0, 2)]];
    _minuteTime = [NSString stringWithFormat:@"%@" , [self.minuteArray[[picker selectedRowInComponent:1]] substringWithRange:NSMakeRange(0, 2)]];
    
    if (self.firstPickerBgView) {
        self.openTimeLabel.text = [NSString stringWithFormat:@"%@:%@" , _hourTime , _minuteTime];
    } else {
        self.closeLabel.text = [NSString stringWithFormat:@"%@:%@" , _hourTime , _minuteTime];
    }
    
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
    
    
    NSMutableDictionary *parames = [NSMutableDictionary dictionaryWithObjectsAndKeys:self.serviceModel.devSn, @"devSn", self.serviceModel.devTypeSn, @"devTypeSn", @"0000000", @"task.runWeek", nil];
    
    if (self.openSwitch.on == 1) {
        [parames setValue:openTime forKey:@"task.onJobTime"];
    }
    
    if (self.closeSwitch.on == 1) {
        [parames setValue:closeTime forKey:@"task.offJobTime"];
    }
    
    if (self.repeatSwitch.on == 1) {
        [parames setValue:@"1111111" forKey:@"task.runWeek"];
    }
    
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
            } andSuperViewController:self Title:@"定时成功"];
        }
    }
    
}



- (void)setServiceModel:(ServicesModel *)serviceModel{
    _serviceModel = serviceModel;
    
    if (_serviceModel.devSn) {
        [HelpFunction requestDataWithUrlString:kGetKongJingTiming andParames:@{@"devSn" : _serviceModel.devSn , @"devTypeSn":_serviceModel.devTypeSn} andDelegate:self];
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
