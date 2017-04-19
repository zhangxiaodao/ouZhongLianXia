//
//  BingJingShouMingTableViewCell.h
//  AEFT冷风扇
//
//  Created by 杭州阿尔法特 on 16/4/4.
//  Copyright © 2016年 阿尔法特. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BingJingShouMingTableViewCell : UITableViewCell

@property (nonatomic , copy) NSString *isKongJing;
@property (nonatomic , strong) NSString *devSn;
@property (nonatomic , strong) UIViewController *vc;


- (void)setUIbuJuWithNowUesrTime:(CGFloat)nowUserTime  andViewController:(UIViewController *)viewController;


@end
