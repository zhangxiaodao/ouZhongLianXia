//
//  HTMLGanYiJiViewController.m
//  联侠
//
//  Created by 杭州阿尔法特 on 2017/2/20.
//  Copyright © 2017年 张海昌. All rights reserved.
//

#import "HTMLGanYiJiViewController.h"

#import <JavaScriptCore/JavaScriptCore.h>
@interface HTMLGanYiJiViewController ()<UIWebViewDelegate>
@property (nonatomic , strong) UIWebView *webView;
@property (nonatomic , strong) UIActivityIndicatorView *searchView;

@property (nonatomic , strong) JSContext *context;
@end

@implementation HTMLGanYiJiViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getDryingMachineDeviceAtcion:) name:@"4332" object:nil];
    
    _webView = [[UIWebView alloc]initWithFrame:kScreenFrame];
    [self.view addSubview:_webView];
    _webView.backgroundColor = kMainColor;
    
    self.webView.delegate = self;

    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.serviceModel.indexUrl]]];
    
    _searchView = [[UIActivityIndicatorView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    [self.view addSubview:_searchView];
    _searchView.activityIndicatorViewStyle = UIActivityIndicatorViewStyleGray;
    [_searchView startAnimating];
    
    [self passValueWithBlock];
    
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    _context = [webView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
    
    __block typeof(self)bself = self;
    _context[@"PageLoadIOS"] = ^{
        
        if (bself.searchView) {
            bself.searchView.hidden = YES;
            
        }
        
        
        
        NSDictionary *userData = [NSDictionary dictionaryWithObjectsAndKeys:@(bself.userModel.sn) , @"userSn" , bself.serviceModel.devTypeSn , @"devTypeSn" , bself.serviceModel.devSn , @"devSn" , @(bself.serviceModel.userDeviceID) , @"UserDeviceID" , [NSString stringWithFormat:@"http://%@:8080/" , localhost] , @"ServieceIP" , bself.serviceModel.brand, @"BrandName" , nil];
        
        
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:userData options:NSJSONWritingPrettyPrinted error:nil];
        NSString *jsonStr = [[NSString alloc]initWithData:jsonData encoding:NSUTF8StringEncoding];
        NSLog(@"%@" , jsonStr);
        
        NSString *orderStr = [NSString stringWithFormat:@"GetUserData(%@)" , jsonStr];
        
        [bself.context evaluateScript:orderStr];
        
        if ([kStanderDefault objectForKey:@"4332Time"]) {
            NSLog(@"%@" , [kStanderDefault objectForKey:@"4332Time"]);
            NSString *time = [kStanderDefault objectForKey:@"4332Time"];
            NSString *sendTimeToHtml = [NSString stringWithFormat:@"GetWebData('%@')" , time];
            [bself.context evaluateScript:sendTimeToHtml];
        }
        
    };
    
    return YES;
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    
    _context[@"SaveWebDataAndroid"] = ^() {
        NSArray *parames = [JSContext currentArguments];
        NSString *arrStr = [[NSString alloc]init];
        for (id obj in parames) {
            arrStr = [arrStr stringByAppendingFormat:@"%@" , obj];
        }
        NSLog(@"%@" , arrStr);
    };

    _context[@"ShowRemind"] = ^() {
        NSArray *parames = [JSContext currentArguments];
        NSString *arrarString = [[NSString alloc]init];
        for (id obj in parames) {
            arrarString = [arrarString stringByAppendingFormat:@"%@" , obj];
        }
        NSLog(@"%@" , arrarString);
        
    };
}

- (void)passValueWithBlock {
    
    JSContext *context = [self.webView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
    __block typeof(self)bself = self;
    context[@"BackIOS"] = ^() {
        [bself.navigationController popViewControllerAnimated:YES];
        
    };
    
    context[@"OrderWebToIOS"] = ^() {
        NSArray *parames = [JSContext currentArguments];
        NSString *arrarString = [[NSString alloc]init];
        
        for (id obj in parames) {
            arrarString = [arrarString stringByAppendingFormat:@"%@" , obj];
        }
        
        
        NSArray *array = [arrarString componentsSeparatedByString:@","];
        
//        NSString *firstToHex = [[NSString ToHex:[array[9] intValue]] substringFromIndex:2];
        NSString *toHex = [[NSString ToHex:[array[9] intValue]] substringFromIndex:2];
        NSLog(@"arrarString--%@ , toHex--%@" , arrarString , toHex);
        [kStanderDefault setObject:toHex forKey:@"4332Time"];
        NSLog(@"%@" , GanYiJi4332SendToHostXieYi(self.serviceModel.devTypeSn, self.serviceModel.devSn, array[0], array[1], array[6], toHex));
        
        [kSocketTCP sendDataToHost:GanYiJi4332SendToHostXieYi(self.serviceModel.devTypeSn, self.serviceModel.devSn, array[0], array[1], array[6], toHex) andType:kZhiLing andIsNewOrOld:kNew];
    };
}


- (void)getDryingMachineDeviceAtcion:(NSNotification *)post {
    NSMutableString *sumStr = nil;
    sumStr = [NSMutableString stringWithString:post.userInfo[@"Message"]];
    for (NSInteger i = sumStr.length - 2; i > 0; i = i - 2) {
        [sumStr insertString:@"," atIndex:i];
    }
   
    
    NSString *callJSstring = nil;
    callJSstring = [NSString stringWithFormat:@"ReceiveOrder('%@')" , sumStr];
    
    NSLog(@"%@" , callJSstring);
    [_context evaluateScript:callJSstring];
    sumStr = nil;
    
}


@end
