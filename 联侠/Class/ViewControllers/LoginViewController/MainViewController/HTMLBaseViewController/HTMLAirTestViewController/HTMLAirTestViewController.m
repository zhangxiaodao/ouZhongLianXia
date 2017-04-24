//
//  HTMLAirTestViewController.m
//  联侠
//
//  Created by 杭州阿尔法特 on 2016/12/1.
//  Copyright © 2016年 张海昌. All rights reserved.
//

#import "HTMLAirTestViewController.h"
#import <JavaScriptCore/JavaScriptCore.h>

@interface HTMLAirTestViewController ()<UIWebViewDelegate>
@property (nonatomic , assign) BOOL order;
@property (nonatomic , strong) UIWebView *webView;
@property (nonatomic , strong) UIActivityIndicatorView *searchView;
@end

@implementation HTMLAirTestViewController

//- (void)viewDidLoad {
//    [super viewDidLoad];
//    
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getAirStaticDeviceAtcion:) name:@"4231" object:nil];
//    
//    _order = NO;
//   
//    
//    _webView = [[UIWebView alloc]init];
//    [self.view addSubview:_webView];
//    
//    
//    NSString *firstRun = [kStanderDefault objectForKey:@"firstRun"];
//    
////    _webView.frame = CGRectMake(0, 0, kScreenW, kScreenH);
//    
//    if ([firstRun isEqualToString:@"YES"]) {
//        _webView.frame = CGRectMake(0, 0, kScreenW, kScreenH);
//    } else {
//        _webView.frame = CGRectMake(0, 0, kScreenW, kScreenH + kScreenW / 7.5);
//    }
//    
//    self.webView.delegate = self;
////     [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://192.168.1.167:8080/tipjack1/index.html"]]];
//    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://192.168.1.106:8080/test/index.html"]]];
//    
//    _searchView = [[UIActivityIndicatorView alloc]initWithFrame:[UIScreen mainScreen].bounds];
//    [self.view addSubview:_searchView];
//    _searchView.activityIndicatorViewStyle = UIActivityIndicatorViewStyleGray;
//    [_searchView startAnimating];
//    
//    [self passValueWithBlock];
//    
//}
//
//- (void)webViewDidFinishLoad:(UIWebView *)webView {
//    [_searchView removeFromSuperview];
//
//    JSContext *context = [self.webView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
//    NSString *callJSstring = nil;
//    callJSstring = @"PageLoadIOS()";
//    [context evaluateScript:callJSstring];
//}
//
//- (void)passValueWithBlock {
//    JSContext *context = [self.webView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
//    context[@"BackIOS"] = ^() {
//        [self.navigationController popViewControllerAnimated:YES];
//    };
//    
//    context[@"OrderWebToIOS"] = ^() {
//        NSArray *parames = [JSContext currentArguments];
//        NSString *arrarString = [[NSString alloc]init];
//        for (id obj in parames) {
//            arrarString = [arrarString stringByAppendingFormat:@"%@" , obj];
//        }
//        
//        if ([arrarString isEqualToString:@"2"]) {
//            [kSocketTCP sendDataToHost:[NSString stringWithFormat:@"HMFF%@%@S2#", self.serviceModel.devTypeSn,self.serviceModel.devSn] andType:kZhiLing andIsNewOrOld:kOld];
//            _order = NO;
//        } else if ([arrarString isEqualToString:@"1"]) {
//            [kSocketTCP sendDataToHost:[NSString stringWithFormat:@"HMFF%@%@S1#", self.serviceModel.devTypeSn,self.serviceModel.devSn] andType:kZhiLing andIsNewOrOld:kOld];
//            _order = YES;
//        }
//        
//        
//    };
//}
//
//
//- (void)getAirStaticDeviceAtcion:(NSNotification *)post {
//    NSString *str = post.userInfo[@"Message"];
//    
//    NSString *kaiGuan = [str substringWithRange:NSMakeRange(30, 2)];
//    NSString *devSn = [str substringWithRange:NSMakeRange(14, 12)];
//    NSLog(@"%@ , %@" , kaiGuan , devSn);
//    
//    if ([kaiGuan isEqualToString:@"02"]) {
//        [self ReceiveOrder];
//    } else if ([kaiGuan isEqualToString:@"01"]) {
//        [self ReceiveOrder];
//    }
//    
//}
//
//- (void)ReceiveOrder {
//    JSContext *context = [self.webView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
//    
//    NSString *callJSstring = nil;
//    if (_order) {
//        callJSstring = @"ReceiveOrder('1')";
//    } else {
//        callJSstring = @"ReceiveOrder('2')";
//    }
//    
//    //调用方法(注意：这里是JS里面的定义的方法)
//    
//    [context evaluateScript:callJSstring];
//}


@end
