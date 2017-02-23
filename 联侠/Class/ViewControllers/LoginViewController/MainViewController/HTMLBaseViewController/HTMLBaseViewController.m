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
    NSDictionary *parames = @{@"loginName" : [kStanderDefault objectForKey:@"phone"] , @"password" : [kStanderDefault objectForKey:@"password"] , @"ua.clientId" : [kStanderDefault objectForKey:@"GeTuiClientId"], @"ua.phoneType" : @(2)};
    [HelpFunction requestDataWithUrlString:kLogin andParames:parames andDelegate:self];
    
    [self setUI];
}


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    if (self.serviceModel.devSn.length > 0 && self.serviceModel.devTypeSn.length != 0 && self.userModel.sn != 0) {
        
        [kSocketTCP sendDataToHost:[NSString stringWithFormat:@"HM%ld%@%@N#" , self.userModel.sn , self.serviceModel.devTypeSn , self.serviceModel.devSn] andType:kAddService andIsNewOrOld:nil];
    }
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
        
        kSocketTCP.userSn = [NSString stringWithFormat:@"%ld" , _userModel.sn];
        [kSocketTCP socketConnectHost];
        
        [HelpFunction requestDataWithUrlString:kQueryTheUserdevice andParames:@{@"userSn" : @(_userModel.sn)} andDelegate:self];
    }
}


- (void)requestData:(HelpFunction *)requset queryUserdevice:(NSDictionary *)dddd {
//    NSLog(@"%@" , dddd);
    NSInteger state = [dddd[@"state"] integerValue];
    if (state == 0) {
        NSMutableArray *dataArray = dddd[@"data"];
        
        if (dataArray.count > 0) {
            
            [kStanderDefault setObject:@"YES" forKey:@"isHaveService"];
            
            kSocketTCP.serviceModel = self.serviceModel;
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [kSocketTCP sendDataToHost:[NSString stringWithFormat:@"HM%ld%@%@N#" , self.userModel.sn , _serviceModel.devTypeSn , _serviceModel.devSn] andType:kAddService andIsNewOrOld:nil];
            });
            
        
            [kStanderDefault setObject:@(self.userModel.sn) forKey:@"userSn"];
            [kStanderDefault setObject:@(self.userModel.idd) forKey:@"userId"];
            
            NSDictionary *parames = @{@"devSn" : _serviceModel.devSn , @"devTypeSn" : _serviceModel.devTypeSn};
            NSLog(@"%@" , parames);
            if ([_serviceModel.devTypeSn isEqualToString:@"4332"]) {
                
                [HelpFunction requestDataWithUrlString:kChaXunGanYiJiZhuangTai andParames:parames andDelegate:self];
            }
        } else {
            AllServicesViewController *allServicesVC = [[AllServicesViewController alloc]init];
            allServicesVC.isFromMainVC = @"YES";
            [self.navigationController pushViewController:allServicesVC animated:YES];
        }
    } else {
        AllServicesViewController *addServiceVC = [[AllServicesViewController alloc]init];
        [self.navigationController pushViewController:addServiceVC animated:YES];
    }
}

#pragma mark - 获取设备的状态
- (void)requestData:(HelpFunction *)request didSuccess:(NSDictionary *)dddd{
    
//    NSLog(@"%@" , dddd);
    
    if ([dddd[@"data"] isKindOfClass:[NSDictionary class]]) {
        NSDictionary *dataDic = dddd[@"data"];
        
        self.stateModel = [[StateModel alloc]init];
        
        for (NSString *key in [dataDic allKeys]) {
            [self.stateModel setValue:dataDic[key] forKey:key];
        }
        [self initStateModel];
    }
    
}


#pragma mark - 布局
- (void)setUI {
    
    
    
    
}

- (NSMutableDictionary *)dic {
    if (!_dic) {
        _dic = [NSMutableDictionary dictionary];
    }
    return _dic;
}

- (void)setServiceModel:(ServicesModel *)serviceModel {
    _serviceModel = serviceModel;
    
    NSLog(@"%@" , _serviceModel);
}

@end
