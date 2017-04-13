//
//  LocationPickerVC.m
//  YouZhi
//
//  Created by roroge on 15/4/9.
//  Copyright (c) 2015年 com.roroge. All rights reserved.
//

#import "LocationPickerVC.h"
#import "UserMessageViewController.h"


@interface LocationPickerVC () <UIPickerViewDataSource, UIPickerViewDelegate , UITextFieldDelegate , HelpFunctionDelegate>
//view
@property (strong, nonatomic)  UIPickerView *myPicker;
@property (strong, nonatomic)  UIView *pickerBgView;
@property (strong, nonatomic) UIView *maskView;

@property (strong, nonatomic) NSMutableDictionary *pickerDic;
@property (strong, nonatomic) NSMutableArray *provinceArray;
@property (strong, nonatomic) NSMutableArray *cityArray;
@property (strong, nonatomic) NSMutableArray *townArray;
@property (strong, nonatomic) NSMutableArray *selectedArray;

@property (nonatomic , strong) UILabel *provinceLable;
@property (nonatomic , strong) UILabel *cityLable;
@property (nonatomic , strong) UILabel *townLable;

@property (nonatomic , strong) UITextField *streetTextFiled;
@property (nonatomic , strong) UITextField *postCodeTextFiled;
@property (nonatomic , strong) UITextField *nameTextFiled;
@property (nonatomic , strong) UITextField *phoneTextFiled;
@property (nonatomic , strong) UIView *navView;

@end

@implementation LocationPickerVC

- (NSMutableDictionary *)pickerDic {
    if (!_pickerDic) {
        _pickerDic = [NSMutableDictionary dictionary];
    }
    return _pickerDic;
}

- (NSMutableArray *)provinceArray {
    if (!_provinceArray) {
        _provinceArray = [NSMutableArray array];
    }
    return _provinceArray;
}

- (NSMutableArray *)cityArray {
    if (!_cityArray) {
        _cityArray = [NSMutableArray array];
    }
    return _cityArray;
}

- (NSMutableArray *)townArray {
    if (!_townArray) {
        _townArray = [NSMutableArray array];
    }
    return _townArray;
}

- (NSMutableArray *)selectedArray {
    if (!_selectedArray) {
        _selectedArray = [NSMutableArray array];
    }
    return _selectedArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];

    NSLog(@"%@" , [kStanderDefault objectForKey:@"userSn"]);
    
    
    [self setUI];
    [self getPickerData];
    
    [self creatPickView];
    
    
}

#pragma mark - 设置UI
- (void)setUI{
    
   
    
    UILabel *titleLable = [UILabel creatLableWithTitle:@"地址修改" andSuperView:self.view andFont:k16 andTextAligment:NSTextAlignmentCenter];
    titleLable.layer.borderWidth = 0;
    titleLable.textColor = [UIColor blackColor];
    [titleLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(kScreenW / 4, kScreenH / 22));
        make.top.mas_equalTo(kScreenH / 33.35);
        
    }];
    
    
    UIView *view = [[UIView alloc]init];
    view.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:view];
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kScreenW, 1));
        make.left.mas_equalTo(self.view.mas_left).offset(0);
        make.top.mas_equalTo(kScreenH / 13.34);
    }];
    

    
    UIView *xiaHuaXian2 = [[UIView alloc]init];
    [self.view addSubview:xiaHuaXian2];
    xiaHuaXian2.backgroundColor = [UIColor lightGrayColor];
    [xiaHuaXian2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kStandardW , 1));
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.top.mas_equalTo(view.mas_bottom).offset(kScreenH / 6);
    }];
    
    
    
    self.streetTextFiled = [UITextField creatTextfiledWithPlaceHolder:@"请输入详细地址信息" andSuperView:self.view];
    self.streetTextFiled.keyboardType = UIKeyboardTypeDefault;
    self.streetTextFiled.delegate = self;
    [self.view addSubview:self.streetTextFiled];
    [ self.streetTextFiled mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kStandardW, kScreenW / 13));
        make.bottom.mas_equalTo(xiaHuaXian2.mas_top);
        make.centerX.mas_equalTo(self.view.mas_centerX);

    }];
    
    
    
    self.provinceLable = [UILabel creatLableWithTitle:@"省/市:" andSuperView:self.view andFont:k14 andTextAligment:NSTextAlignmentCenter];
    self.provinceLable.layer.borderColor = kMainColor.CGColor;
    [self.provinceLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake((kStandardW - 40) / 3, kScreenW / 13));
        make.left.mas_equalTo(xiaHuaXian2.mas_left);
        make.bottom.mas_equalTo(self.streetTextFiled.mas_top).offset(-kScreenW / 25);
    }];
    
    self.cityLable = [UILabel creatLableWithTitle:@"市/区:" andSuperView:self.view andFont:k14 andTextAligment:NSTextAlignmentCenter];
    self.cityLable.layer.borderColor = kMainColor.CGColor;
    [self.cityLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake((kStandardW - 40) / 3, kScreenW / 13));
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.centerY.mas_equalTo(self.provinceLable.mas_centerY);
    }];
    
    self.townLable = [UILabel creatLableWithTitle:@"县:" andSuperView:self.view andFont:k14 andTextAligment:NSTextAlignmentCenter];
    self.townLable.layer.borderColor = kMainColor.CGColor;
    [self.townLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake((kStandardW - 40) / 3, kScreenW / 13));
        make.right.mas_equalTo(xiaHuaXian2.mas_right);
        make.centerY.mas_equalTo(self.provinceLable.mas_centerY);
    }];
    
    self.provinceLable.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAtcion111:)];
    [self.provinceLable addGestureRecognizer:tap1];

    self.cityLable.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap2 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAtcion111:)];
    [self.cityLable addGestureRecognizer:tap2];
    
    self.townLable.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap3 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAtcion111:)];
    [self.townLable addGestureRecognizer:tap3];
    
    
    UIView *postCodeView = [UIView creatTextFiledWithLableText:@"邮政编码:" andTextFiledPlaceHold:@"请输入邮编" andSuperView:self.view];
    [postCodeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kStandardW, kScreenW / 8));
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.top.mas_equalTo(xiaHuaXian2.mas_bottom).offset(kScreenW / 30);
    }];
    self.postCodeTextFiled = postCodeView.subviews[2];
    self.postCodeTextFiled.delegate = self;
    self.phoneTextFiled.keyboardType = UIKeyboardTypeNumberPad;
    
    UIView *nameView = [UIView creatTextFiledWithLableText:@"收货人姓名:" andTextFiledPlaceHold:@"填写收件人姓名" andSuperView:self.view];
    [nameView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kStandardW, kScreenW / 8));
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.top.mas_equalTo(self.postCodeTextFiled.mas_bottom).offset(kScreenW / 30);
    }];
    self.nameTextFiled = nameView.subviews[2];
    self.nameTextFiled.delegate = self;
    self.nameTextFiled.keyboardType = UIKeyboardTypeNamePhonePad;
    
    UIView *phoneView = [UIView creatTextFiledWithLableText:@"手机号码:" andTextFiledPlaceHold:@"填写手机号码" andSuperView:self.view];
    [phoneView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kScreenW, kScreenW / 8));
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.top.mas_equalTo(self.nameTextFiled.mas_bottom).offset(kScreenW / 30);
    }];
    self.phoneTextFiled = phoneView.subviews[2];
    self.phoneTextFiled.delegate = self;
    self.phoneTextFiled.keyboardType = UIKeyboardTypeNumberPad;
    
    UIButton *cancleBtn = [UIButton initWithTitle:@"取消" andColor:kMainColor andSuperView:self.view];
    [cancleBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo( self.streetTextFiled.mas_left);
        make.size.mas_equalTo(CGSizeMake(kScreenW / 5, kScreenW / 10));
        make.top.mas_equalTo(phoneView.mas_bottom).offset(10);
    }];
    [cancleBtn addTarget:self action:@selector(cancleBtnAtcion:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *sureBtn = [UIButton initWithTitle:@"确定" andColor:kMainColor andSuperView:self.view];
    [sureBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.streetTextFiled.mas_right);
        make.size.mas_equalTo(CGSizeMake(kScreenW / 5, kScreenW / 10));
        make.top.mas_equalTo(phoneView.mas_bottom).offset(10);
    }];
    [sureBtn addTarget:self action:@selector(sureBtnAtcion1111:) forControlEvents:UIControlEventTouchUpInside];

    
    
    if (self.diZhiModel.addrProvince) {
        self.provinceLable.text = self.diZhiModel.addrProvince;
    }
    
    if (self.diZhiModel.addrCity) {
        self.cityLable.text = self.diZhiModel.addrCity;
    }
    
    if (self.diZhiModel.addrCounty) {
        self.townLable.text = self.diZhiModel.addrCounty;
    }
    
    if (self.diZhiModel.addrDetail) {
        self.streetTextFiled.text = self.diZhiModel.addrDetail;
    }
    
    if (self.diZhiModel.postcode) {
        self.postCodeTextFiled.text = [NSString stringWithFormat:@"%@" , self.diZhiModel.postcode];
//        self.postCodeTextFiled.text = @"aaaaaaaaaaaa";
    }
    
    if (self.diZhiModel.receiverPhone) {
        self.phoneTextFiled.text = self.diZhiModel.receiverPhone;
    }
    
    if (self.diZhiModel.receiverName) {
        self.nameTextFiled.text = self.diZhiModel.receiverName;
        
//        self.nameTextFiled.text = @"asdssssss";
    }

    
}

- (void)setDiZhiModel:(DiZhiModel *)diZhiModel {
    _diZhiModel = diZhiModel;
    
}

#pragma mark - 点击重新选择地址
- (void)tapAtcion111:(UITapGestureRecognizer *)tap {
    [self showMyPicker];
}

#pragma mark - 返回按钮的点击事件
- (void)cancleBtnAtcion:(UIButton *)btn {

    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - 确定按钮的点击事件
- (void)sureBtnAtcion1111:(UIButton *)btn {
    
    if (self.provinceLable.text.length > 0 && self.cityLable.text.length > 0 && self.townLable.text.length > 0 && self.streetTextFiled.text.length > 0 && self.postCodeTextFiled.text.length >0 && self.nameTextFiled.text.length > 0 && self.phoneTextFiled.text.length > 0) {
        
        
        
        NSString *diZhiStr = [NSString string];
        if ([self.provinceLable.text isEqualToString:self.cityLable.text]) {
            diZhiStr = [NSString stringWithFormat:@"%@-%@-%@" , self.cityLable.text , self.townLable.text , self.streetTextFiled.text];
        } else {
            diZhiStr = [NSString stringWithFormat:@"%@-%@-%@-%@" , self.provinceLable.text , self.cityLable.text , self.townLable.text , self.streetTextFiled.text];
        }
        
        if (_delegate && [_delegate respondsToSelector:@selector(sendDiZhiDataToProvienceVC:)]) {
            [_delegate sendDiZhiDataToProvienceVC:diZhiStr];
        }
        
        if (self.diZhiModel.idd == 0) {
            NSDictionary *parames = @{ @"address.userSn" : [kStanderDefault objectForKey:@"userSn"] , @"address.addrProvince" : self.provinceLable.text , @"address.addrCity" : self.cityLable.text , @"address.addrCounty" : self.townLable.text , @"address.addrDetail" : self.streetTextFiled.text , @"address.postcode" : @([self.postCodeTextFiled.text integerValue]) , @"address.receiverName" : self.nameTextFiled.text , @"address.receiverPhone" : self.phoneTextFiled.text};
            
            [HelpFunction requestDataWithUrlString:kXiuGaiYongHuDiZhi andParames:parames andDelegate:self];
        } else {
            
            
            NSDictionary *parames = @{ @"address.userSn" : [kStanderDefault objectForKey:@"userSn"] , @"address.id" : @(self.diZhiModel.idd), @"address.addrProvince" : self.provinceLable.text , @"address.addrCity" : self.cityLable.text , @"address.addrCounty" : self.townLable.text , @"address.addrDetail" : self.streetTextFiled.text , @"address.postcode" : @([self.postCodeTextFiled.text integerValue]) , @"address.receiverName" : self.nameTextFiled.text , @"address.receiverPhone" : self.phoneTextFiled.text};
            
            [HelpFunction requestDataWithUrlString:kXiuGaiYongHuDiZhi andParames:parames andDelegate:self];
        }
        
        
    } else {
        [UIAlertController creatRightAlertControllerWithHandle:nil andSuperViewController:self Title:@"信息未填写完全"];
    }
}

#pragma mark - 代理返回的数据代理
- (void)requestData:(HelpFunction *)request didSuccess:(NSDictionary *)dddd {
//    NSLog(@"%@" , dddd);
    
    if ([dddd[@"success"] integerValue] == 1) {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (void)requestData:(HelpFunction *)request didFailLoadData:(NSError *)error {
    NSLog(@"%@" , error);
}

#pragma mark - 创建UIPickView
- (UIView *)creatPickView{
    
    self.maskView = [[UIView alloc] initWithFrame:kScreenFrame];
    self.maskView.backgroundColor = [UIColor clearColor];
    //    self.maskView.alpha = 0;
    self.maskView.userInteractionEnabled = YES;
    //    [self.view addSubview:self.maskView];
    [self.maskView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideMyPicker)]];
    
    
    self.pickerBgView = [[UIView alloc]initWithFrame:CGRectMake(0, kScreenH - kScreenH / 2.61568, kScreenW, kScreenH / 2.61568)];
    
    self.pickerBgView.backgroundColor = [UIColor whiteColor];
    
    self.myPicker = [[UIPickerView alloc]init];
    [self.pickerBgView addSubview:self.myPicker];
    [self.myPicker mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kScreenW, kScreenH / 3.08796));
        make.left.mas_equalTo(0);
        make.top.mas_equalTo(kScreenH / 17.1025);
    }];
    self.myPicker.delegate = self;
    self.myPicker.dataSource = self;
    
    [UIView animateWithDuration:0.3 animations:^{
        self.pickerBgView.alpha = 1.0;
    }];
    
    
    UIView *view  =[[UIView alloc]init];
    view.backgroundColor = [UIColor colorWithRed:224/255.0 green:224/255.0 blue:224/255.0 alpha:1.0];
    [self.pickerBgView addSubview:view];
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kScreenW, kScreenH / 17.1025));
        make.left.mas_equalTo(0);
        make.top.mas_equalTo(0);
    }];
    
    UIButton *cancleBtn = [UIButton initWithTitle:@"取消" andColor:[UIColor clearColor] andSuperView:view]
    ;
    [cancleBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [cancleBtn addTarget:self action:@selector(cancel11:) forControlEvents:UIControlEventTouchUpInside];
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
    
    [self.view addSubview:self.maskView];
    [self.view addSubview:self.pickerBgView];
    
    self.pickerBgView.top = self.view.height;
    
    [UIView animateWithDuration:0.3 animations:^{
        
        self.myPicker.alpha = 1.0;
        self.pickerBgView.bottom = self.view.height;
    }];
    
    return self.pickerBgView;
    
}

#pragma mark - 确定  取消  的点击事件
- (void)cancel11:(UIButton *)btn {
    [self hideMyPicker];
}


#pragma mark - get data
- (void)getPickerData {
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"Address" ofType:@"plist"];
    self.pickerDic = [[NSMutableDictionary alloc] initWithContentsOfFile:path];
    self.provinceArray = [[self.pickerDic allKeys] mutableCopy];
    self.selectedArray = [self.pickerDic objectForKey:[[self.pickerDic allKeys] objectAtIndex:0]];
    
    if (self.selectedArray.count > 0) {
        self.cityArray = [[[self.selectedArray objectAtIndex:0] allKeys] mutableCopy];
    }
    
    if (self.cityArray.count > 0) {
        self.townArray = [[self.selectedArray objectAtIndex:0] objectForKey:[self.cityArray objectAtIndex:0]];
    }
    
}

#pragma mark - UIPicker Delegate
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 3;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    if (component == 0) {
        return self.provinceArray.count;
    } else if (component == 1) {
        return self.cityArray.count;
    } else {
        return self.townArray.count;
    }
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    if (component == 0) {
        return [self.provinceArray objectAtIndex:row];
    } else if (component == 1) {
        return [self.cityArray objectAtIndex:row];
    } else {
        return [self.townArray objectAtIndex:row];
    }
}

- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component {
    if (component == 0) {
        return 110;
    } else if (component == 1) {
        return 100;
    } else {
        return 110;
    }
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    if (component == 0) {
        self.selectedArray = [self.pickerDic objectForKey:[self.provinceArray objectAtIndex:row]];
        if (self.selectedArray.count > 0) {
            self.cityArray = [[[self.selectedArray objectAtIndex:0] allKeys] mutableCopy];
        } else {
            self.cityArray = nil;
        }
        if (self.cityArray.count > 0) {
            self.townArray = [[self.selectedArray objectAtIndex:0] objectForKey:[self.cityArray objectAtIndex:0]];
        } else {
            self.townArray = nil;
        }
    }
    [pickerView selectedRowInComponent:1];
    [pickerView reloadComponent:1];
    [pickerView selectedRowInComponent:2];
    
    if (component == 1) {
        if (self.selectedArray.count > 0 && self.cityArray.count > 0) {
            self.townArray = [[self.selectedArray objectAtIndex:0] objectForKey:[self.cityArray objectAtIndex:row]];
        } else {
            self.townArray = nil;
        }
        [pickerView selectRow:1 inComponent:2 animated:YES];
    }
    
    [pickerView reloadComponent:2];
}

#pragma mark - private method
- (void)showMyPicker{
    [self.view addSubview:self.maskView];
    [self.view addSubview:self.pickerBgView];
    self.maskView.alpha = 0;
    self.pickerBgView.top = self.view.height;
    
    [UIView animateWithDuration:0.3 animations:^{
        self.maskView.alpha = 0.3;
        self.pickerBgView.bottom = self.view.height;
    }];
}

- (void)hideMyPicker {
    [UIView animateWithDuration:0.3 animations:^{
        self.maskView.alpha = 0;
        self.pickerBgView.top = self.view.height;
    } completion:^(BOOL finished) {
        [self.maskView removeFromSuperview];
        [self.pickerBgView removeFromSuperview];
    }];
}

#pragma mark - xib click

- (void)ensure:(id)sender {
 
    self.provinceLable.text = [NSString stringWithFormat:@"%@" , [self.provinceArray objectAtIndex:[self.myPicker selectedRowInComponent:0]]];
    self.cityLable.text = [NSString stringWithFormat:@"%@" , [self.cityArray objectAtIndex:[self.myPicker selectedRowInComponent:1]]];
    self.townLable.text = [NSString stringWithFormat:@"%@" , [self.townArray objectAtIndex:[self.myPicker selectedRowInComponent:2]]];
    
    [self hideMyPicker];
}


#pragma mark - textFiled的代理
- (void)textFieldDidEndEditing:(UITextField *)textField {
    
    self.diZhiModel.addrProvince = self.provinceLable.text;
    self.diZhiModel.addrCity = self.cityLable.text;
    self.diZhiModel.addrCounty = self.townLable.text;
    self.diZhiModel.addrDetail = self.streetTextFiled.text;
    if ([textField isEqual:self.postCodeTextFiled]) {
        if (textField.text.length == 6) {
            self.diZhiModel.postcode = textField.text;
        } else {
            
            [UIAlertController creatRightAlertControllerWithHandle:^{
                textField.text = nil;
            } andSuperViewController:self Title:@"邮编须为6位，请重新输入"];
            
        }
        
        
    } else if ([textField isEqual:self.nameTextFiled]) {
        self.diZhiModel.receiverName = textField.text;
    } else if ([textField isEqual:self.phoneTextFiled]){
        if (textField.text.length == 11 && [self validateNumber:textField.text]) {
            self.diZhiModel.receiverPhone = textField.text;
        } else {
            
            [UIAlertController creatRightAlertControllerWithHandle:^{
                textField.text = nil;
            } andSuperViewController:self Title:@"手机号码不正确，请重新输入"];
        }
        
    }
}

#pragma mark - 限制输入为数字
- (BOOL)validateNumber:(NSString*)number {
    BOOL res = YES;
    NSCharacterSet* tmpSet = [NSCharacterSet characterSetWithCharactersInString:@"0123456789"];
    int i = 0;
    while (i < number.length) {
        NSString * string = [number substringWithRange:NSMakeRange(i, 1)];
        NSRange range = [string rangeOfCharacterFromSet:tmpSet];
        if (range.length == 0) {
            res = NO;
            break;
        }
        i++;
    }
    return res;
}


#pragma mark - 点击空白处收回键盘
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

@end
