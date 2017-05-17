//
//  AddServiceModel.h
//  联侠
//
//  Created by 杭州阿尔法特 on 2016/11/8.
//  Copyright © 2016年 张海昌. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AddServiceModel : NSObject
@property (nonatomic , strong) NSString *typeSn;
@property (nonatomic , copy) NSString *typeName;
@property (nonatomic , copy) NSString *protocol;
@property (nonatomic , copy) NSString *bindUrl;
@property (nonatomic , copy) NSString *brand;
@property (nonatomic , copy) NSString *imageUrl;
@property (nonatomic , assign) NSInteger slType;
@end
