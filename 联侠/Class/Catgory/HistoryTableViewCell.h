//
//  HistoryTableViewCell.h
//  联侠
//
//  Created by 杭州阿尔法特 on 2017/2/22.
//  Copyright © 2017年 张海昌. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HistoryTableViewCell : UITableViewCell
@property (nonatomic , strong) ServicesModel *serviceModel;
@property (nonatomic , copy) NSString *chaXunLishiJiLu;
@property (nonatomic , strong) UIColor *liearColor;

@end
