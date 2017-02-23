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
@interface RegisterViewController ()<UITextFieldDelegate , HelpFunctionDelegate>

@property (nonatomic , strong) AuthcodeView *authView;
@property (nonatomic , assign) BOOL isOrRegister;
@property (nonatomic , assign) NSInteger success;
@property (nonatomic , strong) UIView *navView;
//手机
@property (nonatomic, assign)BOOL phoneRight;

@property (nonatomic , strong) UIView *xiaHuaXian1;
@property (nonatomic , strong) UIView *xiaHuaXian2;
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

#pragma mark - 设置UI
- (void)setUI{
    
    [kStanderDefault removeObjectForKey:@"shiJian"];
    
    UIView *xiaHuaXian = [[UIView alloc]init];
    [self.view addSubview:xiaHuaXian];
    xiaHuaXian.backgroundColor = [UIColor grayColor];
    [xiaHuaXian mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kStandardW, 1));
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.top.mas_equalTo(self.view.mas_top).offset(kScreenH/4.18181818);
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
    
    self.pwdTectFiled = [UITextField creatTextfiledWithPlaceHolder:@"请输入验证码" andSuperView:self.view];
    [self.pwdTectFiled mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(xiaHuaXian2.mas_top);
        make.size.mas_equalTo(CGSizeMake(kStandardW / 2, kScreenW / 12));
        //        make.centerX.mas_equalTo(xiaHuaXian.mas_centerX);
        make.left.mas_equalTo(xiaHuaXian2.mas_left);
    }];
    self.pwdTectFiled.delegate = self;
    
    
    
    self.authView = [[AuthcodeView alloc]init];
    [self.view addSubview:self.authView];
    [self.authView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kStandardW / 3, kScreenW / 10));
        make.bottom.mas_equalTo(xiaHuaXian2.mas_bottom).offset(-5);
        make.right.mas_equalTo(xiaHuaXian2.mas_right);
    }];
    
    
    //创建注册按钮
    UIButton *registerBtn = [UIButton initWithTitle:@"立即注册" andColor:[UIColor redColor] andSuperView:self.view];
    [registerBtn addTarget:self action:@selector(registerAction1) forControlEvents:UIControlEventTouchUpInside];
    registerBtn.layer.cornerRadius = kScreenW / 18;
    
    registerBtn.backgroundColor = kMainColor;
    [registerBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kStandardW, kScreenW / 9));
        make.centerX.mas_equalTo(xiaHuaXian.mas_centerX);
        make.top.mas_equalTo(xiaHuaXian2.mas_bottom).offset(kScreenH / 6.53);
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
    
    _xiaHuaXian1 = xiaHuaXian;
    _xiaHuaXian2 = xiaHuaXian2;
}

#pragma mark - 输入框代理，点击return按钮
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    return YES;
}

#pragma mark - textFiled的编辑结束代理
- (void)textFieldDidEndEditing:(UITextField *)textField{
    _xiaHuaXian1.backgroundColor = [UIColor grayColor];
    _xiaHuaXian2.backgroundColor = [UIColor grayColor];
    
}

#pragma mark - 代理返回的数据
- (void)requestData:(HelpFunction *)request didSuccess:(NSDictionary *)dddd {
    
    //    NSLog(@"%@" , dddd);
    
    NSInteger state = [dddd[@"state"] integerValue];
    if (state == 0) {
        
        //判断输入的时候是验证图片中显示的验证码
        if (![self.pwdTectFiled.text isEqualToString:self.authView.authCodeStr]) {
            //验证不匹配，验证码和输入框抖动
            CAKeyframeAnimation *anim = [CAKeyframeAnimation animationWithKeyPath:@"transform.translation.x"];
            anim.repeatCount = 1;
            anim.values = @[@-20 , @20 , @-20];
            [self.pwdTectFiled.layer addAnimation:anim forKey:nil];
            
        } else {
            
            if (self.accTectFiled.text == nil) {
                
                [UIAlertController creatRightAlertControllerWithHandle:nil andSuperViewController:self Title:@"账户输入为空"];
            } else {
                MessageViewController *messageVC = [[MessageViewController alloc]init];
                messageVC.phoneNumber = [NSString stringWithFormat:@"%@" , self.accTectFiled.text];
                [self.navigationController pushViewController:messageVC animated:YES];
                
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
    
    
    if (self.accTectFiled.text.length > 0) {
        if ( self.accTectFiled.text.length == 11 && [NSString validateNumber:self.accTectFiled.text]) {
            NSDictionary *parameters = @{@"phone":self.accTectFiled.text};
            [HelpFunction requestDataWithUrlString:kJiaoYanZhangHu andParames:parameters andDelegate:self];
        } else {
            
            [UIAlertController creatRightAlertControllerWithHandle:^{
                self.accTectFiled.text = nil;
            } andSuperViewController:self Title:@"手机号码格式不正确"];
        }
        
    } else {
        
        [UIAlertController creatRightAlertControllerWithHandle:^{
            self.accTectFiled.text = nil;
        } andSuperViewController:self Title:@"号码输入为空"];
        
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
    } else if (textField == self.pwdTectFiled) {
        _xiaHuaXian1.backgroundColor = [UIColor grayColor];
        _xiaHuaXian2.backgroundColor = kMainColor;
    }
}


@end


