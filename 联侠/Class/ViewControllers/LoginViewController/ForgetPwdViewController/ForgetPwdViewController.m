//
//  ForgetPwdViewController.m
//  AEFT冷风扇
//
//  Created by 杭州阿尔法特 on 16/3/9.
//  Copyright © 2016年 阿尔法特. All rights reserved.
//

#import "ForgetPwdViewController.h"
#import "ChongZhiPwdViewController.h"

@interface ForgetPwdViewController ()<UITextFieldDelegate , HelpFunctionDelegate>
@property (nonatomic , strong) UIButton *nextBtn2;

@property (nonatomic , strong) UITextField *pwdTectFiled;
@property (nonatomic , retain) UITextField *accTectFiled;
//倒计时长度
@property (nonatomic , assign) NSInteger secondsCountDown;
//定时器
@property (nonatomic , strong) NSTimer *countDownTimer;
//发送短信按钮
@property (nonatomic , strong)UIButton *sendDuanXinBtn;

@property (nonatomic , copy) NSString *userSn;
@property (nonatomic , strong) NSString *data;
@property (nonatomic , retain) NSString *message;
@end

@implementation ForgetPwdViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithHexString:@"f2f4fb"];
    
    [self setUI];
}

#pragma mark - 设置UI
- (void)setUI{
    UIView *phoneFiledView = [UIView creatViewWithFiledCoradiusOfPlaceholder:@"请输入您的手机号" andSuperView:self.view];
    [phoneFiledView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kScreenW - kScreenW / 15.625, kScreenW / 8.3));
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.top.mas_equalTo(self.view.mas_top).offset(10);
    }];
    self.accTectFiled = phoneFiledView.subviews[0];
    
    UIView *pwdFiledView = [UIView creatViewWithFiledCoradiusOfPlaceholder:@"请输入验证码" andSuperView:self.view];
    [pwdFiledView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kScreenW - kScreenW / 15.625, kScreenW / 8.3));
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.top.mas_equalTo(phoneFiledView.mas_bottom).offset(10);
    }];
    self.pwdTectFiled = pwdFiledView.subviews[0];
    
    self.sendDuanXinBtn = [UIButton initWithTitle:NSLocalizedString(@"SendSMSCode", nil) andColor:[UIColor redColor] andSuperView:pwdFiledView];
    [self.sendDuanXinBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kScreenW / 3.75, kScreenW / 15));
        make.centerY.mas_equalTo(pwdFiledView.mas_centerY);
        make.right.mas_equalTo(pwdFiledView.mas_right).offset(-kScreenW / 25);
    }];
    self.sendDuanXinBtn.titleLabel.font = [UIFont systemFontOfSize:k12];
    [self.sendDuanXinBtn addTarget:self action:@selector(sendDuanXinBtnAtcion) forControlEvents:UIControlEventTouchUpInside];
    self.sendDuanXinBtn.layer.cornerRadius = kScreenW / 30;
    self.sendDuanXinBtn.backgroundColor = kMainColor;
    
    //创建注册按钮
    UIButton *nextBtn = [UIButton initWithTitle:NSLocalizedString(@"Next", nil) andColor:kMainColor andSuperView:self.view];
    //注册按钮的约束
    [nextBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kScreenW / 2.8, kScreenW / 9.4));
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.top.mas_equalTo(pwdFiledView.mas_bottom).offset(kScreenW / 13.7);
    }];
    nextBtn.titleLabel.font = [UIFont systemFontOfSize:k14];
    nextBtn.layer.cornerRadius = kScreenW / 18.8;
    nextBtn.backgroundColor = kMainColor;
    [nextBtn addTarget:self action:@selector(nextBtnAtcion2) forControlEvents:UIControlEventTouchUpInside];
    
    if (self.phoneNumber != nil) {
        self.accTectFiled.text = self.phoneNumber;
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


#pragma mark - 确定点击事件
- (void)nextBtnAtcion2{
    
    if ([_pwdTectFiled.text isEqualToString:[NSString stringWithFormat:@"%@" , _data]] && self.accTectFiled.text.length == 11) {
        ChongZhiPwdViewController *chongZhiPwd = [[ChongZhiPwdViewController alloc]init];
        chongZhiPwd.phoneNumber = [NSString stringWithFormat:@"%@" , self.accTectFiled.text];
        chongZhiPwd.userSn = self.userSn;
        chongZhiPwd.navigationItem.title = @"重置密码";
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

- (void)requestData:(HelpFunction *)request didFailLoadData:(NSError *)error {
    NSLog(@"%@" , error);
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



@end
