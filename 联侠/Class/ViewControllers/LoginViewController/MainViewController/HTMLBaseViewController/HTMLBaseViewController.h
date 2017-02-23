//
//  HTMLBaseViewController.h
//  联侠
//
//  Created by 杭州阿尔法特 on 2016/12/1.
//  Copyright © 2016年 张海昌. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HTMLBaseViewController : UIViewController

@property (nonatomic , strong) ServicesModel *serviceModel;
@property (nonatomic , strong) StateModel *stateModel;
@property (nonatomic , strong) UserModel *userModel;
@property (nonatomic , strong) NSMutableDictionary *dic;

@property (nonatomic , strong) NSIndexPath *indexPath;

- (void)initStateModel;

@end
