//
//  HTMLGanYiJiViewController.m
//  联侠
//
//  Created by 杭州阿尔法特 on 2017/2/20.
//  Copyright © 2017年 张海昌. All rights reserved.
//

#import "HTMLGanYiJiViewController.h"


@interface HTMLGanYiJiViewController ()
@end

@implementation HTMLGanYiJiViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getMachineDeviceAtcion:) name:@"4332" object:nil];
}

- (void)passValueWithBlock {
    
    [super passValueWithBlock];
    
    JSContext *context = [self.webView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
    __block typeof(self)bself = self;
    
    context[@"OrderWebToIOS"] = ^() {
        NSArray *parames = [JSContext currentArguments];
        NSString *arrarString = [[NSString alloc]init];
        
        for (id obj in parames) {
            arrarString = [arrarString stringByAppendingFormat:@"%@" , obj];
        }
        
        
        NSArray *array = [arrarString componentsSeparatedByString:@","];
        
//        NSString *firstToHex = [[NSString ToHex:[array[9] intValue]] substringFromIndex:2];
        NSString *toHex = [[NSString ToHex:[array[9] intValue]] substringFromIndex:2];

        [kStanderDefault setObject:toHex forKey:[NSString stringWithFormat:@"%@" , NSStringFromClass([self.navigationController.childViewControllers[1] class])]];
        
        
        [kSocketTCP sendDataToHost:GanYiJi4332SendToHostXieYi(self.serviceModel.devTypeSn, self.serviceModel.devSn, array[0], array[1], array[6], toHex) andType:kZhiLing andIsNewOrOld:kNew];
    };
}

@end
