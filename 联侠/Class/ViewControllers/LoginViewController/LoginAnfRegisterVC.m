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

@interface LoginAnfRegisterVC ()<UITextFieldDelegate  , HelpFunctionDelegate>
@property (nonatomic , strong) UITextField *acctextFiled;
@property (nonatomic , strong) UIView *markView;
@property (nonatomic , strong) AlertMessageView *alertMessageView;
@end

@implementation LoginAnfRegisterVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self setUI];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(whetherGegisterSuccess:) name:@"RegisterSuccess" object:nil];
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
        make.bottom.mas_equalTo(shangBiaoImage.mas_bottom).offset(kScreenH / 4.75 + kScreenH / 11);
        make.size.mas_equalTo(CGSizeMake(kStandardW, kScreenW / 10));
        make.centerX.mas_equalTo(self.view.mas_centerX);
    }];
    
    self.acctextFiled = accFiledView.subviews[2];
    self.acctextFiled.delegate = self;
    
    
    UIButton *loginBtn = [UIButton initWithTitle:NSLocalizedString(@"LoginVC_login", nil) andColor:[UIColor clearColor] andSuperView:self.view];
    [loginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kStandardW, kScreenW / 9));
        make.centerX.mas_equalTo(accFiledView.mas_centerX);
        make.top.mas_equalTo(accFiledView.mas_bottom).offset(kScreenW / 7.5);
    }];
    loginBtn.layer.cornerRadius = kScreenW / 18;
    loginBtn.backgroundColor = kMainColor;
    [loginBtn addTarget:self action:@selector(loginBtnAction) forControlEvents:UIControlEventTouchUpInside];
    
    
    
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

-(void)requestData:(HelpFunction *)request didFinishLoadingDtaArray:(NSMutableArray *)data {
    NSDictionary *dic = data[0];
    NSInteger state = [dic[@"state"] integerValue];
    
    if (state == 0) {
        
        NSDictionary *user = dic[@"data"];
        
        [kStanderDefault setObject:user[@"sn"] forKey:@"userSn"];
        [kStanderDefault setObject:user[@"id"] forKey:@"userId"];
        
        [kWindowRoot presentViewController:[[TabBarViewController alloc]init] animated:YES completion:^{
            
            self.acctextFiled.text = nil;
            
            
        }];
    }
}


- (void)whetherGegisterSuccess:(NSNotification *)post {
    NSString *vercodeStr = post.userInfo[@"VercodeStr"];
    NSString *success = post.userInfo[@"RegisterSuccess"];
    //    NSLog(@"%@" , success);
    if ([success isEqualToString:@"YES"]) {
        
        [self cancleAtcion];
        
        NSDictionary *parameters = nil;
        if ([kStanderDefault objectForKey:@"GeTuiClientId"]) {
            parameters = @{@"loginName":self.acctextFiled.text , @"code" : vercodeStr, @"ua.clientId" : [kStanderDefault objectForKey:@"GeTuiClientId"], @"ua.phoneType" : @(2), @"ua.phoneBrand":@"iPhone" , @"ua.phoneModel":[NSString getDeviceName] , @"ua.phoneSystem":[NSString getDeviceSystemVersion]};
        } else {
            parameters = @{@"loginName":self.acctextFiled.text , @"code" : vercodeStr ,@"ua.phoneType" : @(2), @"ua.phoneBrand":@"iPhone" , @"ua.phoneModel":[NSString getDeviceName] , @"ua.phoneSystem":[NSString getDeviceSystemVersion]};
        }
        
        [kStanderDefault setObject:self.acctextFiled.text forKey:@"phone"];
        ;
        [HelpFunction requestDataWithUrlString:kLoginWithRegisterURL andParames:parameters andDelegate:self];
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
            self.alertMessageView.frame = CGRectMake((kScreenW - kScreenW / 1.4) / 2, (kScreenH - kScreenH / 2.66) / 2 - offset, kScreenW / 1.4, kScreenH / 2.66);
            
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
