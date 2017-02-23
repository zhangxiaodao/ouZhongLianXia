//
//  AirPurificationForthTableViewCell.h
//  联侠
//
//  Created by 杭州阿尔法特 on 16/6/7.
//  Copyright © 2016年 张海昌. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AirPurificationForthTableViewCell : UITableViewCell

@property (nonatomic , strong) ServicesModel *serviceModel;

@property (nonatomic , strong) StateModel *stateModel;

@property (nonatomic , copy) NSNumber *buttonSelected;

@end
