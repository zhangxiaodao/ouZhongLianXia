//
//  AirThirtTableViewCell.h
//  联侠
//
//  Created by 杭州阿尔法特 on 16/6/1.
//  Copyright © 2016年 张海昌. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AirPurificationViewController.h"
#import "UUChart.h"

@interface AirThirtTableViewCell : UITableViewCell
@property (nonatomic , weak) AirPurificationViewController *airVC;

@property (nonatomic , strong) ServicesDataModel *serviceDataModel;
@property (nonatomic , strong) ServicesModel *serviceModel;
@property (nonatomic , strong) UserModel *model;
@property (nonatomic , strong) StateModel *stateModel;
@end
