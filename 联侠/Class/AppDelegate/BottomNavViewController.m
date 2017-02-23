//
//  BottomNavViewController.m
//  AEFT冷风扇
//
//  Created by 杭州阿尔法特 on 16/5/12.
//  Copyright © 2016年 阿尔法特. All rights reserved.
//

#import "BottomNavViewController.h"
#import "Launch1ViewController.h"
#import "LoginViewController.h"
#import "MainViewController.h"
#import "AddSViewController.h"
#import "AllServicesViewController.h"

#import "LengFengShanViewController.h"
#import "MineSerivesViewController.h"
#import "AirPurificationViewController.h"
#import "GanYiJiViewController.h"
#import "XinFengViewController.h"

#import "LaunchScreenViewController.h"

@interface BottomNavViewController ()

@end

@implementation BottomNavViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationBar.hidden = YES;
    
    NSUserDefaults *stander = [NSUserDefaults standardUserDefaults];
    NSString *isLaunchLoad = [stander objectForKey:@"isLaunch"];
    if ([isLaunchLoad isEqualToString:@"NO"]) {
        [kStanderDefault setObject:@"NO" forKey:@"firstRun"];
        
        if ([kStanderDefault objectForKey:@"Login"]) {
            
            if ([[kStanderDefault objectForKey:@"isHaveService"] isEqualToString:@"YES"]) {
                MineSerivesViewController *mineVC = [[MineSerivesViewController alloc]init];
                
                [self addChildViewController:mineVC];
             
            } else {
                
                AddSViewController *addServiceVC = [[AddSViewController alloc]init];
                [self addChildViewController:addServiceVC];
                
            }
            
        } else {
            LoginViewController *loginVC = [[LoginViewController alloc]init];
            
            [self addChildViewController:loginVC];
        }
    } else{
        [kStanderDefault setObject:@"YES" forKey:@"firstRun"];
        Launch1ViewController *launchVC = [[Launch1ViewController alloc]init];
        [self addChildViewController:launchVC];
    }
    
    if ([[kStanderDefault objectForKey:@"isRun"] isEqualToString:@"YES"]) {
        
        LaunchScreenViewController *launScreenVC = [[LaunchScreenViewController alloc]init];
        [self addChildViewController:launScreenVC];
        
        
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            [UIView animateWithDuration:1 animations:^{
                launScreenVC.maskView.alpha = 0;
            }];
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                CATransition* transition = [CATransition animation];
                transition.type = kCATransitionPush;//可更改为其他方式
                transition.subtype = kCATransitionFromRight;
                transition.duration = 1;
                [self.view.layer addAnimation:transition forKey:kCATransition];
                [self popViewControllerAnimated:YES];
            });
            
            [kStanderDefault setObject:@"NO" forKey:@"isRun"];
        });

    }
}

@end
