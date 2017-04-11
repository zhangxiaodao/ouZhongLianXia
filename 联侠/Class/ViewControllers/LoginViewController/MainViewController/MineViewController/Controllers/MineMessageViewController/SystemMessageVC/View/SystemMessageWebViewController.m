//
//  SystemMessageWebViewController.m
//  联侠
//
//  Created by 杭州阿尔法特 on 2017/2/5.
//  Copyright © 2017年 张海昌. All rights reserved.
//

#import "SystemMessageWebViewController.h"

@interface SystemMessageWebViewController ()<UIWebViewDelegate>
@property (nonatomic , strong) UIView *navView;
@property (nonatomic , strong) UIActivityIndicatorView *loadingView;
@end

@implementation SystemMessageWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    self.navView = [UIView creatNavView:self.view WithTarget:self action:@selector(backTap:) andTitle:@"系统消息"];
    
    NSURL *url = [NSURL URLWithString:_model.url];
    UIWebView *webView = [[UIWebView alloc]initWithFrame:CGRectZero];
    [self.view addSubview:webView];
    [webView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kScreenW, kScreenH - kScreenH / 14 - 23));
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.top.mas_equalTo(self.navView.mas_bottom);
        
    }];
    webView.delegate = self;
//    webView.backgroundColor = [UIColor whiteColor];
    [webView loadRequest:[NSURLRequest requestWithURL:url]];
    
    UIActivityIndicatorView *loadingView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    loadingView.frame = kScreenFrame;
    [self.view addSubview:loadingView];
    [loadingView startAnimating];
    self.loadingView = loadingView;
}

#pragma mark - 返回主界面
- (void)backTap:(UITapGestureRecognizer *)tap {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)setModel:(SystemMessageModel *)model {
    _model = model;
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    [self.loadingView removeFromSuperview];
}

@end
