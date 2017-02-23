//
//  AppDelegate.m
//  AEFT冷风扇
//
//  Created by 杭州阿尔法特 on 16/3/8.
//  Copyright © 2016年 阿尔法特. All rights reserved.
//

#import "AppDelegate.h"

#import "TabBarViewController.h"

#import "UMSocial.h"
#import "UMSocialWechatHandler.h"
#import "UMSocialSinaSSOHandler.h"
#import "UMSocialQQHandler.h"
#import "AsyncSocket.h"
#import "Reachability.h"

#define STOREAPPID @"1113948983"
@interface AppDelegate ()<GCDAsyncSocketDelegate , AsyncSocketDelegate , HelpFunctionDelegate>
@property (nonatomic) Reachability *hostReachability;
@property (nonatomic) Reachability *internetReachAbility;
@property (nonatomic , copy) NSString *isHaveConnect;
@property (nonatomic , strong) UIAlertController *alertVC;
@property (nonatomic , strong) UIAlertController *alertController;
@property (nonatomic , strong) UserModel *userModel;
@property (nonatomic , strong) ServicesModel *serviceModel;
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    self.window.rootViewController = [[UIViewController alloc]init];
    [self.window makeKeyAndVisible];
    
    
    NSLog(@"%f , %f" , kScreenW , kScreenH);
    _alertController = nil;
    
    self.window.rootViewController = [[TabBarViewController alloc]init];
    
    [UMSocialData setAppKey:kUMAppKey];
    [UMSocialWechatHandler setWXAppId:@"wx4fca522e10aba260" appSecret:@"054b2ba4f76f67310b716e631a6dd5bd" url:@"www.ouzhongiot.com"];
    //打开新浪微博的SSO开关，设置新浪微博回调地址，这里必须要和你在新浪微博后台设置的回调地址一致。
    [UMSocialSinaSSOHandler openNewSinaSSOWithAppKey:@"2648263927"   secret:@"53c58898fa46d492ab3758debec3716e" RedirectURL:@"http://www.ouzhongiot.com"];
    
    //通过个人退平台分配的appID、appKey、appSerect自动SDK，注：该法法需要在主线程中调用
    [GeTuiSdk startSdkWithAppId:kGtAppId appKey:kGtAppKey appSecret:kGtAppSecret delegate:self];
    //注册APNs
    [self registerUserNotification];
    
    //自动锁屏
    [UIApplication sharedApplication].idleTimerDisabled = NO;
    
    
    [HelpFunction requestDataWithUrlString:kChaXunBanBenHao andParames:@{@"type" : @(2)} andDelegate:self];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reachabilityChanged:) name:kReachabilityChangedNotification object:nil];
    
    NSString *remoteHostName = @"www.baidu.com";
    self.hostReachability = [Reachability reachabilityWithHostName:remoteHostName];
    [self.hostReachability startNotifier];
    [self updateInterfaceWithReachAbility:self.hostReachability];
    
    self.internetReachAbility = [Reachability reachabilityForInternetConnection];
    [self.internetReachAbility startNotifier];
    [self updateInterfaceWithReachAbility:self.internetReachAbility];
    
    
    return YES;
}

- (void) reachabilityChanged:(NSNotification *)note
{
  
    Reachability* curReach = [note object];
    NSParameterAssert([curReach isKindOfClass:[Reachability class]]);
    [self updateInterfaceWithReachAbility:curReach];
}

- (void)updateInterfaceWithReachAbility:(Reachability *)reachability {
    if (reachability == self.hostReachability) {
        BOOL connectionRequired = [reachability connectionRequired];
        if (connectionRequired) {
            
            [UIAlertController creatRightAlertControllerWithHandle:nil andSuperViewController:kWindowRoot Title:@"您当前连接的是手机网络"];
        }
    }
    
    if (reachability == self.internetReachAbility) {
        NetworkStatus netStatus = [reachability currentReachabilityStatus];
        
        if (netStatus == NotReachable) {
            NSLog(@"未联网");
            
            self.alertVC = [UIAlertController creatRightAlertControllerWithHandle:^{
                [UIView animateWithDuration:1.0f animations:^{
                    self.window.alpha = 0;
                    self.window.frame = CGRectMake(0, self.window.bounds.size.width, 0, 0);
                } completion:^(BOOL finished) {
                    exit(0);
                }];
            } andSuperViewController:kWindowRoot Title:@"您当前的设备未联网，APP无法使用"];
            NSLog(@"%@" , self.alertVC);
            
            self.isHaveConnect = @"YES";
        } else if (netStatus == ReachableViaWWAN) {
            
            NSLog(@"%@ , %@" , self.userModel , self.serviceModel);
            
            if (self.userModel && self.serviceModel) {
                kSocketTCP.userSn = [NSString stringWithFormat:@"%ld" , _userModel.sn];
                [kSocketTCP socketConnectHost];
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [kSocketTCP sendDataToHost:[NSString stringWithFormat:@"HM%ld%@%@N#" , self.userModel.sn , _serviceModel.devTypeSn , _serviceModel.devSn] andType:kAddService andIsNewOrOld:nil];
                });
            }
            
            if (self.alertVC || [Singleton sharedInstance].socket.isConnected != 1) {
                
                if ([kStanderDefault objectForKey:@"userSn"]) {
                    [kWindowRoot dismissViewControllerAnimated:self.alertVC completion:^{
                        
                        [[[TabBarViewController alloc]init] removeFromParentViewController];
                        self.window.rootViewController = [[TabBarViewController alloc]init];
                    }];
                }
            }
            
            self.alertVC = nil;
            
            
        } else if (netStatus == ReachableViaWiFi) {
            
            NSLog(@"%@ , %@" , self.userModel , self.serviceModel);
            if (self.userModel && self.serviceModel) {
                kSocketTCP.userSn = [NSString stringWithFormat:@"%ld" , _userModel.sn];
                [kSocketTCP socketConnectHost];
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [kSocketTCP sendDataToHost:[NSString stringWithFormat:@"HM%ld%@%@N#" , self.userModel.sn , _serviceModel.devTypeSn , _serviceModel.devSn] andType:kAddService andIsNewOrOld:nil];
                });
            }
            
            NSLog(@"%@ , %d" , self.alertVC , [self.alertVC isKindOfClass:[NSNull class]]);
            if (self.alertVC) {
                
                if ([kStanderDefault objectForKey:@"userSn"]) {
                    
                    [kWindowRoot dismissViewControllerAnimated:self.alertVC completion:^{
                        
                        [[[TabBarViewController alloc]init] removeFromParentViewController];
                        self.window.rootViewController = [[TabBarViewController alloc]init];
                    }];
                }
            }
            
            
            self.alertVC = nil;
        }
    }
}

- (void)requestData:(HelpFunction *)request didSuccess:(NSDictionary *)dddd {
    NSLog(@"%@" , dddd);
    NSDictionary *data = dddd[@"data"];
    
    if ([dddd[@"success"] integerValue] == 1) {
        if ([data[@"isForce"] isKindOfClass:[NSNull class]]) {
            return ;
        } else {
            
            if ([data[@"id"] integerValue] > 12) {
                
                if ([data[@"isForce"] integerValue] == 1) {
                    
                    [UIAlertController creatRightAlertControllerWithHandle:^{
                        
                        NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"https://itunes.apple.com/us/app/id%@?ls=1&mt=8", STOREAPPID]];
                        [[UIApplication sharedApplication] openURL:url];
                    } andSuperViewController:kWindowRoot Title:@"您当前的版本过低，无法使用请更新！"];
                    
                } else {
                    [UIAlertController creatCancleAndRightAlertControllerWithHandle:^{
                        NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"https://itunes.apple.com/us/app/id%@?ls=1&mt=8", STOREAPPID]];
                        [[UIApplication sharedApplication] openURL:url];
                    } andSuperViewController:kWindowRoot Title:@"检查到有新的版本，是否更新?"];
                }
                
            }
            
        }
        
    }
    
}


/**
 *  实现推送功能
 *
 */
/** 注册APNS */
- (void)registerUserNotification {
#ifdef __IPHONE_8_0
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0) {
        
        UIUserNotificationType types = (UIUserNotificationTypeAlert |UIUserNotificationTypeSound |UIUserNotificationTypeBadge);
        
        UIUserNotificationSettings *settings;
        settings = [UIUserNotificationSettings settingsForTypes:types categories:nil];
        [[UIApplication sharedApplication] registerForRemoteNotifications];
        [[UIApplication sharedApplication] registerUserNotificationSettings:settings];
        
    } else {
        UIRemoteNotificationType apn_type = (UIRemoteNotificationType)(UIRemoteNotificationTypeAlert |                          UIRemoteNotificationTypeSound |                          UIRemoteNotificationTypeBadge);
        [[UIApplication sharedApplication] registerForRemoteNotificationTypes:apn_type];
    }
#else
    UIRemoteNotificationType apn_type = (UIRemoteNotificationType)(UIRemoteNotificationTypeAlert |                         UIRemoteNotificationTypeSound |                            UIRemoteNotificationTypeBadge);
    [[UIApplication sharedApplication] registerForRemoteNotificationTypes:apn_type];
#endif
}

#pragma mark - 获取deviceToken
/**
 *  获取到用户当前应用程序的deviceToken时就会调用
 *
 */
- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    
    
    NSString *token = [[deviceToken description] stringByTrimmingCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"<>"]];
    token = [token stringByReplacingOccurrencesOfString:@" " withString:@""];
        NSLog(@"\n>>>[DeviceToken Success]:%@\n\n", token);
    
    //向个推服务器注册deviceToken
    [GeTuiSdk registerDeviceToken:token];
    
}

- (void)application:(UIApplication *)application performFetchWithCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler {
    //Background Fetch 回复SDK运行
    [GeTuiSdk resume];
    completionHandler(UIBackgroundFetchResultNewData);
}

/** SDK启动成功返回cid */
- (void)GeTuiSdkDidRegisterClient:(NSString *)clientId {
    //个推SDK已注册，返回clientId
//        NSLog(@"\n>>>[GeTuiSdk RegisterClient]:%@\n\n", clientId);
    [kStanderDefault setObject:clientId forKey:@"GeTuiClientId"];
}

/** SDK遇到错误回调 */
- (void)GeTuiSdkDidOccurError:(NSError *)error {
    //个推错误报告，集成步骤发生的任何错误都在这里通知，如果集成后，无法正常收到消息，查看这里的通知。
    //    NSLog(@"\n>>>[GexinSdk error]:%@\n\n", [error localizedDescription]);
}

/** SDK收到透传消息回调 */
- (void)GeTuiSdkDidReceivePayloadData:(NSData *)payloadData andTaskId:(NSString *)taskId andMsgId:(NSString *)msgId andOffLine:(BOOL)offLine fromGtAppId:(NSString *)appId {
    //收到个推消息
    NSString *payloadMsg = nil;
    if (payloadData) {
        payloadMsg = [[NSString alloc] initWithBytes:payloadData.bytes
                                              length:payloadData.length
                                            encoding:NSUTF8StringEncoding];
    }
        [GeTuiSdk sendFeedbackMessage:90001 taskId:taskId msgId:msgId];
    
    NSString *message = [NSString stringWithFormat:@"%@" , payloadMsg];
//    NSLog(@"AAAAAQQQQQQQ%@" , message);
    if (!_alertController) {
        
        _alertController = [UIAlertController creatRightAlertControllerWithHandle:^{
            [_alertController dismissViewControllerAnimated:YES completion:^{
                _alertController = nil;
            }];

        } andSuperViewController:kWindowRoot Title:message];
    } else if (_alertController) {
        
        if (![_alertController.message isEqualToString:message]) {
            _alertController.message = message;
        }
    }

    
}

/** APP已经接收到“远程”通知(推送) - 透传推送消息  */
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult result))completionHandler {
    // 处理APNs代码，通过userInfo可以取到推送的信息（包括内容，角标，自定义参数等）。如果需要弹窗等其他操作，则需要自行编码。
    //    NSLog(@"\n>>>[Receive RemoteNotification - Background Fetch]:%@\n\n",userInfo);
    
//    NSLog(@"AAAACCCCCCCCCAAAA%@" , userInfo);
    
    completionHandler(UIBackgroundFetchResultNewData);
}


- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    BOOL result = [UMSocialSnsService handleOpenURL:url];
    if (result == FALSE) {
        //调用其他SDK，例如支付宝SDK等
    }
    return result;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    NSLog(@"程序将要进入非活动状态");
    
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    [[Singleton sharedInstance] enableBackgroundingOnSocket];
    NSLog(@"程序进入后台后执行");
}

- (void)applicationWillEnterForeground:(UIApplication *)application {

    NSLog(@"程序将要进入前台时执行");
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    NSLog(@"程序被激活（获得焦点）后执行");
    
    [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
    [GeTuiSdk resetBadge];

}

- (void)applicationWillTerminate:(UIApplication *)application {
    [kStanderDefault setObject:@"YES" forKey:@"isRun"];
    NSLog(@"程序在终止时执行");
    
    [kSocketTCP cutOffSocket];
    
}

- (void)initUserModel:(UserModel *)userModel {
    
    self.userModel = [[UserModel alloc]init];
    self.userModel = userModel;
    NSLog(@"%@" , _userModel);
}

- (void)initServiceModel:(ServicesModel *)serviceModel {
    self.serviceModel = [[ServicesModel alloc]init];
    self.serviceModel = serviceModel;
    NSLog(@"%@" , _serviceModel);
}

@end
