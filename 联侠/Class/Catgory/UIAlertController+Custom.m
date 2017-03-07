//
//  UIAlertController+Custom.m
//  AEFT冷风扇
//
//  Created by 杭州阿尔法特 on 16/4/5.
//  Copyright © 2016年 阿尔法特. All rights reserved.
//

#import "UIAlertController+Custom.h"

@implementation UIAlertController (Custom)

+ (UIAlertController *)creatCancleAndRightAlertControllerWithHandle:(void (^)())rightHandler andSuperViewController:(UIViewController *)superVC Title:(NSString *)text {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:text preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancleAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:nil];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"好的" style:UIAlertActionStyleDefault handler:rightHandler];
    [alertController addAction:cancleAction];
    [alertController addAction:okAction];
    
    [superVC presentViewController:alertController animated:YES completion:nil];
    return alertController;
    
}

+ (UIAlertController *)creatRightAlertControllerWithHandle:(void (^)())handler andSuperViewController:(UIViewController *)superVC Title:(NSString *)text {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:text preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"好的" style:UIAlertActionStyleDefault handler:handler];
    [alertController addAction:okAction];
    
    [superVC presentViewController:alertController animated:YES completion:nil];
     return alertController;
    
}

+ (UIAlertController *)creatSheetControllerWithFirstHandle:(void (^)())firstHandle andFirstTitle:(NSString *)firstText andSecondHandle:(void(^)())secondHandle andSecondTitle:(NSString *)secondTitle andThirtHandle:(void(^)())thirtHandle andThirtTitle:(NSString *)thirtTitle andForthHandle:(void(^)())forthHandle andForthTitle:(NSString *)forthTitle andSuperViewController:(UIViewController *)superVC {
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    //添加Button
    [alertController addAction: [UIAlertAction actionWithTitle:firstText style: UIAlertActionStyleDefault handler:firstHandle]];
    
    if (secondTitle != nil) {
        [alertController addAction:[UIAlertAction actionWithTitle:secondTitle style: UIAlertActionStyleDefault handler:secondHandle]];
    }
    
    if (thirtTitle != nil) {
        [alertController addAction:[UIAlertAction actionWithTitle:thirtTitle style: UIAlertActionStyleDefault handler:thirtHandle]];
    }
    
    if (forthTitle != nil) {
        [alertController addAction:[UIAlertAction actionWithTitle:forthTitle style: UIAlertActionStyleDefault handler:forthHandle]];
    }
    
    
    [alertController addAction: [UIAlertAction actionWithTitle: @"取消" style: UIAlertActionStyleCancel handler:nil]];
    
    [superVC presentViewController:alertController animated:YES completion:nil];
    return alertController;
}

+ (UIAlertController *)creatAlertControllerWithFirstTextfiledPlaceholder:(NSString *)firstPlaceholder andFirstTextfiledText:(NSString *)firstTitle andFirstAtcion:(SEL)firstAtcion andWhetherEdite:(BOOL)whetherEdite WithSecondTextfiledPlaceholder:(NSString *)secondPlaceholder andSecondTextfiledText:(NSString *)secondTitle andSecondAtcion:(SEL)secondAtcion andAlertTitle:(NSString *)alertTitle andAlertMessage:(NSString *)alertMessage andTextfiledAtcionTarget:(nullable id)target andSureHandle:(void(^)())sureHandle andSuperViewController:(UIViewController *)superVC {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:alertTitle message:alertMessage preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:sureHandle]];
    
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
    
    if (firstTitle || firstPlaceholder) {
        [alert addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
            
            if (firstTitle) {
                textField.text = firstTitle;
            }
            
            if (firstPlaceholder) {
                textField.placeholder = firstPlaceholder;
            }
            
            if (firstAtcion) {
                [textField addTarget:target action:firstAtcion forControlEvents:UIControlEventEditingDidEnd];
            }
            
            textField.userInteractionEnabled = whetherEdite;
        }];
    }
    
    if (secondTitle || secondPlaceholder) {
        [alert addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
            
            if (secondTitle) {
                textField.text = secondTitle;
            }
            
            if (secondPlaceholder) {
                textField.placeholder = secondPlaceholder;
            }
            
            if (secondAtcion) {
                [textField addTarget:target action:secondAtcion forControlEvents:UIControlEventEditingDidEnd];
            }
        }];
    }
    
    [superVC presentViewController:alert animated:YES completion:nil];
    
    return alert;
}

@end
