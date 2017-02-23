//
//  UITextField+Custom.m
//  AEFT冷风扇
//
//  Created by 杭州阿尔法特 on 16/3/8.
//  Copyright © 2016年 阿尔法特. All rights reserved.
//

#import "UITextField+Custom.h"

@implementation UITextField (Custom)

+ (UITextField *)creatTextfiledWithPlaceHolder:(NSString *)text andSuperView:(UIView *)superView {
    UITextField *textFiled = [[UITextField alloc]init];
    textFiled.placeholder = text;
    textFiled.layer.cornerRadius = 5;
    
    textFiled.layer.borderColor = [UIColor blackColor].CGColor;
    textFiled.layer.borderWidth = 0;
    textFiled.clearButtonMode = UITextFieldViewModeWhileEditing;
    textFiled.returnKeyType = UIReturnKeyDone;
    
    textFiled.keyboardType = UIKeyboardTypeNumberPad;
    [textFiled setValue:[UIColor grayColor] forKeyPath:@"_placeholderLabel.textColor"];
    [textFiled setValue:[UIFont fontWithName:kFontWithName size:k14] forKeyPath:@"_placeholderLabel.font"];
    textFiled.font = [UIFont fontWithName:kFontWithName size:k14];
    textFiled.tintColor = kMainColor;
    
    [superView addSubview:textFiled];
    return textFiled;
}


/**
 *  限制输入框只能输入数字
 *
 *
 */
+ (BOOL)validateNumber:(NSString*)number {
    BOOL res = YES;
    NSCharacterSet* tmpSet = [NSCharacterSet characterSetWithCharactersInString:@"0123456789"];
    int i = 0;
    while (i < number.length) {
        NSString * string = [number substringWithRange:NSMakeRange(i, 1)];
        NSRange range = [string rangeOfCharacterFromSet:tmpSet];
        if (range.length == 0) {
            res = NO;
            break;
        }
        i++;
    }
    return res;
}

@end
