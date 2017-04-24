//
//  HTMLColdFan.m
//  联侠
//
//  Created by 杭州阿尔法特 on 2017/4/24.
//  Copyright © 2017年 张海昌. All rights reserved.
//

#import "HTMLColdFan.h"

@interface HTMLColdFan ()

@end

@implementation HTMLColdFan

- (void)viewDidLoad {
    [super viewDidLoad];
    self.webView.backgroundColor = kACOLOR(39, 143, 255, 1.0);
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getMachineDeviceAtcion:) name:@"4131" object:nil];
    
}

- (void)passValueWithBlock {
    
    [super passValueWithBlock];
    
    JSContext *context = [self.webView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
    __block typeof(self)bself = self;
    
    context[@"OrderWebToIOSColdFanA"] = ^() {
        NSArray *parames = [JSContext currentArguments];
        NSString *arrarString = [[NSString alloc]init];
        
        for (id obj in parames) {
            arrarString = [arrarString stringByAppendingFormat:@"%@" , obj];
        }
        
        NSString *subOrderType = [arrarString substringToIndex:1];
        NSString *subOrder = [arrarString substringFromIndex:1];
        subOrder = [NSString stringWithFormat:@"%ld" , subOrder.integerValue - 48];

        NSString *tcp = ColdFan4131SendToHostXieYi(self.serviceModel.devTypeSn, self.serviceModel.devSn, subOrderType, subOrder);
        
        [kSocketTCP sendDataToHost:ColdFan4131SendToHostXieYi(self.serviceModel.devTypeSn, self.serviceModel.devSn, subOrderType, subOrder) andType:kZhiLing andIsNewOrOld:kOld];
        
    };
}

- (void)getMachineDeviceAtcion:(NSNotification *)post {
    [super getMachineDeviceAtcion:post];
}

@end
