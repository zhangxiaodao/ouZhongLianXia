//
//  MineViewController.h
//  AEFT冷风扇
//
//  Created by 杭州阿尔法特 on 16/3/12.
//  Copyright © 2016年 阿尔法特. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DiZhiModel.h"
@interface MineViewController : UIViewController
//@property (nonatomic , strong) NSMutableArray *serviceArray;
//@property (nonatomic , strong) DiZhiModel *diZhiModel;
@property (nonatomic , strong) UserModel *userModel;
@property (nonatomic , strong) UIImage *headImage;
@property (nonatomic , strong) UIImageView *headImageView;
@property (nonatomic  ,strong) NSString *fromMainVC;
@end
