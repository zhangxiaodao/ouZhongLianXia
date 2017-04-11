//
//  SystemMessageModel.m
//  联侠
//
//  Created by 杭州阿尔法特 on 2017/2/5.
//  Copyright © 2017年 张海昌. All rights reserved.
//

#import "SystemMessageModel.h"

@implementation SystemMessageModel

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    if ([key isEqualToString:@"id"]) {
        _idd = value;
    }
}

- (NSString *)description {
    return [NSString stringWithFormat:@"_title---%@ \n, _url---%@ , content--%@, readCount--%ld" , _title , _url , _content , (long)_readCount];
}

@end
