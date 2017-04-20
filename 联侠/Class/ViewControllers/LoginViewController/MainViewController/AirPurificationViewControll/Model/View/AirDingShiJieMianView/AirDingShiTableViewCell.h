//
//  AirDingShiTableViewCell.h
//  联侠
//
//  Created by 杭州阿尔法特 on 16/6/8.
//  Copyright © 2016年 张海昌. All rights reserved.
//

#import <UIKit/UIKit.h>

@class AirDingShiTableViewCell;
@protocol AirDingShiTableViewCellDelegate <NSObject>

- (void)getKongJingDingShiData:(AirDingShiTableViewCell *)AirDingShiTableViewCell andData:(id)data;

@end

@interface AirDingShiTableViewCell : UITableViewCell
@property (nonatomic , strong) UIViewController *currentVC;
@property (nonatomic , copy) NSString *fromWhich;

@property (nonatomic , strong) UIButton *isSelectedBtn;

@property (nonatomic , strong) UILabel *offTime;
@property (nonatomic , strong) UILabel *openTime;

@property (nonatomic , assign) id<AirDingShiTableViewCellDelegate> delegate;

@end
