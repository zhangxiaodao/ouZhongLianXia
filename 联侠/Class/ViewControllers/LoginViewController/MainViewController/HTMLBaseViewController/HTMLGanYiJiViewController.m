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
   
    NSLog(@"%@", self.serviceModel);
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getDryingMachineDeviceAtcion:) name:@"4332" object:nil];
    
    _webView = [[UIWebView alloc]init];
    [self.view addSubview:_webView];
    
    
    NSString *firstRun = [kStanderDefault objectForKey:@"firstRun"];
        
    if ([firstRun isEqualToString:@"YES"]) {
        _webView.frame = CGRectMake(0, 0, kScreenW, kScreenH);
    } else {
        _webView.frame = CGRectMake(0, 0, kScreenW, kScreenH + kScreenW / 7.5);
    }
    
    self.webView.delegate = self;

    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.serviceModel.indexUrl]]];
    
    _searchView = [[UIActivityIndicatorView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    [self.view addSubview:_searchView];
    _searchView.activityIndicatorViewStyle = UIActivityIndicatorViewStyleGray;
    [_searchView startAnimating];
    
    [self passValueWithBlock];
    
}

- (void)webViewDidStartLoad:(UIWebView *)webView {
    
    _context = [self.webView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
    NSString *callJSstring = nil;
    callJSstring = @"PageLoadIOS";
    [_context evaluateScript:callJSstring];
    
//    NSArray *keyArray = @[@"devTypeSn" , @"devSn" , @"UserDeviceID" , @"BrandName" , @"userSn" , @"ServieceIP"];
//    NSArray *valueArray = @[@(self.userModel.sn) , self.serviceModel.devTypeSn , self.serviceModel.devSn , @(self.serviceModel.userDeviceID) , localhost , self.serviceModel.brand];
//    NSMutableString *keyAndValueStr = [NSMutableString string];
    
    
    NSDictionary *userData = [NSDictionary dictionaryWithObjectsAndKeys:@(self.userModel.sn) , @"userSn" , self.serviceModel.devTypeSn , @"devTypeSn" , self.serviceModel.devSn , @"devSn" , @(self.serviceModel.userDeviceID) , @"UserDeviceID" , localhost , @"ServieceIP" , self.serviceModel.brand, @"BrandName" , nil];
//    NSMutableString *keyAndValueStr = [NSMutableString stringWithFormat:@"%@" , userData];
//    keyAndValueStr = [[keyAndValueStr substringWithRange:NSMakeRange(1, keyAndValueStr.length - 1)] mutableCopy];
    
    
    NSString *orderStr = [NSString stringWithFormat:@"GetUserData('%@')" , userData];
    NSLog(@"%@" , orderStr);
    [_context evaluateScript:orderStr];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    [_searchView removeFromSuperview];
    
    
    
    
}

- (void)passValueWithBlock {
    JSContext *context = [self.webView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
    context[@"BackIOS()"] = ^() {
        [self.navigationController popViewControllerAnimated:YES];
    };
    
    context[@"OrderWebToIOS"] = ^() {
        NSArray *parames = [JSContext currentArguments];
        NSString *arrarString = [[NSString alloc]init];
        for (id obj in parames) {
            arrarString = [arrarString stringByAppendingFormat:@"%@" , obj];
        }
        
        
        NSArray *array = [arrarString componentsSeparatedByString:@","];
//        NSLog(@"%@ , %@ ， %@" , array , arrarString ,GanYiJi4332SendToHostXieYi(self.serviceModel.devTypeSn, self.serviceModel.devSn, @"01", @"00", @"00", @"00"));
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
        }
        
        if (![array[9] isEqualToString:@"0"]) {
            [kSocketTCP sendDataToHost:GanYiJi4332SendToHostXieYi(self.serviceModel.devTypeSn, self.serviceModel.devSn, @"00", @"00", @"00", array[9]) andType:kZhiLing andIsNewOrOld:kNew];
        }
    };
}


- (void)getDryingMachineDeviceAtcion:(NSNotification *)post {
    NSString *str = post.userInfo[@"Message"];
    
    NSLog(@"%@" , str);
    NSString *devSn = [str substringWithRange:NSMakeRange(14, 12)];
    NSString *kaiGuan = [str substringWithRange:NSMakeRange(28, 2)];
    NSString *ozone = [str substringWithRange:NSMakeRange(30, 2)];
    NSString *power = [str substringWithRange:NSMakeRange(38, 2)];
    NSString *time = [str substringWithRange:NSMakeRange(44, 2)];
    NSLog(@"%@ , %@ , %@ , %@ , %@" , kaiGuan , devSn , ozone , power , time);
    
    if ([kaiGuan isEqualToString:@"02"]) {
        [self receiveOrderWith:@"02" withOrderType:@"kaiguan"];
    } else if ([kaiGuan isEqualToString:@"01"]) {
        [self receiveOrderWith:@"01" withOrderType:@"kaiguan"];
    }
    
    if ([ozone isEqualToString:@"01"]) {
        [self receiveOrderWith:@"01" withOrderType:@"ozone"];
    } else if ([ozone isEqualToString:@"02"]) {
        [self receiveOrderWith:@"02" withOrderType:@"ozone"];
    }
    
    if ([power isEqualToString:@"01"]) {
        [self receiveOrderWith:@"01" withOrderType:@"power"];
    } else if ([power isEqualToString:@"02"]) {
        [self receiveOrderWith:@"02" withOrderType:@"power"];
    }
    
    if ([time isEqualToString:@"00"]) {
        [self receiveOrderWith:time withOrderType:@"power"];
    }
}

- (void)receiveOrderWith:(NSString *)order withOrderType:(NSString *)orderType {
    JSContext *context = [self.webView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
    
    NSString *callJSstring = nil;
    
    if ([orderType isEqualToString:@"kaiguan"]) {
        callJSstring = [self sendOrderBytesToHTMLWith:GanYiJi4332SendToHTMLXieYi(order, @"00", @"00", @"00")];
    } else if ([orderType isEqualToString:@"ozone"]) {
        callJSstring = [self sendOrderBytesToHTMLWith:GanYiJi4332SendToHTMLXieYi(@"00", order, @"00", @"00")];
    } else if ([orderType isEqualToString:@"power"]) {
        callJSstring = [self sendOrderBytesToHTMLWith:GanYiJi4332SendToHTMLXieYi(@"00", @"00", order, @"00")];
    } else if ([orderType isEqualToString:@"time"]) {
        callJSstring = [self sendOrderBytesToHTMLWith:GanYiJi4332SendToHTMLXieYi(@"00", @"00", @"00", order)];
    }
    
    NSLog(@"%@" , callJSstring);
    
    //调用方法(注意：这里是JS里面的定义的方法)
    [context evaluateScript:callJSstring];
}

- (void)initStateModel {
    
    NSLog(@"%@" , self.stateModel);
    if (self.stateModel.fSwitch == 1) {
        
        [self receiveOrderWith:@"01" withOrderType:@"kaiguan"];
    } else if (self.stateModel.fSwitch == 2) {
        
        [self receiveOrderWith:@"02" withOrderType:@"kaiguan"];
    }
    
    
    
}

- (NSString *)sendOrderBytesToHTMLWith:(NSString *)order {
    NSMutableString *orderStr = [NSMutableString string];
    for (int i = 0; i < order.length; i = i + 2) {
        orderStr = [[orderStr stringByAppendingString:[NSString stringWithFormat:@"%@ ," , [order substringWithRange:NSMakeRange(i, 2)]]] mutableCopy];
    }
    orderStr = [[orderStr substringToIndex:orderStr.length - 1] mutableCopy];
    orderStr = [[@"[" stringByAppendingString:orderStr] mutableCopy];
    orderStr = [[orderStr stringByAppendingString:@"]"] mutableCopy];
    
    NSString *callStr = [NSString stringWithFormat:@"ReceiveOrder('%@')" , orderStr];
    return callStr;
    
}

@end
