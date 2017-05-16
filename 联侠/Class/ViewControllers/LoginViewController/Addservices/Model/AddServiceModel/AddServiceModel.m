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
    
    if ([key isEqualToString:@"typeSn"]) {
        _typeSn = value;
    }
    
    if ([key isEqualToString:@"typeName"]) {
        _typeName = value;
    }
    
    if ([key isEqualToString:@"protocol"]) {
        _protocol = value;
    }
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    
}

-(NSString *)description{
    
    return [NSString stringWithFormat:@"typeSn--%@ , typeName--%@ , protocol--%@ , bindUrl--%@" , _typeSn , _typeName , _protocol , _bindUrl];
}

@end
