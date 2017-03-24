//
//  AppDelegate.h
//  AEFT冷风扇
//
//  Created by 杭州阿尔法特 on 16/3/8.
//  Copyright © 2016年 阿尔法特. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "GCDAsyncSocket.h"
#import "GeTuiSdk.h" 
#import "ServicesModel.h"
#import "UserModel.h"
#import "XinFengViewController.h"

// iOS10 及以上需导入 UserNotifications.framework
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_10_0
#import <UserNotifications/UserNotifications.h>
#endif

@interface AppDelegate : UIResponder <UIApplicationDelegate , GCDAsyncSocketDelegate , GeTuiSdkDelegate , UNUserNotificationCenterDelegate>

@property (strong, nonatomic) UIWindow *window;

- (void)initLastMainViewController:(MainViewController *)viewController;
- (void)initLastXinFengViewController:(XinFengViewController *)viewController;
- (void)initUserModel:(UserModel *)userModel;
- (void)initServiceModel:(ServicesModel *)serviceModel;
@end

