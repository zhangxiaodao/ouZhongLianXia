//
//  UITextField+Custom.h
//  AEFT冷风扇
//
//  Created by 杭州阿尔法特 on 16/3/8.
//  Copyright © 2016年 阿尔法特. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITextField (Custom)

+ (UITextField *)creatTextfiledWithPlaceHolder:(NSString *)text andSuperView:(UIView *)superView;

/**
 *  限制输入框只能输入数字
 *
 *
 */
+ (BOOL)validateNumber:(NSString*)number;

@end
