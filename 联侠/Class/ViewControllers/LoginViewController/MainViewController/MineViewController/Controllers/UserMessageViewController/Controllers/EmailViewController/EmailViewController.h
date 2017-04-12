//
//  EmailViewController.h
//  AEFT冷风扇
//
//  Created by 杭州阿尔法特 on 16/4/6.
//  Copyright © 2016年 阿尔法特. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SendEmailAddressToPreviousVCDelegate <NSObject>

- (void)sendEmailAddressToPreviousVC:(NSString *)emailAddress;

@end

@interface EmailViewController : UIViewController
@property (nonatomic , assign) id<SendEmailAddressToPreviousVCDelegate> delegate;
@property (nonatomic , strong) UserModel *userModel;
@end
