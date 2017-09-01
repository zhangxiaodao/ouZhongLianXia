//
//  ServicesModel.m
//  AEFT冷风扇
//
//  Created by 杭州阿尔法特 on 16/4/11.
//  Copyright © 2016年 阿尔法特. All rights reserved.
//

#import "ServicesModel.h"

@implementation ServicesModel
- (void)setValue:(id)value forUndefinedKey:(NSString *)key {

}

//- (void)setValue:(id)value forKey:(NSString *)key {
//    if ([key isEqualToString:@"slType"]) {
//        if (value) {
//            _slType = (NSInteger)value;
//        } else {
//            _slType = 0;
//        }
//    }
//}

- (NSString *)description {
   
    return [NSString stringWithFormat:@"devTypeSn--%@ , typeSn--%@ , devSn--%@ , typeName--%@ , brand--%@ , bindUrl--%@ , slTypeInt--%ld , indexUrl--%@ , definedName--%@ , devTypeNumber--%@" , _devTypeSn , _typeSn , _devSn , _typeName , _brand , _bindUrl , (long)_slTypeInt , _indexUrl , _definedName , _devTypeNumber];
}

@end
