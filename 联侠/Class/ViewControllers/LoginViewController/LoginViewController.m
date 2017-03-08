//
//  LoginViewController.m
//  AEFT冷风扇
//
//  Created by 杭州阿尔法特 on 16/3/8.
//  Copyright © 2016年 阿尔法特. All rights reserved.
//

#import "LoginViewController.h"
#import "ForgetPwdViewController.h"
#import "RegisterViewController.h"
#import "MainViewController.h"
#import "AddSViewController.h"

#import "GCDAsyncSocket.h"
#import "ServicesModel.h"
#import "MineSerivesViewController.h"

#import "CCLocationManager.h"
#import "TabBarViewController.h"


#define NUMBERS @"0123456789"

#define kStandardW kScreenW / 1.47

@interface LoginViewController ()<UITextFieldDelegate  , HelpFunctionDelegate  ,CCLocationManagerZHCDelegate>

@property (nonatomic , strong) UITextField *pwdTectFiled;
@property (nonatomic , strong) UITextField *acctextFiled;
@property (nonatomic , assign)  NSInteger success;

@property (nonatomic , strong) NSString *message;
@property (nonatomic , strong) UIButton *loginBtn;
@property (nonatomic , strong) UIView *navView;

@property (nonatomic , strong) UIView *xiaHuaXian1;
@property (nonatomic , strong) UIView *xiaHuaXian2;
@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.shadowImage = [[UIImage alloc] init];
    
    self.navigationController.navigationBarHidden = YES;
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.navView = [UIView creatNavView:self.view WithTarget:self action:@selector(backTap:)  andTitle:@"登陆"];
    UIView *backView = [[UIView alloc]init];
    backView = [_navView.subviews objectAtIndex:0];

    UIImageView *iiii = [backView.subviews objectAtIndex:1];
    iiii.image = [UIImage new];
    
    [self cityAndProvience];
    [self setUI];
    
}


#pragma mark - 请求天气参数
- (void)cityAndProvience {
    [[CCLocationManager shareLocation] getNowCityNameAndProvienceName:self];
}

- (void)getCityNameAndProvience:(NSArray *)address {
    NSLog(@"%@" , address);
}

#pragma mark - 返回主界面
- (void)backTap:(UITapGestureRecognizer *)tap {

}

#pragma mark - 设置UI界面
- (void)setUI{
    
    //创建商标
    UIImageView *shangBiaoImage = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"logo"]];
    [self.view addSubview:shangBiaoImage];
    [shangBiaoImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kScreenW / 3.5, kScreenW / 3.5));
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.top.mas_equalTo(kScreenH / 7);
    }];
    
    UIView *xiaHuaXian = [[UIView alloc]init];
    [self.view addSubview:xiaHuaXian];
    xiaHuaXian.backgroundColor = [UIColor grayColor];
    [xiaHuaXian mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kStandardW, 1));
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.top.mas_equalTo(self.view.mas_top).offset(kScreenH / 2.08);
    }];
    _xiaHuaXian1 = xiaHuaXian;
    
    self.acctextFiled = [UITextField creatTextfiledWithPlaceHolder:@"请输入您的手机号码或ID账号" andSuperView:self.view];
    self.acctextFiled.delegate = self;
    [self.acctextFiled mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(xiaHuaXian.mas_top);
        make.size.mas_equalTo(CGSizeMake(kStandardW, kScreenW / 10));
        make.centerX.mas_equalTo(xiaHuaXian.mas_centerX);
    }];
    
    UIView *xiaHuaXian2 = [[UIView alloc]init];
    [self.view addSubview:xiaHuaXian2];
    xiaHuaXian2.backgroundColor = [UIColor grayColor];
    [xiaHuaXian2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kStandardW, 1));
        make.centerX.mas_equalTo(xiaHuaXian.mas_centerX);
        make.bottom.mas_equalTo(xiaHuaXian.mas_bottom).offset(kScreenH / 11);
    }];
    _xiaHuaXian2 = xiaHuaXian2;
    
    self.pwdTectFiled = [UITextField creatTextfiledWithPlaceHolder:@"请输入密码" andSuperView:self.view];
    self.pwdTectFiled.keyboardType = UIKeyboardTypeDefault;
    [self.pwdTectFiled mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(xiaHuaXian2.mas_top);
        make.size.mas_equalTo(CGSizeMake(kStandardW, kScreenW / 10));
        make.centerX.mas_equalTo(xiaHuaXian.mas_centerX);
    }];
    self.pwdTectFiled.delegate = self;
    self.pwdTectFiled.secureTextEntry = YES;
    
    //创建注册按钮
    self.loginBtn = [UIButton initWithTitle:@"登陆" andColor:[UIColor redColor] andSuperView:self.view];
    self.loginBtn.layer.cornerRadius = kScreenW / 18;
    
    
    self.loginBtn.backgroundColor = kMainColor;
    
    [self.loginBtn addTarget:self action:@selector(loginBtnAction) forControlEvents:UIControlEventTouchUpInside];
    //注册按钮的约束
    [self.loginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kStandardW, kScreenW / 9));
        make.centerX.mas_equalTo(xiaHuaXian.mas_centerX);
        make.top.mas_equalTo(xiaHuaXian2.mas_bottom).offset(kScreenH / 8);
    }];
    
    
    UIButton *registerBtn = [UIButton initWithTitle:@"立即注册" andColor:[UIColor clearColor] andSuperView:self.view];
    [registerBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [registerBtn addTarget:self action:@selector(registerBtnAction) forControlEvents:UIControlEventTouchUpInside];
    //注册按钮的约束
    [registerBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kStandardW / 4, kScreenW / 25));
        make.right.mas_equalTo(_loginBtn.mas_right);
        make.top.mas_equalTo(_loginBtn.mas_bottom).offset(kScreenH / 36.8);
    }];
    
    UIButton *resertBtn = [UIButton initWithTitle:@"忘记密码" andColor:[UIColor clearColor] andSuperView:self.view];
    [resertBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [resertBtn addTarget:self action:@selector(forgetPwdBtnAction) forControlEvents:UIControlEventTouchUpInside];
    //注册按钮的约束
    [resertBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kStandardW / 4, kScreenW / 25));
        make.left.mas_equalTo(_loginBtn.mas_left);
        make.top.mas_equalTo(_loginBtn.mas_bottom).offset(kScreenH / 36.8);
    }];

    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleCustom];
    [SVProgressHUD setBackgroundColor:[UIColor clearColor]];
    [SVProgressHUD setForegroundColor:kMainColor];
}

#pragma mark - 注册用户
- (void)registerBtnAction{

    RegisterViewController *registerVC = [[RegisterViewController alloc]init];
    [self.navigationController pushViewController:registerVC animated:YES];
}

#pragma mark - 忘记密码点击事件
- (void)forgetPwdBtnAction{
    
    ForgetPwdViewController *forgetPwdVC = [[ForgetPwdViewController alloc]init];

    [self.navigationController pushViewController:forgetPwdVC animated:YES];
}


#pragma mark - 登陆按钮点击事件
- (void)loginBtnAction{

    
    if ( (self.acctextFiled.text.length == 11 || self.acctextFiled.text.length == 9) && [UITextField validateNumber:self.acctextFiled.text]  && self.pwdTectFiled.text != nil) {
        
        [SVProgressHUD show];
        NSDictionary *parameters = @{@"loginName":self.acctextFiled.text , @"password" : self.pwdTectFiled.text , @"ua.clientId" : [kStanderDefault objectForKey:@"GeTuiClientId"], @"ua.phoneType" : @(2)};
        [kStanderDefault setObject:self.pwdTectFiled.text forKey:@"password"];
        [kStanderDefault setObject:self.acctextFiled.text forKey:@"phone"];

        [HelpFunction requestDataWithUrlString:kLogin andParames:parameters andDelegate:self];
    } else {
        if (self.acctextFiled.text.length == 0) {
            [self setAlertText:@"账号输入为空"];
        }
        
        if (self.pwdTectFiled.text.length == 0) {
            [self setAlertText:@"密码为空"];
        }
        
        if (self.acctextFiled.text.length != 11 || self.acctextFiled.text.length != 9) {

            [UIAlertController creatRightAlertControllerWithHandle:^{
                self.acctextFiled.text = nil;
            } andSuperViewController:self Title:@"账号格式输入错误"];
            
        }
    }
    
}

- (void)requestData:(HelpFunction *)request didSuccess:(NSDictionary *)dddd {
    [SVProgressHUD dismiss];
    NSInteger state = [dddd[@"state"] integerValue];
    
    if (state == 0) {
        [self setAlertText:@"用户未注册"];
    } else if (state == 1) {
        [self setAlertText:@"您输入的有误，请重新输入"];
    }
}

#pragma mark - 登陆的数据
- (void)requestData:(HelpFunction *)request didFinishLoadingDtaArray:(NSMutableArray *)data {
    [SVProgressHUD dismiss];
    
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
        [kSocketTCP socketConnectHost];
        
        [HelpFunction requestDataWithUrlString:kQueryTheUserdevice andParames:@{@"userSn" : @(userModel.sn)} andDelegate:self];
        
    } else {
        NSInteger state = [dic[@"state"] integerValue];
        if (state == 1) {
            [self setAlertText:@"账号或密码为空"];
        } else if (state == 2) {
            [self setAlertText:@"用户不存在"];
        } else {
            [self setAlertText:@"密码错误"];
        }
    }
}

- (void)requestData:(HelpFunction *)requset queryUserdevice:(NSDictionary *)dddd {
    [SVProgressHUD dismiss];
    
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
//                myMachineVC.tabBarController.tabBar.hidden = NO;
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
    if (textField == self.acctextFiled) {
        _xiaHuaXian1.backgroundColor = kMainColor;
        _xiaHuaXian2.backgroundColor = [UIColor grayColor];
    } else if (textField == self.pwdTectFiled) {
        _xiaHuaXian1.backgroundColor = [UIColor grayColor];
        _xiaHuaXian2.backgroundColor = kMainColor;
    }
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    _xiaHuaXian1.backgroundColor = [UIColor grayColor];
    _xiaHuaXian2.backgroundColor = [UIColor grayColor];
}

- (void)setAlertText:(NSString *)text {
    [UIAlertController creatRightAlertControllerWithHandle:nil andSuperViewController:self Title:text];
}
@end
