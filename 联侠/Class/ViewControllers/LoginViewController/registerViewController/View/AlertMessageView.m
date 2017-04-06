//
//  AlertMessageView.m
//  联侠
//
//  Created by 杭州阿尔法特 on 2017/3/14.
//  Copyright © 2017年 张海昌. All rights reserved.
//

#import "AlertMessageView.h"
#import "PZXVerificationCodeView.h"

#define kSpace ((self.height - kScreenW / 20 - 5 - self.height / 7 - self.height / 10 - self.height / 8 - self.height / 5) / 5)

@interface AlertMessageView ()<HelpFunctionDelegate>
@property(nonatomic,strong)PZXVerificationCodeView *pzxView;
@property (nonatomic , strong) UILabel *phoneLabel;
@property (nonatomic , strong) NSString *data;
@property (nonatomic , strong) NSTimer *countDownTimer;
@property (nonatomic , strong) UIButton *countdownBtn;
@property (nonatomic , assign) NSInteger secondsCountDown;
@end

@implementation AlertMessageView

- (UIView *)initWithFrame:(CGRect)frame TitleText:(NSString *)titleText andBtnTarget:(nullable id)target andCancleAtcion:(nonnull SEL)cancleAtcion {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.layer.cornerRadius = 3;
        self.layer.masksToBounds = YES;
        
        UIButton *cancleBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [self addSubview:cancleBtn];
        [cancleBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(kScreenW / 20, kScreenW / 20));
            make.right.mas_equalTo(self.mas_right).offset(-5);
            make.top.mas_equalTo(self.mas_top).offset(5);
        }];
        [cancleBtn addTarget:target action:cancleAtcion forControlEvents:UIControlEventTouchUpInside];
        [cancleBtn setImage:[UIImage imageNamed:@"cancleImage"] forState:UIControlStateNormal];
        
        UILabel *titleLabel = [UILabel creatLableWithTitle:titleText andSuperView:self andFont:k20 andTextAligment:NSTextAlignmentCenter];
        [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(self.width, self.height / 7));
            make.left.mas_equalTo(self.mas_left).offset(0);
            make.top.mas_equalTo(cancleBtn.mas_bottom);
        }];
        
        UILabel *phoneLabel = [UILabel creatLableWithTitle:@"" andSuperView:self andFont:k12 andTextAligment:NSTextAlignmentCenter];
        [phoneLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(self.width, self.height / 10));
            make.left.mas_equalTo(self.mas_left).offset(0);
            make.top.mas_equalTo(titleLabel.mas_bottom).offset(kSpace);
        }];
        self.phoneLabel = phoneLabel;
        
        _countdownBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [self addSubview:_countdownBtn];
        [_countdownBtn setTitle:NSLocalizedString(@"Resend", nil) forState:UIControlStateNormal];
        [_countdownBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        _countdownBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        [_countdownBtn addTarget:self action:@selector(againSendAtcion) forControlEvents:UIControlEventTouchUpInside];
        [_countdownBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(self.width / 2, self.height / 8));
            make.centerX.mas_equalTo(self.mas_left).offset(self.width / 2);
            make.top.mas_equalTo(phoneLabel.mas_bottom).offset(kSpace);
        }];
        _countdownBtn.layer.cornerRadius = 3;
        _countdownBtn.layer.masksToBounds = YES;
        _countdownBtn.layer.borderColor = [UIColor grayColor].CGColor;
        _countdownBtn.layer.borderWidth = 1;
        
        _pzxView = [[PZXVerificationCodeView alloc]initWithFrame:CGRectMake(0, self.height * 3 / 5 + kSpace, kScreenW / 1.4, self.height / 5)];
        [self addSubview:_pzxView];
        _pzxView.tag = 10003;

        _pzxView.selectedColor = kMainColor;
        _pzxView.VerificationCodeNum = 6;
        _pzxView.Spacing = 3;//每个格子间距属性
    }
    return self;
}

- (void)timeFireMethod {
    [self.countdownBtn setTitle:[NSString stringWithFormat:@"%lds%@",(long)self.secondsCountDown , NSLocalizedString(@"AfterSecondsRe-Send", nil)] forState:UIControlStateNormal];
    
    if(self.secondsCountDown==0){
        [_countDownTimer invalidate];
        _countDownTimer = nil;
        
        self.data = 0;
        [self.countdownBtn setTitle:NSLocalizedString(@"Resend", nil) forState:UIControlStateNormal];
        self.countdownBtn.userInteractionEnabled = YES;
        
    }
    self.secondsCountDown--;
}

- (void)againSendAtcion {
    self.secondsCountDown = 60;
    _countDownTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timeFireMethod) userInfo:nil repeats:YES];
    self.countdownBtn.backgroundColor = [UIColor clearColor];
    self.countdownBtn.userInteractionEnabled = NO;
    
    NSDictionary *parameters = @{@"dest":self.phoneNumber , @"bool" : @(0)};
    [HelpFunction requestDataWithUrlString:kFaSongDuanXin andParames:parameters andDelegate:self];
}

- (void)setPhoneNumber:(NSString *)phoneNumber {
    _phoneNumber = phoneNumber;
    
    _phoneLabel.text = [NSString stringWithFormat:@"验证码发送至:%@" , _phoneNumber];
    
    if (!_countDownTimer) {
        [self againSendAtcion];
    }
    
}

#pragma mark - 代理返回的数据
- (void)requestData:(HelpFunction *)request didFinishLoadingDtaArray:(NSMutableArray *)data {
    NSDictionary *dic = data[0];
    NSLog(@"%@" , dic);
    
    if (dic[@"data"]) {
        NSInteger state = [dic[@"state"] integerValue];
        
        if (state == 0) {
            NSDictionary *data = dic[@"data"];
            NSString *code = data[@"code"];
            self.data = code;
            
            _pzxView.sendMessage = self.data;
            
            NSLog(@"%@" , self.data);
        }
    }
    
}

@end
