//
//  CustomPickerView.m
//  联侠
//
//  Created by 杭州阿尔法特 on 2017/2/28.
//  Copyright © 2017年 张海昌. All rights reserved.
//

#import "CustomPickerView.h"

@interface CustomPickerView ()<UIPickerViewDelegate , UIPickerViewDataSource>
@property (nonatomic  ,strong) UIView *pickerBgView;

@property (strong, nonatomic) UIView *markView;
@property (nonatomic , strong) CustomPickerView *customView;



@property (nonatomic , assign) NSInteger type;
@property (nonatomic , copy) UIColor *backColor;
@property (nonatomic , strong) UIPickerView *myPicker;
@property (nonatomic , strong) UIDatePicker *myDatePicker;

@property (nonatomic , strong) NSMutableArray *minuteArray;
@property (nonatomic , strong) NSMutableArray *hourArray;
@property (nonatomic , strong) NSMutableArray *sexArray;
@property (strong, nonatomic) NSMutableArray *provinceArray;
@property (strong, nonatomic) NSMutableArray *cityArray;
@property (strong, nonatomic) NSMutableArray *townArray;

@property (nonatomic , strong) NSMutableDictionary *pickerDic;

@end

@implementation CustomPickerView

- (NSMutableDictionary *)pickerDic {
    if (!_pickerDic) {
        NSString *path = [[NSBundle mainBundle] pathForResource:@"Address" ofType:@"plist"];
        _pickerDic = [[NSMutableDictionary alloc] initWithContentsOfFile:path];

    }
    return _pickerDic;
}

- (void)getAddressData {
    
    self.provinceArray = [[self.pickerDic allKeys] mutableCopy];
    NSMutableArray *selectedArray = [self.pickerDic objectForKey:[self.provinceArray objectAtIndex:0]];
    
    if (selectedArray.count > 0) {
        self.cityArray = [[[selectedArray objectAtIndex:0] allKeys] mutableCopy];
    }
    
    if (self.cityArray.count > 0) {
        self.townArray = [[selectedArray objectAtIndex:0] objectForKey:[self.cityArray objectAtIndex:0]];
    }
    
}

- (NSMutableArray *)sexArray {
    if (!_sexArray) {
        _sexArray = [NSMutableArray arrayWithObjects:@"男", @"女" ,nil];
    }
    return _sexArray;
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

- (instancetype _Nullable )initWithPickerViewType:(NSInteger)type andBackColor:(UIColor * _Nullable)backColor {
    self = [super initWithFrame:kScreenFrame];
    if (self) {
        self.backColor = [UIColor clearColor];
        _type = type;
        _backColor = backColor;
        self.myPicker = nil;
        self.myDatePicker = nil;
        [self getAddressData];
        [self creatPickerView];
        
        
    }
    return self;
}

- (void)creatPickerView {

    self.markView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenW, kScreenH - kHeight)];
    self.markView.backgroundColor = [UIColor clearColor];
    self.markView.userInteractionEnabled = YES;
    [self addSubview:self.markView];
    [self.markView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hidePickerViewAtcion)]];

    self.pickerBgView = [[UIView alloc]initWithFrame:CGRectMake(0, kScreenH - kScreenH / 2.61568, kScreenW, kScreenH / 2.61568)];
    self.pickerBgView.backgroundColor = [UIColor whiteColor];
    [self.markView addSubview:self.pickerBgView];
    
    if (_type == 3) {
        UIDatePicker *myPicker = [[UIDatePicker alloc] init];
        myPicker.locale = [[NSLocale alloc]initWithLocaleIdentifier:@"zh_ch"];
        // 设置时区，中国在东八区
        myPicker.timeZone = [NSTimeZone timeZoneWithName:@"GTM+8"];
        [self.pickerBgView addSubview:myPicker];
        myPicker.frame = CGRectMake(0, kScreenH / 2.61568 - kScreenH / 3.2, kScreenW, kScreenH / 3.2);
//        [myPicker mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.size.mas_equalTo(CGSizeMake(kScreenW, kScreenH / 3.2));
//            make.left.mas_equalTo(0);
//            make.top.mas_equalTo(kScreenH / 17.1025);
//        }];
        myPicker.datePickerMode = UIDatePickerModeDate;
        NSDate *maxDate = [[NSDate alloc]initWithTimeIntervalSinceNow:24*60*60];
        myPicker.maximumDate = maxDate;
        NSDate *minDate = [NSDate date];
        myPicker.maximumDate = minDate;
        self.myDatePicker = myPicker;
    } else {
        UIPickerView *myPicker = [[UIPickerView alloc]init];
        [self.pickerBgView addSubview:myPicker];
        myPicker.frame = CGRectMake(0, kScreenH / 2.61568 - kScreenH / 3.2, kScreenW, kScreenH / 3.2);
//        [myPicker mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.size.mas_equalTo(CGSizeMake(kScreenW, kScreenH / 3.2));
//            make.left.mas_equalTo(0);
//            make.top.mas_equalTo(kScreenH / 17.1025);
//        }];
        myPicker.delegate = self;
        myPicker.dataSource = self;
        self.myPicker = myPicker;
    }
    
    UIView *view = [[UIView alloc]init];
    view.backgroundColor = _backColor;
    [self.pickerBgView addSubview:view];
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kScreenW, kScreenH / 17.1025));
        make.left.mas_equalTo(0);
        make.top.mas_equalTo(0);
    }];
    
    UIButton *cancleBtn = [UIButton initWithTitle:@"取消" andColor:[UIColor clearColor] andSuperView:view]
    ;
    [cancleBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [cancleBtn addTarget:self action:@selector(hidePickerViewAtcion) forControlEvents:UIControlEventTouchUpInside];
    [cancleBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.size.mas_equalTo(CGSizeMake(kScreenW / 4, kScreenH / 17.1025));
        make.top.mas_equalTo(0);
    }];
    
    UIButton *sureBtn = [UIButton initWithTitle:@"确定" andColor:[UIColor clearColor] andSuperView:view]
    ;
    [sureBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [sureBtn addTarget:self action:@selector(selectPickerViewAtcion) forControlEvents:UIControlEventTouchUpInside];
    [sureBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(0);
        make.size.mas_equalTo(CGSizeMake(kScreenW / 4, kScreenH / 17.1025));
        make.top.mas_equalTo(0);
    }];

    self.pickerBgView.top = self.markView.height;
    [UIView animateWithDuration:.3 animations:^{
        self.pickerBgView.bottom = self.markView.bottom;
    }];
    
}

- (void)selectPickerViewAtcion {
    
    if (self.myPicker) {
        if (_delegate && [_delegate respondsToSelector:@selector(sendPickerViewToVC:)]) {
            [_delegate sendPickerViewToVC:self.myPicker];
        }
    } else if (self.myDatePicker) {
        if (_delegate && [_delegate respondsToSelector:@selector(sendDatePickerViewToVC:)]) {
            [_delegate sendDatePickerViewToVC:self.myDatePicker];
        }
    }
    
    [self hidePickerViewAtcion];
}

- (void)hidePickerViewAtcion {
    [UIView animateWithDuration:0.3 animations:^{
        self.pickerBgView.top = self.markView.bottom;
        self.markView.alpha = 0;
    } completion:^(BOOL finished) {
        [self.pickerBgView removeFromSuperview];
        [self.markView removeFromSuperview];
        [self removeFromSuperview];
    }];
}


- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    
    if (_type == 1) return 2;
    else if (_type == 2) return 1;
    else return 3;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    
    if (_type == 1) {
        if (component == 0) {
            return self.hourArray.count;
        } else {
            return self.minuteArray.count;
        }
    } else if (_type == 2) {
        return self.sexArray.count;
    } else {
        if (component == 0) {
            return self.provinceArray.count;
        } else if (component == 1) {
            return self.cityArray.count;
        } else {
            return self.townArray.count;
        }
    }
    
}
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    
    if (_type == 1) {
        if (component == 0) {
            return [self.hourArray objectAtIndex:row];
        } else {
            return [self.minuteArray objectAtIndex:row];
        }
    } else if (_type == 2) {
        return [self.sexArray objectAtIndex:row];
    } else {
        if (component == 0) {
            return [self.provinceArray objectAtIndex:row];
        } else if (component == 1) {
            return [self.cityArray objectAtIndex:row];
        } else {
            return [self.townArray objectAtIndex:row];
        }
    }
    
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    [self getSelectedAddressData];
    
    [self.myPicker reloadAllComponents];
}

- (void)getSelectedAddressData {
    
    
    NSInteger colProvince = [self.myPicker selectedRowInComponent:0];
    NSInteger colCity = [self.myPicker selectedRowInComponent:1];
    
    NSString *province = self.provinceArray[colProvince];
    
    NSDictionary *selectedDict = [self.pickerDic objectForKey:province][0];
    
    if (selectedDict.count > 0) {
        self.cityArray = [[selectedDict allKeys] mutableCopy];
    }
    
    
    if (self.cityArray.count > colCity) {
        NSString *city = self.cityArray[colCity];
        self.townArray = selectedDict[city];
    }
    
    
}

@end
