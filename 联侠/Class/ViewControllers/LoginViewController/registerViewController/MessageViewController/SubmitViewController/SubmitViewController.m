//
//  SubmitViewController.m
//  AEFT冷风扇
//
//  Created by 杭州阿尔法特 on 16/3/9.
//  Copyright © 2016年 阿尔法特. All rights reserved.
//

#import "SubmitViewController.h"
#import "SuccessReviseViewController.h"
#import "MessageViewController.h"
#import "LoginViewController.h"
@interface SubmitViewController ()<UITextFieldDelegate , HelpFunctionDelegate>
@property (nonatomic , retain) UITextField *againPwdTextFiled;
@property (nonatomic , strong) UIView *navView;


@property (nonatomic , strong) UIView *xiaHuaXian1;
@property (nonatomic , strong) UIView *xiaHuaXian2;
@end

@implementation SubmitViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.navView = [UIView creatNavView:self.view WithTarget:self action:@selector(backTap:) andTitle:NSLocalizedString(@"RegistVC_Register", nil)];
    UIView *backView = [[UIView alloc]init];
    backView = [_navView.subviews objectAtIndex:0];
    
    UIImageView *iiii = [backView.subviews objectAtIndex:1];
    iiii.image = [UIImage new];
    [self setUI];
}
#pragma mark - 返回主界面
- (void)backTap:(UITapGestureRecognizer *)tap {
//    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - 设置UI
- (void)setUI{
    UILabel *phoneNumberLable = [UILabel creatLableWithTitle:[NSString stringWithFormat:@"%@%@" , NSLocalizedString(@"RegisterMobilePhoneNumber", nil) , self.phoneNumber] andSuperView:self.view andFont:k14 andTextAligment:NSTextAlignmentLeft];
    phoneNumberLable.layer.borderWidth = 0;
    [phoneNumberLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kStandardW, kScreenW / 17));
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.top.mas_equalTo(self.view.mas_top).offset(kScreenH / 5.29);
    }];
    phoneNumberLable.textColor = [UIColor grayColor];
    
    phoneNumberLable.attributedText = [NSString setSubStringOfOriginalString:phoneNumberLable.text andColorString:self.phoneNumber andColor:kMainColor];
    
    UILabel *tiShiLable = [UILabel creatLableWithTitle:NSLocalizedString(@"SetYourPwd", nil) andSuperView:self.view andFont:k14 andTextAligment:NSTextAlignmentLeft];
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
    
    
    self.pwdTectFiled = [UITextField creatTextfiledWithPlaceHolder:NSLocalizedString(@"LoginVC_PwdPlacrholder", nil) andSuperView:self.view];
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
    
   
    self.againPwdTextFiled = [UITextField creatTextfiledWithPlaceHolder:NSLocalizedString(@"AgainRepeatPwd", nil) andSuperView:self.view];
    self.againPwdTextFiled.keyboardType = UIKeyboardTypeDefault;
    self.againPwdTextFiled.secureTextEntry = YES;
    self.againPwdTextFiled.delegate = self;
    [self.againPwdTextFiled mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kStandardW, kScreenW / 10));
        make.centerX.mas_equalTo(xiaHuaXian.mas_centerX);
        make.bottom.mas_equalTo(xiaHuaXian2.mas_top);
    }];
    
    
//    UILabel *wenHaoLable = [UILabel creatLableWithTitle:@"!" andSuperView:self.view andFont:k14 andTextAligment:NSTextAlignmentCenter];
//    wenHaoLable.textColor = [UIColor whiteColor];
//    wenHaoLable.backgroundColor = [UIColor blackColor];
//    wenHaoLable.userInteractionEnabled = YES;
//    wenHaoLable.layer.cornerRadius = kScreenW / 50;
//    wenHaoLable.layer.masksToBounds = YES;
//    wenHaoLable.layer.borderWidth = 0;
//    [wenHaoLable mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.size.mas_equalTo(CGSizeMake(kScreenW/25, kScreenW/25));
//        make.left.mas_equalTo(xiaHuaXian2.mas_left);
//        make.top.mas_equalTo(xiaHuaXian2.mas_bottom).offset(kScreenW/30);
//    }];
//    
//    UILabel *jingShiLable = [UILabel creatLableWithTitle:@"密码长度为6~16位，仅限数字、字母、字符"  andSuperView:self.view andFont:k14 andTextAligment:NSTextAlignmentLeft];
//    jingShiLable.layer.borderWidth = 0;
//    [jingShiLable mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.mas_equalTo(wenHaoLable.mas_right);
//        make.centerY.mas_equalTo(wenHaoLable.mas_centerY);
//        make.size.mas_equalTo(CGSizeMake(kScreenW * 5 / 6, kScreenW / 14));
//    }];
    
    UIButton *submitBtn = [UIButton initWithTitle:NSLocalizedString(@"Submit", nil) andColor:[UIColor redColor] andSuperView:self.view];
    [submitBtn addTarget:self action:@selector(submitBtnAtcion) forControlEvents:UIControlEventTouchUpInside];
    submitBtn.layer.cornerRadius = kScreenW / 18;
    
    submitBtn.backgroundColor = kMainColor;
    [submitBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kStandardW, kScreenW / 9));
        make.centerX.mas_equalTo(xiaHuaXian.mas_centerX);
        make.top.mas_equalTo(xiaHuaXian2.mas_bottom).offset(kScreenH / 11.1);
    }];
    
    UIButton *backBtn = [UIButton initWithTitle:NSLocalizedString(@"Back", nil) andColor:[UIColor clearColor] andSuperView:self.view];
    [backBtn setTitleColor:kMainColor forState:UIControlStateNormal];
    backBtn.layer.cornerRadius = kScreenW / 18;
    backBtn.layer.borderWidth = 1;
    backBtn.layer.borderColor = kMainColor.CGColor;
    
    [backBtn addTarget:self action:@selector(backBtnBtnAction) forControlEvents:UIControlEventTouchUpInside];
    //注册按钮的约束
    [backBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kStandardW, kScreenW / 9));
        make.centerX.mas_equalTo(xiaHuaXian.mas_centerX);
        make.top.mas_equalTo(submitBtn.mas_bottom).offset(kScreenH / 33.5);
    }];
    
    _xiaHuaXian1 = xiaHuaXian;
    _xiaHuaXian2 = xiaHuaXian2;
}

#pragma mark - 返回按钮点击事件
- (void)backBtnBtnAction{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - 输入框代理
- (void)textFieldDidEndEditing:(UITextField *)textField {
    
    _xiaHuaXian1.backgroundColor = [UIColor grayColor];
    _xiaHuaXian2.backgroundColor = [UIColor grayColor];
    
    if (textField.text.length >= 6 && textField.text.length <= 16) {
        
        if ([textField isEqual:self.againPwdTextFiled]) {
            if (![self.pwdTectFiled.text isEqualToString:self.againPwdTextFiled.text] && self.pwdTectFiled.text.length > 0 && self.againPwdTextFiled.text.length > 0) {
                UIAlertController *alert = [UIAlertController alertControllerWithTitle:NSLocalizedString(@"Prompt", nil) message:NSLocalizedString(@"PwdTwiceDifferentRe-enter", nil) preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction *rightAtcion = [UIAlertAction actionWithTitle:NSLocalizedString(@"Right", nil) style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    self.pwdTectFiled.text = nil;
                    self.againPwdTextFiled.text = nil;
                }];
                [alert addAction:rightAtcion];
                
                [self presentViewController:alert animated:YES completion:nil];
            }
        }
        
    } else {
        UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:NSLocalizedString(@"Prompt", nil) message:NSLocalizedString(@"PwdFormat", nil) preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *rightAtcion = [UIAlertAction actionWithTitle:@"好的" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            textField.text = nil;
        }];
        [alertVC addAction:rightAtcion];
        [self presentViewController:alertVC animated:YES completion:nil];
    }
    
    
}

#pragma mark - 提交点击事件
- (void)submitBtnAtcion{
    
    
    if (self.pwdTectFiled.text.length >= 6 && self.againPwdTextFiled.text.length >= 6 && self.pwdTectFiled.text.length <= 16 && self.againPwdTextFiled.text.length <= 16) {
        
        
        if ([self.pwdTectFiled.text isEqualToString:self.againPwdTextFiled.text]) {
            NSDictionary *parameters = @{@"user.phone":self.phoneNumber , @"user.password" : self.againPwdTextFiled.text};
            
            [HelpFunction requestDataWithUrlString:kDuanXinTiJiao andParames:parameters andDelegate:self];
            
        } else {
           
            [UIAlertController creatRightAlertControllerWithHandle:nil andSuperViewController:self Title:@"您两次输入的密码不相同，请重新输入"];
        }
    } else {
        UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"提示" message:@"密码长度必须大于6位并小于16位" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *rightAtcion = [UIAlertAction actionWithTitle:@"好的" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            self.pwdTectFiled.text = nil;
            self.againPwdTextFiled.text = nil;
        }];
        [alertVC addAction:rightAtcion];
        [self presentViewController:alertVC animated:YES completion:nil];
    }
}

- (void)requestData:(HelpFunction *)request didSuccess:(NSDictionary *)dddd {
    NSInteger state = [dddd[@"state"] integerValue];
    
    NSLog(@"%@" , dddd);
    if (state == 0) {
        
        NSDictionary *user = dddd[@"data"];
        
        [kStanderDefault setObject:user[@"sn"] forKey:@"userSn"];
        [kStanderDefault setObject:user[@"id"] forKey:@"userId"];
        
        UserModel *userModel = [[UserModel alloc]init];
        for (NSString *key in [user allKeys]) {
            [userModel setValue:user[key] forKey:key];
        }
        
        SuccessReviseViewController *successVC = [[SuccessReviseViewController alloc]init];
        successVC.phoneNumber = [NSString stringWithString:self.phoneNumber];
        successVC.pwd = self.againPwdTextFiled.text;
        successVC.userModel = userModel;
        [self.navigationController pushViewController:successVC animated:YES];
    } else if (state == 1) {
        
        [UIAlertController creatRightAlertControllerWithHandle:nil andSuperViewController:self Title:@"密码输入为空"];
    } else {
        [UIAlertController creatRightAlertControllerWithHandle:nil andSuperViewController:self Title:@"系统异常，请重试"];
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
    } else if (textField == self.againPwdTextFiled) {
        _xiaHuaXian1.backgroundColor = [UIColor grayColor];
        _xiaHuaXian2.backgroundColor = kMainColor;
    }
}



@end
