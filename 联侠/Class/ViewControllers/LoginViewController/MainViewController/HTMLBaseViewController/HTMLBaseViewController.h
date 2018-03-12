//
//  HTMLBaseViewController.h
//  联侠
//
//  Created by 杭州阿尔法特 on 2016/12/1.
//  Copyright © 2016年 张海昌. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <JavaScriptCore/JavaScriptCore.h>

@protocol SendServiceModelToParentVCDelegate <NSObject>
@optional
- (void)sendServiceModelToParentVC:(ServicesModel *)serviceModel;
@end

@interface HTMLBaseViewController : UIViewController

@property (nonatomic , strong) ServicesModel *serviceModel;
@property (nonatomic , strong) UserModel *userModel;
@property (nonatomic , strong) NSMutableDictionary *dic;

@property (nonatomic , strong) NSIndexPath *indexPath;

@property (nonatomic , strong) UIWebView *webView;
@property (nonatomic , strong) UIActivityIndicatorView *searchView;

@property (nonatomic , strong) JSContext *context;

@property (nonatomic , assign) id<SendServiceModelToParentVCDelegate> sendServiceModelToParentVCDelegate;

- (void)passValueWithBlock;
- (void)getMachineDeviceAtcion:(NSNotification *)post;
@end
