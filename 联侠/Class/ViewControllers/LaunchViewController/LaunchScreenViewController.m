//
//  LaunchScreenViewController.m
//  联侠
//
//  Created by 杭州阿尔法特 on 2017/1/11.
//  Copyright © 2017年 张海昌. All rights reserved.
//

#import "LaunchScreenViewController.h"

@interface LaunchScreenViewController ()

@end

@implementation LaunchScreenViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIImageView *imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"mainpng1"]];
    [self.view addSubview:imageView];
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.top.mas_equalTo(self.view.mas_top).mas_equalTo(kScreenH / 4.3);
        make.size.mas_equalTo(CGSizeMake(kStandardW, kScreenH / 14));
    }];
    
    
    UIImageView *bottomImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"mainactivity"]];
    [self.view addSubview:bottomImageView];
    [bottomImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.top.mas_equalTo(imageView.mas_bottom);
        make.size.mas_equalTo(CGSizeMake(kScreenW, kScreenH / 1.55));
    }];
    bottomImageView.contentMode = UIViewContentModeScaleAspectFit;
    
    _maskView = [[UIView alloc]initWithFrame:kScreenFrame];
    [self.view addSubview:_maskView];
    _maskView.backgroundColor = [UIColor whiteColor];
   
    
}

@end
