//
//  StateModel.h
//  AEFT冷风扇
//
//  Created by 杭州阿尔法特 on 16/4/12.
//  Copyright © 2016年 阿尔法特. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface StateModel : NSObject

/**
 *  公用
 *
 */

/**
 *  开关
 */
@property (nonatomic , assign) NSInteger fSwitch;
/**
 *  风速：1：低，2：中，3：高 4; 最高
 */
@property (nonatomic , assign) NSInteger fWind;
/**
 *  杀菌
 */
@property (nonatomic , assign) NSInteger fUV;

/**
 *  负离子模式
 */
@property (nonatomic , assign) NSInteger fAnion;


/**
 *  冷风扇
 */

/**
 *  摆风：0：关闭，1：开启
 */
@property (nonatomic , assign) NSInteger fSwing;
/**
 *  童锁
 */
@property (nonatomic , assign) NSInteger fLock;
/**
 *  状态：制冷加湿
 */
@property (nonatomic , assign) NSInteger fCold;
/**
 *  冷风扇: 模式：1：正常，2：自然，3：睡眠
 *
 */
@property (nonatomic , assign) NSInteger fMode;


/**
 *  空净
 */


/**
 *  自动模式
 */
@property (nonatomic , assign) NSInteger fAuto;
/**
 *  睡眠模式
 */
@property (nonatomic , assign) NSInteger fSleep;

/**
 *  温度
 */
@property (nonatomic , copy) NSString *currentC;
/**
 *  空气质量
 */
@property (nonatomic , copy) NSString *aqi;
/**
 *  清洁滤网时间
 */
@property (nonatomic , assign) NSInteger cleanFilterScreen;
/**
 *  更换滤网时间
 */
@property (nonatomic , assign) NSInteger changeFilterScreen;
/**
 *  pm25的值
 */
@property (nonatomic , copy) NSString *pm25;
/**
 *  指示灯颜色
 */
@property (nonatomic , assign) NSInteger light;
/**
 *  干衣机
 */
/**
 *  干衣机: 档位: 1:高热  2：节能
 */
@property (nonatomic , assign) NSInteger fShift;

#pragma mark - 新风空净的属性
#pragma mark - 新风当前湿度
@property (nonatomic , assign) NSInteger   currentH;

#pragma mark - 新风当前co2
@property (nonatomic , assign) NSInteger   co2;

#pragma mark - 新风定时时间
@property (nonatomic , assign) NSInteger   durTime;

#pragma mark - 新风甲醛
@property (nonatomic , assign) NSInteger   methanal;



@end
