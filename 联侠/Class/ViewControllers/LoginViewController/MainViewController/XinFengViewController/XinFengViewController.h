//
//  XinFengViewController.h
//  联侠
//
//  Created by 杭州阿尔法特 on 16/10/10.
//  Copyright © 2016年 张海昌. All rights reserved.
//

#import "MainViewController.h"

@protocol SendServiceModelToParentVCDelegate <NSObject>

- (void)sendServiceModelToParentVC:(ServicesModel *)serviceModel;

@end

@interface XinFengViewController : UIViewController

- (void)requestServiceState;
@property (nonatomic , strong) NSIndexPath *indexPath;
@property (nonatomic , strong) NSMutableArray *serviceArray;
@property (nonatomic , assign) id<SendServiceModelToParentVCDelegate> sendServiceModelToParentVCDelegate;

@end
