//
//  XinFengCaiDengFirstTableViewCell.h
//  联侠
//
//  Created by 杭州阿尔法特 on 2017/3/22.
//  Copyright © 2017年 张海昌. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XinFengCaiDengFirstTableViewCell : UITableViewCell
@property (nonatomic , strong) ServicesModel *serviceModel;
@property (nonatomic , strong) StateModel *stateModel;
@property (nonatomic , copy) NSString *titleString;
@property (nonatomic , strong) NSIndexPath *indexPath;
    
@end
