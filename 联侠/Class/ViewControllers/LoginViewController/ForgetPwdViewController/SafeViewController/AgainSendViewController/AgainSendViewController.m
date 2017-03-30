//
//  AgainSendViewController.m
//  AEFT冷风扇
//
//  Created by 杭州阿尔法特 on 16/3/9.
//  Copyright © 2016年 阿尔法特. All rights reserved.
//

#import "AgainSendViewController.h"
#import "ChongZhiPwdViewController.h"

@interface AgainSendViewController ()<UITextFieldDelegate , HelpFunctionDelegate>
@property (nonatomic , strong) UIView *navView;
@property (nonatomic , strong) UIButton *doneBtn2;

@property (nonatomic , strong) UITextField *pwdTectFiled;
@property (nonatomic , retain) UITextField *accTectFiled;
//倒计时长度
@property (nonatomic , assign) NSInteger secondsCountDown;
//定时器
@property (nonatomic , strong) NSTimer *countDownTimer;
//发送短信按钮
@property (nonatomic , strong)UIButton *sendDuanXinBtn;

@property (nonatomic , strong) UIView *xiaHuaXian1;
@property (nonatomic , strong) UIView *xiaHuaXian2;

@property (nonatomic , copy) NSString *userSn;
@property (nonatomic , strong) NSString *data;
@property (nonatomic , retain) NSString *message;
@end

@implementation AgainSendViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
     self.navView = [UIView creatNavView:self.view WithTarget:self action:@selector(backTap:) andTitle:NSLocalizedString(@"ResetVC_ResetPwd", nil)];
    
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
    
    
    self.accTectFiled = [UITextField creatTextfiledWithPlaceHolder:NSLocalizedString(@"EnterPhone", nil) andSuperView:self.view];
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
    
    self.pwdTectFiled = [UITextField creatTextfiledWithPlaceHolder:NSLocalizedString(@"EnterSMSVerificationCode", nil) andSuperView:self.view];
    self.pwdTectFiled.delegate = self;
    [self.pwdTectFiled mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kStandardW / 2, kScreenW / 10));
        make.left.mas_equalTo(xiaHuaXian2.mas_left);
        make.bottom.mas_equalTo(xiaHuaXian2.mas_top);
    }];
    
    self.sendDuanXinBtn = [UIButton initWithTitle:NSLocalizedString(@"SendSMSCode", nil) andColor:[UIColor redColor] andSuperView:self.view];
    [self.sendDuanXinBtn addTarget:self action:@selector(sendDuanXinBtnAtcion) forControlEvents:UIControlEventTouchUpInside];
    self.sendDuanXinBtn.layer.cornerRadius = kStandardW / 20;
    self.sendDuanXinBtn.backgroundColor = kMainColor;
    [self.sendDuanXinBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kStandardW / 3, kStandardW / 10));
        make.bottom.mas_equalTo(xiaHuaXian2.mas_bottom).offset(-5);
        make.right.mas_equalTo(xiaHuaXian2.mas_right);
    }];
    self.sendDuanXinBtn.titleLabel.font = [UIFont systemFontOfSize:k14];
    
    //创建注册按钮
    UIButton *doneBtn = [UIButton initWithTitle:NSLocalizedString(@"Next", nil) andColor:[UIColor redColor] andSuperView:self.view];
    doneBtn.layer.cornerRadius = kScreenW / 18;
    
    doneBtn.backgroundColor = kMainColor;
    
    [doneBtn addTarget:self action:@selector(doneBtnAtcion2) forControlEvents:UIControlEventTouchUpInside];
    //注册按钮的约束
    [doneBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kStandardW, kScreenW / 9));
        make.centerX.mas_equalTo(xiaHuaXian2.mas_centerX);
        make.top.mas_equalTo(self.view.mas_top).offset(kScreenH / 2.1);
    }];
    
    UIButton *registerBtn = [UIButton initWithTitle:NSLocalizedString(@"Back", nil) andColor:[UIColor clearColor] andSuperView:self.view];
    [registerBtn setTitleColor:kMainColor forState:UIControlStateNormal];
    registerBtn.layer.cornerRadius = kScreenW / 18;
    registerBtn.layer.borderWidth = 2;
    registerBtn.layer.borderColor = kMainColor.CGColor;
    
    [registerBtn addTarget:self action:@selector(backBtnAtcion) forControlEvents:UIControlEventTouchUpInside];
    //注册按钮的约束
    [registerBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kStandardW, kScreenW / 9));
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.top.mas_equalTo(doneBtn.mas_bottom).offset(kScreenH / 36.8);
    }];
    
    _xiaHuaXian1 = xiaHuaXian;
    _xiaHuaXian2 = xiaHuaXian2;
    
    if ([self.changePwd isEqualToString:@"YES"]) {
        self.accTectFiled.text = [kStanderDefault objectForKey:@"phone"];
        self.accTectFiled.userInteractionEnabled = NO;
    }
    
}

#pragma mark - 发送短信按钮60S倒计时
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];

    if ([kStanderDefault objectForKey:@"sendTimeInterVal"]) {
        NSInteger currentTimeInterval = [NSString getNowTimeInterval];
        
        NSInteger sendEmailTimeInterval = [[kStanderDefault objectForKey:@"sendTimeInterVal"] integerValue];
        
        if (currentTimeInterval >= sendEmailTimeInterval + 60) {
            [kStanderDefault removeObjectForKey:@"sendTimeInterVal"];

            [self.sendDuanXinBtn setTitle:NSLocalizedString(@"SendSMSCode", nil) forState:UIControlStateNormal];
            self.sendDuanXinBtn.backgroundColor = kMainColor;
            self.sendDuanXinBtn.userInteractionEnabled = YES;
            
            [_countDownTimer invalidate];
            _countDownTimer = nil;
            _secondsCountDown = 60;
        } else {
            
            _secondsCountDown = sendEmailTimeInterval + 60 - currentTimeInterval;
            self.sendDuanXinBtn.userInteractionEnabled = NO;
            self.sendDuanXinBtn.backgroundColor = [UIColor grayColor];
            
            [_countDownTimer invalidate];
            _countDownTimer = nil;
            _countDownTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timeFireMethod) userInfo:nil repeats:YES];
        }
        
    }
    
}


#pragma mark - 返回按钮点击事件
- (void)backBtnAtcion{
    [self.navigationController popViewControllerAnimated:YES];
}


#pragma mark - 确定点击事件
- (void)doneBtnAtcion2{
    
    if ([_pwdTectFiled.text isEqualToString:[NSString stringWithFormat:@"%@" , _data]] && self.accTectFiled.text.length == 11) {
        ChongZhiPwdViewController *chongZhiPwd = [[ChongZhiPwdViewController alloc]init];
        chongZhiPwd.phoneNumber = [NSString stringWithFormat:@"%@" , self.accTectFiled.text];
        chongZhiPwd.userSn = self.userSn;
        [self.navigationController pushViewController:chongZhiPwd animated:YES];
        
        [kStanderDefault removeObjectForKey:@"sendTimeInterVal"];
        [self.countDownTimer invalidate];
        self.countDownTimer = nil;
    } else {
        
        if (self.accTectFiled.text.length != 11) {
            [UIAlertController creatRightAlertControllerWithHandle:^{
                self.accTectFiled.text = nil;
            } andSuperViewController:self Title:NSLocalizedString(@"YourPhoneNumberErrorSoRe-Enter", nil)];
        } else if (![_pwdTectFiled.text isEqualToString:[NSString stringWithFormat:@"%@" , _data]]) {
            [UIAlertController creatRightAlertControllerWithHandle:^{
                self.pwdTectFiled.text = nil;
            } andSuperViewController:self Title:NSLocalizedString(@"YourVerificationCodeErrorSoRe-Enter", nil)];
        }
    }
    
}


#pragma mark - 发送按钮点击事件
- (void)sendDuanXinBtnAtcion{
    
    if (self.accTectFiled.text.length == 11) {
        NSDictionary *parameters = @{@"phone":self.accTectFiled.text};
        [HelpFunction requestDataWithUrlString:kJiaoYanZhangHu andParames:parameters andDelegate:self];
    } else {
        [UIAlertController creatRightAlertControllerWithHandle:^{
            self.pwdTectFiled.text = nil;
        } andSuperViewController:self Title:NSLocalizedString(@"PhoneFormattedError", nil)];
    }
    
}


- (void)requestData:(HelpFunction *)request didSuccess:(NSDictionary *)dddd {
    
    //    NSLog(@"%@" , dddd);
    
    NSInteger state = [dddd[@"state"] integerValue];
    if (state == 0) {
        [UIAlertController creatRightAlertControllerWithHandle:^{
            self.accTectFiled.text = nil;
        } andSuperViewController:self Title:NSLocalizedString(@"ThisAccNoExist", nil)];
    } else if (state == 1) {
        [UIAlertController creatRightAlertControllerWithHandle:nil andSuperViewController:self Title:NSLocalizedString(@"InputValueError", nil)];
    } else if (state == 3) {
        
        {
            NSDictionary *parameters = @{@"dest":self.accTectFiled.text , @"bool" : @(1)};
            [HelpFunction requestDataWithUrlString:kFaSongDuanXin andParames:parameters andDelegate:self];
            
            NSInteger sendTimeInterVal = [NSString getNowTimeInterval];
            [kStanderDefault setObject:@(sendTimeInterVal) forKey:@"sendTimeInterVal"];
            
            self.sendDuanXinBtn.userInteractionEnabled = NO;
            self.sendDuanXinBtn.backgroundColor = [UIColor grayColor];
            
            self.secondsCountDown = 60;
            
            self.countDownTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timeFireMethod) userInfo:nil repeats:YES];
        }
    }
}


#pragma mark - 代理返回的数据
- (void)requestData:(HelpFunction *)request didFinishLoadingDtaArray:(NSMutableArray *)data {
    NSDictionary *dic = data[0];
    
    if (dic[@"data"]) {
        NSInteger state = [dic[@"state"] integerValue];
        
        if (state == 0) {
            NSDictionary *data = dic[@"data"];
            NSString *code = data[@"code"];
            NSString *userSn = data[@"userSn"];
            
            self.data = code;
            _userSn = userSn;
            NSLog(@"%@ , %@" , self.data , userSn);
        }
    }

}

-(void)timeFireMethod{
    [self.sendDuanXinBtn setTitle:[NSString stringWithFormat:@"%lds%@",(long)self.secondsCountDown , NSLocalizedString(@"AfterSecondsRe-Send", nil)] forState:UIControlStateNormal];
    
    if(self.secondsCountDown==0){
        [self.countDownTimer invalidate];
        self.countDownTimer = nil;
        self.data = 0;
        [self.sendDuanXinBtn setTitle:NSLocalizedString(@"SendSMSCode", nil) forState:UIControlStateNormal];
        self.sendDuanXinBtn.backgroundColor = kMainColor;
        self.sendDuanXinBtn.userInteractionEnabled = YES;
    }
    
    self.secondsCountDown--;
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

- (void)textFieldDidEndEditing:(UITextField *)textField {
    _xiaHuaXian1.backgroundColor = [UIColor grayColor];
    _xiaHuaXian2.backgroundColor = [UIColor grayColor];
}

@end
