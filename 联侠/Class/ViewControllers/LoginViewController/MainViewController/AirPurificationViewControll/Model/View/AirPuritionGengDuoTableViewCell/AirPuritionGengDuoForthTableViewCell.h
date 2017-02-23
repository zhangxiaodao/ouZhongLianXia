//
//  AirPuritionGengDuoForthTableViewCell.h
//  联侠
//
//  Created by 杭州阿尔法特 on 16/6/14.
//  Copyright © 2016年 张海昌. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UUChart.h"
@interface AirPuritionGengDuoForthTableViewCell : UITableViewCell
@property (nonatomic , strong) UIImageView *shiNeiHeShiWai;
@property (nonatomic , strong) UILabel *titleLable;

- (NSString *)timeAndAfterHours:(NSNumber *)hour andAfterDays:(NSNumber *)day andMonth:(NSNumber *)month;

@end
