//
//  LvWangJieDuTableViewCell.h
//  AEFT冷风扇
//
//  Created by 杭州阿尔法特 on 16/3/31.
//  Copyright © 2016年 阿尔法特. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LvWangJieDuTableViewCell : UITableViewCell

@property (nonatomic , copy) NSString *isKongJingLvWang;
@property (nonatomic , strong) UIView *yanZhongView;
@property (nonatomic , strong) UIView *zhongDuView;
@property (nonatomic , strong) UIView *qingDuView;
@property (nonatomic , strong) UIView *qingJieView;
@property (nonatomic , strong) UIImageView *zhiBiaoView;
@property (nonatomic , strong) UIViewController *vc;
@property (nonatomic , strong) NSString *devSn;

- (void)setZhiZhenView:(NSInteger)index andViewController:(UIViewController *)viewController;

@end
