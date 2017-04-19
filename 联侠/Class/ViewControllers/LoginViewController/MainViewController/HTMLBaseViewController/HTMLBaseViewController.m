//
//  HTMLBaseViewController.m
//  联侠
//
//  Created by 杭州阿尔法特 on 2016/12/1.
//  Copyright © 2016年 张海昌. All rights reserved.
//

#import "HTMLBaseViewController.h"
#import "AllServicesViewController.h"

@interface HTMLBaseViewController ()<HelpFunctionDelegate>

@end

@implementation HTMLBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor clearColor];
    
    
    [kStanderDefault setObject:@"YES" forKey:@"Login"];
    
    NSDictionary *parames = nil;
    if ([kStanderDefault objectForKey:@"GeTuiClientId"]) {
        parames = @{@"loginName" : [kStanderDefault objectForKey:@"phone"] , @"password" : [kStanderDefault objectForKey:@"password"] , @"ua.clientId" : [kStanderDefault objectForKey:@"GeTuiClientId"], @"ua.phoneType" : @(2)};
    } else {
        parames = @{@"loginName" : [kStanderDefault objectForKey:@"phone"] , @"password" : [kStanderDefault objectForKey:@"password"] , @"ua.phoneType" : @(2)};
    }
    
    [HelpFunction requestDataWithUrlString:kLogin andParames:parames andDelegate:self];
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
}


- (void)requestData:(HelpFunction *)request didFinishLoadingDtaArray:(NSMutableArray *)data {
    NSDictionary *dic = data[0];
//    NSLog(@"%@" , dic);
    if ([dic[@"state"] integerValue] == 0) {
        
        NSDictionary *user = dic[@"data"];
        
        [kStanderDefault setObject:user[@"sn"] forKey:@"userSn"];
        [kStanderDefault setObject:user[@"id"] forKey:@"userId"];
        
        _userModel = [[UserModel alloc]init];
        for (NSString *key in [user allKeys]) {
            [_userModel setValue:user[key] forKey:key];
        }
    }
}

- (void)requestData:(HelpFunction *)request didFailLoadData:(NSError *)error {
    NSLog(@"%@" , error);
}

- (void)setServiceModel:(ServicesModel *)serviceModel {
    _serviceModel = serviceModel;
    
    NSLog(@"%@" , _serviceModel);
    
    
}


- (NSMutableDictionary *)dic {
    if (!_dic) {
        _dic = [NSMutableDictionary dictionary];
    }
    return _dic;
}


@end
