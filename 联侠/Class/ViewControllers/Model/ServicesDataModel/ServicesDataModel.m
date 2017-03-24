//
//  ServicesDataModel.m
//  AEFT冷风扇
//
//  Created by 杭州阿尔法特 on 16/4/12.
//  Copyright © 2016年 阿尔法特. All rights reserved.
//

#import "ServicesDataModel.h"

@implementation ServicesDataModel

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    if ([key isEqualToString:@"filterDust"]) {
        self.filterDust = [key floatValue];
    }
    if ([key isEqualToString:@"iceCrystalTime"]) {
        self.iceCrystalTime = [key floatValue];
    }
    
    if ([key isEqualToString:@"filterScreenNeat"]) {
        self.filterScreenNeat = [key floatValue];
    }
    
    if ([key isEqualToString:@"totalC"]) {
        self.totalC = [key floatValue];
    }
    
    if ([key isEqualToString:@"totalTime"]) {
        self.totalTime = [key floatValue];
    }
    
    if ([key isEqualToString:@"waterStateTime"]) {
        self.waterStateTime = [key floatValue];
    }
    
    if ([key isEqualToString:@"filterTime"]) {
        self.filterTime = [key floatValue];
    }
    
}

- (NSString *)description {
    return [NSString stringWithFormat:@"_totalTime--%f" , _totalTime];
}

@end
