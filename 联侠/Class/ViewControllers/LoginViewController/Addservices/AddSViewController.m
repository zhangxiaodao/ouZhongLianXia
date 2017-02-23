//
//  AddSViewController.m
//  AEFT冷风扇
//
//  Created by 杭州阿尔法特 on 16/3/25.
//  Copyright © 2016年 阿尔法特. All rights reserved.
//

#import "AddSViewController.h"
//#import "AllServicesViewController.h"
#import "AllTypeServiceViewController.h"
@interface AddSViewController ()
@property (nonatomic , strong) UIView *navView;

@end

@implementation AddSViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBarHidden = YES;
    self.view.backgroundColor = kCOLOR(242, 242, 242);
    self.navView = [UIView creatNavView:self.view WithTarget:self action:@selector(backTap:) andTitle:@"添加设备"];

    if ([self.isFromBottomNav isEqualToString:@"YES"]) {
        UIView *iii = [self.navView.subviews objectAtIndex:0];
        UIImageView *jjj = [iii.subviews objectAtIndex:1];
        jjj.image = [jjj.image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
        jjj.tintColor = [UIColor whiteColor];
        
        UILabel *lable222 = self.navView.subviews[2];
        lable222.textColor = [UIColor whiteColor];
    }
    
    [self setUI];
}
#pragma mark - 返回主界面
- (void)backTap:(UITapGestureRecognizer *)tap {
    
    if ([self.isFromMainVC isEqualToString:@"YES"]) {
        [self.navigationController popViewControllerAnimated:YES];
    } else {
         return ;
    }
    
   
}

#pragma mark - 设置UI
- (void)setUI {
    UIImageView *imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"meiYouSheBei"]];
    [self.view addSubview:imageView];
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kScreenW / 4, kScreenH / 11));
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.top.mas_equalTo(self.view.mas_top).offset(kScreenH / 2.3);
    }];
    
    UILabel *lable = [UILabel creatLableWithTitle:@"暂时没有添加设备" andSuperView:self.view andFont:k17 andTextAligment:NSTextAlignmentCenter];
    [lable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kScreenW / 2, kScreenW / 10));
        make.top.mas_equalTo(imageView.mas_bottom).offset(kScreenW / 20);
        make.centerX.mas_equalTo(self.view.mas_centerX);
    }];
    lable.textColor = kCOLOR(212, 204, 196);
    lable.layer.borderWidth = 0;
    
    UIButton *button = [UIButton initWithTitle:@"添加设备" andColor:kFenGeXianYanSe andSuperView:self.view];
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kScreenW / 2, kScreenW / 10));
        make.top.mas_equalTo(lable.mas_bottom).offset(kScreenW / 10);
        make.centerX.mas_equalTo(self.view.mas_centerX);
    }];
    button.layer.cornerRadius = 5;
    button.layer.masksToBounds = YES;
    button.layer.borderWidth = 1;
    button.backgroundColor = [UIColor whiteColor];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];

    [button addTarget:self action:@selector(addSerViceAtcion:) forControlEvents:UIControlEventTouchUpInside];
    
    
}

- (void)addSerViceAtcion:(UIButton *)btn {
    AllTypeServiceViewController *allServiceVC = [[AllTypeServiceViewController alloc]init];
    [self.navigationController pushViewController:allServiceVC animated:YES];
}



@end
