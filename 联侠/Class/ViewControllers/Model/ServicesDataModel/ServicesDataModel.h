//
//  ServicesDataModel.h
//  AEFT冷风扇
//
//  Created by 杭州阿尔法特 on 16/4/12.
//  Copyright © 2016年 阿尔法特. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ServicesDataModel : NSObject
/**
 *  共用
 */
/**
*  累计运行时间
*/
@property (nonatomic , assign) CGFloat totalTime;

/**
 *  滤芯使用寿命
 */
@property (nonatomic , assign) CGFloat filterTime;


/**
 *  冷风扇数据
 */
/**
 *  累计降温摄氏度（时间维度）
 */
@property (nonatomic , assign) CGFloat totalC;
/**
 *  累计过滤粉尘mg（时间维度）
 */
@property (nonatomic , assign) CGFloat filterDust;
/**
 *  已用水位状态时间（时间维度）
 */
@property (nonatomic , assign) CGFloat waterStateTime;
/**
 *  已用滤网洁度（时间维度）
 */
@property (nonatomic , assign) CGFloat filterScreenNeat;
/**
 *  已用冰晶时间（时间维度）
 */
@property (nonatomic , assign) CGFloat iceCrystalTime;

@end
