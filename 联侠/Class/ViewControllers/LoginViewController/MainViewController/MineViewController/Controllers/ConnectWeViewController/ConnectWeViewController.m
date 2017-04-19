//
//  ConnectWeViewController.m
//  AEFT冷风扇
//
//  Created by 杭州阿尔法特 on 16/3/16.
//  Copyright © 2016年 阿尔法特. All rights reserved.
//

#import "ConnectWeViewController.h"

@interface ConnectWeViewController ()<UIWebViewDelegate>{
    UIWebView *webView;
}

@property (nonatomic , strong) UITableView *tableView;
@property (nonatomic , strong) UIActivityIndicatorView *searchView;
@end

@implementation ConnectWeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithHexString:@"f2f4fb"];
    
    [self setUI];
}

#pragma mark - 设置UI
- (void)setUI {
    
    webView = [[UIWebView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview: webView];
    
    NSURLRequest *request =[NSURLRequest requestWithURL:[NSURL URLWithString:kAboutOurs]];
    [webView loadRequest:request];
    webView.delegate = self;
    
    _searchView = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    _searchView.frame = kScreenFrame;
    [self.view addSubview:_searchView];
    [_searchView startAnimating];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    [_searchView removeFromSuperview];
}

@end
