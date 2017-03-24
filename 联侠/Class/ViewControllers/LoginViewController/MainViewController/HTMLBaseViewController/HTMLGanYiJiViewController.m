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
    
    
//    NSString *firstRun = [kStanderDefault objectForKey:@"firstRun"];
//        
//    if ([firstRun isEqualToString:@"YES"]) {
//        _webView.frame = CGRectMake(0, 0, kScreenW, kScreenH);
//    } else {
//        _webView.frame = CGRectMake(0, 0, kScreenW, kScreenH + kScreenW / 7.5);
//    }
    
    self.webView.delegate = self;

    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.serviceModel.indexUrl]]];
    
    _searchView = [[UIActivityIndicatorView alloc]initWithFrame:[UIScreen mainScreen].bounds];
//    [self.view addSubview:_searchView];
    _searchView.activityIndicatorViewStyle = UIActivityIndicatorViewStyleGray;
    [_searchView startAnimating];
    
    [self passValueWithBlock];
    
}

- (void)webViewDidStartLoad:(UIWebView *)webView {
    
    
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    [_searchView removeFromSuperview];
    
    _context = [self.webView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
//    NSString *callJSstring = nil;
//    callJSstring = @"PageLoadIOS()";
//    [_context evaluateScript:callJSstring];
    
    __block typeof(self)bself = self;
    _context[@"PageLoadIOS"] = ^{
//        NSDictionary *userData = [NSDictionary dictionaryWithObjectsAndKeys:@(bself.userModel.sn) , @"userSn" , bself.serviceModel.devTypeSn , @"devTypeSn" , bself.serviceModel.devSn , @"devSn" , @(bself.serviceModel.userDeviceID) , @"UserDeviceID" , [NSString stringWithFormat:@"http://%@:8080/" , localhost] , @"ServieceIP" , bself.serviceModel.brand, @"BrandName" , nil];
        
        NSMutableString *sumStr = [NSMutableString string];
        NSString *userSnStr = [NSString stringWithFormat:@"userSn:%@" , @(bself.userModel.sn)];
        NSString *devTypeSnStr = [NSString stringWithFormat:@"devTypeSn:%@" , bself.serviceModel.devTypeSn];
        NSString *devSnStr = [NSString stringWithFormat:@"devSn:%@" , bself.serviceModel.devSn];
        NSString *UserDeviceIDStr = [NSString stringWithFormat:@"UserDeviceID:%@" , @(bself.serviceModel.userDeviceID)];
        NSString *ServieceIPStr = [NSString stringWithFormat:@"ServieceIP:%@" , [NSString stringWithFormat:@"http://%@:8080/" , localhost]];
        NSString *BrandNameStr = [NSString stringWithFormat:@"BrandName:%@" , bself.serviceModel.brand];
        
        NSArray *strArray = @[userSnStr , devTypeSnStr , devSnStr , UserDeviceIDStr , ServieceIPStr , BrandNameStr];
        for (int i = 0; i < strArray.count; i++) {
            sumStr = [[sumStr stringByAppendingFormat:@"%@", [NSString stringWithFormat:@"%@," , strArray[i]]] mutableCopy];
        }
        
        sumStr = [[@"{" stringByAppendingString:sumStr] mutableCopy];
        sumStr = [[sumStr stringByAppendingString:@"}"] mutableCopy];
        
        NSString *orderStr = [NSString stringWithFormat:@"GetUserData('%@')" , sumStr];
//        orderStr = [orderStr stringByReplacingOccurrencesOfString:@"=" withString:@":"];
        NSLog(@"%@" , orderStr);
        [bself.context evaluateScript:orderStr];
    };
    
//    JSContext *context = [self.webView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
//    NSString *callJSstring = nil;
//    callJSstring = @"PageLoadIOS";
//    [context evaluateScript:callJSstring];
//    
//    NSDictionary *userData = [NSDictionary dictionaryWithObjectsAndKeys:@(self.userModel.sn) , @"userSn" , self.serviceModel.devTypeSn , @"devTypeSn" , self.serviceModel.devSn , @"devSn" , @(self.serviceModel.userDeviceID) , @"UserDeviceID" , [NSString stringWithFormat:@"http://%@:8080/" , localhost] , @"ServieceIP" , self.serviceModel.brand, @"BrandName" , nil];
//
//    NSString *orderStr = [NSString stringWithFormat:@"GetUserData('%@')" , userData];
//    orderStr = [orderStr stringByReplacingOccurrencesOfString:@"=" withString:@":"];
//    NSLog(@"%@" , orderStr);
//    [_context evaluateScript:orderStr];
    
    NSMutableString *sumStr = [NSMutableString string];
    NSString *userSnStr = [NSString stringWithFormat:@"userSn:%@" , @(bself.userModel.sn)];
    NSString *devTypeSnStr = [NSString stringWithFormat:@"devTypeSn:%@" , bself.serviceModel.devTypeSn];
    NSString *devSnStr = [NSString stringWithFormat:@"devSn:%@" , bself.serviceModel.devSn];
    NSString *UserDeviceIDStr = [NSString stringWithFormat:@"UserDeviceID:%@" , @(bself.serviceModel.userDeviceID)];
    NSString *ServieceIPStr = [NSString stringWithFormat:@"ServieceIP:%@" , [NSString stringWithFormat:@"http://%@:8080/" , localhost]];
    NSString *BrandNameStr = [NSString stringWithFormat:@"BrandName:%@" , bself.serviceModel.brand];
    
    NSArray *strArray = @[userSnStr , devTypeSnStr , devSnStr , UserDeviceIDStr , ServieceIPStr , BrandNameStr];
    for (int i = 0; i < strArray.count; i++) {
        sumStr = [[sumStr stringByAppendingFormat:@"%@", [NSString stringWithFormat:@"%@," , strArray[i]]] mutableCopy];
    }
    
    sumStr = [[@"{" stringByAppendingString:sumStr] mutableCopy];
    sumStr = [[sumStr substringToIndex:(sumStr.length - 1)] mutableCopy];
    sumStr = [[sumStr stringByAppendingString:@"}"] mutableCopy];
    
    NSString *orderStr = [NSString stringWithFormat:@"GetUserData('%@')" , sumStr];
    //        orderStr = [orderStr stringByReplacingOccurrencesOfString:@"=" withString:@":"];
    NSLog(@"%@" , orderStr);
    [bself.context evaluateScript:orderStr];
    
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
        NSLog(@"array--%@" , arrarString);
        if ([array[0] isEqualToString:@"2"]) {
            [kSocketTCP sendDataToHost:GanYiJi4332SendToHostXieYi(self.serviceModel.devTypeSn, self.serviceModel.devSn, @"02", @"00", @"00", @"00") andType:kZhiLing andIsNewOrOld:kNew];
            
        } else if ([array[0] isEqualToString:@"1"]) {
            [kSocketTCP sendDataToHost:GanYiJi4332SendToHostXieYi(self.serviceModel.devTypeSn, self.serviceModel.devSn, @"01", @"00", @"00", @"00") andType:kZhiLing andIsNewOrOld:kNew];
            
        }
        
        if ([array[1] isEqualToString:@"1"]) {
            [kSocketTCP sendDataToHost:GanYiJi4332SendToHostXieYi(self.serviceModel.devTypeSn, self.serviceModel.devSn, @"00", @"01", @"00", @"00") andType:kZhiLing andIsNewOrOld:kNew];
        } else if ([array[1] isEqualToString:@"2"]) {
            [kSocketTCP sendDataToHost:GanYiJi4332SendToHostXieYi(self.serviceModel.devTypeSn, self.serviceModel.devSn, @"00", @"02", @"00", @"00") andType:kZhiLing andIsNewOrOld:kNew];
        }
        
        if ([array[6] isEqualToString:@"1"]) {
            [kSocketTCP sendDataToHost:GanYiJi4332SendToHostXieYi(self.serviceModel.devTypeSn, self.serviceModel.devSn, @"00", @"00", @"01", @"00") andType:kZhiLing andIsNewOrOld:kNew];
        } else if ([array[6] isEqualToString:@"2"]) {
            [kSocketTCP sendDataToHost:GanYiJi4332SendToHostXieYi(self.serviceModel.devTypeSn, self.serviceModel.devSn, @"00", @"00", @"02", @"00") andType:kZhiLing andIsNewOrOld:kNew];
        } else if ([array[6] isEqualToString:@"3"]) {
            [kSocketTCP sendDataToHost:GanYiJi4332SendToHostXieYi(self.serviceModel.devTypeSn, self.serviceModel.devSn, @"00", @"00", @"03", @"00") andType:kZhiLing andIsNewOrOld:kNew];
        }
        
        if (![array[9] isEqualToString:@"0"]) {
            [kSocketTCP sendDataToHost:GanYiJi4332SendToHostXieYi(self.serviceModel.devTypeSn, self.serviceModel.devSn, @"00", @"00", @"00", array[9]) andType:kZhiLing andIsNewOrOld:kNew];
        }
    };
}


- (void)getDryingMachineDeviceAtcion:(NSNotification *)post {
    NSArray *devArray = post.userInfo[@"Message"];
    
    NSString *callJSstring = nil;
    callJSstring = [NSString stringWithFormat:@"ReceiveOrder('%@')" , devArray];
    
    NSLog(@"%@" , callJSstring);
    [_context evaluateScript:callJSstring];
    
}


@end
