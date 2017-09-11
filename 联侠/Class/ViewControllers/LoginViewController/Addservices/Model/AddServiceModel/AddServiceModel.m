//
//  AddServiceModel.m
//  联侠
//
//  Created by 杭州阿尔法特 on 2016/11/8.
//  Copyright © 2016年 张海昌. All rights reserved.
//

#import "AddServiceModel.h"

@implementation AddServiceModel

- (void)setValue:(id)value forKey:(NSString *)key {
    
    if ([key isEqualToString:@"bindUrl"]) {
        if (value == nil || [value isKindOfClass:[NSNull class]]) {
            _bindUrl = nil;
        } else {
            _bindUrl = value;
        }
    }
    
    if ([key isEqualToString:@"slType"]) {
        if ([value isKindOfClass:[NSNull class]]) {
            _slType = 0;
        } else {
            _slType = [value integerValue];
        }
    }
    
    if ([key isEqualToString:@"typeSn"]) {
        _typeSn = value;
    }
    
    if ([key isEqualToString:@"typeName"]) {
        _typeName = value;
    }
    
    if ([key isEqualToString:@"typeNumber"]) {
        _typeNumber = value;
    }
    
    if ([key isEqualToString:@"protocol"]) {
        _protocol = value;
    }
    
    if ([key isEqualToString:@"brand"]) {
        _brand = value;
    }
    
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    
}

-(NSString *)description{
    
    return [NSString stringWithFormat:@"typeSn--%@ , typeName--%@ , typeNumber--%@ , protocol--%@ , bindUrl--%@ , brand--%@" , _typeSn , _typeName , _typeNumber ,  _protocol , _bindUrl , _brand];
}

@end
