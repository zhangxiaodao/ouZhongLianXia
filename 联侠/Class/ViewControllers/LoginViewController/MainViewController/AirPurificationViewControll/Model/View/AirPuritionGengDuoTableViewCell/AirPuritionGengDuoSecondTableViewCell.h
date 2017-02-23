//
//  AirPuritionGengDuoSecondTableViewCell.h
//  联侠
//
//  Created by 杭州阿尔法特 on 16/6/14.
//  Copyright © 2016年 张海昌. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AirPuritionGengDuoSecondTableViewCell : UITableViewCell
@property (nonatomic , strong) ServicesDataModel *serviceDataModel;
@property (nonatomic , strong) StateModel *stateModel;
@property (nonatomic , copy) NSString *shiWaiPm25;
@property (nonatomic , copy) NSString *shiNeiPm25;
@end
