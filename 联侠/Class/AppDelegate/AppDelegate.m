//
//  AppDelegate.m
//  AEFT冷风扇
//
//  Created by 杭州阿尔法特 on 16/3/8.
//  Copyright © 2016年 阿尔法特. All rights reserved.
//

#import "AppDelegate.h"
#import <UMSocialCore/UMSocialCore.h>
#import "TabBarViewController.h"
#import "AsyncSocket.h"
#import "Reachability.h"
#import "LoginViewController.h"
#import "XMGNavigationController.h"
#import "LaunchScreenViewController.h"
#import "HTMLBaseViewController.h"


#define STOREAPPID @"1113948983"
@interface AppDelegate ()<GCDAsyncSocketDelegate , AsyncSocketDelegate , HelpFunctionDelegate>
@property (nonatomic) Reachability *hostReachability;
@property (nonatomic) Reachability *internetReachAbility;

@property (nonatomic , strong) UIAlertController *alertVC;
@property (nonatomic , strong) UIAlertController *alertController;
@property (nonatomic , strong) UserModel *userModel;
@property (nonatomic , strong) ServicesModel *serviceModel;
@property (nonatomic , strong) XinFengViewController *xinFengVC;
@property (nonatomic , strong) MainViewController *mainVC;
@property (nonatomic , strong) UILabel *noNetwork;
@property (nonatomic , strong) UIView *markview;
#pragma mark - 0 没网 1 有网
@property (nonatomic , assign) BOOL noNetWorkStr;
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    self.window.rootViewController = [[UIViewController alloc]init];
    [self.window makeKeyAndVisible];
    self.noNetWorkStr = 1;
        
    NSLog(@"%f , %f" , kScreenW , kScreenH);
    
    
    
    _alertController = nil;
    
    [self setRootViewController];
    
    [self setYouMeng];
    [self setGeTui];
    [self checkNetwork];
    
    [HelpFunction requestDataWithUrlString:kChaXunBanBenHao andParames:@{@"type" : @(2)} andDelegate:self];
    
    return YES;
}


- (UILabel *)addNoNetLabel {
    UILabel *noNetWork = [UILabel creatLableWithTitle:@"❗️当前网络不可用，请检查手机网络" andSuperView:kWindowRoot.view andFont:k13 andTextAligment:NSTextAlignmentCenter];
    [noNetWork mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kScreenW, kScreenW / 15));
        make.centerX.mas_equalTo(kWindowRoot.view  .mas_centerX);
        make.top.mas_equalTo(kHeight);
    }];
    
    noNetWork.textColor = [UIColor colorWithHexString:@"ef6060"];
    noNetWork.backgroundColor = [UIColor colorWithHexString:@"ffdcdc"];
    noNetWork.layer.borderWidth = 0;
    noNetWork.layer.cornerRadius = 0;
    noNetWork.hidden = YES;
    
    UIView *markview = [[UIView alloc]initWithFrame:self.window.bounds];
    [kWindowRoot.view addSubview:markview];
    markview.backgroundColor = [UIColor clearColor];
    markview.hidden = YES;
    self.markview = markview;
    
    return noNetWork;
}

- (void)setRootViewController {
    NSString *isLaunchLoad = [kStanderDefault objectForKey:@"isLaunch"];
    if ([isLaunchLoad isEqualToString:@"NO"]) {
        [kStanderDefault setObject:@"NO" forKey:@"firstRun"];
        
        if ([kStanderDefault objectForKey:@"Login"]) {
            
            self.window.rootViewController = [[TabBarViewController alloc]init];
        } else {
            
            LoginViewController *loginVC = [[LoginViewController alloc]init];
            XMGNavigationController *nav = [[XMGNavigationController alloc]initWithRootViewController:loginVC];
            
            
            self.window.rootViewController = nav;
        }
    } else {
        self.window.rootViewController = [[LaunchScreenViewController alloc]init];
    }
    self.noNetwork = [self addNoNetLabel];
}

- (void)checkNetwork {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reachabilityChanged:) name:kReachabilityChangedNotification object:nil];
    
    NSString *remoteHostName = @"www.baidu.com";
    self.hostReachability = [Reachability reachabilityWithHostName:remoteHostName];
    [self.hostReachability startNotifier];
    [self updateInterfaceWithReachAbility:self.hostReachability];
    
    self.internetReachAbility = [Reachability reachabilityForInternetConnection];
    [self.internetReachAbility startNotifier];
    [self updateInterfaceWithReachAbility:self.internetReachAbility];
}

- (void)setGeTui {
    //通过个人退平台分配的appID、appKey、appSerect自动SDK，注：该法法需要在主线程中调用
    [GeTuiSdk startSdkWithAppId:kGtAppId appKey:kGtAppKey appSecret:kGtAppSecret delegate:self];
    //注册APNs
    [self registerRemoteNotification];
}

- (void)setYouMeng {

    
    /* 打开调试日志 */
    [[UMSocialManager defaultManager] openLog:YES];
    
    /* 设置友盟appkey */
    [[UMSocialManager defaultManager] setUmSocialAppkey:kUMAppKey];
    
    [self configUSharePlatforms];
    
    [self confitUShareSettings];
}


- (void)confitUShareSettings
{
    
}

- (void)configUSharePlatforms
{
    /* 设置微信的appKey和appSecret */
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_WechatSession appKey:@"wx4fca522e10aba260" appSecret:@"054b2ba4f76f67310b716e631a6dd5bd" redirectURL:@"www.ouzhongiot.com"];
    
    /* 设置新浪的appKey和appSecret */
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_Sina appKey:@"2648263927"  appSecret:@"53c58898fa46d492ab3758debec3716e" redirectURL:@"http://www.ouzhongiot.com"];
    
    
    
}

- (void) reachabilityChanged:(NSNotification *)note
{
  
    Reachability* curReach = [note object];
    NSParameterAssert([curReach isKindOfClass:[Reachability class]]);
    [self updateInterfaceWithReachAbility:curReach];
}

- (void)updateInterfaceWithReachAbility:(Reachability *)reachability {
    
    if (reachability == self.internetReachAbility) {
        NetworkStatus netStatus = [reachability currentReachabilityStatus];
        
        if (netStatus == NotReachable) {
            self.noNetWorkStr = 0;
           
            if ([[[HelpFunction shareHelpFunction] getPresentedViewController] isKindOfClass:[UITabBarController class]]) {
                UITabBarController *tab = (UITabBarController *)[[HelpFunction shareHelpFunction] getPresentedViewController];
                XMGNavigationController *nav = tab.selectedViewController;
                
                if ([nav.visibleViewController isKindOfClass:[MainViewController class]] || [nav.visibleViewController isKindOfClass:[XinFengViewController class]] || [nav.visibleViewController isKindOfClass:[HTMLBaseViewController class]]) {
                    self.noNetwork.hidden = YES;
                    self.markview.hidden = YES;
                    self.alertVC = [UIAlertController creatRightAlertControllerWithHandle:^{
                        [UIView animateWithDuration:1.0f animations:^{
                            self.window.alpha = 0;
                            self.window.frame = CGRectMake(0, self.window.bounds.size.width, 0, 0);
                        } completion:^(BOOL finished) {
                            exit(0);
                        }];
                    } andSuperViewController:kWindowRoot Title:@"您当前的设备未联网，APP无法使用"];
                } else {
                    self.noNetwork.hidden = NO;
                    self.markview.hidden = NO;
                }
            } else {
                self.noNetwork.hidden = NO;
                self.markview.hidden = NO;
            }
            
            
        } else if (netStatus == ReachableViaWWAN || netStatus == ReachableViaWiFi) {
            self.noNetWorkStr = 1;
            
            if (self.noNetwork || self.alertVC) {
                self.noNetwork.hidden = YES;
                self.markview.hidden = YES;
                [self.alertVC dismissViewControllerAnimated:YES completion:^{
                    self.alertVC = nil;
                }];
            }
            
        }
    }
}

- (NSInteger)wheatherHaveNet {
    return self.noNetWorkStr;
}

- (void)requestData:(HelpFunction *)request didSuccess:(NSDictionary *)dddd {
    NSLog(@"%@" , dddd);
    NSDictionary *data = dddd[@"data"];
    
    if ([dddd[@"success"] integerValue] == 1) {
        if ([data[@"isForce"] isKindOfClass:[NSNull class]]) {
            return ;
        } else {
            
            if ([data[@"id"] integerValue] > 42) {
                
                if ([data[@"isForce"] integerValue] == 0) {
                    return ;
                }
                
                if ([data[@"isForce"] integerValue] == 1) {
                    
                    [self wheatherUpdate:@"您当前的版本过低，无法使用请更新！"];
                } else {
                    [self wheatherUpdate:@"检查到有新的版本，是否更新?"];
                }
            }
        }
    }
}

- (void)requestData:(HelpFunction *)request didFailLoadData:(NSError *)error {
    NSLog(@"%@" , error);
}

- (void)wheatherUpdate:(NSString *)title {
    [UIAlertController creatCancleAndRightAlertControllerWithHandle:^{
        NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"https://itunes.apple.com/us/app/id%@?ls=1&mt=8", STOREAPPID]];
        [[UIApplication sharedApplication] openURL:url];
    } andSuperViewController:kWindowRoot Title:title];
}

/**
 *  实现推送功能
 *
 */
/** 注册APNS */
- (void)registerRemoteNotification {
    /*
     警告：Xcode8 需要手动开启"TARGETS -> Capabilities -> Push Notifications"
     */
    
    /*
     警告：该方法需要开发者自定义，以下代码根据 APP 支持的 iOS 系统不同，代码可以对应修改。
     以下为演示代码，注意根据实际需要修改，注意测试支持的 iOS 系统都能获取到 DeviceToken
     */
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 10.0) {
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_10_0 // Xcode 8编译会调用
        UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
        center.delegate = self;
        [center requestAuthorizationWithOptions:(UNAuthorizationOptionBadge | UNAuthorizationOptionSound | UNAuthorizationOptionAlert | UNAuthorizationOptionCarPlay) completionHandler:^(BOOL granted, NSError *_Nullable error) {
            if (!error) {
                NSLog(@"request authorization succeeded!");
            }
        }];
        
        [[UIApplication sharedApplication] registerForRemoteNotifications];
#else // Xcode 7编译会调用
        UIUserNotificationType types = (UIUserNotificationTypeAlert | UIUserNotificationTypeSound | UIUserNotificationTypeBadge);
        UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:types categories:nil];
        [[UIApplication sharedApplication] registerForRemoteNotifications];
        [[UIApplication sharedApplication] registerUserNotificationSettings:settings];
#endif
    } else if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0) {
        UIUserNotificationType types = (UIUserNotificationTypeAlert | UIUserNotificationTypeSound | UIUserNotificationTypeBadge);
        UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:types categories:nil];
        [[UIApplication sharedApplication] registerForRemoteNotifications];
        [[UIApplication sharedApplication] registerUserNotificationSettings:settings];
    } else {
        UIRemoteNotificationType apn_type = (UIRemoteNotificationType)(UIRemoteNotificationTypeAlert |
                                                                       UIRemoteNotificationTypeSound |
                                                                       UIRemoteNotificationTypeBadge);
        [[UIApplication sharedApplication] registerForRemoteNotificationTypes:apn_type];
    }
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
    
    // 向个推服务器注册deviceToken
    [GeTuiSdk registerDeviceToken:token];
    
}

- (void)application:(UIApplication *)application performFetchWithCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler {
    /// Background Fetch 恢复SDK 运行
    [GeTuiSdk resume];
    completionHandler(UIBackgroundFetchResultNewData);
}

/** SDK启动成功返回cid */
- (void)GeTuiSdkDidRegisterClient:(NSString *)clientId {
    //个推SDK已注册，返回clientId
        NSLog(@"\n>>>[GeTuiSdk RegisterClient]:%@\n\n", clientId);
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
        payloadMsg = [[NSString alloc] initWithBytes:payloadData.bytes length:payloadData.length encoding:NSUTF8StringEncoding];
    }
    
    NSString *message = [NSString stringWithFormat:@"%@" , payloadMsg];
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
    // 将收到的APNs信息传给个推统计
    [GeTuiSdk handleRemoteNotification:userInfo];
    completionHandler(UIBackgroundFetchResultNewData);
}


- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    //6.3的新的API调用，是为了兼容国外平台(例如:新版facebookSDK,VK等)的调用[如果用6.2的api调用会没有回调],对国内平台没有影响
    BOOL result = [[UMSocialManager defaultManager] handleOpenURL:url sourceApplication:sourceApplication annotation:annotation];
    if (!result) {
        // 其他如支付等SDK的回调
    }
    return result;
}

#if __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_10_0

//  iOS 10: App在前台获取到通知
- (void)userNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(UNNotificationPresentationOptions))completionHandler {
    
    NSLog(@"willPresentNotification：%@", notification.request.content.userInfo);
    
    // 根据APP需要，判断是否要提示用户Badge、Sound、Alert
    completionHandler(UNNotificationPresentationOptionBadge | UNNotificationPresentationOptionSound | UNNotificationPresentationOptionAlert);
}

//  iOS 10: 点击通知进入App时触发，在该方法内统计有效用户点击数
- (void)userNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)())completionHandler {
    
    NSLog(@"didReceiveNotification：%@", response.notification.request.content.userInfo);
    
    // [ GTSdk ]：将收到的APNs信息传给个推统计
    [GeTuiSdk handleRemoteNotification:response.notification.request.content.userInfo];
    
    completionHandler();
}

#endif

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
    
    NSInteger nowTime = [NSString getNowTimeInterval];
    NSString *endTime = [kStanderDefault objectForKey:@"endTime"];
    if (nowTime > endTime.integerValue + 3600 * 2 && endTime != nil) {
        [self setRootViewController];
        [kStanderDefault removeObjectForKey:@"endTime"];
    }
    
    [GeTuiSdk resetBadge];
    [self setUpEnterForeground];
    
   
    
}

- (void)setUpEnterForeground {
    if (self.userModel && self.serviceModel) {
        
        [kSocketTCP cutOffSocket];
        kSocketTCP.userSn = [NSString stringWithFormat:@"%ld" , (long)_userModel.sn];
        [kSocketTCP socketConnectHost];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.7 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [kSocketTCP sendDataToHost:[NSString stringWithFormat:@"HM%ld%@%@N#" , (long)self.userModel.sn , _serviceModel.devTypeSn , _serviceModel.devSn] andType:kAddService andIsNewOrOld:nil];
        });
    }
    
    if (self.xinFengVC) {
        [self.xinFengVC requestXinFengServiceState];
    }
    
    if (self.mainVC) {
        [self.mainVC requestMainVCServiceState];
    }
}

- (void)applicationWillTerminate:(UIApplication *)application {
    NSLog(@"程序在终止时执行");
    
    [kSocketTCP cutOffSocket];
    
    NSString *endTime = [NSString stringWithFormat:@"%ld" , [NSString getNowTimeInterval]];
    [kStanderDefault setObject:endTime forKey:@"endTime"];
    
}

- (void)initUserModel:(UserModel *)userModel {
    
    self.userModel = [[UserModel alloc]init];
    self.userModel = userModel;
}

- (void)initServiceModel:(ServicesModel *)serviceModel {
    self.serviceModel = [[ServicesModel alloc]init];
    self.serviceModel = serviceModel;
}

- (void)initLastXinFengViewController:(XinFengViewController *)viewController {
    self.xinFengVC = viewController;
}

- (void)initLastMainViewController:(MainViewController *)viewController {
    self.mainVC = viewController;
}

@end
