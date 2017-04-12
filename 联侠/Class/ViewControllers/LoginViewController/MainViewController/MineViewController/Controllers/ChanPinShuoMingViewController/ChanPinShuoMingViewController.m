//
//  ChanPinShuoMingViewController.m
//  AEFT冷风扇
//
//  Created by 杭州阿尔法特 on 16/3/16.
//  Copyright © 2016年 阿尔法特. All rights reserved.
//

#import "ChanPinShuoMingViewController.h"

@interface ChanPinShuoMingViewController ()<UIWebViewDelegate>{
    UIWebView *webView;
}
@property (nonatomic , strong) UIActivityIndicatorView *searchView;
@end

@implementation ChanPinShuoMingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithHexString:@"f2f4fb"];
    
    [self setUI];
}

#pragma mark - 设置UI
- (void)setUI {
    
    webView = [[UIWebView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview: webView];
    webView.delegate = self;
    
    NSString *typeService = [_serviceModel.typeSn substringWithRange:NSMakeRange(0, 2)];
    if ([typeService isEqualToString:@"41"]) {
        [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:kChanPinShuoLengFengShan]]];
    } else if ([typeService isEqualToString:@"42"]) {
        [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:kChanPinShuoKongJing]]];
    } else if ([typeService isEqualToString:@"43"]) {
        [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:kChanPinShuoGanYiJi]]];
    }
    
    _searchView = [[UIActivityIndicatorView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    [self.view addSubview:_searchView];
    _searchView.activityIndicatorViewStyle = UIActivityIndicatorViewStyleGray;
    [_searchView startAnimating];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    [_searchView removeFromSuperview];
}

- (void)setServiceModel:(ServicesModel *)serviceModel {
    _serviceModel = serviceModel;
}

@end
