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

- (void)setValue:(id)value forKey:(NSString *)key {
    if ([key isEqualToString:@"offJobTime"]) {
        if ([value isKindOfClass:[NSNull class]]) {
            _offJobTime = 0;
        } else {
            _offJobTime = value;
        }
    } if ([key isEqualToString:@"onJobTime"]) {
        if ([value isKindOfClass:[NSNull class]]) {
            _onJobTime = 0;
        } else {
            _onJobTime = value;
        }
    } if ([key isEqualToString:@"runWeek"]) {
        if ([value isKindOfClass:[NSNull class]]) {
            _runWeek = 0;
        } else {
            _runWeek = value;
        }
    } if ([key isEqualToString:@"fSwitchOff"]) {
        
        if ([value isKindOfClass:[NSNull class]]) {
            _fSwitchOff = 0;
        } else {
            _fSwitchOff = [value integerValue];
        }
        
    } if ([key isEqualToString:@"fSwitchOn"]) {
        
        if ([value isKindOfClass:[NSNull class]]) {
            _fSwitchOn = 0;
        } else {
            _fSwitchOn = [value integerValue];
        }
        
    } if ([key isEqualToString:@"hasRunOff"]) {
        
        if ([value isKindOfClass:[NSNull class]]) {
            _hasRunOff = 0;
        } else {
            _hasRunOff = [value integerValue];
        }
        
    } if ([key isEqualToString:@"hasRunOffOnce"]) {
        
        if ([value isKindOfClass:[NSNull class]]) {
            _hasRunOffOnce = 0;
        } else {
            _hasRunOffOnce = [value integerValue];
        }
        
    } if ([key isEqualToString:@"hasRunOn"]) {
        
        if ([value isKindOfClass:[NSNull class]]) {
            _hasRunOn = 0;
        } else {
            _hasRunOn = [value integerValue];
        }
        
    } if ([key isEqualToString:@"hasRunOnOnce"]) {
        
        if ([value isKindOfClass:[NSNull class]]) {
            _hasRunOnOnce = 0;
        } else {
            _hasRunOnOnce = [value integerValue];
        }
    }
}

- (NSString *)description {
    return [NSString stringWithFormat:@"_fSwitchOff--%ld , _fSwitchOn--%ld , _hasRunOff--%ld , _hasRunOffOnce--%ld , __hasRunOn--%ld , _hasRunOnOnce--%ld , _offJobTime--%@ , _onJobTime--%@ , _runWeek--%@" , _fSwitchOff , _fSwitchOn , _hasRunOff , _hasRunOffOnce , _hasRunOn , _hasRunOnOnce , _offJobTime , _onJobTime , _runWeek];
}

@end
