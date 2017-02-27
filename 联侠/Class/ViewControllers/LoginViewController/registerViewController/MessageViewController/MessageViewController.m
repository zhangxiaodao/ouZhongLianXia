//
//  MessageViewController.m
//  AEFT冷风扇
//
//  Created by 杭州阿尔法特 on 16/3/16.
//  Copyright © 2016年 阿尔法特. All rights reserved.
//

#import "MessageViewController.h"
#import "SubmitViewController.h"
#import "RegisterViewController.h"
#import "LoginViewController.h"
@interface MessageViewController ()<UITextFieldDelegate , HelpFunctionDelegate>
@property (nonatomic , strong) UIButton *doneBtn;

@property (nonatomic , strong) UIButton *sendDuanXinBtn;
//倒计时长度
@property (nonatomic , assign) NSInteger secondsCountDown;
//定时器
@property (nonatomic , strong) NSTimer *countDownTimer;

@property (nonatomic , strong) UIView *navView;

//@property (nonatomic , assign) NSInteger count;
@property (nonatomic , strong) UILabel *tiShiLablexxx;


@property (nonatomic , strong) UIView *xiaHuaXian1;

@end

@implementation MessageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    _secondsCountDown = 60;
    
    self.navView = [UIView creatNavView:self.view WithTarget:self action:@selector(backTap:) andTitle:@"注册"];
    [self setUI];
}

#pragma mark - 返回主界面
- (void)backTap:(UITapGestureRecognizer *)tap {
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - 设置UI
- (void)setUI{
    UILabel *tiShiLable = [UILabel creatLableWithTitle:@"我们将发送一条短信到:" andSuperView:self.view andFont:k15 andTextAligment:NSTextAlignmentLeft];
    tiShiLable.layer.borderWidth = 0;
    [tiShiLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kStandardW, kScreenW / 17));
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.top.mas_equalTo(self.view.mas_top).offset(kScreenH / 5.55);
    }];
    
    UILabel *phoneNumber = [UILabel creatLableWithTitle:[NSString stringWithFormat:@"%@" , self.phoneNumber] andSuperView:self.view andFont:k14 andTextAligment:NSTextAlignmentLeft];
    phoneNumber.textColor = kMainColor;
    phoneNumber.layer.borderWidth = 0;
    [phoneNumber mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kStandardW, kScreenW / 14));
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.top.mas_equalTo(tiShiLable.mas_bottom);
    }];
    
    
    UIView *xiaHuaXian = [[UIView alloc]init];
    [self.view addSubview:xiaHuaXian];
    xiaHuaXian.backgroundColor = [UIColor grayColor];
    [xiaHuaXian mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kStandardW, 1));
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.top.mas_equalTo(self.view.mas_top).offset(kScreenH / 2.7);
    }];
    
   
    self.pwdTectFiled = [UITextField creatTextfiledWithPlaceHolder:@"请输入短信验证码" andSuperView:self.view];
    self.pwdTectFiled.delegate = self;
    [self.pwdTectFiled mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kStandardW / 2, kScreenW / 10));
        make.left.mas_equalTo(xiaHuaXian.mas_left);
        make.bottom.mas_equalTo(xiaHuaXian.mas_top);
    }];
    
    self.sendDuanXinBtn = [UIButton initWithTitle:@"发送短信" andColor:[UIColor redColor] andSuperView:self.view];
    [self.sendDuanXinBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kStandardW / 3, kStandardW / 10));
        make.bottom.mas_equalTo(xiaHuaXian.mas_bottom).offset(-5);
        make.right.mas_equalTo(xiaHuaXian.mas_right);
    }];
    [self.sendDuanXinBtn addTarget:self action:@selector(sendDuanXinBtnAtcion11) forControlEvents:UIControlEventTouchUpInside];
    self.sendDuanXinBtn.layer.cornerRadius = kStandardW / 20;
    self.sendDuanXinBtn.backgroundColor = kMainColor;
    self.sendDuanXinBtn.titleLabel.font = [UIFont systemFontOfSize:k14];
    
    //创建注册按钮
    UIButton *doneBtn = [UIButton initWithTitle:@"下一步" andColor:[UIColor redColor] andSuperView:self.view];
    doneBtn.layer.cornerRadius = kScreenW / 18;
    doneBtn.backgroundColor = kMainColor;
    [doneBtn addTarget:self action:@selector(doneBtnAtcion1) forControlEvents:UIControlEventTouchUpInside];
    //注册按钮的约束
    [doneBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kStandardW, kScreenW / 9));
        make.centerX.mas_equalTo(xiaHuaXian.mas_centerX);
        make.top.mas_equalTo(self.view.mas_top).offset(kScreenH / 2.1);
    }];
    
    UIButton *registerBtn = [UIButton initWithTitle:@"返回" andColor:[UIColor clearColor] andSuperView:self.view];
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
    
}

#pragma mark - 确定按钮点击事件
- (void)doneBtnAtcion1{

    if ([self.pwdTectFiled.text isEqualToString:[NSString stringWithFormat:@"%@" , self.data]]) {
        SubmitViewController *subVC = [[SubmitViewController alloc]init];
        subVC.phoneNumber = [NSString stringWithFormat:@"%@" , self.phoneNumber];
        [_countDownTimer setFireDate:[NSDate distantFuture]];
        [self.navigationController pushViewController:subVC animated:YES];
    } else {
        
        [UIAlertController creatRightAlertControllerWithHandle:^{
            self.pwdTectFiled.text = nil;
        } andSuperViewController:self Title:@"您输入的验证码错误，请重新输入"];
        
    }

    
}

#pragma mark - 返回按钮点击事件
- (void)backBtnAtcion{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - 发送按钮点击事件
- (void)sendDuanXinBtnAtcion11{
    
    NSDictionary *parameters = @{@"dest":self.phoneNumber , @"bool" : @(0)};
    [HelpFunction requestDataWithUrlString:kFaSongDuanXin andParames:parameters andDelegate:self];
    
    self.sendDuanXinBtn.userInteractionEnabled = NO;
    self.sendDuanXinBtn.backgroundColor = [UIColor grayColor];
    
    self.secondsCountDown = 60;
    _countDownTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timeFireMethod) userInfo:nil repeats:YES];
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
            NSLog(@"%@ , %@" , self.data , _userSn);
        }
    }
    
}

-(void)timeFireMethod{
    
    [self.sendDuanXinBtn setTitle:[NSString stringWithFormat:@"%lds后发送",(long)self.secondsCountDown] forState:UIControlStateNormal];
    
    if(self.secondsCountDown==0){
        [_countDownTimer invalidate];
        _countDownTimer = nil;
        self.data = 0;
        [self.sendDuanXinBtn setTitle:@"发送短信" forState:UIControlStateNormal];
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
    _xiaHuaXian1.backgroundColor = kMainColor;
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    _xiaHuaXian1.backgroundColor = [UIColor grayColor];
}


@end
