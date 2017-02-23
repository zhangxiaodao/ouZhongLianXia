//
//  SystemMessageModel.h
//  联侠
//
//  Created by 杭州阿尔法特 on 2017/2/5.
//  Copyright © 2017年 张海昌. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SystemMessageModel : NSObject

@property (nonatomic , copy) NSString *title;
@property (nonatomic , copy) NSString *url;
@property (nonatomic , copy) NSString *addTime;
@property (nonatomic , copy) NSString *addUser;
@property (nonatomic , copy) NSString *content;
@property (nonatomic , assign) NSInteger readCount;
@property (nonatomic , copy) NSString *idd;
@end
