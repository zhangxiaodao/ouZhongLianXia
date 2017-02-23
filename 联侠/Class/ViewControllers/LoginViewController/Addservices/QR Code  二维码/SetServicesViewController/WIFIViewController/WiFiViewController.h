//
//  WiFiViewController.h
//  AEFT冷风扇
//
//  Created by 杭州阿尔法特 on 16/3/25.
//  Copyright © 2016年 阿尔法特. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WiFiViewController : UIViewController

@property (strong, nonatomic)  UILabel *ssidLabel;
@property (strong, nonatomic) NSString *bssid;
@property (nonatomic , strong) AddServiceModel *addServiceModel;
@end
