//
//  UserInfoCommonCell.h
//  联侠
//
//  Created by 杭州阿尔法特 on 2017/4/13.
//  Copyright © 2017年 张海昌. All rights reserved.
//

#import "UserInfoCell.h"

@interface UserInfoCommonCell : UITableViewCell
@property (nonatomic , strong) UIImageView *headPortraitImageView;
@property (nonatomic , strong) UIViewController *currentVC;
@property (nonatomic , strong) UILabel *rightLabel;
@property (nonatomic , strong) UIImageView *selectedImage;
@property (nonatomic , strong) NSIndexPath *indexPath;
@property (nonatomic , strong) UserModel *userModel;
@property (nonatomic , strong) UILabel *idLabel;
@end
