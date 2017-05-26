//
//  AllTypeServiceTableViewCell.h
//  联侠
//
//  Created by 杭州阿尔法特 on 2016/12/2.
//  Copyright © 2016年 张海昌. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AllTypeServiceModel.h"
#import "BaseTableViewCell.h"

@interface AllTypeServiceTableViewCell : BaseTableViewCell
@property (nonatomic , assign) NSInteger count;
@property (nonatomic , strong) AllTypeServiceModel *allTypeServiceModel;

@end
