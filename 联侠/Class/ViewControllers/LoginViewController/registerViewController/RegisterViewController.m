//
//  RegisterViewController.m
//  AEFT冷风扇
//
//  Created by 杭州阿尔法特 on 16/3/8.
//  Copyright © 2016年 阿尔法特. All rights reserved.
//

#import "RegisterViewController.h"
#import "MessageViewController.h"
#import "YinSiViewController.h"
#import "XieYiNeiRongViewController.h"
#import "AuthcodeView.h"
#import "LoginViewController.h"
#import "AlertMessageView.h"
#import "PZXVerificationCodeView.h"

@interface RegisterViewController ()<UITextFieldDelegate , HelpFunctionDelegate>
@property (nonatomic , retain) UITextField *accTectFiled;
@property (nonatomic , retain) UITextField *pwdTectFiled;
@property (nonatomic , retain) UITextField *verificationCodeTectFiled;
@property (nonatomic , strong) AuthcodeView *authView;
@property (nonatomic , assign) BOOL isOrRegister;
@property (nonatomic , assign) NSInteger success;
@property (nonatomic , strong) UIView *navView;
//手机
@property (nonatomic, assign)BOOL phoneRight;

@property (nonatomic , strong) UIView *markView;

@property (nonatomic , strong) UIView *xiaHuaXian1;
@property (nonatomic , strong) UIView *xiaHuaXian2;
@property (nonatomic , strong) UIView *xiaHuaXian3;

@property (nonatomic , strong) AlertMessageView *alertMessageView;
@end

@implementation RegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.navView = [UIView creatNavView:self.view WithTarget:self action:@selector(backTap:) andTitle:@"注册"];
    
    [self setUI];
}
#pragma mark - 返回主界面
- (void)backTap:(UITapGestureRecognizer *)tap {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)requestServicesData:(HelpFunction *)request didOK:(NSDictionary *)dic {
    NSInteger state = [dic[@"state"] integerValue];
    
    if (state == 0) {
        
        NSDictionary *user = dic[@"data"];
        
        [kStanderDefault setObject:user[@"sn"] forKey:@"userSn"];
        [kStanderDefault setObject:user[@"id"] forKey:@"userId"];
        [UIAlertController creatRightAlertControllerWithHandle:^{
            [self.navigationController popViewControllerAnimated:YES];
        } andSuperViewController:self Title:@"恭喜您，注册成功"];
    }
}


- (void)whetherGegisterSuccess:(NSNotification *)post {
    NSString *success = post.userInfo[@"RegisterSuccess"];
//    NSLog(@"%@" , success);
    if ([success isEqualToString:@"YES"]) {
        
        [self cancleAtcion];
        
        NSDictionary *parameters = @{@"user.phone":self.accTectFiled.text , @"user.password" : self.pwdTectFiled.text};
        
        [HelpFunction requestDataWithUrlString:kDuanXinTiJiao andParames:parameters andDelegate:self];
    }
}

#pragma mark - 设置UI
- (void)setUI{
    
    [kStanderDefault removeObjectForKey:@"shiJian"];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(whetherGegisterSuccess:) name:@"RegisterSuccess" object:nil];
    
    UIView *xiaHuaXian = [[UIView alloc]init];
    [self.view addSubview:xiaHuaXian];
    xiaHuaXian.backgroundColor = [UIColor grayColor];
    [xiaHuaXian mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kStandardW, 1));
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.top.mas_equalTo(self.view.mas_top).offset(kScreenH/4.2);
    }];
    
    self.accTectFiled = [UITextField creatTextfiledWithPlaceHolder:@"请输入您的手机号码" andSuperView:self.view];
    self.accTectFiled.delegate = self;
    [self.accTectFiled mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(xiaHuaXian.mas_top);
        make.size.mas_equalTo(CGSizeMake(kStandardW, kScreenW / 12));
        make.centerX.mas_equalTo(xiaHuaXian.mas_centerX);
    }];
    
    UIView *xiaHuaXian2 = [[UIView alloc]init];
    [self.view addSubview:xiaHuaXian2];
    xiaHuaXian2.backgroundColor = [UIColor grayColor];
    [xiaHuaXian2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kStandardW, 1));
        make.centerX.mas_equalTo(xiaHuaXian.mas_centerX);
        make.top.mas_equalTo(xiaHuaXian.mas_bottom).offset(kScreenH/8.8674);
    }];
    
    self.pwdTectFiled = [UITextField creatTextfiledWithPlaceHolder:@"请输入密码" andSuperView:self.view];
    self.pwdTectFiled.delegate = self;
    [self.pwdTectFiled mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(xiaHuaXian2.mas_top);
        make.size.mas_equalTo(CGSizeMake(kStandardW, kScreenW / 12));
        make.centerX.mas_equalTo(xiaHuaXian2.mas_centerX);
    }];
    self.pwdTectFiled.keyboardType = UIKeyboardTypeDefault;
    
    UIView *xiaHuaXian3 = [[UIView alloc]init];
    [self.view addSubview:xiaHuaXian3];
    xiaHuaXian3.backgroundColor = [UIColor grayColor];
    [xiaHuaXian3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kStandardW, 1));
        make.centerX.mas_equalTo(xiaHuaXian.mas_centerX);
        make.top.mas_equalTo(xiaHuaXian2.mas_bottom).offset(kScreenH/8.8674);
    }];
    
    self.verificationCodeTectFiled = [UITextField creatTextfiledWithPlaceHolder:@"请输入验证码" andSuperView:self.view];
    [self.verificationCodeTectFiled mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(xiaHuaXian3.mas_top);
        make.size.mas_equalTo(CGSizeMake(kStandardW / 2, kScreenW / 12));
        make.left.mas_equalTo(xiaHuaXian3.mas_left);
    }];
    self.verificationCodeTectFiled.delegate = self;
    
    
    self.authView = [[AuthcodeView alloc]init];
    [self.view addSubview:self.authView];
    [self.authView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kStandardW / 3, kScreenW / 10));
        make.bottom.mas_equalTo(xiaHuaXian3.mas_bottom).offset(-5);
        make.right.mas_equalTo(xiaHuaXian3.mas_right);
    }];
    
    
    //创建注册按钮
    UIButton *registerBtn = [UIButton initWithTitle:@"立即注册" andColor:[UIColor redColor] andSuperView:self.view];
    [registerBtn addTarget:self action:@selector(registerAction1) forControlEvents:UIControlEventTouchUpInside];
    registerBtn.layer.cornerRadius = kScreenW / 18;
    
    registerBtn.backgroundColor = kMainColor;
    [registerBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kStandardW, kScreenW / 9));
        make.centerX.mas_equalTo(xiaHuaXian.mas_centerX);
        make.top.mas_equalTo(xiaHuaXian3.mas_bottom).offset(kScreenH / 6.53);
    }];
    
    UILabel *changLable = [UILabel creatLableWithTitle:@"点击“立即注册”，即表示你同意遵守欧众" andSuperView:self.view andFont:k14 andTextAligment:NSTextAlignmentCenter];
    changLable.textColor = [UIColor grayColor];
    changLable.layer.borderWidth = 0;
    [changLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kStandardW, kScreenW / 14));
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.top.mas_equalTo(registerBtn.mas_bottom).offset(kScreenH / 6.93);
    }];
    
    UILabel *heLable = [UILabel creatLableWithTitle:@"和" andSuperView:self.view andFont:k14 andTextAligment:NSTextAlignmentCenter];
    heLable.layer.borderWidth = 0;
    heLable.textColor = [UIColor grayColor];
    [heLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kScreenW / 20, kScreenW / 13));
        make.centerX.mas_equalTo(changLable.mas_centerX);
        make.top.mas_equalTo(changLable.mas_bottom);
    }];
    
    
    UILabel *xieYiLable = [UILabel creatLableWithTitle:@"协议内容" andSuperView:self.view andFont:k14 andTextAligment:NSTextAlignmentRight];
    xieYiLable.textColor = [UIColor blackColor];
    xieYiLable.layer.borderWidth = 0;
    [xieYiLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kScreenW / 6, kScreenW / 14));
        make.right.mas_equalTo(heLable.mas_left);
        make.top.mas_equalTo(changLable.mas_bottom);
    }];
    xieYiLable.userInteractionEnabled = YES;
    UITapGestureRecognizer *tapXieYi = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(xieYiAction)];
    [xieYiLable addGestureRecognizer:tapXieYi];
    
    
    
    UILabel *yinSiLable = [UILabel creatLableWithTitle:@"隐私政策" andSuperView:self.view andFont:k14 andTextAligment:NSTextAlignmentLeft];
    yinSiLable.textColor = [UIColor blackColor];
    yinSiLable.layer.borderWidth = 0;
    [yinSiLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(heLable.mas_right);
        make.size.mas_equalTo(CGSizeMake(kScreenW / 6, kScreenW / 14));
        make.top.mas_equalTo(changLable.mas_bottom);
    }];
    
    yinSiLable.userInteractionEnabled = YES;
    UITapGestureRecognizer *tapYinSi = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(yinSiAtcion)];
    [yinSiLable addGestureRecognizer:tapYinSi];
    
    self.markView = [[UIView alloc]initWithFrame:kScreenFrame];
    [self.view addSubview:self.markView];
    //模糊效果
    UIBlurEffect *light = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
    UIVisualEffectView *bgView = [[UIVisualEffectView alloc]initWithEffect:light];
    bgView.frame = self.markView.bounds;
    [self.markView addSubview:bgView];
    self.markView.alpha = 0;
    
    self.alertMessageView = [[AlertMessageView alloc]initWithFrame:CGRectMake((kScreenW - kScreenW / 1.4) / 2, (kScreenH - kScreenH / 2.66) / 2, kScreenW / 1.4, kScreenH / 2.66) TitleText:@"输入验证码" andBtnTarget:self andCancleAtcion:@selector(cancleAtcion)];
    [self.view addSubview:self.alertMessageView];

    self.alertMessageView.alpha = 0;
    
    
    _xiaHuaXian1 = xiaHuaXian;
    _xiaHuaXian2 = xiaHuaXian2;
    _xiaHuaXian3 = xiaHuaXian3;
}


- (void)cancleAtcion {
    [UIView animateWithDuration:.3 animations:^{
        self.markView.alpha = 0;
        self.alertMessageView.alpha = 0;
    }];
    [self.view endEditing:YES];
}

#pragma mark - 输入框代理，点击return按钮
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    return YES;
}

#pragma mark - textFiled的编辑结束代理
- (void)textFieldDidEndEditing:(UITextField *)textField{
    _xiaHuaXian1.backgroundColor = [UIColor grayColor];
    _xiaHuaXian2.backgroundColor = [UIColor grayColor];
    _xiaHuaXian3.backgroundColor = [UIColor grayColor];
    
}

#pragma mark - 代理返回的数据
- (void)requestData:(HelpFunction *)request didSuccess:(NSDictionary *)dddd {
    
    //    NSLog(@"%@" , dddd);
    
    NSInteger state = [dddd[@"state"] integerValue];
    if (state == 0) {
        
        //判断输入的时候是验证图片中显示的验证码
        if (![self.verificationCodeTectFiled.text isEqualToString:self.authView.authCodeStr]) {
            //验证不匹配，验证码和输入框抖动
            CAKeyframeAnimation *anim = [CAKeyframeAnimation animationWithKeyPath:@"transform.translation.x"];
            anim.repeatCount = 1;
            anim.values = @[@-20 , @20 , @-20];
            [self.verificationCodeTectFiled.layer addAnimation:anim forKey:nil];
            
        } else {
            
            if (self.accTectFiled.text == nil) {
                
                [UIAlertController creatRightAlertControllerWithHandle:nil andSuperViewController:self Title:@"账户输入为空"];
            } else {
//                MessageViewController *messageVC = [[MessageViewController alloc]init];
//                messageVC.phoneNumber = [NSString stringWithFormat:@"%@" , self.accTectFiled.text];
//                [self.navigationController pushViewController:messageVC animated:YES];
                
                self.alertMessageView.phoneNumber = self.accTectFiled.text;
                
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
                    self.alertMessageView.frame = CGRectMake((kScreenW - kScreenW / 1.4) / 2, (kScreenH - kScreenH / 2.66) / 2 - offset, kScreenW / 1.4, kScreenH / 2.66);

                }
                
                [UIView commitAnimations];
                
            }
        }
        
    } else if (state == 1) {
        [UIAlertController creatRightAlertControllerWithHandle:nil andSuperViewController:self Title:@"输入值异常"];
    } else if (state == 3) {
        
        [UIAlertController creatRightAlertControllerWithHandle:^{
            [self.navigationController popViewControllerAnimated:YES];
        } andSuperViewController:self Title:@"此账户已存在，请直接登录"];
    }
}

#pragma mark - 隐私政策点击事件
- (void)yinSiAtcion{
    YinSiViewController *yinSiVC = [[YinSiViewController alloc]init];
    [self.navigationController pushViewController:yinSiVC animated:YES];
}

#pragma mark - 用户协议点击事件
- (void)xieYiAction{
    XieYiNeiRongViewController *xieYiVC = [[XieYiNeiRongViewController alloc]init];
    [self.navigationController pushViewController:xieYiVC animated:YES];
}

#pragma mark - 立即注册按钮点击事件
- (void)registerAction1{
    
    if (self.accTectFiled.text.length > 0 && self.pwdTectFiled.text.length > 0 && self.verificationCodeTectFiled.text.length > 0) {
        if (self.accTectFiled.text.length == 11 && [NSString validateNumber:self.accTectFiled.text] && self.pwdTectFiled.text.length >= 6 && self.pwdTectFiled.text.length <= 12 && [self.verificationCodeTectFiled.text isEqualToString:self.authView.authCodeStr]) {
            NSDictionary *parameters = @{@"phone":self.accTectFiled.text};
            [HelpFunction requestDataWithUrlString:kJiaoYanZhangHu andParames:parameters andDelegate:self];
        } else {
            if (self.accTectFiled.text.length != 11) {
                [UIAlertController creatRightAlertControllerWithHandle:^{
                    self.accTectFiled.text = nil;
                } andSuperViewController:self Title:@"手机号码格式不正确"];
            } else if ( self.pwdTectFiled.text.length < 6 || self.pwdTectFiled.text.length > 12) {
                [UIAlertController creatRightAlertControllerWithHandle:^{
                    self.pwdTectFiled.text = nil;
                } andSuperViewController:self Title:@"密码长度不正确"];
            } else if (![self.verificationCodeTectFiled.text isEqualToString:self.authView.authCodeStr]) {
                [UIAlertController creatRightAlertControllerWithHandle:^{
                    self.verificationCodeTectFiled.text = nil;
                } andSuperViewController:self Title:@"验证码不正确"];
            }
        }
    } else {
        if (self.accTectFiled.text.length == 0) {
            [UIAlertController creatRightAlertControllerWithHandle:nil andSuperViewController:self Title:@"手机号码为空"];
        } else if (self.pwdTectFiled.text.length == 0) {
            [UIAlertController creatRightAlertControllerWithHandle:nil andSuperViewController:self Title:@"密码为空"];
        } else if (self.verificationCodeTectFiled.text.length == 0) {
            [UIAlertController creatRightAlertControllerWithHandle:nil andSuperViewController:self Title:@"验证码为空"];
        }
    }
}

#pragma mark - 点击空白处收回键盘
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
    
}


- (void)textFieldDidBeginEditing:(UITextField *)textField {
    if (textField == self.accTectFiled) {
        _xiaHuaXian1.backgroundColor = kMainColor;
        _xiaHuaXian2.backgroundColor = [UIColor grayColor];
        _xiaHuaXian3.backgroundColor = [UIColor grayColor];
    } else if (textField == self.pwdTectFiled) {
        _xiaHuaXian1.backgroundColor = [UIColor grayColor];
        _xiaHuaXian2.backgroundColor = kMainColor;
        _xiaHuaXian3.backgroundColor = [UIColor grayColor];
    } else if (textField == self.verificationCodeTectFiled) {
        _xiaHuaXian1.backgroundColor = [UIColor grayColor];
        _xiaHuaXian2.backgroundColor = [UIColor grayColor];
        _xiaHuaXian3.backgroundColor = kMainColor;
    }
}


@end


