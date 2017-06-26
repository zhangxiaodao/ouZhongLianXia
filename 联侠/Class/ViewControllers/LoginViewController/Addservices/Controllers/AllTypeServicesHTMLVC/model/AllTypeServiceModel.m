//
//  AllTypeServiceModel.m
//  联侠
//
//  Created by 杭州阿尔法特 on 2016/12/2.
//  Copyright © 2016年 张海昌. All rights reserved.
//

#import "AllTypeServiceModel.h"

@implementation AllTypeServiceModel

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    
}

- (NSString *)description {
    return [NSString stringWithFormat:@"\n imageUrl--%@\n , typeName--%@\n , typeSn--%ld" , _imageUrl , _typeName , _typeSn];
}

@end

