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
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getMachineDeviceAtcion:) name:kServiceOrder object:nil];
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.webView.backgroundColor = kCOLOR(38, 139, 218);
    
}

- (void)passValueWithBlock {
    
    [super passValueWithBlock];
    
    JSContext *context = [self.webView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
//    __block typeof(self)bself = self;
    
    context[@"OrderWebToIOSColdFanA"] = ^() {
        NSArray *parames = [JSContext currentArguments];
        NSString *arrarString = [[NSString alloc]init];
        
        for (id obj in parames) {
            arrarString = [arrarString stringByAppendingFormat:@"%@" , obj];
        }
        
        NSString *subOrderType = [arrarString substringToIndex:1];
        NSString *subOrder = [arrarString substringFromIndex:1];
        subOrder = [NSString stringWithFormat:@"%ld" , subOrder.integerValue - 48];
        
        [kSocketTCP sendDataToHost:ColdFan4131SendToHostXieYi(self.serviceModel.devTypeSn, self.serviceModel.devSn, subOrderType, subOrder) andType:kZhiLing andIsNewOrOld:kOld];
        
    };
    
    __block typeof (self)bselef = self;
    context[@"SaveWebDataAndroid"] = ^() {
        NSArray *parames = [JSContext currentArguments];
        NSString *arrStr = [[NSString alloc]init];
        for (id obj in parames) {
            arrStr = [arrStr stringByAppendingFormat:@"%@" , obj];
        }
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:[arrStr dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableContainers error:nil];

        
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:nil];
        NSString *jsonStr = [[NSString alloc]initWithData:jsonData encoding:NSUTF8StringEncoding];
        NSLog(@"%@" , jsonStr);
        [kStanderDefault setObject:jsonStr forKey:[NSString stringWithFormat:@"%@" , NSStringFromClass([bselef.navigationController.childViewControllers[1] class])]];
    };

}

- (void)getMachineDeviceAtcion:(NSNotification *)post {
    [super getMachineDeviceAtcion:post];
}
- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
@end
