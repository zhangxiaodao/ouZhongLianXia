//
//  CZNetworkManager.m
//  联侠
//
//  Created by 杭州阿尔法特 on 2017/8/31.
//  Copyright © 2017年 张海昌. All rights reserved.
//

#import "CZNetworkManager.h"

static CZNetworkManager *helper = nil;

@implementation CZNetworkManager


+ (instancetype)shareCZNetworkManager {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        helper = [[self alloc] init];
        helper.requestSerializer = [AFJSONRequestSerializer serializer];
        helper.responseSerializer = [AFJSONResponseSerializer serializer];
        helper.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html", @"text/plain",nil];
        [helper.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Accept"];
        [helper.requestSerializer setValue:@"text/html;charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    });
    
    AFNetworkReachabilityManager *manager = [AFNetworkReachabilityManager sharedManager];
    __weak typeof (AFNetworkReachabilityManager) *wearManager= manager;
    [manager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        [wearManager stopMonitoring];
        // 当网络状态改变时调用
        switch (status) {
            case AFNetworkReachabilityStatusUnknown:
                NSLog(@"未知网络");
                break;
            case AFNetworkReachabilityStatusNotReachable:{
                
                [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
                
                [SVProgressHUD show];
                [SVProgressHUD showErrorWithStatus:@"当前网络不可用，\n请检查您的网络设置"];
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [SVProgressHUD dismiss];
                });
                
                NSLog(@"没有网络");
            }
                break;
            case AFNetworkReachabilityStatusReachableViaWWAN:
                NSLog(@"手机自带网络");
                break;
            case AFNetworkReachabilityStatusReachableViaWiFi:
                NSLog(@"WIFI");
                break;
        }
    }];
    [manager startMonitoring];
    
    return helper;
}

- (void)requestGetUrlString:(NSString *)urlString parameters:(NSDictionary *)parameters isSuccess:(success)isSuccess failure:(failure)failure {
    if (urlString == nil) {
        return ;
    }
    
    [self GET:urlString parameters:parameters progress:^(NSProgress * _Nonnull downloadProgress) {
    } success:isSuccess failure:failure];
}

- (void)requestPOSTUrlString:(NSString *)urlString parameters:(NSDictionary *)parameters isSuccess:(success)isSuccess failure:(failure)failure {
    if (urlString == nil) {
        return ;
    }
    
    [self POST:urlString parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:isSuccess failure:failure];
}

@end
