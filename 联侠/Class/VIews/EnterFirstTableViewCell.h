//
//  EnterFirstTableViewCell.h
//  AEFT冷风扇
//
//  Created by 杭州阿尔法特 on 16/3/11.
//  Copyright © 2016年 阿尔法特. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol ModelDelegate <NSObject>

- (void)sendTheModelType:(NSString *)modelType;

@end

@interface EnterFirstTableViewCell : UITableViewCell
@property (nonatomic , strong) ServicesModel *serviceModel;
@property (nonatomic , strong) StateModel *model;
@property (nonatomic , strong) NSString *modelString;

@property (nonatomic , copy) NSString *isAnimation;
@property (nonatomic , assign) id<ModelDelegate> delegate;
@property (nonatomic , strong) UIViewController *currentVC;
@end
