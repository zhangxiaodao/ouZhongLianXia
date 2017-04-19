//
//  SystemMessageWebViewController.m
//  联侠
//
//  Created by 杭州阿尔法特 on 2017/2/5.
//  Copyright © 2017年 张海昌. All rights reserved.
//

#import "SystemMessageWebViewController.h"

@interface SystemMessageWebViewController ()<UIWebViewDelegate>
@property (nonatomic , strong) UIActivityIndicatorView *loadingView;
@end

@implementation SystemMessageWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithHexString:@"f2f4fb"];
    
    NSURL *url = [NSURL URLWithString:_model.url];
    UIWebView *webView = [[UIWebView alloc]initWithFrame:kScreenFrame];
    [self.view addSubview:webView];
    webView.delegate = self;

    [webView loadRequest:[NSURLRequest requestWithURL:url]];
    
    UIActivityIndicatorView *loadingView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    loadingView.frame = kScreenFrame;
    [self.view addSubview:loadingView];
    [loadingView startAnimating];
    self.loadingView = loadingView;
}

- (void)setModel:(SystemMessageModel *)model {
    _model = model;
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    [self.loadingView removeFromSuperview];
}

@end
