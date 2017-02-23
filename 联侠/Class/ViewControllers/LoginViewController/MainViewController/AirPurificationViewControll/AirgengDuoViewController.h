//
//  AirgengDuoViewController.h
//  联侠
//
//  Created by 杭州阿尔法特 on 16/6/1.
//  Copyright © 2016年 张海昌. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AirgengDuoViewController : UIViewController
@property (nonatomic , strong) UserModel *userModel;
@property (nonatomic , strong) ServicesDataModel *serviceDataModel;
@property (nonatomic , strong) ServicesModel *serviceModel;
@property (nonatomic , strong) StateModel *stateModel;
@property (nonatomic , assign) CGFloat sumLvXinTime;

@property (nonatomic , copy) NSString *shiWaiPm25;
@property (nonatomic , copy) NSString *shiNeiPm25;

@end
