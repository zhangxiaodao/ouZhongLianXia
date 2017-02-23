//
//  UserMessageTableViewCell.h
//  AEFT冷风扇
//
//  Created by 杭州阿尔法特 on 16/3/16.
//  Copyright © 2016年 阿尔法特. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DiZhiModel.h"
@class GeRenModel;

@interface UserMessageTableViewCell : UITableViewCell

@property (nonatomic , retain) UILabel *leftLable;
@property (nonatomic , retain) UILabel *rightLable;
@property (nonatomic , retain) UIImageView *rightImage;

@property (nonatomic , strong) DiZhiModel *dizhiModel;
@property (nonatomic , strong) NSIndexPath *indexPath;
@property (nonatomic , strong) UserModel *userModel;

@property (nonatomic , strong) GeRenModel *geRenModel;
@end
