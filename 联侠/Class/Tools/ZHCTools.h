//
//  ZHCTools.h
//  联侠
//
//  Created by 杭州阿尔法特 on 2017/11/21.
//  Copyright © 2017年 张海昌. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZHCTools : NSObject

+ (instancetype)shareZHCTools;
- (void)setAlertText:(NSString *)text viewController:(UIViewController *)controller handle:(void (^)())handler;
@end
