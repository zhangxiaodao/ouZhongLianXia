//
//  searchServicesViewController.h
//  AEFT冷风扇
//
//  Created by 杭州阿尔法特 on 16/3/26.
//  Copyright © 2016年 阿尔法特. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SearchServicesViewController : UIViewController

//@property (nonatomic , strong) AddServiceModel *addServiceModel;

@property (strong, nonatomic) NSString *bssid;
@property (strong, nonatomic)  NSString *ssidText;
@property (nonatomic ,strong) NSString *apSsid;
@property (nonatomic , strong) NSString *deviceSn;
@end
