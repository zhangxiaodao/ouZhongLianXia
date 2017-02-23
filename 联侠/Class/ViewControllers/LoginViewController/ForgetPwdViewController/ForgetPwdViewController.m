//
//  ForgetPwdViewController.m
//  AEFT冷风扇
//
//  Created by 杭州阿尔法特 on 16/3/9.
//  Copyright © 2016年 阿尔法特. All rights reserved.
//

#import "ForgetPwdViewController.h"
#import "AuthcodeView.h"
#import "AgainSendViewController.h"

@interface ForgetPwdViewController ()<UITextFieldDelegate , HelpFunctionDelegate>
@property (nonatomic , strong) AuthcodeView *authView;
//手机
@property (nonatomic, assign)BOOL phoneRight;
@property (nonatomic , strong) UIView *navView;

@property (nonatomic , strong) UIView *xiaHuaXian1;
@property (nonatomic , strong) UIView *xiaHuaXian2;
@end

@implementation ForgetPwdViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
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
        make.size.mas_equalTo(CGSizeMake(kStandardW, kScreenW / 12));
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.bottom.mas_equalTo(xiaHuaXian.mas_top);
    }];
    
    UIView *xiaHuaXian2 = [[UIView alloc]init];
    [self.view addSubview:xiaHuaXian2];
    xiaHuaXian2.backgroundColor = [UIColor grayColor];
    [xiaHuaXian2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kStandardW, 1));
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.top.mas_equalTo(xiaHuaXian.mas_bottom).offset(kScreenH/8.8674);
    }];
    
    
    self.pwdTectFiled = [UITextField creatTextfiledWithPlaceHolder:@"请输入验证码" andSuperView:self.view];
    self.pwdTectFiled.delegate = self;
    [self.pwdTectFiled mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kStandardW / 2, kScreenW / 12));
        make.left.mas_equalTo(xiaHuaXian2.mas_left);
        make.bottom.mas_equalTo(xiaHuaXian2.mas_top);
    }];
    
    
    
    self.authView = [[AuthcodeView alloc]init];
    [self.view addSubview:self.authView];
    [self.authView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kStandardW / 3, kScreenW / 10));
        make.bottom.mas_equalTo(xiaHuaXian2.mas_bottom).offset(-5);
        make.right.mas_equalTo(xiaHuaXian2.mas_right);
    }];
    
    
    //创建注册按钮
    UIButton *registerBtn = [UIButton initWithTitle:@"下一步" andColor:[UIColor redColor] andSuperView:self.view];
    [registerBtn addTarget:self action:@selector(nextBtnAction) forControlEvents:UIControlEventTouchUpInside];
    registerBtn.layer.cornerRadius = kScreenW / 18;
   
    registerBtn.backgroundColor = kMainColor;
    [registerBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kStandardW, kScreenW / 9));
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.top.mas_equalTo(self.view.mas_top).offset(kScreenH / 2.1);
    }];
    
    _xiaHuaXian1 = xiaHuaXian;
    _xiaHuaXian2 = xiaHuaXian2;
}

#pragma mark - textFiled的编辑结束代理
- (void)textFieldDidEndEditing:(UITextField *)textField{
    _xiaHuaXian1.backgroundColor = [UIColor grayColor];
    _xiaHuaXian2.backgroundColor = [UIColor grayColor];
    
    
    if ([textField isEqual:self.accTectFiled]) {
        if (self.accTectFiled.text.length == 11 && [NSString validateNumber:self.accTectFiled.text]) {
            NSDictionary *parameters = @{@"phone":self.accTectFiled.text};
            [HelpFunction requestDataWithUrlString:kJiaoYanZhangHu andParames:parameters andDelegate:self];
        } else {
           
            [UIAlertController creatRightAlertControllerWithHandle:^{
                textField.text = nil;
            } andSuperViewController:self Title:@"手机号码格式不正确"];
        }
        
    }
    
}

- (void)requestData:(HelpFunction *)request didSuccess:(NSDictionary *)dddd {
    NSLog(@"%@" , dddd);
    NSInteger state = [dddd[@"state"] integerValue];
    if (state == 0) {
        
        [UIAlertController creatRightAlertControllerWithHandle:^{
            [self.navigationController popViewControllerAnimated:YES];
        } andSuperViewController:self Title:@"账户未注册"];
        
    } else if (state == 1) {
       
        [UIAlertController creatRightAlertControllerWithHandle:nil andSuperViewController:kWindowRoot Title:@"输入值为空"];
    }
}


#pragma mark - 下一步点击事件
- (void)nextBtnAction{
    
    //判断输入的时候是验证图片中显示的验证码
    if (![self.pwdTectFiled.text isEqualToString:self.authView.authCodeStr]) {
        //验证不匹配，验证码和输入框抖动
        CAKeyframeAnimation *anim = [CAKeyframeAnimation animationWithKeyPath:@"transform.translation.x"];
        anim.repeatCount = 1;
        anim.values = @[@-20 , @20 , @-20];
        [self.pwdTectFiled.layer addAnimation:anim forKey:nil];
        
    } else if(self.accTectFiled.text.length == 11){
        AgainSendViewController *safeVC = [[AgainSendViewController alloc]init];
        safeVC.phoneNumber = [NSString stringWithFormat:@"%@" , self.accTectFiled.text];
        [self.navigationController pushViewController:safeVC animated:YES];
    }
}

#pragma mark - 输入框代理，点击return按钮
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    //判断输入的时候是验证图片中显示的验证码
    if (![textField.text isEqualToString:self.authView.authCodeStr]) {
        //验证不匹配，验证码和输入框抖动
        CAKeyframeAnimation *anim = [CAKeyframeAnimation animationWithKeyPath:@"transform.translation.x"];
        anim.repeatCount = 1;
        anim.values = @[@-20 , @20 , @-20];
        [textField.layer addAnimation:anim forKey:nil];
        
    }
    return YES;
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
    } else if (textField == self.pwdTectFiled) {
        _xiaHuaXian1.backgroundColor = [UIColor grayColor];
        _xiaHuaXian2.backgroundColor = kMainColor;
    }
}


@end
