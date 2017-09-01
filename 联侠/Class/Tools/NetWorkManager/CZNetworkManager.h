//
//  CZNetworkManager.h
//  联侠
//
//  Created by 杭州阿尔法特 on 2017/8/31.
//  Copyright © 2017年 张海昌. All rights reserved.
//

#import <AFNetworking/AFNetworking.h>

typedef NS_ENUM(NSInteger, CZHTTPMethod) {
    CZHTTPMethodGET = 0,
    CZHTTPMethodPOST = 1,
};

typedef void(^success)(NSURLSessionDataTask * task,id result);
typedef void(^failure)(NSURLSessionDataTask * task,NSError * error);

@interface CZNetworkManager : AFHTTPSessionManager

+ (instancetype _Nullable )shareCZNetworkManager;

- (void)requestGetUrlString:(NSString *_Nullable)urlString parameters:(NSDictionary *_Nullable)parameters isSuccess:(success _Nullable )isSuccess failure:(failure _Nullable)failure;
- (void)requestPOSTUrlString:(NSString *_Nullable)urlString parameters:(NSDictionary *_Nullable)parameters isSuccess:(success _Nullable )isSuccess failure:(failure _Nullable)failure;
@end
