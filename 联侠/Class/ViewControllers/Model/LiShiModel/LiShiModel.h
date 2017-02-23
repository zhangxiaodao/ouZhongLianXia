//
//  LiShiModel.h
//  AEFT冷风扇
//
//  Created by 杭州阿尔法特 on 16/4/12.
//  Copyright © 2016年 阿尔法特. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LiShiModel : NSObject

@property (nonatomic , strong) NSDate *useDate;
@property (nonatomic , assign) NSInteger useTime;

/**
 *  空气质量时间
 */
@property (nonatomic , copy) NSString *aqiDate;
/**
 *  空气质量时间
 */
@property (nonatomic , copy) NSString *aqiTime;
/**
 *  空气质量城市
 */
@property (nonatomic , copy) NSString *city;
/**
 *  空气质量指数
 */
@property (nonatomic , copy) NSString *aqi;
/**
 *  pm25的值
 */
@property (nonatomic , copy) NSString *pm25;
@end
