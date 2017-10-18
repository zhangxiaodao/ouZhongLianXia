//
//  EnterThirtTableViewCell.h
//  AEFT冷风扇
//
//  Created by 杭州阿尔法特 on 16/3/11.
//  Copyright © 2016年 阿尔法特. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol WindTypeDelegate <NSObject>

- (void)sendWindType:(NSString *)windType;

@end

@interface EnterThirtTableViewCell : UITableViewCell
@property (nonatomic , strong) ServicesModel *serviceModel;
@property (nonatomic , strong) UISlider *slider;
@property (nonatomic , strong) StateModel *model;
@property (nonatomic , assign) id<WindTypeDelegate>    delegate;
@end
