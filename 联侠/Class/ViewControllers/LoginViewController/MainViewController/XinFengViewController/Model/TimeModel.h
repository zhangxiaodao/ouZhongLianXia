//
//  TimeModel.h
//  联侠
//
//  Created by 杭州阿尔法特 on 2017/3/2.
//  Copyright © 2017年 张海昌. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TimeModel : NSObject
@property (nonatomic , assign) NSInteger fSwitchOff;
@property (nonatomic , assign) NSInteger fSwitchOn;
@property (nonatomic , assign) NSInteger hasRunOff;
@property (nonatomic , assign) NSInteger hasRunOffOnce;
@property (nonatomic , assign) NSInteger hasRunOn;
@property (nonatomic , assign) NSInteger hasRunOnOnce;
@property (nonatomic , copy) NSString *offJobTime;
@property (nonatomic , copy) NSString *onJobTime;
@property (nonatomic , copy) NSString *runWeek;

@end
