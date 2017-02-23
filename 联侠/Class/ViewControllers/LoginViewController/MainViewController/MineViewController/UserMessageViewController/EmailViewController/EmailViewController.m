
//
//  EmailViewController.m
//  AEFT冷风扇
//
//  Created by 杭州阿尔法特 on 16/4/6.
//  Copyright © 2016年 阿尔法特. All rights reserved.
//

#import "EmailViewController.h"
#import "UserMessageViewController.h"
@interface EmailViewController ()<UITextFieldDelegate>
@property (nonatomic , strong) UITextField *textFiled;
@property (nonatomic , strong) UIView *navView;
@property (nonatomic , strong) UIView *xianHuaXian;
@end

@implementation EmailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self setUI];
}

#pragma mark - 设置UI
- (void)setUI{
    
    
    UILabel *titleLable = [UILabel creatLableWithTitle:@"我的邮箱" andSuperView:self.view andFont:k16 andTextAligment:NSTextAlignmentCenter];
    titleLable.layer.borderWidth = 0;
    titleLable.textColor = [UIColor blackColor];
    [titleLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(kScreenW / 4, kScreenH / 22.23333));
        make.top.mas_equalTo(kScreenH / 33.35);
    }];
    
    UIView *view = [[UIView alloc]init];
    view.backgroundColor = [UIColor grayColor];
    [self.view addSubview:view];
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kScreenW, 1));
        make.left.mas_equalTo(0);
        make.top.mas_equalTo(kScreenH / 13.34);
    }];
    
    
    self.textFiled = [UITextField creatTextfiledWithPlaceHolder:@"请输入您要修改的信息" andSuperView:self.view];
    self.textFiled.layer.borderColor = [UIColor redColor].CGColor;
    self.textFiled.keyboardType = UIKeyboardTypeEmailAddress;
    [self.textFiled mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(kHeight + 20);
        make.size.mas_equalTo(CGSizeMake(kStandardW, kScreenW / 10));
        make.centerX.mas_equalTo(self.view.mas_centerX);
    }];
    self.textFiled.delegate = self;
    
    UIView *xiaHuaXian2 = [[UIView alloc]init];
    [self.view addSubview:xiaHuaXian2];
    xiaHuaXian2.backgroundColor = [UIColor lightGrayColor];
    [xiaHuaXian2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kStandardW, 1));
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.top.mas_equalTo(self.textFiled.mas_bottom);
    }];
    
    UIButton *cancleBtn = [UIButton initWithTitle:@"取消" andColor:kMainColor andSuperView:self.view];
    [cancleBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(xiaHuaXian2.mas_left);
        make.size.mas_equalTo(CGSizeMake((kScreenW / 2 - 40) / 2, kScreenW / 10));
        make.top.mas_equalTo( self.textFiled.mas_bottom).offset(10);
    }];
    [cancleBtn addTarget:self action:@selector(cancleBtnAtcion:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *sureBtn = [UIButton initWithTitle:@"确定" andColor:kMainColor andSuperView:self.view];
    [sureBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(xiaHuaXian2.mas_right);
        make.size.mas_equalTo(CGSizeMake((kScreenW / 2 - 40) / 2, kScreenW / 10));
        make.top.mas_equalTo( self.textFiled.mas_bottom).offset(10);
    }];
    [sureBtn addTarget:self action:@selector(sureBtnAtcion33:) forControlEvents:UIControlEventTouchUpInside];
 
    _xianHuaXian = xiaHuaXian2;
    
}



#pragma mark 判断邮箱，手机，QQ的格式
-(BOOL)isValidateEmail:(NSString *)email{
    
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    BOOL emailRight = [emailTest evaluateWithObject:email];
    return emailRight;
    
}

#pragma mark - 返回按钮的点击事件
- (void)cancleBtnAtcion:(UIButton *)btn {
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - 确定按钮的点击事件
- (void)sureBtnAtcion33:(UIButton *)btn {
    

    if (self.textFiled.text.length == 0) {
        
        [UIAlertController creatRightAlertControllerWithHandle:nil andSuperViewController:self Title:@"输入为空"];
        
    } else {
       BOOL emailRight = [self isValidateEmail:self.textFiled.text];
        if (emailRight == 0) {
            
            [UIAlertController creatRightAlertControllerWithHandle:^{
                self.textFiled.text = nil;
            } andSuperViewController:self Title:@"你输入的邮箱格式错误,请重新输入"];
            
        } else {
            
            if (_delegate && [_delegate respondsToSelector:@selector(sendEmailAddressToPreviousVC:)]) {
                [_delegate sendEmailAddressToPreviousVC:_textFiled.text];
            }
            
            [self.navigationController popViewControllerAnimated:YES];
        }
    }
    
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}

- (void)setUserModel:(UserModel *)userModel {
    _userModel = userModel;
    if (_userModel.email) {
        self.textFiled.text = _userModel.email;
    }
}

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    _xianHuaXian.backgroundColor = kMainColor;
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    _xianHuaXian.backgroundColor = [UIColor lightGrayColor];
}

@end
