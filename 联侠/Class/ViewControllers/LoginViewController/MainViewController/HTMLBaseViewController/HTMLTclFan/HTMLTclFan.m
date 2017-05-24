//
//  HTMLTclFan.m
//  联侠
//
//  Created by 杭州阿尔法特 on 2017/4/25.
//  Copyright © 2017年 张海昌. All rights reserved.
//

#import "HTMLTclFan.h"

@interface HTMLTclFan ()

@end

@implementation HTMLTclFan

- (void)viewDidLoad {
    [super viewDidLoad];
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getMachineDeviceAtcion:) name:@"4134" object:nil];
    
}

//- (void)passValueWithBlock {
//    
//    [super passValueWithBlock];
//    
////    JSContext *context = [self.webView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
////    __block typeof(self)bself = self;
////    
////    context[@"OrderWebToIOS"] = ^() {
////        NSArray *parames = [JSContext currentArguments];
////        NSString *arrarString = [[NSString alloc]init];
////        
////        for (id obj in parames) {
////            arrarString = [arrarString stringByAppendingFormat:@"%@" , obj];
////        }
////        
////        
////        NSArray *array = [arrarString componentsSeparatedByString:@","];
////        
////        NSString *toHex = [[NSString ToHex:[array[9] intValue]] substringFromIndex:2];
////        NSLog(@"arrarString--%@ , toHex--%@" , arrarString , toHex);
////        [kStanderDefault setObject:toHex forKey:[NSString stringWithFormat:@"%@" , NSStringFromClass([self.navigationController.childViewControllers[1] class])]];
////        
////        
////        NSLog(@"%@" , TCLFan4134SendToHostXieYi(self.serviceModel.devTypeSn, self.serviceModel.devSn , array[0], array[1], array[2], array[3], array[9], array[10], array[11]));
////        
////        [kSocketTCP sendDataToHost:TCLFan4134SendToHostXieYi(self.serviceModel.devTypeSn, self.serviceModel.devSn , array[0], array[1], array[2], array[3], array[9], array[10], array[11]) andType:kZhiLing andIsNewOrOld:kNew];
////    };
////    
////    context[@"SaveWebDataAndroid"] = ^() {
////        NSArray *parames = [JSContext currentArguments];
////        NSString *arrStr = [[NSString alloc]init];
////        for (id obj in parames) {
////            arrStr = [arrStr stringByAppendingFormat:@"%@" , obj];
////        }
////        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:[arrStr dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableContainers error:nil];
////        NSLog(@"%@" , dic);
////    };
//}
@end
