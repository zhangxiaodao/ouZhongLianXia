//
//  NiChengViewController.m
//  AEFT冷风扇
//
//  Created by 杭州阿尔法特 on 16/3/16.
//  Copyright © 2016年 阿尔法特. All rights reserved.
//

#import "NiChengViewController.h"
#import "UserMessageViewController.h"
@interface NiChengViewController ()
@property (nonatomic , strong) UIView *navView;
@property (nonatomic , strong) UITextField *textFiled;

@end

@implementation NiChengViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    

}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self setUI];
}

- (void)viewDidDisappear:(BOOL)animated {
    NSArray *array = [NSArray arrayWithArray:self.view.subviews];
    for (int i = 0; i < array.count; i++) {
        [array[i] removeFromSuperview];
    }
}

#pragma mark - 设置UI
- (void)setUI{

    
    UILabel *titleLable = [UILabel creatLableWithTitle:@"昵称" andSuperView:self.view andFont:k16 andTextAligment:NSTextAlignmentCenter];
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
    self.textFiled.keyboardType = UIKeyboardTypeDefault;
    [self.textFiled mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(kHeight + 20);
        make.size.mas_equalTo(CGSizeMake(kStandardW, kScreenW / 10));
        make.centerX.mas_equalTo(self.view.mas_centerX);
    }];
    
    UIView *xiaHuaXian2 = [[UIView alloc]init];
    [self.view addSubview:xiaHuaXian2];
    xiaHuaXian2.backgroundColor = kMainColor;
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
    [sureBtn addTarget:self action:@selector(sureBtnAtcion:) forControlEvents:UIControlEventTouchUpInside];
    
}


#pragma mark - 返回按钮的点击事件
- (void)cancleBtnAtcion:(UIButton *)btn {
    [self.navigationController popViewControllerAnimated:YES];
    
}

#pragma mark - 确定按钮的点击事件
- (void)sureBtnAtcion:(UIButton *)btn {
    
    if (self.textFiled.text.length == 0) {
        [UIAlertController creatRightAlertControllerWithHandle:nil andSuperViewController:self Title:@"输入为空"];
    } else {
        if (_delegate && [_delegate respondsToSelector:@selector(sendNickNameToPreviousVC:)]) {
            [_delegate sendNickNameToPreviousVC:self.textFiled.text];
        }
        
        [self.navigationController popViewControllerAnimated:YES];
    }

   
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

@end
