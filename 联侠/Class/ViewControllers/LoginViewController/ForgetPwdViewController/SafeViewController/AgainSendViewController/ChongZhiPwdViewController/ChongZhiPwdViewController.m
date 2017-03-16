//
//  ChongZhiPwdViewController.m
//  AEFT冷风扇
//
//  Created by 杭州阿尔法特 on 16/3/9.
//  Copyright © 2016年 阿尔法特. All rights reserved.
//

#import "ChongZhiPwdViewController.h"
#import "SuccessViewController.h"
#import "MineSerivesViewController.h"
#import "AddSViewController.h"

@interface ChongZhiPwdViewController ()<UITextFieldDelegate , HelpFunctionDelegate>

@property (nonatomic , strong) UIView *navView;

@property (nonatomic , strong) UIView *xiaHuaXian1;
@property (nonatomic , strong) UIView *xiaHuaXian2;
@end

@implementation ChongZhiPwdViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navView = [UIView creatNavView:self.view WithTarget:self action:@selector(backTap:) andTitle:@"重置密码"];
    [self setUI];
}
#pragma mark - 返回主界面
- (void)backTap:(UITapGestureRecognizer *)tap {
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - 设置UI
- (void)setUI{
    UILabel *phoneNumberLable = [UILabel creatLableWithTitle:[NSString stringWithFormat:@"您注册的手机号码为:%@" , self.phoneNumber] andSuperView:self.view andFont:k14 andTextAligment:NSTextAlignmentLeft];
    phoneNumberLable.layer.borderWidth = 0;
    [phoneNumberLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kStandardW, kScreenW / 17));
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.top.mas_equalTo(self.view.mas_top).offset(kScreenH / 5.29);
    }];
    phoneNumberLable.textColor = [UIColor grayColor];
    
    phoneNumberLable.attributedText = [NSString setSubStringOfOriginalString:phoneNumberLable.text andColorString:self.phoneNumber andColor:kMainColor];
    
    UILabel *tiShiLable = [UILabel creatLableWithTitle:@"请设置您的密码。" andSuperView:self.view andFont:k14 andTextAligment:NSTextAlignmentLeft];
    tiShiLable.textColor = [UIColor grayColor];
    tiShiLable.layer.borderWidth = 0;
    [tiShiLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(kStandardW, kScreenW/15));
        make.top.mas_equalTo(phoneNumberLable.mas_bottom);
    }];
    
    UIView *xiaHuaXian = [[UIView alloc]init];
    [self.view addSubview:xiaHuaXian];
    xiaHuaXian.backgroundColor = [UIColor blackColor];
    [xiaHuaXian mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kStandardW, 1));
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.top.mas_equalTo(self.view.mas_top).offset(kScreenH/2.92);
    }];
    
    
    self.pwdTectFiled = [UITextField creatTextfiledWithPlaceHolder:@"请输入密码" andSuperView:self.view];
    self.pwdTectFiled.secureTextEntry = YES;
    self.pwdTectFiled.keyboardType = UIKeyboardTypeDefault;
    self.pwdTectFiled.delegate = self;
    [self.pwdTectFiled mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kStandardW, kScreenW / 10));
        make.centerX.mas_equalTo(xiaHuaXian.mas_centerX);
        make.bottom.mas_equalTo(xiaHuaXian.mas_top);
    }];
    
    UIView *xiaHuaXian2 = [[UIView alloc]init];
    [self.view addSubview:xiaHuaXian2];
    xiaHuaXian2.backgroundColor = [UIColor grayColor];
    [xiaHuaXian2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kStandardW, 1));
        make.centerX.mas_equalTo(xiaHuaXian.mas_centerX);
        make.top.mas_equalTo(xiaHuaXian.mas_bottom).offset(kScreenH/10.1);
    }];
    
    
    self.againPwdTectFiled = [UITextField creatTextfiledWithPlaceHolder:@"请重复输入密码" andSuperView:self.view];
    self.againPwdTectFiled.keyboardType = UIKeyboardTypeDefault;
    self.againPwdTectFiled.secureTextEntry = YES;
    self.againPwdTectFiled.delegate = self;
    [self.againPwdTectFiled mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kStandardW, kScreenW / 10));
        make.centerX.mas_equalTo(xiaHuaXian.mas_centerX);
        make.bottom.mas_equalTo(xiaHuaXian2.mas_top);
    }];
    
    
    UIButton *submitBtn = [UIButton initWithTitle:@"提交" andColor:[UIColor redColor] andSuperView:self.view];
    [submitBtn addTarget:self action:@selector(doneBtnAtcion) forControlEvents:UIControlEventTouchUpInside];
    submitBtn.layer.cornerRadius = kScreenW / 18;
    
    submitBtn.backgroundColor = kMainColor;
    [submitBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kStandardW, kScreenW / 9));
        make.centerX.mas_equalTo(xiaHuaXian.mas_centerX);
        make.top.mas_equalTo(xiaHuaXian2.mas_bottom).offset(kScreenH / 11.1);
    }];
    
    _xiaHuaXian1 = xiaHuaXian;
    _xiaHuaXian2 = xiaHuaXian2;
}

#pragma mark - 输入框代理
- (void)textFieldDidEndEditing:(UITextField *)textField {
    
    _xiaHuaXian1.backgroundColor = [UIColor grayColor];
    _xiaHuaXian2.backgroundColor = [UIColor grayColor];
    
    if (textField.text.length >= 6 && textField.text.length <= 16) {
        if ([textField isEqual:self.againPwdTectFiled]) {
            if (![self.pwdTectFiled.text isEqualToString:self.againPwdTectFiled.text] && self.pwdTectFiled.text.length > 0 && self.againPwdTectFiled.text.length > 0) {
                UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"您两次输入的密码不同，请再次输入" preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction *rightAtcion = [UIAlertAction actionWithTitle:@"好的" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    self.pwdTectFiled.text = nil;
                    self.againPwdTectFiled.text = nil;
                }];
                [alert addAction:rightAtcion];
                
                [self presentViewController:alert animated:YES completion:nil];
            }
        }
    } else {
        UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"提示" message:@"密码长度必须大于6位并小于16位" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *rightAtcion = [UIAlertAction actionWithTitle:@"好的" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            textField.text = nil;
        }];
        [alertVC addAction:rightAtcion];
        [self presentViewController:alertVC animated:YES completion:nil];

    }
}


#pragma mark - 确定按钮点击事件
- (void)doneBtnAtcion{

    
    if (self.pwdTectFiled.text.length >= 6 && self.againPwdTectFiled.text.length >= 6 && self.pwdTectFiled.text.length <= 16 && self.againPwdTectFiled.text.length <= 16) {
        if ([self.pwdTectFiled.text isEqualToString:self.againPwdTectFiled.text]) {
            NSDictionary *parameters = @{@"userSn":self.userSn , @"newPassword" : self.againPwdTectFiled.text};
            NSLog(@"%@" , parameters);
            [HelpFunction requestDataWithUrlString:kChongZhiMiMa andParames:parameters andDelegate:self];
            
        } else {
           
            [UIAlertController creatRightAlertControllerWithHandle:nil andSuperViewController:self Title:@"您两次输入的密码不相同，请重新输入"];
        }
    } else {
        
        [UIAlertController creatRightAlertControllerWithHandle:nil andSuperViewController:self Title:@"密码长度必须大于6位并小于16位"];
        
    }
    
}

- (void)requestData:(HelpFunction *)request didSuccess:(NSDictionary *)dddd {
    
    NSLog(@"%@" , dddd);
    
    NSInteger state = [dddd[@"state"] integerValue];
    if (state == 0) {
//        SuccessViewController *successVC = [[SuccessViewController alloc]init];
//        successVC.phoneNumber = [NSString stringWithString:self.phoneNumber];
//        successVC.pwd = [NSString stringWithString:self.againPwdTectFiled.text];
//        [self.navigationController pushViewController:successVC animated:YES];
        
        NSDictionary *parameters = nil;
        if ([kStanderDefault objectForKey:@"GeTuiClientId"]) {
            parameters = @{@"loginName":self.phoneNumber , @"password" : self.againPwdTectFiled.text , @"ua.clientId" : [kStanderDefault objectForKey:@"GeTuiClientId"], @"ua.phoneType" : @(2)};
        } else {
            parameters = @{@"loginName":self.phoneNumber , @"password" : self.againPwdTectFiled.text , @"ua.phoneType" : @(2)};
        }
        
   
        [kStanderDefault setObject:self.againPwdTectFiled.text forKey:@"password"];
        [kStanderDefault setObject:self.phoneNumber forKey:@"phone"];
        [HelpFunction requestDataWithUrlString:kLogin andParames:parameters andDelegate:self];
        
    } else if (state == 1) {
        [UIAlertController creatRightAlertControllerWithHandle:nil andSuperViewController:self Title:@"密码输入为空"];
    } else {
       
        [UIAlertController creatRightAlertControllerWithHandle:nil andSuperViewController:self Title:@"系统异常，请重试"];
    }
}

#pragma mark - 代理返回的数据
- (void)requestData:(HelpFunction *)request didFinishLoadingDtaArray:(NSMutableArray *)data {
    NSDictionary *dic = data[0];
    //    NSLog(@"%@" , dic);
    if ([dic[@"state"] integerValue] == 0) {
        
        NSDictionary *user = dic[@"data"];
        
        [kStanderDefault setObject:user[@"sn"] forKey:@"userSn"];
        [kStanderDefault setObject:user[@"id"] forKey:@"userId"];
        
        UserModel *userModel = [[UserModel alloc]init];
        for (NSString *key in [user allKeys]) {
            [userModel setValue:user[key] forKey:key];
        }
        
        kSocketTCP.userSn = [NSString stringWithFormat:@"%ld" , userModel.sn];
        //        [kSocketTCP cutOffSocket];
        [kSocketTCP socketConnectHost];
        
        [HelpFunction requestDataWithUrlString:kQueryTheUserdevice andParames:@{@"userSn" : @(userModel.sn)} andDelegate:self];
    }
}


- (void)requestData:(HelpFunction *)requset queryUserdevice:(NSDictionary *)dddd {
    
    //    NSLog(@"%@" , dddd);
    NSInteger state = [dddd[@"state"] integerValue];
    if (state == 0) {
        
        if (![dddd[@"data"] isKindOfClass:[NSArray class]]) {
            AddSViewController *addServiceVC = [[AddSViewController alloc]init];
            [self.navigationController pushViewController:addServiceVC animated:YES];
        } else {
            NSMutableArray *dataArray = dddd[@"data"];
            if (dataArray.count > 0) {
                [kStanderDefault setObject:@"YES" forKey:@"isHaveService"];
                
                //                MineSerivesViewController *myMachineVC = [[MineSerivesViewController alloc]init];
                //                [self.navigationController pushViewController:myMachineVC animated:YES];
                
                [self.navigationController pushViewController:[[TabBarViewController alloc]init] animated:YES];
            } else {
                AddSViewController *addServiceVC = [[AddSViewController alloc]init];
                [self.navigationController pushViewController:addServiceVC animated:YES];
            }
            
        }
    }
}


#pragma mark - 点击空白处收回键盘
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}


- (void)textFieldDidBeginEditing:(UITextField *)textField {
    if (textField == self.pwdTectFiled) {
        _xiaHuaXian1.backgroundColor = kMainColor;
        _xiaHuaXian2.backgroundColor = [UIColor grayColor];
    } else if (textField == self.againPwdTectFiled) {
        _xiaHuaXian1.backgroundColor = [UIColor grayColor];
        _xiaHuaXian2.backgroundColor = kMainColor;
    }
}


@end
