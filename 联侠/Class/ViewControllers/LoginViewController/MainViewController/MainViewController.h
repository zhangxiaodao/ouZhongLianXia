//
//  MainViewController.h
//  AEFT冷风扇
//
//  Created by 杭州阿尔法特 on 16/3/8.
//  Copyright © 2016年 阿尔法特. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ServicesDataModel.h"
#import "StateModel.h"
#import "ServicesModel.h"

@protocol SendServiceModelToParentVCDelegate <NSObject>

- (void)sendServiceModelToParentVC:(ServicesModel *)serviceModel;

@end

@protocol SendViewControllerToParentVCDelegate <NSObject>

- (void)sendViewControllerToParentVC:(UIViewController *)viewController;

@end

@interface MainViewController : UIViewController
@property (nonatomic , retain) NSDictionary *accAndPassWord;
@property (nonatomic , strong) UIImage *headImage;
@property (nonatomic , strong) UIImageView *touMingImageVIew;
@property (nonatomic , strong) NSMutableArray *wearthArray;
@property (nonatomic , strong) ServicesDataModel *serviceDataModel;
@property (nonatomic , strong) StateModel *stateModel;
@property (nonatomic , strong) ServicesModel *serviceModel;
@property (nonatomic , strong) UserModel *userModel;

@property (nonatomic , strong) NSMutableArray *serviceArray;

@property (nonatomic , strong) UIView *bottomView;
@property (nonatomic , strong) UIButton *bottomBtn;
@property (nonatomic , strong) UITableView *tableView;
@property (nonatomic , strong) NSMutableDictionary *wearthDic;

@property (nonatomic , assign) id<SendViewControllerToParentVCDelegate> sendVCDelegate;
@property (nonatomic , assign) id<SendServiceModelToParentVCDelegate> sendServiceModelToParentVCDelegate;


- (void)requestMainVCServiceState;
- (void)swipeGesture:(UISwipeGestureRecognizer *)swipe;
- (void)kongQiJingHuaQiOpenAtcion:(UIButton *)btn;
- (void)lengFengShanOpenAtcion:(UIButton *)btn;
- (void)lengFengShanCloseAtcion:(UIButton *)btn;
- (void)ganYiJiOpenAtcion:(UIButton *)btn;
@end
