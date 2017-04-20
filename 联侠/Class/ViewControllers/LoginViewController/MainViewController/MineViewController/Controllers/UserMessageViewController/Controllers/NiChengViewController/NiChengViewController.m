//
//  NiChengViewController.m
//  AEFT冷风扇
//
//  Created by 杭州阿尔法特 on 16/3/16.
//  Copyright © 2016年 阿尔法特. All rights reserved.
//

#import "NiChengViewController.h"
#import "UserMessageViewController.h"
@interface NiChengViewController ()<HelpFunctionDelegate , UITextFieldDelegate>
@property (nonatomic , strong) UITextField *textFiled;

@end

@implementation NiChengViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithHexString:@"f2f4fb"];
    [self setUI];

}

#pragma mark - 设置UI
- (void)setUI{

    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(kScreenW / 29, kScreenW / 29, kScreenW - kScreenW * 2 / 29, kScreenH / 13.3)];
    view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:view];
    view.layer.cornerRadius = 5;
    view.layer.masksToBounds = YES;
    
    
    self.textFiled = [UITextField creatTextfiledWithPlaceHolder:@"请修改您的信息" andSuperView:view];
    self.textFiled.keyboardType = UIKeyboardTypeDefault;
    self.textFiled.delegate = self;
    [self.textFiled mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kScreenW - kScreenW * 2 / 20, kScreenH / 13.3));
        make.centerX.mas_equalTo(view.mas_centerX);
        make.centerY.mas_equalTo(view.mas_centerY);
    }];

    
    UIButton *sureBtn = [UIButton initWithTitle:@"完成" andColor:kMainColor andSuperView:self.view];
    [sureBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(view.mas_centerX);
        make.size.mas_equalTo(CGSizeMake( kScreenW / 2.68, kScreenW / 9.375));
        make.top.mas_equalTo(view.mas_bottom).offset(kScreenW / 7.5);
    }];
    [sureBtn addTarget:self action:@selector(sureBtnAtcion:) forControlEvents:UIControlEventTouchUpInside];
    
    if ([self.navigationItem.title isEqualToString:@"昵称"]) {
        if (![_userModel.nickname isKindOfClass:[NSNull class]] && ![_userModel.nickname isEqualToString:@"昵称"]) {
            self.textFiled.text = _userModel.nickname;
            [self.textFiled becomeFirstResponder];
        }
    } else {
        if (![_userModel.email isKindOfClass:[NSNull class]] && ![_userModel.email isEqualToString:@"请输入邮箱"]) {
            self.textFiled.text = _userModel.email;
            [self.textFiled becomeFirstResponder];;
        }
    }
}


#pragma mark - 确定按钮的点击事件
- (void)sureBtnAtcion:(UIButton *)btn {
    
    if (self.textFiled.text.length == 0) {
        [UIAlertController creatRightAlertControllerWithHandle:nil andSuperViewController:self Title:@"输入为空"];
    } else {
        if (_delegate && [_delegate respondsToSelector:@selector(sendNickOrEmailToPreviousVC:)]) {
            [_delegate sendNickOrEmailToPreviousVC:@[self.textFiled.text , self.navigationItem.title]];
        }
        
        
        NSDictionary *parames = nil;
        if ([self.navigationItem.title isEqualToString:@"昵称"]) {
            parames = @{@"user.sn" : @(self.userModel.sn) , @"user.nickname" : self.textFiled.text};
        } else {
            parames = @{@"user.sn" : @(self.userModel.sn) , @"user.email" : self.textFiled.text};
        }
        
        NSLog(@"%@" , parames);
        
        [HelpFunction requestDataWithUrlString:kXiuGaiXinXi andParames:parames andDelegate:self];
        
    }

   
}

- (void)requestData:(HelpFunction *)request didSuccess:(NSDictionary *)dddd {
    NSLog(@"%@" , dddd);
    
    if ([dddd[@"success"] integerValue] == 1) {
        [self.navigationController popViewControllerAnimated:YES];
    }
    
}

- (void)requestData:(HelpFunction *)request didFailLoadData:(NSError *)error {
    NSLog(@"%@" , error);
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}


- (void)setUserModel:(UserModel *)userModel {
    _userModel = userModel;
}

@end
