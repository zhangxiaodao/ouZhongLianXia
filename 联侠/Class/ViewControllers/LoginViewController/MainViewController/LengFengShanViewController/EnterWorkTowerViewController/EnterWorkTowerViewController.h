//
//  EnterWorkTowerViewController.h
//  AEFT冷风扇
//
//  Created by 杭州阿尔法特 on 16/3/11.
//  Copyright © 2016年 阿尔法特. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SendLengFengShanKaiGuanZhuangTaiDelegate <NSObject>

- (void)sendLengFengShanKaiGuanZhuangTai:(NSString *)whearthOpen;

@end


@interface EnterWorkTowerViewController : UIViewController
@property (nonatomic , strong) ServicesDataModel *serviceDataModel;
@property (nonatomic , strong) ServicesModel *serviceModel;
@property (nonatomic , strong) UserModel *model;
@property (nonatomic , strong) UIButton *offBtn;
@property (nonatomic , assign) NSInteger sumBingJingTime;
@property (nonatomic , strong) NSString *deviceSn;
@property (nonatomic , strong) StateModel *stateModel;

@property (nonatomic , assign) id<SendLengFengShanKaiGuanZhuangTaiDelegate> lengFengShanStateDelegate;

@end



