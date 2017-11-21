//
//  ZHCTools.m
//  联侠
//
//  Created by 杭州阿尔法特 on 2017/11/21.
//  Copyright © 2017年 张海昌. All rights reserved.
//

#import "ZHCTools.h"

static ZHCTools *tools = nil;

@implementation ZHCTools

+ (instancetype)shareZHCTools {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        tools = [[self alloc]init];
    });
    return tools;
}

- (void)setAlertText:(NSString *)text viewController:(UIViewController *)controller handle:(void (^)())handler{
    [UIAlertController creatRightAlertControllerWithHandle:handler andSuperViewController:controller Title:text];
}

@end
