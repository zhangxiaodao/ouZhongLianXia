//
//  GeRenModel.m
//  AEFT冷风扇
//
//  Created by 杭州阿尔法特 on 16/4/21.
//  Copyright © 2016年 阿尔法特. All rights reserved.
//

#import "GeRenModel.h"

@implementation GeRenModel

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
}

- (void)setValue:(id)value forKey:(NSString *)key {
    if ([key isEqualToString:@"user.birthdate"]) {
        _birthday = value;
    }
    
    if ([key isEqualToString:@"user.email"]) {
        _email = value;
    }
    
    if ([key isEqualToString:@"user.nickname"]) {
        _niCheng = value;
    }
    
    if ([key isEqualToString:@"user.sex"]) {
        _sex = value;
    }
}

- (NSString *)description {
    return [NSString stringWithFormat:@"_birthday--%@ \n _email--%@ \n _niCheng--%@ \n _sex--%@" , _birthday , _email , _niCheng , _sex];
}

@end
