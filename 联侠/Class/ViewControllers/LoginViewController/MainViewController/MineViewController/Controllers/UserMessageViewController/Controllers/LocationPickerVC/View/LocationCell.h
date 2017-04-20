//
//  LocationCell.h
//  联侠
//
//  Created by 杭州阿尔法特 on 2017/4/14.
//  Copyright © 2017年 张海昌. All rights reserved.
//

#import "UserInfoCell.h"

@interface LocationCell : UserInfoCell

@property (nonatomic , copy) NSString *provience;
@property (nonatomic , copy) NSString *city;
@property (nonatomic , copy) NSString *town;
@property (nonatomic , strong) UIViewController *currentVC;
@end
