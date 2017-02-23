//
//  AirDingShiJieMianViewController.h
//  联侠
//
//  Created by 杭州阿尔法特 on 16/6/8.
//  Copyright © 2016年 张海昌. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AirDingShiJieMianViewController : UIViewController
@property (nonatomic , copy) NSString *titleText;
@property (nonatomic , copy) NSString *fromWhich;
@property (nonatomic , strong) ServicesModel *serviceModel;

@property (nonatomic , copy) NSNumber *buttonSelected;


@end
