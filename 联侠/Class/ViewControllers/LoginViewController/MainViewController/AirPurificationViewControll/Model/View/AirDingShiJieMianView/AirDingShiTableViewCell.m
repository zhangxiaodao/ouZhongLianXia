//
//  AirDingShiTableViewCell.m
//  联侠
//
//  Created by 杭州阿尔法特 on 16/6/8.
//  Copyright © 2016年 张海昌. All rights reserved.
//

#import "AirDingShiTableViewCell.h"
#import "CustomPickerView.h"

@interface AirDingShiTableViewCell ()<UIPickerViewDataSource , UIPickerViewDelegate , HelpFunctionDelegate>
@property (nonatomic , strong) NSMutableDictionary *dic;

@property (nonatomic  ,strong) UIView *pickerBgView;
@property (nonatomic , strong) UIPickerView *myPicker;
@property (strong, nonatomic) UIView *markView;
@property (nonatomic , strong) UIView *openPickerBgView;
@property (nonatomic , strong) UIView *offPickerBgView;
@property (nonatomic , strong) NSMutableArray *minuteArray;
@property (nonatomic , strong) NSMutableArray *hourArray;
@end

@implementation AirDingShiTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self creatPickViewData];
    }
    return self;
}

- (void)customUI {
    
    
    self.dic =  [[kStanderDefault objectForKey:@"AirData"] mutableCopy];

    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenW, kScreenH / 4.16875)];
    view.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:view];
    
    UILabel *titleLable = [UILabel creatLableWithTitle:@"模式设置" andSuperView:view andFont:k20 andTextAligment:NSTextAlignmentLeft];
    [titleLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kScreenW / 2.8, kScreenW / 10));
        make.left.mas_equalTo(view.mas_left).offset(kScreenW / 30);
        make.top.mas_equalTo(view.mas_top).offset(kScreenW / 35);
    }];
    
    UILabel *isSureRepeat = [UILabel creatLableWithTitle:@"是否每天重复定时" andSuperView:view andFont:k15 andTextAligment:NSTextAlignmentCenter];


    [isSureRepeat mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kScreenW / 2, kScreenW / 10));
        make.left.mas_equalTo(titleLable.mas_right);
        make.top.mas_equalTo(titleLable.mas_top);
    }];
    
    UIButton *queDingBtn = [UIButton initWithTitle:@"" andColor:[UIColor clearColor] andSuperView:view];
//    queDingBtn.layer.borderColor = [UIColor blackColor].CGColor;
//    queDingBtn.layer.borderWidth = 1;
    [queDingBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(isSureRepeat.mas_right);
        make.centerY.mas_equalTo(isSureRepeat.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(kScreenW / 10, kScreenW / 10));
    }];
    
    _isSelectedBtn = queDingBtn;
    
    
    if ([[self.dic objectForKey:@"isSelectedBtn"] integerValue] == 0) {
        [queDingBtn setImage:[UIImage imageNamed:@"dingshiguanbi"] forState:UIControlStateNormal];
        [queDingBtn removeTarget:nil action:nil forControlEvents:UIControlEventTouchUpInside];
        [queDingBtn addTarget:self action:@selector(isSureRepeat:) forControlEvents:UIControlEventTouchUpInside];
    } else {
        [queDingBtn setImage:[UIImage imageNamed:@"dingshikaiqi"] forState:UIControlStateNormal];
        [queDingBtn removeTarget:nil action:nil forControlEvents:UIControlEventTouchUpInside];
        [queDingBtn addTarget:self action:@selector(isSureRepeatAgainAtcion:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    UIImageView *imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"shiJian"]];
    [view addSubview:imageView];
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kScreenW / 10, kScreenW / 10));
        make.left.mas_equalTo(titleLable.mas_left);
        make.centerY.mas_equalTo(view.mas_bottom).offset(-kScreenH / 11.1166);
    }];

    [UIImageView setImageViewColor:imageView andColor:[UIColor lightGrayColor]];
    
    UIView *fenGeView = [[UIView alloc]init];
    [view addSubview:fenGeView];
    fenGeView.backgroundColor = kFenGeXianYanSe;
    [fenGeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kScreenW - kScreenW / 30 - kScreenW / 10, 1));
        make.left.mas_equalTo(imageView.mas_right).offset(kScreenW / 50);
        make.centerY.mas_equalTo(imageView.mas_centerY);
    }];
    
    UILabel *kaiQiLable = [UILabel creatLableWithTitle:@"开启" andSuperView:view andFont:k15 andTextAligment:NSTextAlignmentLeft];
    [kaiQiLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kScreenW / 3, kScreenW / 10));
        make.left.mas_equalTo(fenGeView.mas_left);
        make.centerY.mas_equalTo(fenGeView.mas_top).offset(-kScreenH / 22.2333);
    }];
    kaiQiLable.textColor = [UIColor lightGrayColor];
    
    
    UILabel *openTimeLable = [UILabel creatLableWithTitle:[NSString stringWithFormat:@"%@" , [self.dic objectForKey:@"openTime"]] andSuperView:view andFont:k15 andTextAligment:NSTextAlignmentLeft];
    [openTimeLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kScreenW / 3, kScreenW / 10));
        make.right.mas_equalTo(fenGeView.mas_right).offset(-kScreenW / 10);
        make.bottom.mas_equalTo(kaiQiLable.mas_bottom);
    }];
    openTimeLable.textColor = [UIColor lightGrayColor];
    self.openTime = openTimeLable;
    
    UIImageView *jianTouimageView1 = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"iconfont-qianjin"]];
    [view addSubview:jianTouimageView1];
    
    [UIImageView setImageViewColor:jianTouimageView1 andColor:[UIColor lightGrayColor]];
    
    [jianTouimageView1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kScreenW / 20, kScreenW / 20));
        make.right.mas_equalTo(view.mas_right);
        make.centerY.mas_equalTo(openTimeLable.mas_centerY);
    }];
    
    UILabel *guanBiLable = [UILabel creatLableWithTitle:@"关闭" andSuperView:view andFont:k15 andTextAligment:NSTextAlignmentLeft];
    [guanBiLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kScreenW / 3, kScreenW / 10));
        make.left.mas_equalTo(fenGeView.mas_left);
        make.centerY.mas_equalTo(fenGeView.mas_bottom).offset(kScreenH / 22.2333);
    }];
    guanBiLable.textColor = [UIColor lightGrayColor];
    
    UILabel *guanBiTimeLable = [UILabel creatLableWithTitle:[NSString stringWithFormat:@"%@" , [self.dic objectForKey:@"offTime"]] andSuperView:view andFont:k15 andTextAligment:NSTextAlignmentLeft];
    [guanBiTimeLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kScreenW / 3, kScreenW / 10));
        make.right.mas_equalTo(fenGeView.mas_right).offset(-kScreenW / 10);
        make.top.mas_equalTo(guanBiLable.mas_top);
    }];
    guanBiTimeLable.textColor = [UIColor lightGrayColor];
    self.offTime = guanBiTimeLable;

    
    UIImageView *jianTouimageView2 = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"iconfont-qianjin"]];
    [view addSubview:jianTouimageView2];
    
    [UIImageView setImageViewColor:jianTouimageView2 andColor:[UIColor lightGrayColor]];
    [jianTouimageView2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kScreenW / 20, kScreenW / 20));
        make.right.mas_equalTo(view.mas_right);
        make.centerY.mas_equalTo(guanBiLable.mas_centerY);
        
    }];
    
    
    kaiQiLable.layer.borderWidth = 0;
    openTimeLable.layer.borderWidth = 0;
    guanBiLable.layer.borderWidth = 0;
    guanBiTimeLable.layer.borderWidth = 0;
    titleLable.layer.borderWidth = 0;
    
    kaiQiLable.userInteractionEnabled = YES;
    openTimeLable.userInteractionEnabled = YES;
    guanBiLable.userInteractionEnabled = YES;
    guanBiTimeLable.userInteractionEnabled = YES;
    
    kaiQiLable.tag = 1;
    openTimeLable.tag = 2;
    
    
    UITapGestureRecognizer *kaiQiTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(pickerViewTap:)];
    [kaiQiLable addGestureRecognizer:kaiQiTap];
    UITapGestureRecognizer *kaiQiTimeTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(pickerViewTap:)];
    [openTimeLable addGestureRecognizer:kaiQiTimeTap];
    UITapGestureRecognizer *guanBiTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(pickerViewTap:)];
    [guanBiLable addGestureRecognizer:guanBiTap];
    UITapGestureRecognizer *guanBiTimeTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(pickerViewTap:)];
    [guanBiTimeLable addGestureRecognizer:guanBiTimeTap];
    
    
}

- (void)isSureRepeat:(UIButton *)btn {
    
    btn.selected = !btn.selected;
    [btn setImage:[UIImage imageNamed:@"dingshikaiqi"] forState:UIControlStateNormal];
    
    [btn removeTarget:nil action:nil forControlEvents:UIControlEventTouchUpInside];
    
    [btn addTarget:self action:@selector(isSureRepeatAgainAtcion:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)isSureRepeatAgainAtcion:(UIButton *)btn {
    
    btn.selected = !btn.selected;
    [btn setImage:[UIImage imageNamed:@"dingshiguanbi"] forState:UIControlStateNormal];
    
    [btn removeTarget:nil action:nil forControlEvents:UIControlEventTouchUpInside];
    [btn addTarget:self action:@selector(isSureRepeat:) forControlEvents:UIControlEventTouchUpInside];
}

#pragma mark - 弹出pickView
- (void)pickerViewTap:(UITapGestureRecognizer *)tap {

    if (tap.view.tag == 1 || tap.view.tag == 2) {
        
        self.openPickerBgView = [[CustomPickerView alloc]createPickerViewWithBackGroundColor:kMainColor withFrame:kScreenFrame andDelegate:self andDataSource:self  andEnsureDelegate:self andEnsureAtcion:@selector(ensurePickerViewAtcion) andCancleTarget:self andCancleAtcion:@selector(cancelPickerViewAtcion) andTapAtcion:@selector(cancelPickerViewAtcion)];
        [kWindowRoot.view addSubview:self.openPickerBgView];
        
        self.markView = self.openPickerBgView.subviews[0];
        
        
    } else {
        self.offPickerBgView = [[CustomPickerView alloc]createPickerViewWithBackGroundColor:kMainColor withFrame:kScreenFrame andDelegate:self andDataSource:self  andEnsureDelegate:self andEnsureAtcion:@selector(ensurePickerViewAtcion) andCancleTarget:self andCancleAtcion:@selector(cancelPickerViewAtcion) andTapAtcion:@selector(cancelPickerViewAtcion)];
        [kWindowRoot.view addSubview:self.offPickerBgView];
        self.markView = self.offPickerBgView.subviews[0];
    }
    self.pickerBgView = self.markView.subviews[0];
    self.myPicker = self.pickerBgView.subviews[0];
    
}


- (void)cancelPickerViewAtcion {
    [self hidePickerViewAtcion];
}

#pragma mark - 隐藏UIPickView
- (void)hidePickerViewAtcion {
    [UIView animateWithDuration:0.3 animations:^{
        self.pickerBgView.top = self.markView.bottom;
        self.markView.alpha = 0;
    } completion:^(BOOL finished) {
        [self.pickerBgView removeFromSuperview];
        [self.markView removeFromSuperview];
        [self.offPickerBgView removeFromSuperview];
        [self.openPickerBgView removeFromSuperview];
        self.openPickerBgView = nil;
        self.offPickerBgView = nil;
    }];
}

- (void)ensurePickerViewAtcion {
   
    UIPickerView *openPickerView = nil;
    UIPickerView *offPickerView = nil;
    if (self.openPickerBgView) {
        openPickerView = [self.pickerBgView viewWithTag:1];
    } else {
        offPickerView = [self.pickerBgView viewWithTag:1];
    }
    
    if ([self.myPicker isEqual:openPickerView]) {
        self.openTime.text = [NSString stringWithFormat:@"%@:%@" , [self.hourArray[[openPickerView selectedRowInComponent:0]] substringWithRange:NSMakeRange(0, 2)] , [self.minuteArray[[openPickerView selectedRowInComponent:1]] substringWithRange:NSMakeRange(0, 2)]];
        
    }
    
    if ([self.myPicker isEqual:offPickerView]) {
        self.offTime.text = [NSString stringWithFormat:@"%@:%@" , [self.hourArray[[offPickerView selectedRowInComponent:0]] substringWithRange:NSMakeRange(0, 2)] , [self.minuteArray[[offPickerView selectedRowInComponent:1]] substringWithRange:NSMakeRange(0, 2)]];
        
    }
    
    [self.dic setObject:self.openTime.text forKey:@"openTime"];
    [self.dic setObject:self.offTime.text forKey:@"offTime"];
    [self.dic setObject:self.fromWhich forKey:@"fromWhich"];
    [self.dic setObject:@(self.isSelectedBtn.selected) forKey:@"isSelectedBtn"];
    [kStanderDefault setObject:self.dic forKey:@"AirData"];
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(getKongJingDingShiData:andData:)]) {
        [self.delegate getKongJingDingShiData:self andData:self.dic];
    }
    [[NSNotificationCenter defaultCenter] postNotification:[NSNotification notificationWithName:@"AirTimeText" object:nil userInfo:@{@"AirTimeText" : self.dic}]];
    
    [self hidePickerViewAtcion];
}

#pragma mark - UIPickView的代理
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
        return 2;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    
    if (component == 0) {
        return self.hourArray.count;
    } else {
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


- (void)creatPickViewData{
    self.minuteArray = [NSMutableArray array];
    for (int i = 0; i < 60; i++) {
        if (i < 10) {
            [self.minuteArray addObject:[NSString stringWithFormat:@"0%d分" , i]];
        } else {
            [self.minuteArray addObject:[NSString stringWithFormat:@"%d分" , i]];
        }
        
    }
    
    self.hourArray = [NSMutableArray array];
    for (int i = 0; i < 24; i++) {
        if (i < 10) {
            [self.hourArray addObject:[NSString stringWithFormat:@"0%d时" , i]];
        } else {
            [self.hourArray addObject:[NSString stringWithFormat:@"%d时" , i]];
        }
        
    }
    
}

- (NSMutableDictionary *)dic{
    if (!_dic) {
        self.dic = [NSMutableDictionary dictionary];
    }
    return _dic;
}

- (void)setFromWhich:(NSString *)fromWhich {
    _fromWhich = fromWhich;
    
    if (self.contentView.subviews.count > 0) {
        [self.contentView.subviews[0] removeFromSuperview];
        [self customUI];
    } else {
        [self customUI];
    }
    
    if (![[self.dic objectForKey:@"fromWhich"] isEqualToString:_fromWhich]) {
        if ([_fromWhich isEqualToString:@"first"]) {
            
            
            self.openTime.text = @"08:00";
            
            self.offTime.text = @"12:00";
            
            
        } else if ([_fromWhich isEqualToString:@"second"]) {
            self.openTime.text = @"06:00";
            
            self.offTime.text = @"23:00";
            
            
        } else if ([_fromWhich isEqualToString:@"thirt"]) {
            self.openTime.text = @"10:00";
            
            self.offTime.text = @"22:00";
            
            
        } else {
            self.openTime.text = @"00:00";
            
            self.offTime.text = @"00:00";
            
        }
        
    }
}

@end
