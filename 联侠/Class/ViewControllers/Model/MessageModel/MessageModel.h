//
//  MessageModel.h
//  AEFT冷风扇
//
//  Created by 杭州阿尔法特 on 16/4/5.
//  Copyright © 2016年 阿尔法特. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MessageModel : NSObject

@property (nonatomic , strong) NSString *title;
@property (nonatomic , strong) NSString *content;
@property (nonatomic , strong) NSString *sendTime;

@end
