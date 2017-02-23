//
//  MessageViewController.h
//  AEFT冷风扇
//
//  Created by 杭州阿尔法特 on 16/3/16.
//  Copyright © 2016年 阿尔法特. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MessageViewController : UIViewController

@property (nonatomic , retain) NSString *phoneNumber;

@property (nonatomic , assign)  NSInteger success;

@property (nonatomic , strong) NSString *data;

@property (nonatomic , retain) NSString *message;

@property (nonatomic , retain) UITextField *pwdTectFiled;
@property (nonatomic , copy) NSString *userSn;
@end
