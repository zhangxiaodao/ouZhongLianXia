//
//  HelpFunction.h
//  知晓时代
//
//  Created by laouhn on 15/12/16.
//  Copyright (c) 2015年 laouhn. All rights reserved.
//

#import <Foundation/Foundation.h>
@class HelpFunction;
@protocol HelpFunctionDelegate <NSObject>
@optional

- (void)requestData:(HelpFunction *)request changeServiceName:(NSDictionary *)dic;

- (void)requestData:(HelpFunction *)request didFinishLoadingDtaArray:(NSMutableArray *) data;

- (void)requestData:(HelpFunction *)request didSuccess:(NSDictionary *)dddd;

- (void)requestWearthData:(HelpFunction *)request didDone:(NSMutableArray *)array;

- (void)requestServicesData:(HelpFunction *)request didOK:(NSDictionary *)dic;
- (void)requestServicesState:(HelpFunction *)request didOK:(NSDictionary *)dic;

- (void)requestRemoveService:(HelpFunction *)request didDone:(NSDictionary *)dic;

- (void)requestFuWeiShuJu:(HelpFunction *)request didYes:(NSDictionary *)dic;

- (void)requestServicesTimeing:(NSDictionary *)dic;

- (void)requestKongQiZhiLiangShuJu:(HelpFunction *)request didYes:(NSDictionary *)dic;

- (void)requestData:(HelpFunction *)requset queryUserdevice:(NSDictionary *)dddd;



//请求失败的代理
- (void)requestData:(HelpFunction *)request didFailLoadData:(NSError *)error;

- (void)requestDataWithDontHaveReturnValue:(HelpFunction *)request;
@end

@interface HelpFunction : NSObject

@property (nonatomic,strong) id<HelpFunctionDelegate> delegate;
@property (nonatomic,strong) NSString *urlString;
@property (nonatomic,assign) NSInteger page;
@property (nonatomic , strong) NSDictionary *parames;
@property (nonatomic , strong) UIImage *image;
@property (nonatomic , strong) UIViewController *currentVC;

//单例
+ (HelpFunction *)shareHelpFunction;
//为外界提供一个类方法,方便外接使用
+ (HelpFunction *)requestDataWithUrlString:(NSString *)urlString andPage:(NSNumber *)page andDelegate:(id<HelpFunctionDelegate>)delegate;


+ (HelpFunction *)requestDataWithUrlString:(NSString *)urlString andParames:(NSDictionary *)parames andDelegate:(id<HelpFunctionDelegate>)delegate;

+ (HelpFunction *)requestDataWithUrlString:(NSString *)urlString andParames:(NSDictionary *)parames andImage:(UIImage *)image andDelegate:(id<HelpFunctionDelegate>)delegate;

+ (HelpFunction *)requestWeatherDataWithDelegate:(id<HelpFunctionDelegate>)delegate andCityName:(NSString *)cityName;
- (UIViewController *)getCurrentVC;
- (UIViewController *)getPresentedViewController;
@end
