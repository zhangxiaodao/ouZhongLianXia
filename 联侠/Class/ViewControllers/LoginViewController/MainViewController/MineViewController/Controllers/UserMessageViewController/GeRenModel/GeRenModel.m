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


- (NSString *)description {
    return [NSString stringWithFormat:@"_birthday--%@ \n _email--%@ \n nickName--%@ \n _sex--%ld , _address--%@" , _birthday , _email , _nickName , _sex , _address];
}

@end
