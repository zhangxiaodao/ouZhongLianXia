//
//  GanYiJiDingShiCollectionViewController.h
//  联侠
//
//  Created by 杭州阿尔法特 on 16/6/30.
//  Copyright © 2016年 张海昌. All rights reserved.
//

#import <UIKit/UIKit.h>

@class GanYiJiDingShiCollectionViewController;
@protocol GanYiJiDingShiCollectionViewControllerDelegate <NSObject>

- (void)getGanYiJiDelegate:(GanYiJiDingShiCollectionViewController *)ganYiJiVC andDelegate:(NSArray *)dataArray;

@end

@interface GanYiJiDingShiCollectionViewController : UICollectionViewController

@property (nonatomic , copy) NSString *titleText;
@property (nonatomic , copy) NSString *fromWhich;
@property (nonatomic , strong) ServicesModel *serviceModel;
@property (nonatomic , assign) id<GanYiJiDingShiCollectionViewControllerDelegate>   delegate;
@end
