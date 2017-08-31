//
//  UIAlertController+Custom.h
//  AEFT冷风扇
//
//  Created by 杭州阿尔法特 on 16/4/5.
//  Copyright © 2016年 阿尔法特. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIAlertController (Custom)

+ (UIAlertController *_Nullable)creatCancleAndRightAlertControllerWithHandle:(void (^ __nullable)())rightHandler andSuperViewController:(UIViewController *_Nullable)superVC Title:(NSString *_Nullable)text;

+ (UIAlertController *_Nullable)creatRightAlertControllerWithHandle:(void (^ __nullable)())handler andSuperViewController:(UIViewController *_Nullable)superVC Title:(NSString *_Nullable)text;

+ (UIAlertController *_Nullable)creatSheetControllerWithFirstHandle:(void (^ __nullable)())firstHandle andFirstTitle:(NSString *_Nullable)firstText andSecondHandle:(void(^ __nullable)())secondHandle andSecondTitle:(NSString *_Nullable)secondTitle andThirtHandle:(void(^ __nullable)())thirtHandle andThirtTitle:(NSString *_Nullable)thirtTitle andForthHandle:(void(^ __nullable)())forthHandle andForthTitle:(NSString *_Nullable)forthTitle andSuperViewController:(UIViewController *_Nullable)superVC;

+ (UIAlertController *_Nullable)creatAlertControllerWithFirstTextfiledPlaceholder:(NSString *_Nullable)firstPlaceholder andFirstTextfiledText:(NSString *_Nullable)firstTitle andFirstAtcion:(SEL _Nullable )firstAtcion andWhetherEdite:(BOOL)whetherEdite WithSecondTextfiledPlaceholder:(NSString *_Nullable)secondPlaceholder andSecondTextfiledText:(NSString *_Nullable)secondTitle andSecondAtcion:(SEL _Nullable )secondAtcion andAlertTitle:(NSString *_Nullable)alertTitle andAlertMessage:(NSString *_Nullable)alertMessage andTextfiledAtcionTarget:(nullable id)target andSureHandle:(void(^ __nullable)())sureHandle andSuperViewController:(UIViewController *_Nullable)superVC ;


@end
