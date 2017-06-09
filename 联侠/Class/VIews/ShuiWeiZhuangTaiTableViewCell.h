//
//  ShuiWeiZhuangTaiTableViewCell.h
//  AEFT冷风扇
//
//  Created by 杭州阿尔法特 on 16/3/31.
//  Copyright © 2016年 阿尔法特. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ShuiWeiZhuangTaiTableViewCell : UITableViewCell
@property (nonatomic , strong) ServicesModel *serviceModel;
@property (nonatomic , strong) UIImageView *imageVV;
@property (nonatomic , strong) UIViewController *vc;
@property (nonatomic , strong) UILabel *shengYuLable;
@property (nonatomic , strong) UIButton *fuWeiBtn;
@property (nonatomic , assign) CGFloat shengYuTime;

- (void)setUIBuJuWith:(CGFloat)shengYuTimeText andSumShuiWei:(CGFloat)sumShuiWei andImage:(UIImage *)image andViewController:(UIViewController *)viewContrller;

@end
