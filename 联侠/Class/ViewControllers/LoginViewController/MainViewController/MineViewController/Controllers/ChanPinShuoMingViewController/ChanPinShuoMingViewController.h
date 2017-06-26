//
//  ChanPinShuoMingViewController.h
//  AEFT冷风扇
//
//  Created by 杭州阿尔法特 on 16/3/16.
//  Copyright © 2016年 阿尔法特. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ChanPinShuoMingViewController : UIViewController
@property (nonatomic , strong) ServicesModel *serviceModel;
@property (nonatomic , copy) NSString *typeSn;
@property (nonatomic , assign) NSInteger isFromMainVC;
@end
