//
//  NiChengViewController.h
//  AEFT冷风扇
//
//  Created by 杭州阿尔法特 on 16/3/16.
//  Copyright © 2016年 阿尔法特. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol SendNickOrEmailToPreviousVCDelegate <NSObject>

- (void)sendNickOrEmailToPreviousVC:(NSArray *)nickOrEmailArr;

@end

@interface NiChengViewController : UIViewController

@property (nonatomic , assign) id<SendNickOrEmailToPreviousVCDelegate> delegate;

@property (nonatomic , strong) UserModel *userModel;

@end
