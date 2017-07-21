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

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBar.hidden = false;
    self.navigationItem.title = self.serviceModel.typeName;
    self.navigationItem.leftBarButtonItem = nil;
    
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [backButton setImage:[UIImage imageNamed:@"navigationButtonReturn"] forState:UIControlStateNormal];
    [backButton setTitle:@"返回" forState:UIControlStateNormal];
    [backButton setTitleColor:[UIColor colorWithHexString:@"00a2ff"] forState:UIControlStateNormal];
    backButton.titleLabel.font = [UIFont systemFontOfSize:k15];
    [backButton sizeToFit];
    // 这句代码放在sizeToFit后面
    backButton.contentEdgeInsets = UIEdgeInsetsMake(0, -10, 0, 0);
    backButton.titleEdgeInsets = UIEdgeInsetsMake(0, 5, 0, 0);
    [backButton addTarget:self action:@selector(backAtcion) forControlEvents:UIControlEventTouchUpInside];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
    
}

- (void)backAtcion {
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - 设置UI
- (void)setUI {
    
    webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, kScreenW, kScreenH - kHeight)];
    [self.view addSubview: webView];
    webView.delegate = self;
    
    NSURL *url = [NSURL URLWithString:kServiceDescriptionURL(self.typeSn, self.serviceModel.typeSn)];
    
    if (_isFromMainVC) {
        url = [NSURL URLWithString:kServiceDescriptionURL(self.typeSn, self.serviceModel.devTypeSn)];
    }
    
    [webView loadRequest:[NSURLRequest requestWithURL:url]];
    
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
