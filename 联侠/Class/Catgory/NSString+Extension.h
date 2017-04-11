//
//  NSString+Extension.h
//  联侠
//
//  Created by 杭州阿尔法特 on 16/9/19.
//  Copyright © 2016年 张海昌. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Extension)

+ (NSMutableAttributedString *)setSubStringOfOriginalString:(NSString *)originalStr andColorString:(NSString *)colorSubString andColor:(UIColor *)color;

#pragma mark - 限制输入为数字
+ (BOOL)validateNumber:(NSString*)number;

+ (void)setNSMutableAttributedString:(CGFloat)number andSuperLabel:(UILabel *)superLabel andDanWei:(NSString *)danWei andSize:(CGFloat)size andTextColor:(UIColor *)color isNeedTwoXiaoShuo:(NSString *)isNeedTwoXiaoShu;

+ (void)setAttributedString:(NSString *)sumStr WithSubString:(NSInteger)subFromIndex andSize:(CGFloat)size andTextColor:(UIColor *)color isNeedTwoXiaoShuo:(NSString *)isNeedTwoXiaoShu andSuperLabel:(UILabel *)superLabel;


/**
 *  以当前时间为节点，获取N小时前，或N天前，或N月前的时间
 *
 *  @param hour  小时（可以为空）
 *  @param day   天（可以为空）
 *  @param month 月（可以穿NULL值）
 *
 *  @return 返回以前的时间
 */
+ (NSString *)timeAndAfterHours:(NSNumber *)hour andAfterDays:(NSNumber *)day andMonth:(NSNumber *)month;

/**
 *  以当前时间为节点，获取afterHour小时后，或afterMinutes分钟之后的时间
 *
 *  @param afterHour  小时（可以为空）
 *  @param afterMinutes   分钟（可以为空）
 *  @param isNeedTimeInterval 是否需要转化为秒数（需要传YES  不需要传NO）
 *
 *  @return 返回以前的时间
 */
+ (NSMutableArray *)nowTimeAndAfterHour:(NSString *)afterHour andAfterMinutes:(NSString *)afterMinutes andIsNeedTimeInterval:(NSString *)isNeedTimeInterval;

/**
 *  获取当前时间，以字符串的形式返回
 *  @return 返回当前的时间
 */
+ (NSString *)getNowTimeString;

/**
 *  获取当前时间秒数，以字符串的形式返回
 *  @return 返回当前的时间
 */
+ (NSInteger)getNowTimeInterval;

/**
 *  把秒数转化成时间值
 *  @return 返回当前的时间
 */
+ (NSString *)turnTimeIntervalToString:(NSInteger)timeInterval;
/**
 *  把时间转化成时间戳
 *  @return 返回时间的时间戳
 */
+(NSInteger)turnTimeToInterval:(NSString *)formatTime;


/**
 *  十六进制转十进制
 *  @return 返回对应的十进制
 */
+ (NSString *)turnHexToInt:(NSString *)hexString;

+(NSString *)ToHex:(long long int)tmpid;

#pragma mark - 把当前时间的 时 和 分  转化为十六进制
+ (NSArray *)sendXinFengNowTime;

@end
