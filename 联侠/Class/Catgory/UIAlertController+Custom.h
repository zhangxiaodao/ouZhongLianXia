//
//  UIAlertController+Custom.h
//  AEFT冷风扇
//
//  Created by 杭州阿尔法特 on 16/4/5.
//  Copyright © 2016年 阿尔法特. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIAlertController (Custom)

+ (UIAlertController *)creatCancleAndRightAlertControllerWithHandle:(void (^)())rightHandler andSuperViewController:(UIViewController *)superVC Title:(NSString *)text;

+ (UIAlertController *)creatRightAlertControllerWithHandle:(void (^)())handler andSuperViewController:(UIViewController *)superVC Title:(NSString *)text;

+ (UIAlertController *)creatSheetControllerWithFirstHandle:(void (^)())firstHandle andFirstTitle:(NSString *)firstText andSecondHandle:(void(^)())secondHandle andSecondTitle:(NSString *)secondTitle andThirtHandle:(void(^)())thirtHandle andThirtTitle:(NSString *)thirtTitle andForthHandle:(void(^)())forthHandle andForthTitle:(NSString *)forthTitle andSuperViewController:(UIViewController *)superVC;

+ (UIAlertController *)creatAlertControllerWithFirstTextfiledPlaceholder:(NSString *)firstPlaceholder andFirstTextfiledText:(NSString *)firstTitle andFirstAtcion:(SEL)firstAtcion andWhetherEdite:(BOOL)whetherEdite WithSecondTextfiledPlaceholder:(NSString *)secondPlaceholder andSecondTextfiledText:(NSString *)secondTitle andSecondAtcion:(SEL)secondAtcion andAlertTitle:(NSString *)alertTitle andAlertMessage:(NSString *)alertMessage andTextfiledAtcionTarget:(nullable id)target andSureHandle:(void(^)())sureHandle andSuperViewController:(UIViewController *)superVC ;


@end
