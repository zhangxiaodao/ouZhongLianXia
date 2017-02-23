//
//  ConnectWeViewController.m
//  AEFT冷风扇
//
//  Created by 杭州阿尔法特 on 16/3/16.
//  Copyright © 2016年 阿尔法特. All rights reserved.
//

#import "ConnectWeViewController.h"

@interface ConnectWeViewController (){
    UIWebView *webView;
}
@property (nonatomic , strong) UIView *navView;
@property (nonatomic , strong) UITableView *tableView;
@end

@implementation ConnectWeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.navView = [UIView creatNavView:self.view WithTarget:self action:@selector(backTap:) andTitle:@"联系我们"];
    
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
    NSURLRequest *request =[NSURLRequest requestWithURL:[NSURL URLWithString:kAboutOurs]];
    
    [webView loadRequest:request];
    
}
@end
