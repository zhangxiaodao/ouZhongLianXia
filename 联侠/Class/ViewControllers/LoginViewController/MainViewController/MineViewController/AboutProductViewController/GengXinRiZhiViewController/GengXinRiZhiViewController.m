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
@property (nonatomic , strong) UIView *navView;
@end

@implementation GengXinRiZhiViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navView = [UIView creatNavView:self.view WithTarget:self action:@selector(backTap:) andTitle:@"更新日志"];
    
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
