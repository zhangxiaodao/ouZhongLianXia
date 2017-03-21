//
//  HistoryViewController.h
//  AEFT冷风扇
//
//  Created by 杭州阿尔法特 on 16/3/11.
//  Copyright © 2016年 阿尔法特. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HistoryViewController : UIViewController
@property (nonatomic , strong) NSString *deviceSn;
@property (nonatomic , assign) CGFloat temperature;
 
@property (nonatomic  ,assign) CGFloat text;

@property (nonatomic  ,assign) NSInteger timeText;

@property (nonatomic , assign) CGFloat shengYuTime;

@property (nonatomic , assign) CGFloat nowUserTime;

@property (nonatomic , assign) NSInteger sumBingJingTime;

@property (nonatomic , strong) UserModel *userModel;

@property (nonatomic , strong) ServicesDataModel *serviceDataModel;

@property (nonatomic , strong) ServicesModel *serviceModel;

@end
