//
//  ServicesModel.h
//  AEFT冷风扇
//
//  Created by 杭州阿尔法特 on 16/4/11.
//  Copyright © 2016年 阿尔法特. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ServicesModel : NSObject

@property (nonatomic , copy) NSString *bindUrl;
@property (nonatomic , strong) NSString *imageUrl;
@property (nonatomic , copy) NSString *indexUrl;

@property (nonatomic , copy) NSString *typeSn;
@property (nonatomic , strong) NSString *devSn;
@property (nonatomic , strong) NSString *typeName;
@property (nonatomic , copy) NSString *brand;
@property (nonatomic , assign) NSInteger userDeviceID;
@property (nonatomic , copy) NSString *protocol;
@property (nonatomic , assign) NSInteger slTypeInt;

@property (nonatomic , copy) NSString *definedName;

/**
 *  测试使用将来需要删除
 */
@property (nonatomic , strong) NSString *devTypeSn;
@end
