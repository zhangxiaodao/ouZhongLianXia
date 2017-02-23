//
//  Singleton.h
//  socket_tutorial
//
//  Created by xiaoliangwang on 14-7-4.
//  Copyright (c) 2014年 芳仔小脚印. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ServicesModel.h"
#import "GCDAsyncSocket.h"

#define DEFINE_SHARED_INSTANCE_USING_BLOCK(block) \
static dispatch_once_t onceToken = 0; \
__strong static id sharedInstance = nil; \
dispatch_once(&onceToken, ^{ \
sharedInstance = block(); \
}); \
return sharedInstance; \

@interface Singleton : NSObject

@property (nonatomic, strong) GCDAsyncSocket    *socket;       // socket
@property (nonatomic, copy  ) NSString       *socketHost;   // socket的Host
@property (nonatomic, assign) UInt16         socketPort;    // socket的prot

@property (nonatomic, retain) NSTimer        *connectTimer; // 计时器

@property (nonatomic , strong) ServicesModel *serviceModel;

@property (nonatomic , copy) NSString *userSn;


+ (Singleton *)sharedInstance;

-(void)socketConnectHost;// socket连接

-(void)cutOffSocket;// 断开socket连接

/**
 *  向服务器发送数据（通过TCP）
 *
 *  @param string 发送的内容
 *  @param type   发送的类型 
 */
- (void)sendDataToHost:(NSString *)string andType:(NSString *)type andIsNewOrOld:(NSString *)isNewOrOld;

- (void)enableBackgroundingOnSocket;
// 心跳连接
-(void)longConnectToSocket;

- (void)connectHost;

@end
