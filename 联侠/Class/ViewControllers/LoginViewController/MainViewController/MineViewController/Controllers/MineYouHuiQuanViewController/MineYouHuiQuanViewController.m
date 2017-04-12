//
//  MineYouHuiQuanViewController.m
//  AEFT冷风扇
//
//  Created by 杭州阿尔法特 on 16/3/16.
//  Copyright © 2016年 阿尔法特. All rights reserved.
//

#import "MineYouHuiQuanViewController.h"

@interface MineYouHuiQuanViewController ()<UIWebViewDelegate>{
    UIWebView *webView;
}
@property (nonatomic , strong) UIActivityIndicatorView *searchView;
@end

@implementation MineYouHuiQuanViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor colorWithHexString:@"f2f4fb"];
    
    
    [self setUI];
}
#pragma mark - 设置UI
- (void)setUI {
    webView = [[UIWebView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview: webView];
    NSURLRequest *request =[NSURLRequest requestWithURL:[NSURL URLWithString:kZaiXianBangZhu]];
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
