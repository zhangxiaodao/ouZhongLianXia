//
//  JianChaGengXinViewController.m
//  AEFT冷风扇
//
//  Created by 杭州阿尔法特 on 16/5/5.
//  Copyright © 2016年 阿尔法特. All rights reserved.
//

#import "JianChaGengXinViewController.h"

@interface JianChaGengXinViewController ()
@property (nonatomic , strong) UIView *navView;
@end

@implementation JianChaGengXinViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navView = [UIView creatNavView:self.view WithTarget:self action:@selector(backTap:) andTitle:@"检查更新"];
    
    [self setUI];
    
}
#pragma mark - 返回主界面
- (void)backTap:(UITapGestureRecognizer *)tap {
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - 设置UI
- (void)setUI {
    UILabel *lable = [UILabel creatLableWithTitle:@"敬请期待" andSuperView:self.view andFont:k20 andTextAligment:NSTextAlignmentCenter];
    lable.layer.borderWidth = 0;
    [lable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kScreenW, kScreenW / 10));
        make.left.mas_equalTo(0);
        make.centerY.mas_equalTo(self.view.mas_centerY);
    }];
    
}


@end
