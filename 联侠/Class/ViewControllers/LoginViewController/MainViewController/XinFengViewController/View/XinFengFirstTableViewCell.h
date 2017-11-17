//
//  XinFengFirstTableViewCell.h
//  联侠
//
//  Created by 杭州阿尔法特 on 16/10/10.
//  Copyright © 2016年 张海昌. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XinFengFirstTableViewCell : UITableViewCell
@property (nonatomic , strong) ServicesDataModel *serviceDataModel;
@property (nonatomic , strong) ServicesModel *serviceModel;
@property (nonatomic , strong) NSTimer *myTimer;

@property (nonatomic , strong) UIButton *pm25Btn;
- (void)setPm25BtnValueText;
- (void)setPm25BtnText;
@end
