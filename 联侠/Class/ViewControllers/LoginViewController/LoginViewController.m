//
//  LoginViewController.m
//  AEFT冷风扇
//
//  Created by 杭州阿尔法特 on 16/3/8.
//  Copyright © 2016年 阿尔法特. All rights reserved.
//

#import "LoginViewController.h"
#import "RegisterViewController.h"
#import "ForgetPwdViewController.h"
#import "TabBarViewController.h"

#define NUMBERS @"0123456789"

#define kStandardW kScreenW / 1.47

@interface LoginViewController ()<UITextFieldDelegate  , HelpFunctionDelegate>

@property (nonatomic , strong) UITextField *pwdTectFiled;
@property (nonatomic , strong) UITextField *acctextFiled;

@property (nonatomic , strong) UIButton *loginBtn;

@property (nonatomic , strong) UIView *xiaHuaXian1;
@property (nonatomic , strong) UIView *xiaHuaXian2;
@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self setUI];
    
    
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [SVProgressHUD dismiss];

}

#pragma mark - 设置UI界面
- (void)setUI{
    
    //创建商标
    UIImageView *shangBiaoImage = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"logo"]];
    [self.view addSubview:shangBiaoImage];
    [shangBiaoImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kScreenW / 3.5, kScreenW / 3.5));
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.top.mas_equalTo(kScreenH / 5.9 - kHeight);
    }];
    
    UIView *accFiledView = [UIView creatTextFiledWithLableText:@"账户" andTextFiledPlaceHold:NSLocalizedString(@"LoginVC_AccPlaceholder", nil) andSuperView:self.view];
    [accFiledView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(shangBiaoImage.mas_bottom).offset(kScreenH / 4.75);
        make.size.mas_equalTo(CGSizeMake(kStandardW, kScreenW / 10));
        make.centerX.mas_equalTo(self.view.mas_centerX);
    }];
    _xiaHuaXian1 = accFiledView.subviews[0];

    self.acctextFiled = accFiledView.subviews[2];
    self.acctextFiled.delegate = self;

    
    UIView *pwdFiledView = [UIView creatTextFiledWithLableText:@"密码" andTextFiledPlaceHold:NSLocalizedString(@"LoginVC_PwdPlacrholder", nil) andSuperView:self.view];
    [pwdFiledView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(accFiledView.mas_bottom).offset(kScreenH / 11);
        make.size.mas_equalTo(CGSizeMake(kStandardW, kScreenW / 10));
        make.centerX.mas_equalTo(accFiledView.mas_centerX);
    }];
    _xiaHuaXian2 = pwdFiledView.subviews[0];
    self.pwdTectFiled = pwdFiledView.subviews[2];
    self.pwdTectFiled.keyboardType = UIKeyboardTypeDefault;
    self.pwdTectFiled.delegate = self;
    self.pwdTectFiled.secureTextEntry = YES;
    
    
    self.loginBtn = [UIButton initWithTitle:NSLocalizedString(@"LoginVC_login", nil) andColor:[UIColor redColor] andSuperView:self.view];
    [self.loginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kStandardW, kScreenW / 9));
        make.centerX.mas_equalTo(accFiledView.mas_centerX);
        make.top.mas_equalTo(pwdFiledView.mas_bottom).offset(kScreenW / 7.5);
    }];
    self.loginBtn.layer.cornerRadius = kScreenW / 18;
    self.loginBtn.backgroundColor = kMainColor;
    [self.loginBtn addTarget:self action:@selector(loginBtnAction) forControlEvents:UIControlEventTouchUpInside];
    
    
    UIButton *resertBtn = [UIButton initWithTitle:NSLocalizedString(@"LoginVC_ForgetPwd", nil) andColor:[UIColor clearColor] andSuperView:self.view];
    [resertBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kStandardW / 3, kScreenW / 25));
        make.right.mas_equalTo(_loginBtn.mas_centerX).offset(-5);
        make.top.mas_equalTo(_loginBtn.mas_bottom).offset(kScreenH / 36.8);
    }];
    [resertBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [resertBtn addTarget:self action:@selector(forgetPwdBtnAction) forControlEvents:UIControlEventTouchUpInside];
    resertBtn.titleLabel.font = [UIFont systemFontOfSize:k12];
    
    UIButton *registerBtn = [UIButton initWithTitle:NSLocalizedString(@"LoginVC_Register", nil) andColor:[UIColor clearColor] andSuperView:self.view];
    //注册按钮的约束
    [registerBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kStandardW / 3, kScreenW / 25));
        make.left.mas_equalTo(_loginBtn.mas_centerX).offset(5);
        make.top.mas_equalTo(_loginBtn.mas_bottom).offset(kScreenH / 36.8);
    }];
    [registerBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [registerBtn addTarget:self action:@selector(registerBtnAction) forControlEvents:UIControlEventTouchUpInside];
    registerBtn.titleLabel.font = [UIFont systemFontOfSize:k12];
    
    UIView *fenGeView = [[UIView alloc]init];
    [self.view addSubview:fenGeView];
    fenGeView.backgroundColor = [UIColor grayColor];
    [fenGeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(1, kScreenW / 25));
        make.centerX.mas_equalTo(pwdFiledView.mas_centerX);
        make.centerY.mas_equalTo(resertBtn.mas_centerY);
    }];
    
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleCustom];
    [SVProgressHUD setBackgroundColor:[UIColor clearColor]];
    [SVProgressHUD setForegroundColor:kMainColor];
}

#pragma mark - 注册用户
- (void)registerBtnAction{

    RegisterViewController *registerVC = [[RegisterViewController alloc]init];
    registerVC.navigationItem.title = @"注册";
    [self.navigationController pushViewController:registerVC animated:YES];
}

#pragma mark - 忘记密码点击事件
- (void)forgetPwdBtnAction{
    
    ForgetPwdViewController *forgetPwdVC = [[ForgetPwdViewController alloc]init];
    forgetPwdVC.navigationItem.title = @"重置密码";
    [self.navigationController pushViewController:forgetPwdVC animated:YES];
}


#pragma mark - 登陆按钮点击事件
- (void)loginBtnAction{

    
    if ( (self.acctextFiled.text.length == 11 || self.acctextFiled.text.length == 9) && [UITextField validateNumber:self.acctextFiled.text]  && self.pwdTectFiled.text != nil) {
        
        [SVProgressHUD show];
        NSDictionary *parameters = nil;
        if ([kStanderDefault objectForKey:@"GeTuiClientId"]) {
            parameters = @{@"loginName":self.acctextFiled.text , @"password" : self.pwdTectFiled.text , @"ua.clientId" : [kStanderDefault objectForKey:@"GeTuiClientId"], @"ua.phoneType" : @(2)};
        } else {
            parameters = @{@"loginName":self.acctextFiled.text , @"password" : self.pwdTectFiled.text ,  @"ua.phoneType" : @(2)};
        }
        
        [kStanderDefault setObject:self.pwdTectFiled.text forKey:@"password"];
        [kStanderDefault setObject:self.acctextFiled.text forKey:@"phone"];

        [HelpFunction requestDataWithUrlString:kLogin andParames:parameters andDelegate:self];
    } else {
        if (self.acctextFiled.text.length == 0) {
            [self setAlertText:NSLocalizedString(@"AccEmpty", nil)];
        }
        
        if (self.pwdTectFiled.text.length == 0) {
            [self setAlertText:NSLocalizedString(@"PwdEmpty", nil)];
        }
        
        if (self.acctextFiled.text.length != 11 || self.acctextFiled.text.length != 9) {

            [UIAlertController creatRightAlertControllerWithHandle:^{
                self.acctextFiled.text = nil;
            } andSuperViewController:self Title:NSLocalizedString(@"AccountFormatInputError", nil)];
            
        }
    }
    
}

- (void)requestData:(HelpFunction *)request didSuccess:(NSDictionary *)dddd {
    [SVProgressHUD dismiss];
    NSInteger state = [dddd[@"state"] integerValue];
    
    if (state == 0) {
        [self setAlertText:NSLocalizedString(@"UserNoRegistered", nil)];
    } else if (state == 1) {
        [self setAlertText:NSLocalizedString(@"EnterdErrorSoReenter", nil)];
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
        
        kSocketTCP.userSn = [NSString stringWithFormat:@"%ld" , (long)userModel.sn];
        [kSocketTCP socketConnectHost];
        
        [HelpFunction requestDataWithUrlString:kQueryTheUserdevice andParames:@{@"userSn" : @(userModel.sn)} andDelegate:self];
        
    } else {
        NSInteger state = [dic[@"state"] integerValue];
        if (state == 1) {
            [self setAlertText:NSLocalizedString(@"AccOrPwdEmpty", nil)];
        } else if (state == 2) {
            [self setAlertText:NSLocalizedString(@"UserNoRegistered", nil)];
        } else {
            [self setAlertText:NSLocalizedString(@"PwdError", nil)];
        }
    }
}

- (void)requestData:(HelpFunction *)requset queryUserdevice:(NSDictionary *)dddd {
    [SVProgressHUD dismiss];
    
//    NSLog(@"%@" , dddd);
    NSInteger state = [dddd[@"state"] integerValue];
    if (state == 0) {
        if ([dddd[@"data"] isKindOfClass:[NSArray class]]) {
            NSMutableArray *dataArray = dddd[@"data"];
            if (dataArray.count > 0) {
                [kStanderDefault setObject:@"YES" forKey:@"isHaveService"];
            }
        }
        [kWindowRoot presentViewController:[[TabBarViewController alloc]init] animated:YES completion:^{
            self.acctextFiled.text = nil;
            self.pwdTectFiled.text = nil;
        }];
    }
}

- (void)requestData:(HelpFunction *)request didFailLoadData:(NSError *)error {
    NSLog(@"%@" , error);
    [SVProgressHUD dismiss];
}

#pragma mark - 点击空白处收回键盘
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}


-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    
    if (textField == self.acctextFiled) {
        _xiaHuaXian1.backgroundColor = kMainColor;
        _xiaHuaXian2.backgroundColor = [UIColor grayColor];
    } else if (textField == self.pwdTectFiled) {
        _xiaHuaXian1.backgroundColor = [UIColor grayColor];
        _xiaHuaXian2.backgroundColor = kMainColor;
    }
    
}

-(void)textFieldDidEndEditing:(UITextField *)textField
{
    
    _xiaHuaXian1.backgroundColor = [UIColor grayColor];
    _xiaHuaXian2.backgroundColor = [UIColor grayColor];
    
}

- (void)setAlertText:(NSString *)text {
    [UIAlertController creatRightAlertControllerWithHandle:nil andSuperViewController:self Title:text];
}
@end
