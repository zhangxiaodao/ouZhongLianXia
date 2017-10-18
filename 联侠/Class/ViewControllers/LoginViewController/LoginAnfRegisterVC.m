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

#define NUMBERS @"0123456789"

#define kStandardW kScreenW / 1.47

@interface LoginAnfRegisterVC ()<UITextFieldDelegate>
@property (nonatomic , strong) UITextField *acctextFiled;
@property (nonatomic , strong) UIView *markView;
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
//    self.acctextFiled.delegate = self;
    
    UIButton *loginBtn = [UIButton initWithTitle:NSLocalizedString(@"LoginVC_login", nil) andColor:[UIColor clearColor] andSuperView:self.view];
    [loginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kStandardW, kScreenW / 9));
        make.centerX.mas_equalTo(accFiledView.mas_centerX);
        make.top.mas_equalTo(accFiledView.mas_bottom)
        .offset(kScreenW / 16);
    }];
    loginBtn.layer.cornerRadius = kScreenW / 18;
    loginBtn.backgroundColor = kMainColor;
    [loginBtn addTarget:self action:@selector(loginBtnAction) forControlEvents:UIControlEventTouchUpInside];
    
    
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
            [parameters setObject:@"ua.clientId" forKey:[kStanderDefault objectForKey:@"GeTuiClientId"]];
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

#pragma mark - 登陆按钮点击事件
- (void)loginBtnAction{
    
    
    if (self.acctextFiled.text.length == 11 || self.acctextFiled.text.length == 9) {
        
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

@end
