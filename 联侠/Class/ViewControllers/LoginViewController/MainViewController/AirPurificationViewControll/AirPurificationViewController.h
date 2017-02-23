//
//  AirPurificationViewController.h
//  联侠
//
//  Created by 杭州阿尔法特 on 16/5/27.
//  Copyright © 2016年 张海昌. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MainViewController.h"

@class AirPurificationViewController;
@protocol AirPurificationViewControllerDelegate <NSObject>

- (void)airPurificationViewController:(AirPurificationViewController *)airVC andButtonState:(NSNumber *)selected;

@end

@interface AirPurificationViewController : MainViewController

@property (nonatomic , assign) id<AirPurificationViewControllerDelegate> delegate;

@end
