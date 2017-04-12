//
//  GengXinRiZhiViewController.m
//  AEFT冷风扇
//
//  Created by 杭州阿尔法特 on 16/5/5.
//  Copyright © 2016年 阿尔法特. All rights reserved.
//

#import "GengXinRiZhiViewController.h"

@interface GengXinRiZhiViewController ()<UIWebViewDelegate>{
    UIWebView *webView;
}
@property (nonatomic , strong) UIActivityIndicatorView *searchView;
@end

@implementation GengXinRiZhiViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self setUI];
}
#pragma mark - 设置UI
- (void)setUI {
    webView = [[UIWebView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview: webView];

    NSURLRequest *request =[NSURLRequest requestWithURL:[NSURL URLWithString:kGengXinRiZhi]];
    [webView loadRequest:request];
    webView.delegate = self;
    
    _searchView = [[UIActivityIndicatorView alloc]initWithFrame:kScreenFrame];
    _searchView.activityIndicatorViewStyle = UIActivityIndicatorViewStyleGray;
    [self.view addSubview:_searchView];
    [_searchView startAnimating];
}


- (void)webViewDidFinishLoad:(UIWebView *)webView {
    [_searchView removeFromSuperview];
}

@end
