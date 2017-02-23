//
//  XinFengTimeViewController.h
//  联侠
//
//  Created by 杭州阿尔法特 on 2017/2/21.
//  Copyright © 2017年 张海昌. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol XinFengTimeVCSendTimeToParentVCDelegate <NSObject>

- (void)xinFengTimeVCSendTimeToParentVCDelegate:(NSArray *)array;

@end

@interface XinFengTimeViewController : UIViewController

@property (nonatomic , strong) ServicesModel *serviceModel;
@property (nonatomic , assign) id<XinFengTimeVCSendTimeToParentVCDelegate> delegate;
@end
