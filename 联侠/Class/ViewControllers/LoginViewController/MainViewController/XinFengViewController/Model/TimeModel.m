//
//  TimeModel.m
//  联侠
//
//  Created by 杭州阿尔法特 on 2017/3/2.
//  Copyright © 2017年 张海昌. All rights reserved.
//

#import "TimeModel.h"

@implementation TimeModel

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    
}

- (NSString *)description {
    return [NSString stringWithFormat:@"_offJobTime--%@ , _onJobTime--%@ , _runWeek--%@ , _durTime--%@" , _offJobTime , _onJobTime , _runWeek , _durTime];
}

@end
