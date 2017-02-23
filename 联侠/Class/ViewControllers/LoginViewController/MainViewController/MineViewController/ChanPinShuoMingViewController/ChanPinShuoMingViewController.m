//
//  ChanPinShuoMingViewController.m
//  AEFT冷风扇
//
//  Created by 杭州阿尔法特 on 16/3/16.
//  Copyright © 2016年 阿尔法特. All rights reserved.
//

#import "ChanPinShuoMingViewController.h"

@interface ChanPinShuoMingViewController (){
    UIWebView *webView;
}
@property (nonatomic , strong) UIView *navView;
@end

@implementation ChanPinShuoMingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.navView = [UIView creatNavView:self.view WithTarget:self action:@selector(backTap:) andTitle:@"产品说明"];
    [self setUI];
}

#pragma mark - 返回主界面
- (void)backTap:(UITapGestureRecognizer *)tap {
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - 设置UI
- (void)setUI {
    
    webView = [[UIWebView alloc] init];
    [self.view addSubview: webView];
    [webView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kScreenW, kScreenH - self.navView.height));
        make.top.mas_equalTo(self.navView.mas_bottom);
        make.centerX.mas_equalTo(self.view.mas_centerX);
    }];
    
    NSString *typeService = [_serviceModel.typeSn substringWithRange:NSMakeRange(0, 2)];
    if ([typeService isEqualToString:@"41"]) {
        [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:kChanPinShuoLengFengShan]]];
    } else if ([typeService isEqualToString:@"42"]) {
        [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:kChanPinShuoKongJing]]];
    } else if ([typeService isEqualToString:@"43"]) {
        [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:kChanPinShuoGanYiJi]]];
    }
}

- (void)setServiceModel:(ServicesModel *)serviceModel {
    _serviceModel = serviceModel;
}

@end
