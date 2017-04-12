//
//  UserMessageViewController.h
//  AEFT冷风扇
//
//  Created by 杭州阿尔法特 on 16/3/16.
//  Copyright © 2016年 阿尔法特. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DiZhiModel.h"

@interface UserMessageViewController : UITableViewController

@property (nonatomic , retain) UIImageView *headImageView;
@property (nonatomic  ,strong) UserModel *userModel;

@property (nonatomic , strong) UIImage *headImage;

@end
