//
//  CustomPickerView.m
//  联侠
//
//  Created by 杭州阿尔法特 on 2017/2/28.
//  Copyright © 2017年 张海昌. All rights reserved.
//

#import "CustomPickerView.h"

@interface CustomPickerView ()
@property (nonatomic  ,strong) UIView *pickerBgView;
@property (nonatomic , strong) UIPickerView *myPicker;
@property (strong, nonatomic) UIView *markView;
@property (nonatomic , strong) CustomPickerView *customView;


@end

@implementation CustomPickerView
- (CustomPickerView *)createPickerViewWithBackGroundColor:(UIColor *)backColor withFrame:(CGRect)frame andDelegate:(id<UIPickerViewDelegate>)delegate andDataSource:(id<UIPickerViewDataSource>)dataSourc andEnsureDelegate:(nullable id)target andEnsureAtcion:(SEL)atcion andCancleTarget:(nullable id)cancleTarget andCancleAtcion:(SEL)cancleAtcion andTapAtcion:(nullable SEL)tapAction{
    self.customView = [[CustomPickerView alloc]initWithFrame:frame];
    
    self.markView = [[UIView alloc]initWithFrame:frame];
    self.markView.backgroundColor = [UIColor clearColor];
    self.markView.userInteractionEnabled = YES;
    [self.markView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:cancleTarget action:tapAction]];
    [UIView animateWithDuration:0.3 animations:^{
        self.markView.alpha = 1.0;
    }];
    [_customView addSubview:self.markView];
    
    
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
    
    UIView *view  =[[UIView alloc]init];
    view.backgroundColor = kMainColor;
    [self.pickerBgView addSubview:view];
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kScreenW, kScreenH / 17.1025));
        make.left.mas_equalTo(0);
        make.top.mas_equalTo(0);
    }];
    
    UIButton *cancleBtn = [UIButton initWithTitle:@"取消" andColor:[UIColor clearColor] andSuperView:view]
    ;
    [cancleBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [cancleBtn addTarget:cancleTarget action:cancleAtcion forControlEvents:UIControlEventTouchUpInside];
    [cancleBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.size.mas_equalTo(CGSizeMake(kScreenW / 4, kScreenH / 17.1025));
        make.top.mas_equalTo(0);
    }];
    
    UIButton *sureBtn = [UIButton initWithTitle:@"确定" andColor:[UIColor clearColor] andSuperView:view]
    ;
    [sureBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [sureBtn addTarget:target action:atcion forControlEvents:UIControlEventTouchUpInside];
    [sureBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(0);
        make.size.mas_equalTo(CGSizeMake(kScreenW / 4, kScreenH / 17.1025));
        make.top.mas_equalTo(0);
    }];
    
    [self.markView addSubview:self.pickerBgView];
    self.pickerBgView.top = self.markView.height;
    
    self.myPicker.delegate = delegate;
    self.myPicker.dataSource = dataSourc;
    
    
    
    [UIView animateWithDuration:.3 animations:^{
        self.myPicker.alpha = 1.0;
        self.pickerBgView.bottom = self.markView.bottom;
    }];
    
    
    return _customView;
}



@end
