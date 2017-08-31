//
//  HTMLBaseViewController.m
//  联侠
//
//  Created by 杭州阿尔法特 on 2016/12/1.
//  Copyright © 2016年 张海昌. All rights reserved.
//

#import "HTMLBaseViewController.h"
#import "AllServicesViewController.h"
#import <JavaScriptCore/JavaScriptCore.h>
@interface HTMLBaseViewController ()<HelpFunctionDelegate , UIWebViewDelegate>


@end

@implementation HTMLBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [kStanderDefault setObject:@"YES" forKey:@"Login"];
    
    NSDictionary *parames = nil;
    if ([kStanderDefault objectForKey:@"GeTuiClientId"]) {
        parames = @{@"loginName" : [kStanderDefault objectForKey:@"phone"] , @"password" : [kStanderDefault objectForKey:@"password"] , @"ua.clientId" : [kStanderDefault objectForKey:@"GeTuiClientId"], @"ua.phoneType" : @(2), @"ua.phoneBrand":@"iPhone" , @"ua.phoneModel":[NSString getDeviceName] , @"ua.phoneSystem":[NSString getDeviceSystemVersion]};
    } else {
        parames = @{@"loginName" : [kStanderDefault objectForKey:@"phone"] , @"password" : [kStanderDefault objectForKey:@"password"] , @"ua.phoneType" : @(2), @"ua.phoneBrand":@"iPhone" , @"ua.phoneModel":[NSString getDeviceName] , @"ua.phoneSystem":[NSString getDeviceSystemVersion]};
    }
    
    [HelpFunction requestDataWithUrlString:kLogin andParames:parames andDelegate:self];
    
    
    
    _webView = [[UIWebView alloc]initWithFrame:kScreenFrame];
    [self.view addSubview:_webView];
    _webView.scrollView.scrollEnabled = NO;
    _webView.backgroundColor = [UIColor clearColor];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:YES];
    self.webView.delegate = self;
    
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.serviceModel.indexUrl]]];
    
    _searchView = [[UIActivityIndicatorView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    [self.view addSubview:_searchView];
    _searchView.activityIndicatorViewStyle = UIActivityIndicatorViewStyleGray;
    [_searchView startAnimating];
    
    [self passValueWithBlock];
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getMachineDeviceAtcion:) name:kServiceOrder object:nil];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:YES animated:animated];
    
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    [self.navigationController setNavigationBarHidden:NO animated:animated];
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    _context = [webView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
    
    __block typeof(self)bself = self;
    
    _context[@"PageLoadIOS"] = ^{
        
        if (bself.searchView) {
            bself.searchView.hidden = YES;
        }
        
        NSDictionary *userData = nil;
        if ([bself.serviceModel.brand isKindOfClass:[NSNull class]]) {
            userData = [NSDictionary dictionaryWithObjectsAndKeys:@(bself.userModel.sn) , @"userSn" , bself.serviceModel.devTypeSn , @"devTypeSn" , bself.serviceModel.devSn , @"devSn" , @(bself.serviceModel.userDeviceID) , @"UserDeviceID" , [NSString stringWithFormat:@"http://%@:8080/" , localhost] , @"ServieceIP" , nil];
        } else {
            userData = [NSDictionary dictionaryWithObjectsAndKeys:@(bself.userModel.sn) , @"userSn" , bself.serviceModel.devTypeSn , @"devTypeSn" , bself.serviceModel.devSn , @"devSn" , @(bself.serviceModel.userDeviceID) , @"UserDeviceID" , [NSString stringWithFormat:@"http://%@:8080/" , localhost] , @"ServieceIP" , [NSString stringWithFormat:@"%@%@" , bself.serviceModel.brand , bself.serviceModel.typeName], @"BrandName" , nil];
        }
        
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:userData options:NSJSONWritingPrettyPrinted error:nil];
        NSString *jsonStr = [[NSString alloc]initWithData:jsonData encoding:NSUTF8StringEncoding];
        
        
        NSString *orderStr = [NSString stringWithFormat:@"GetUserData(%@)" , jsonStr];
        [bself.context evaluateScript:orderStr];
        
        NSString *key = [NSString stringWithFormat:@"%@" , NSStringFromClass([bself.navigationController.childViewControllers[1] class])];
        
        if ([kStanderDefault objectForKey:key]) {

            NSString *time = [kStanderDefault objectForKey:key];
            NSString *sendTimeToHtml = [NSString stringWithFormat:@"GetWebData(%@)" , time];
            NSLog(@"%@" , sendTimeToHtml);
            [bself.context evaluateScript:sendTimeToHtml];
        }
        
    };
    
    return YES;
}


- (void)webViewDidFinishLoad:(UIWebView *)webView {
    
        
//    __block typeof(self)bself = self;
    __block typeof (self)bself = self;
    _context[@"ShowRemind"] = ^() {
        NSArray *parames = [JSContext currentArguments];
        NSString *arrarString = [[NSString alloc]init];
        for (id obj in parames) {
            arrarString = [arrarString stringByAppendingFormat:@"%@" , obj];
        }
        NSLog(@"%@" , arrarString);
        
        [UIAlertController creatCancleAndRightAlertControllerWithHandle:nil andSuperViewController:bself Title:arrarString];
        
    };
}


- (void)passValueWithBlock {
    
    JSContext *context = [self.webView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
    __block typeof(self)bself = self;
    context[@"BackIOS"] = ^() {
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [bself.navigationController popViewControllerAnimated:YES];
        });
        
    };
    
    context[@"OrderWebToIOS"] = ^() {
        NSArray *parames = [JSContext currentArguments];
        NSString *arrarString = [[NSString alloc]init];
        
        for (id obj in parames) {
            arrarString = [arrarString stringByAppendingFormat:@"%@" , obj];
        }
        
        
        NSArray *array = [arrarString componentsSeparatedByString:@","];
        
        NSMutableString *sumStr = [NSMutableString string];
        [sumStr appendFormat:@"%@", [NSString stringWithFormat:@"HMFFM%@%@w" , self.serviceModel.devTypeSn, self.serviceModel.devSn]];
        
        for (NSString *sub in array) {
            
            if (sub.length == 1) {
                [sumStr appendFormat:@"0%@", sub];
            } else {
                [sumStr appendFormat:@"%@", sub];
            }
        }
        
        [sumStr appendString:@"#"];
        
        NSLog(@"发送给TCP的命令%@ , %@" , sumStr , parames);
        
        [kSocketTCP sendDataToHost:sumStr andType:kZhiLing andIsNewOrOld:kNew];
    };
}

- (void)getMachineDeviceAtcion:(NSNotification *)post {
    NSMutableString *sumStr = nil;
    sumStr = [NSMutableString stringWithString:post.userInfo[@"Message"]];
    
    for (NSInteger i = sumStr.length - 2; i > 0; i = i - 2) {
        [sumStr insertString:@"," atIndex:i];
    }
    
    
    NSString *callJSstring = nil;
    callJSstring = [NSString stringWithFormat:@"ReceiveOrder('%@')" , sumStr];
    
    NSLog(@"发送给H5的命令%@" , callJSstring);
    
    if (_context == nil || callJSstring == nil) {
        return ;
    }
    
    [_context evaluateScript:callJSstring];
    sumStr = nil;
    
}


- (void)requestData:(HelpFunction *)request didFinishLoadingDtaArray:(NSMutableArray *)data {
    NSDictionary *dic = data[0];
//    NSLog(@"%@" , dic);
    if ([dic[@"state"] integerValue] == 0) {
        
        NSDictionary *user = dic[@"data"];
        
        [kStanderDefault setObject:user[@"sn"] forKey:@"userSn"];
        [kStanderDefault setObject:user[@"id"] forKey:@"userId"];
        
        _userModel = [[UserModel alloc]init];
        for (NSString *key in [user allKeys]) {
            [_userModel setValue:user[key] forKey:key];
        }
        
        [self webView:_webView shouldStartLoadWithRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@""]] navigationType:UIWebViewNavigationTypeLinkClicked];
    }
}

- (void)requestData:(HelpFunction *)request didFailLoadData:(NSError *)error {
    NSLog(@"%@" , error);
}

- (void)setServiceModel:(ServicesModel *)serviceModel {
    _serviceModel = serviceModel;
    
    NSLog(@"%@" , _serviceModel);
    
    
}


- (NSMutableDictionary *)dic {
    if (!_dic) {
        _dic = [NSMutableDictionary dictionary];
    }
    return _dic;
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
