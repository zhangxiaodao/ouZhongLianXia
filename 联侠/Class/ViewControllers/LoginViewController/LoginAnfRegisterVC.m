//
//  LoginAnfRegisterVC.m
//  联侠
//
//  Created by 杭州阿尔法特 on 2017/9/4.
//  Copyright © 2017年 张海昌. All rights reserved.
//

#import "LoginAnfRegisterVC.h"
#import "AlertMessageView.h"
#import "PZXVerificationCodeView.h"
#import "TabBarViewController.h"
#import "ForgetPwdViewController.h"
#import "RegisterViewController.h"

#define NUMBERS @"0123456789"

#define kStandardW kScreenW / 1.47

@interface LoginAnfRegisterVC ()<UITextFieldDelegate>
@property (nonatomic , strong) UIView *markView;
@property (nonatomic , strong) UIView *pwdFiledView;
@property (nonatomic , strong) UIView *accFiledView;
@property (nonatomic , strong) UITextField *acctextFiled;
@property (nonatomic , strong) UITextField *pwdTectFiled;
@property (nonatomic , strong) UIButton *loginBtn;
@property (nonatomic , strong) UIButton *changeBtn;
@property (nonatomic , strong) UIButton *resertBtn;
@property (nonatomic , strong) UIButton *registerBtn;

@property (nonatomic , strong) AlertMessageView *alertMessageView;
@end

@implementation LoginAnfRegisterVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self setUI];
    [self setOther];
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setHidden:YES];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.navigationController.navigationBar setHidden:NO];
    [SVProgressHUD dismiss];
}

- (void)updateViewConstraints {
    [self.loginBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kStandardW, kScreenW / 9));
        make.centerX
        .mas_equalTo(self.accFiledView.mas_centerX);
        if (self.changeBtn.selected) {
            make.top
            .mas_equalTo(self.acctextFiled.mas_bottom)
            .offset(kScreenW / 16);
        } else {
            make.top
            .mas_equalTo(self.pwdFiledView.mas_bottom)
            .offset(kScreenW / 16);
        }
    }];
    
    [self.resertBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(_loginBtn.mas_centerX)
        .offset(-5);
        make.top.mas_equalTo(_loginBtn.mas_bottom)
        .offset(kScreenH / 36.8);
    }];
    
    [self.registerBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_loginBtn.mas_centerX)
        .offset(5);
        make.top.mas_equalTo(_loginBtn.mas_bottom)
        .offset(kScreenH / 36.8);
    }];
    
    [super updateViewConstraints];
}

#pragma mark - 设置UI界面
- (void)setUI{
    
    UIImageView *loginBackImage = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"loginBackImage"]];
    [self.view addSubview:loginBackImage];
    loginBackImage.frame = self.view.bounds;
    
    
    UIImageView *shangBiaoImage = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"logo"]];
    [self.view addSubview:shangBiaoImage];
    [shangBiaoImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kScreenW / 4.5, kScreenW / 4.5));
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.top.mas_equalTo(kNavibarH);
    }];
    
    
    UILabel *titleLabel = [UILabel creatLableWithTitle:@"联侠" andSuperView:self.view andFont:k20 andTextAligment:NSTextAlignmentCenter];
    titleLabel.textColor = kCOLOR(14, 106, 121);
    titleLabel.layer.borderWidth = 0;
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.top.mas_equalTo(shangBiaoImage.mas_bottom)
        .offset(kScreenW / 30);
    }];
    
    UILabel *lianXiaLabel = [UILabel creatLableWithTitle:@"L   I   A   N   X   I   A" andSuperView:self.view andFont:k12 andTextAligment:NSTextAlignmentCenter];
    lianXiaLabel.textColor = kCOLOR(14, 106, 121);
    [lianXiaLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.top.mas_equalTo(titleLabel.mas_bottom);
    }];
    
    UIView *accFiledView = [UIView creatTextFiledWithLableText:@"账户" andTextFiledPlaceHold:NSLocalizedString(@"LoginVC_AccPlaceholder", nil) andSuperView:self.view];
    [accFiledView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(lianXiaLabel.mas_bottom)
        .offset(kScreenW / 2.67);
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(kStandardW, kScreenW / 10));
    }];
    self.acctextFiled = accFiledView.subviews[2];
    self.accFiledView = accFiledView;
    
    UIView *pwdFiledView = [UIView creatTextFiledWithLableText:@"密码" andTextFiledPlaceHold:NSLocalizedString(@"LoginVC_PwdPlacrholder", nil) andSuperView:self.view];
    [pwdFiledView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(accFiledView.mas_bottom)
        .offset(kScreenH / 11);
        make.size.mas_equalTo(CGSizeMake(kStandardW, kScreenW / 10));
        make.centerX.mas_equalTo(accFiledView.mas_centerX);
    }];
    self.pwdTectFiled = pwdFiledView.subviews[2];
    self.pwdTectFiled.keyboardType = UIKeyboardTypeDefault;
    self.pwdTectFiled.delegate = self;
    self.pwdTectFiled.secureTextEntry = YES;
    self.pwdFiledView = pwdFiledView;
    pwdFiledView.hidden = YES;
    
    UIButton *loginBtn = [UIButton initWithTitle:NSLocalizedString(@"LoginVC_login", nil) andColor:[UIColor clearColor] andSuperView:self.view];
    loginBtn.layer.cornerRadius = kScreenW / 18;
    loginBtn.backgroundColor = kMainColor;
    [loginBtn addTarget:self action:@selector(loginBtnAction) forControlEvents:UIControlEventTouchUpInside];
    self.loginBtn = loginBtn;
    
    UIButton *resertBtn = [UIButton initWithTitle:NSLocalizedString(@"LoginVC_ForgetPwd", nil) andColor:[UIColor clearColor] andSuperView:self.view];
    [resertBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [resertBtn addTarget:self action:@selector(forgetPwdBtnAction) forControlEvents:UIControlEventTouchUpInside];
    resertBtn.titleLabel.font = [UIFont systemFontOfSize:k12];
    self.resertBtn = resertBtn;
    resertBtn.hidden = YES;
    
    UIButton *registerBtn = [UIButton initWithTitle:NSLocalizedString(@"LoginVC_Register", nil) andColor:[UIColor clearColor] andSuperView:self.view];
    [registerBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [registerBtn addTarget:self action:@selector(registerBtnAction) forControlEvents:UIControlEventTouchUpInside];
    registerBtn.titleLabel.font = [UIFont systemFontOfSize:k12];
    self.registerBtn = registerBtn;
    registerBtn.hidden = YES;
    
    UILabel *messageLabel = [UILabel creatLableWithTitle:@"开启你的云端智能生活" andSuperView:self.view andFont:k15 andTextAligment:NSTextAlignmentCenter];
    messageLabel.textColor = kCOLOR(14, 106, 121);
    [messageLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.bottom.mas_equalTo(self.view.mas_bottom).offset(-kNavibarH);
    }];
    
    UILabel *englishMessageLabel = [UILabel creatLableWithTitle:@"Open your intelligent life in the cloud" andSuperView:self.view andFont:k12 andTextAligment:NSTextAlignmentCenter];
    englishMessageLabel.textColor = kCOLOR(14, 106, 121);
    [englishMessageLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.top.mas_equalTo(messageLabel.mas_bottom);
    }];
    
    UIButton *changeBtn = [UIButton initWithTitle:@"账号密码登录" andColor:[UIColor clearColor] andSuperView:self.view];
    [changeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(pwdFiledView.mas_centerX);
        make.bottom.mas_equalTo(messageLabel.mas_top)
        ;
    }];
    [changeBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    changeBtn.titleLabel.font = [UIFont systemFontOfSize:k20];
    [changeBtn addTarget:self action:@selector(changeBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    self.changeBtn = changeBtn;
    changeBtn.selected = YES;
    
}

- (void)setOther {
    [kStanderDefault removeObjectForKey:@"GeRenInfo"];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(whetherGegisterSuccess:) name:@"RegisterSuccess" object:nil];
}

- (void)setMarkView {
    self.markView = [[UIView alloc]initWithFrame:kScreenFrame];
    [self.view addSubview:self.markView];
    //模糊效果
    UIBlurEffect *light = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
    UIVisualEffectView *bgView = [[UIVisualEffectView alloc]initWithEffect:light];
    bgView.frame = self.markView.bounds;
    [self.markView addSubview:bgView];
    self.markView.alpha = 0;
    
    self.alertMessageView = [[AlertMessageView alloc]initWithFrame:CGRectMake((kScreenW - kScreenW / 1.4) / 2, (kScreenH - kScreenH / 2.66) / 2, kScreenW / 1.4, kScreenH / 2.66) TitleText:NSLocalizedString(@"EnterVertionCode", nil) andBtnTarget:self andCancleAtcion:@selector(cancleAtcion)];
    [self.view addSubview:self.alertMessageView];
    
    self.alertMessageView.alpha = 0;
}


- (void)whetherGegisterSuccess:(NSNotification *)post {
    NSString *vercodeStr = post.userInfo[@"VercodeStr"];
    NSString *success = post.userInfo[@"RegisterSuccess"];
    if ([success isEqualToString:@"YES"]) {
        
        NSMutableDictionary *parameters = [NSMutableDictionary dictionaryWithDictionary:@{@"loginName":self.acctextFiled.text , @"code" : vercodeStr ,@"ua.phoneType" : @(2), @"ua.phoneBrand":@"iPhone" , @"ua.phoneModel":[NSString getDeviceName] , @"ua.phoneSystem":[NSString getDeviceSystemVersion]}];
        if ([kStanderDefault objectForKey:@"GeTuiClientId"]) {
            [parameters setObject:[kStanderDefault objectForKey:@"GeTuiClientId"] forKey:@"ua.clientId"];
        }
        
        [kStanderDefault setObject:self.acctextFiled.text forKey:@"phone"];

        [kNetWork requestPOSTUrlString:kLoginWithRegisterURL parameters:parameters isSuccess:^(NSDictionary * _Nullable responseObject) {
            NSDictionary *dic = responseObject;
            NSInteger state = [dic[@"state"] integerValue];
            
            if (state == 0) {
                [self cancleAtcion];
                NSDictionary *user = dic[@"data"];
                
                [kStanderDefault setObject:user[@"sn"] forKey:@"userSn"];
                [kStanderDefault setObject:user[@"id"] forKey:@"userId"];
                
                [kWindowRoot presentViewController:[[TabBarViewController alloc]init] animated:YES completion:^{
                    self.acctextFiled.text = nil;
                }];
            } else {
                [UIAlertController creatCancleAndRightAlertControllerWithHandle:^{
                    [self.alertMessageView clearNumber];
                } andSuperViewController:self Title:@"验证码填写错误"];
            }
        } failure:nil];
    }
}

#pragma mark - 登录按钮点击事件
- (void)loginBtnAction{
    if (self.changeBtn.selected) {
        [self verificationCodeLogin];
    } else {
        [self accountPwfLogin];
    }
}
#pragma mark - 验证码登录
- (void)verificationCodeLogin {
    
    if (self.acctextFiled.text.length == 11) {
        
        [self setMarkView];
        
        self.alertMessageView.phoneNumber = self.acctextFiled.text;
        
        [UIView animateWithDuration:.3 animations:^{
            self.markView.alpha = .8;
            self.alertMessageView.alpha = 1;
            
        }];
        
        PZXVerificationCodeView *pzxView = [self.alertMessageView viewWithTag:10003];
        UITextField *firstTf = [pzxView viewWithTag:100];
        [firstTf becomeFirstResponder];
        
        CGRect frame = self.alertMessageView.frame;
        int offset = frame.origin.y + frame.size.height - (kScreenH - (216+36)) + kScreenW / 10;
        
        NSTimeInterval animationDuration = 0.30f;
        [UIView beginAnimations:@"ResizeForKeyboard" context:nil];
        [UIView setAnimationDuration:animationDuration];
        
        if(offset > 0)
        {
            self.alertMessageView.frame = CGRectMake((kScreenW - kScreenW / 1.4) / 2, (kScreenH - kScreenW / 1.5) / 2 - offset, kScreenW / 1.4, kScreenW / 1.5);
            
        }
        
        [UIView commitAnimations];
    } else {
        [UIAlertController creatRightAlertControllerWithHandle:nil andSuperViewController:self Title:@"请输入正确账号"];
    }
}

#pragma mark - 账号密码登录
- (void)accountPwfLogin {
    if ( (self.acctextFiled.text.length == 11 || self.acctextFiled.text.length == 9) && (self.pwdTectFiled.text.length >= 6 && self.pwdTectFiled.text.length <= 16)) {
        
        [SVProgressHUD show];
        NSDictionary *parameters = nil;
        if ([kStanderDefault objectForKey:@"GeTuiClientId"]) {
            parameters = @{@"loginName":self.acctextFiled.text , @"password" : self.pwdTectFiled.text , @"ua.clientId" : [kStanderDefault objectForKey:@"GeTuiClientId"], @"ua.phoneType" : @(2), @"ua.phoneBrand":@"iPhone" , @"ua.phoneModel":[NSString getDeviceName] , @"ua.phoneSystem":[NSString getDeviceSystemVersion]};
        } else {
            parameters = @{@"loginName":self.acctextFiled.text , @"password" : self.pwdTectFiled.text ,  @"ua.phoneType" : @(2), @"ua.phoneBrand":@"iPhone" , @"ua.phoneModel":[NSString getDeviceName] , @"ua.phoneSystem":[NSString getDeviceSystemVersion]};
        }
        
        [kStanderDefault setObject:self.pwdTectFiled.text forKey:@"password"];
        [kStanderDefault setObject:self.acctextFiled.text forKey:@"phone"];
        
        [kNetWork requestPOSTUrlString:kLogin parameters:parameters isSuccess:^(NSDictionary * _Nullable responseObject) {
            
            NSDictionary *dic = responseObject;
            NSInteger state = [dic[@"state"] integerValue];
            if (state == 0) {
                NSDictionary *user = dic[@"data"];
                
                [kStanderDefault setObject:user[@"sn"] forKey:@"userSn"];
                [kStanderDefault setObject:user[@"id"] forKey:@"userId"];
                
                [kWindowRoot presentViewController:[[TabBarViewController alloc]init] animated:YES completion:^{
                    self.acctextFiled.text = nil;
                    self.pwdTectFiled.text = nil;
                }];
            } else {
                [self setAlertText:@"验证码填写错误"];
            }
        } failure:nil];
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

#pragma mark - 密码登录和验证码登陆切换
- (void)changeBtnAction:(UIButton *)btn {
    
    btn.selected = !btn.selected;
    if (btn.selected) {
        self.pwdFiledView.hidden = YES;
        self.resertBtn.hidden = YES;
        self.registerBtn.hidden = YES;
        
        [btn setTitle:@"账户密码登录" forState:UIControlStateNormal];
        [self.loginBtn setTitle:@"登录 / 注册" forState:UIControlStateNormal];
    } else {
        self.pwdFiledView.hidden = NO;
        self.resertBtn.hidden = NO;
        self.registerBtn.hidden = NO;
        [btn setTitle:@"验证码登录" forState:UIControlStateNormal];
        [self.loginBtn setTitle:@"登录" forState:UIControlStateNormal];
    }
    [self.view setNeedsUpdateConstraints];
    [self.view updateConstraintsIfNeeded];
    
    [UIView animateWithDuration:0.3 animations:^{
        [self.view layoutIfNeeded];
    }];
    
}

#pragma mark - 忘记密码
- (void)forgetPwdBtnAction {
    ForgetPwdViewController *forgetPwdVC = [[ForgetPwdViewController alloc]init];
    forgetPwdVC.navigationItem.title = @"重置密码";
    [self.navigationController pushViewController:forgetPwdVC animated:YES];
}
#pragma mark - 注册账户
- (void)registerBtnAction {
    RegisterViewController *registerVC = [[RegisterViewController alloc]init];
    registerVC.navigationItem.title = @"注册";
    [self.navigationController pushViewController:registerVC animated:YES];
}

- (void)cancleAtcion {
    [self.alertMessageView clearNumber];
    [UIView animateWithDuration:.3 animations:^{
        self.markView.alpha = 0;
        self.alertMessageView.alpha = 0;
    }];
    
    [self.markView removeFromSuperview];
    [self.alertMessageView removeFromSuperview];
    [self.view endEditing:YES];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

- (void)setAlertText:(NSString *)text {
    [UIAlertController creatRightAlertControllerWithHandle:nil andSuperViewController:self Title:text];
}

@end
