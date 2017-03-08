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
@property (nonatomic , strong) UIView *navView;
@property (nonatomic , strong) UIActivityIndicatorView *searchView;
@end

@implementation MineYouHuiQuanViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor whiteColor];
    
    if ([_fromMineVC isEqualToString:@"YES"]) {
        self.navView = [UIView creatNavView:self.view WithTarget:self action:@selector(backTap:) andTitle:@"优惠券"];
    } else {
        self.navView = [UIView creatNavView:self.view WithTarget:self action:@selector(backTap:) andTitle:@"在线帮助"];
    }
    
    
    [self setUI];
}
#pragma mark - 返回主界面
- (void)backTap:(UITapGestureRecognizer *)tap {
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - 设置UI
- (void)setUI {
    UILabel *lable = [UILabel creatLableWithTitle:@"敬请期待" andSuperView:self.view andFont:k20 andTextAligment:NSTextAlignmentCenter];
    lable.layer.borderWidth = 0;
    [lable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kScreenW, kScreenW / 10));
        make.left.mas_equalTo(0);
        make.centerY.mas_equalTo(self.view.mas_centerY);
    }];
    
    if ([_fromMineVC isEqualToString:@"YES"]) {
        UILabel *lable = [UILabel creatLableWithTitle:@"敬请期待" andSuperView:self.view andFont:k20 andTextAligment:NSTextAlignmentCenter];
        lable.layer.borderWidth = 0;
        [lable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(kScreenW, kScreenW / 10));
            make.left.mas_equalTo(0);
            make.centerY.mas_equalTo(self.view.mas_centerY);
        }];
    } else {
        webView = [[UIWebView alloc] init];
        [self.view addSubview: webView];
        [webView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(kScreenW, kScreenH - self.navView.height));
            make.top.mas_equalTo(self.navView.mas_bottom);
            make.centerX.mas_equalTo(self.view.mas_centerX);
        }];
        NSURLRequest *request =[NSURLRequest requestWithURL:[NSURL URLWithString:kZaiXianBangZhu]];
        [webView loadRequest:request];
        webView.delegate = self;
        
        _searchView = [[UIActivityIndicatorView alloc]initWithFrame:kScreenFrame];
        _searchView.activityIndicatorViewStyle = UIActivityIndicatorViewStyleGray;
        [self.view addSubview:_searchView];
        [_searchView startAnimating];
    }
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    [_searchView removeFromSuperview];
}

@end
