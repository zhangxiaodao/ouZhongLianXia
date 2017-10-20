//
//  GanYiJiCommonTableViewCell.m
//  联侠
//
//  Created by 杭州阿尔法特 on 16/7/19.
//  Copyright © 2016年 张海昌. All rights reserved.
//

#import "GanYiJiCommonTableViewCell.h"

#define kClothesTime 5

@interface GanYiJiCommonTableViewCell ()<UIPickerViewDataSource , UIPickerViewDelegate>{
    UIView *backView;
    UILabel *kaiQiLable;
}

@property (nonatomic , strong) NSMutableDictionary *dic;
@property (nonatomic , strong) NSMutableArray *countArray;
@property (nonatomic , strong) NSMutableArray *minutesArray;

@property (nonatomic  ,strong) UIView *pickerBgView22;
@property (nonatomic , strong) UIView *firstView;
@property (nonatomic , strong) UIView *secondView;
@property (nonatomic , strong) UIPickerView *myPicker22;

@property (strong, nonatomic) UIView *maskView22;

@end

@implementation GanYiJiCommonTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self creatPickViewData];
        [self customUI];
    }
    return self;
}

- (void)customUI {
    
    self.dic = [kStanderDefault objectForKey:@"GanYiJiData"];
    
    backView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenW, kScreenH / 4.16875)];
    [self.contentView addSubview:backView];
    backView.backgroundColor = [UIColor whiteColor];

    
    UILabel *titleLable = [UILabel creatLableWithTitle:@"衣物选择" andSuperView:backView andFont:k20 andTextAligment:NSTextAlignmentLeft];
    [titleLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kScreenW / 3, kScreenW / 10));
        make.left.mas_equalTo(backView.mas_left).offset(kScreenW / 30);
        make.top.mas_equalTo(backView.mas_top).offset(kScreenW / 35);
    }];
    
    kaiQiLable = [UILabel creatLableWithTitle:@"点击此处选择衣物数量" andSuperView:backView andFont:k30 andTextAligment:NSTextAlignmentCenter];
    [kaiQiLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kScreenW , kScreenW / 10));
        make.centerX.mas_equalTo(backView.mas_centerX);
        make.centerY.mas_equalTo(backView.mas_centerY);
    }];
    kaiQiLable.textColor = [UIColor lightGrayColor];
    kaiQiLable.tag = 1;
    
    UILabel *numClothesLable = [UILabel creatLableWithTitle:[self.dic objectForKey:@"numClothes"] andSuperView:backView andFont:k15 andTextAligment:NSTextAlignmentLeft];
    [numClothesLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kScreenW / 3, kScreenW / 10));
        make.left.mas_equalTo(backView.mas_left).offset(kScreenW / 20);
        make.centerY.mas_equalTo(backView.mas_centerY).offset(- backView.height / 4 + kScreenW / 10);
    }];
    numClothesLable.textColor = [UIColor lightGrayColor];
    numClothesLable.tag = 2;
    
    
    UILabel *timeLable = [UILabel creatLableWithTitle:[self.dic objectForKey:@"time"] andSuperView:backView andFont:k15 andTextAligment:NSTextAlignmentLeft];
    [timeLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kScreenW / 3, kScreenW / 10));
        make.right.mas_equalTo(backView.mas_right).offset(-kScreenW / 20);
        make.centerY.mas_equalTo(numClothesLable.mas_centerY);
    }];
    timeLable.textColor = [UIColor lightGrayColor];
    timeLable.tag = 3;
    
    UILabel *openTimeLable = [UILabel creatLableWithTitle:[self.dic objectForKey:@"openTime"] andSuperView:backView andFont:k15 andTextAligment:NSTextAlignmentLeft];
    [openTimeLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kScreenW / 3, kScreenW / 10));
        make.left.mas_equalTo(numClothesLable.mas_left);
        make.centerY.mas_equalTo(backView.mas_centerY).offset(backView.height / 4);
    }];
    openTimeLable.textColor = [UIColor lightGrayColor];
    openTimeLable.tag = 4;
    
    UILabel *closeTimeLable = [UILabel creatLableWithTitle:[self.dic objectForKey:@"closeTime"] andSuperView:backView andFont:k15 andTextAligment:NSTextAlignmentLeft];
    [closeTimeLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kScreenW / 3, kScreenW / 10));
        make.right.mas_equalTo(timeLable.mas_right);
        make.centerY.mas_equalTo(openTimeLable.mas_centerY);
    }];
    closeTimeLable.textColor = [UIColor lightGrayColor];
    closeTimeLable.tag = 5;
    
    
    kaiQiLable.layer.borderWidth = 0;
    numClothesLable.layer.borderWidth = 0;
    timeLable.layer.borderWidth = 0;
    openTimeLable.layer.borderWidth = 0;
    closeTimeLable.layer.borderWidth = 0;
    
    
    kaiQiLable.userInteractionEnabled = YES;
    
    UITapGestureRecognizer *kaiQiTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(pickerViewTap234:)];
    [kaiQiLable addGestureRecognizer:kaiQiTap];
    
   
    
    if ([kStanderDefault objectForKey:@"GanYiJiData"]) {
        kaiQiLable.hidden = YES;
        numClothesLable.hidden = NO;
        timeLable.hidden = NO;
        openTimeLable.hidden = NO;
        closeTimeLable.hidden = NO;
    } else {
        kaiQiLable.hidden = NO;
        numClothesLable.hidden = YES;
        timeLable.hidden = YES;
        openTimeLable.hidden = YES;
        closeTimeLable.hidden = YES;
    }
}

- (void)setIsChongZhi:(NSString *)isChongZhi {
    _isChongZhi = isChongZhi;
    
    [kStanderDefault removeObjectForKey:@"GanYiJiData"];
    UILabel *lable1 = [backView viewWithTag:1];
    UILabel *lable2 = [backView viewWithTag:2];
    UILabel *lable3 = [backView viewWithTag:3];
    UILabel *lable4 = [backView viewWithTag:4];
    UILabel *lable5 = [backView viewWithTag:5];
    
    if ([_isChongZhi isEqualToString:@"YES"]) {
        
        lable1.hidden = NO;
        lable2.hidden = YES;
        lable3.hidden = YES;
        lable4.hidden = YES;
        lable5.hidden = YES;
    }
}

- (void)pickerViewTap234:(UITapGestureRecognizer *)tap {
    
    
    if ([self.isFromWhich isEqualToString:@"first"] || [self.isFromWhich isEqualToString:@"second"]) {
        self.firstView = [self creatPickView234];
    } else if ([self.isFromWhich isEqualToString:@"thirt"]) {
        self.secondView = [self creatPickView234];
    }
    
}


#pragma mark - 创建UIPickView
- (UIView *)creatPickView234{
    
    self.maskView22 = [[UIView alloc] initWithFrame:kScreenFrame];
    self.maskView22.backgroundColor = [UIColor clearColor];
    [self.vc.view addSubview:self.maskView22];

    self.maskView22.userInteractionEnabled = YES;
    //    [self.view addSubview:self.maskView22];
    [self.maskView22 addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hidemyPicker22)]];
    
    
    self.pickerBgView22 = [[UIView alloc]initWithFrame:CGRectMake(0, kScreenH - kScreenH / 2.61568, kScreenW, kScreenH / 2.61568)];
    [self.vc.view addSubview:self.pickerBgView22];
    self.pickerBgView22.backgroundColor = [UIColor whiteColor];
    
    self.myPicker22 = [[UIPickerView alloc]init];
    [self.pickerBgView22 addSubview:self.myPicker22];
    [self.myPicker22 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kScreenW, kScreenH / 3.08796));
        make.left.mas_equalTo(0);
        make.top.mas_equalTo(kScreenH / 17.1025);
    }];
    self.myPicker22.tag = 1;
    self.myPicker22.delegate = self;
    self.myPicker22.dataSource = self;
    
    [UIView animateWithDuration:0.3 animations:^{
        self.pickerBgView22.alpha = 1.0;
    }];
    
    
    UIView *view  =[[UIView alloc]init];
    view.backgroundColor = kACOLOR(224, 224, 224, 1.0);
    
    [self.pickerBgView22 addSubview:view];
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kScreenW, kScreenH / 17.1025));
        make.left.mas_equalTo(0);
        make.top.mas_equalTo(0);
    }];
    
    UIButton *cancleBtn = [UIButton initWithTitle:@"取消" andColor:[UIColor clearColor] andSuperView:view]
    ;
    [cancleBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [cancleBtn addTarget:self action:@selector(cancel:) forControlEvents:UIControlEventTouchUpInside];
    [cancleBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.size.mas_equalTo(CGSizeMake(kScreenW / 4, kScreenH / 17.1025));
        make.top.mas_equalTo(0);
    }];
    
    UIButton *sureBtn = [UIButton initWithTitle:@"确定" andColor:[UIColor clearColor] andSuperView:view]
    ;
    [sureBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [sureBtn addTarget:self action:@selector(ensure:) forControlEvents:UIControlEventTouchUpInside];
    [sureBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(0);
        make.size.mas_equalTo(CGSizeMake(kScreenW / 4, kScreenH / 17.1025));
        make.top.mas_equalTo(0);
    }];
    
    
    self.pickerBgView22.top = self.vc.view.height;
    
    [UIView animateWithDuration:0.3 animations:^{
        
        self.myPicker22.alpha = 1.0;
        self.pickerBgView22.bottom = self.vc.view.height;
    }];
    
    return self.pickerBgView22;
    
}

#pragma mark - 确定  取消  的点击事件
- (void)cancel:(UIButton *)btn {
    [self hidemyPicker22];
}


- (void)ensure:(UIButton *)btn {
    self.dic = [NSMutableDictionary dictionary];

    UILabel *lable1 = [backView viewWithTag:1];
    UILabel *lable2 = [backView viewWithTag:2];
    UILabel *lable3 = [backView viewWithTag:3];
    UILabel *lable4 = [backView viewWithTag:4];
    UILabel *lable5 = [backView viewWithTag:5];
    
    lable1.hidden = YES;
    lable2.hidden = NO;
    lable3.hidden = NO;
    lable4.hidden = NO;
    lable5.hidden = NO;
    
    NSString *numClothes = self.countArray[[self.myPicker22 selectedRowInComponent:0]];
    lable2.text = [NSString stringWithFormat:@"衣物数量:%@" , numClothes];
    
    NSString *timeClotfes = [NSString stringWithFormat:@"%ld 分" , numClothes.integerValue * kClothesTime];
    
    if ([self.isFromWhich isEqualToString:@"thirt"]) {

        UIPickerView *ppppp = [self.secondView viewWithTag:1];
        timeClotfes = self.minutesArray[[ppppp selectedRowInComponent:1]];
    }
    
    lable3.text = [NSString stringWithFormat:@"时长:%@" , timeClotfes];
    
    
    NSDate *date = [NSDate date];
    NSDateFormatter *fm = [[NSDateFormatter alloc]init];
    [fm setDateFormat:@"HH:mm"];
    NSString *time = [fm stringFromDate:date];
    
    lable4.text = [NSString stringWithFormat:@"开启:%@" , time];
    
    
    NSDate *sendDate = [NSDate date];
    
    
    NSTimeInterval date2 = (timeClotfes.integerValue * 60 + (NSInteger)[sendDate timeIntervalSince1970]);
    NSDate *confirmTimeSp = [NSDate dateWithTimeIntervalSince1970:date2];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"YYYY/MM/dd HH:mm"];
    
    
    NSString *confirmTimeStr = [dateFormatter stringFromDate:confirmTimeSp];
    
    lable5.text = [NSString stringWithFormat:@"关闭:%@" , [confirmTimeStr substringFromIndex:11]];
    
    [self.dic setObject:lable2.text forKey:@"numClothes"];
    [self.dic setObject:lable3.text forKey:@"time"];
    [self.dic setObject:lable4.text forKey:@"openTime"];
    [self.dic setObject:lable5.text forKey:@"closeTime"];
    [self.dic setObject:self.isFromWhich forKey:@"formWhich"];
    [self.dic setObject:confirmTimeStr forKey:@"confirmTimeStr"];
    [self.dic setObject:@(date2) forKey:@"date2"];
    
    [kStanderDefault setObject:self.dic forKey:@"GanYiJiData"];
    
    
    NSArray *array = @[self.isFromWhich , [lable3.text substringFromIndex:3] , [lable4.text substringFromIndex:3] , [lable5.text substringFromIndex:3]];
    if (self.delegate && [self.delegate respondsToSelector:@selector(getGaiYiJiCommonClothesData:andClothesData:)]) {
        [self.delegate getGaiYiJiCommonClothesData:self andClothesData:array];
    }
    
    [self hidemyPicker22];
}


#pragma mark - 隐藏UIPickView
- (void)hidemyPicker22 {
    [UIView animateWithDuration:0.3 animations:^{
        self.maskView22.alpha = 0;
        self.pickerBgView22.top = self.vc.view.height;
    } completion:^(BOOL finished) {
        [self.maskView22 removeFromSuperview];
        [self.pickerBgView22 removeFromSuperview];
    }];
}

#pragma mark - UIPickView的代理
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    
    if ([pickerView isEqual:[self.firstView viewWithTag:1]]) {
        return 1;
    } else  {
        return 2;
    }
    
    
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    
    
    if ([pickerView isEqual:[self.firstView viewWithTag:1]]) {
        return self.countArray.count;
    } else  {
        
        if (component == 0) {
            return self.countArray.count;
        } else {
            return self.minutesArray.count;
        }
    }
    
}
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    
    if ([pickerView isEqual:[self.firstView viewWithTag:1]]) {
        return [self.countArray objectAtIndex:row];
    } else  {
        
        if (component == 0) {
            return [self.countArray objectAtIndex:row];
        } else {
            return [self.minutesArray objectAtIndex:row];
        }

    }
    
}


- (void)creatPickViewData{

    self.countArray = [NSMutableArray array];
    for (int i = 1; i <= 20; i++) {
        [self.countArray addObject:[NSString stringWithFormat:@"%d件" , i]];
    }
    
    self.minutesArray = [NSMutableArray array];
    
    for (int i = 1; i <= 60; i++) {
        [self.minutesArray addObject:[NSString stringWithFormat:@"%d分" , i]];
    }
}


- (NSMutableDictionary *)dic{
    if (!_dic) {
        self.dic = [NSMutableDictionary dictionary];
    }
    return _dic;
}

- (void)setIsFromWhich:(NSString *)isFromWhich {
    _isFromWhich = isFromWhich;
    
    NSDictionary *dddd = [kStanderDefault objectForKey:@"GanYiJiData"];
    NSString *fromWich = dddd[@"formWhich"];
    
//    NSLog(@"%@ , %@" , _isFromWhich , fromWich);
    UILabel *lable1 = [backView viewWithTag:1];
    UILabel *lable2 = [backView viewWithTag:2];
    UILabel *lable3 = [backView viewWithTag:3];
    UILabel *lable4 = [backView viewWithTag:4];
    UILabel *lable5 = [backView viewWithTag:5];
    
  
    
    if (![_isFromWhich isEqualToString:fromWich]) {
        lable1.hidden = NO;
        lable2.hidden = YES;
        lable3.hidden = YES;
        lable4.hidden = YES;
        lable5.hidden = YES;
    } else {
        lable1.hidden = YES;
        lable2.hidden = NO;
        lable3.hidden = NO;
        lable4.hidden = NO;
        lable5.hidden = NO;
    }
    
    if ([_isFromWhich isEqualToString:@"thirt"]) {
        kaiQiLable.text = @"请选择衣物数量和时长";
    }
    
}

@end
