//
//  TabBarViewController.m
//  联侠
//
//  Created by 杭州阿尔法特 on 16/10/8.
//  Copyright © 2016年 张海昌. All rights reserved.
//

#import "TabBarViewController.h"
#import "MineViewController.h"
#import "MineSerivesViewController.h"
#import "XMGNavigationController.h"

#define STOREAPPID @"1113948983"
@interface TabBarViewController ()<UITabBarControllerDelegate>

@end

@implementation TabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    MineSerivesViewController *mineSerVC = [[MineSerivesViewController alloc]init];
    XMGNavigationController *mineSerNav = [[XMGNavigationController alloc]initWithRootViewController:mineSerVC];
    mineSerVC.tabBarItem.title = @"设备列表";
    mineSerVC.tabBarItem.image = [[UIImage imageNamed:@"tabbar_service"] imageWithRenderingMode:UIImageRenderingModeAutomatic];
    
   
    
    MineViewController *userVC = [[MineViewController alloc]init];
    XMGNavigationController *userNav = [[XMGNavigationController alloc]initWithRootViewController:userVC];
    userNav.tabBarItem.title = @"个人中心";
    userNav.tabBarItem.image = [[UIImage imageNamed:@"tabbar_mine"] imageWithRenderingMode:UIImageRenderingModeAutomatic];
    
    self.automaticallyAdjustsScrollViewInsets = YES;

    self.tabBar.hidden = YES;
    

    [self addChildViewController:mineSerNav];
    [self addChildViewController:userNav];
    
    
    self.tabBar.tintColor = kMainColor;
    self.delegate = self;
}

@end
