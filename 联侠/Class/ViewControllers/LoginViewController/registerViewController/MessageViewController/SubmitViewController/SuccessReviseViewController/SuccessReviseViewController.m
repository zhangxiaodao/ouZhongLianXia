//
//  SuccessReviseViewController.m
//  AEFT冷风扇
//
//  Created by 杭州阿尔法特 on 16/3/9.
//  Copyright © 2016年 阿尔法特. All rights reserved.
//

#import "SuccessReviseViewController.h"
#import "AddSViewController.h"

#import "MineSerivesViewController.h"
@interface SuccessReviseViewController ()<HelpFunctionDelegate>
@property (nonatomic , strong) UIView *navView;
@end

@implementation SuccessReviseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navView = [UIView creatNavView:self.view WithTarget:self action:@selector(backTap:) andTitle:@"注册"];
    UIView *backView = [[UIView alloc]init];
    backView = [_navView.subviews objectAtIndex:0];
    
    UIImageView *iiii = [backView.subviews objectAtIndex:1];
    iiii.image = [UIImage new];
    [self setUI];
}
#pragma mark - 返回主界面
- (void)backTap:(UITapGestureRecognizer *)tap {
    
}

#pragma mark - 设置UI
- (void)setUI{
    UILabel *lable = [UILabel creatLableWithTitle:@"恭喜您,注册成功!" andSuperView:self.view andFont:k15 andTextAligment:NSTextAlignmentLeft];
    lable.layer.borderWidth = 0;
    [lable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(kScreenW / 15);
        make.size.mas_equalTo(CGSizeMake(kScreenW * 2 / 3, kScreenW / 10));
        make.top.mas_equalTo(self.view.mas_top).offset(kScreenH / 7.510204);
    }];
    
    UIButton *submitBtn = [UIButton initWithTitle:@"马上登陆" andColor:[UIColor redColor] andSuperView:self.view];
    [submitBtn addTarget:self action:@selector(loginBtnAtcion) forControlEvents:UIControlEventTouchUpInside];
    submitBtn.layer.cornerRadius = kScreenW / 18;
    
    submitBtn.backgroundColor = kMainColor;
    [submitBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kStandardW, kScreenW / 9));
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.top.mas_equalTo(self.view.mas_top).offset(kScreenH / 2.38187702);
    }];

}

#pragma mark - 登陆按钮点击事件
- (void)loginBtnAtcion{
    
    
    NSDictionary *parameters = @{@"loginName":self.phoneNumber , @"password" : self.pwd , @"ua.clientId" : [kStanderDefault objectForKey:@"GeTuiClientId"], @"ua.phoneType" : @(2)};
    [kStanderDefault setObject:self.pwd forKey:@"password"];
    [kStanderDefault setObject:self.phoneNumber forKey:@"phone"];
    [HelpFunction requestDataWithUrlString:kLogin andParames:parameters andDelegate:self];
    
    
}

#pragma mark - 代理返回的数据
- (void)requestData:(HelpFunction *)request didFinishLoadingDtaArray:(NSMutableArray *)data {
    NSDictionary *dic = data[0];
//    NSLog(@"%@" , dic);
    if ([dic[@"state"] integerValue] == 0) {
        
        NSDictionary *user = dic[@"data"];
        
        [kStanderDefault setObject:user[@"sn"] forKey:@"userSn"];
        [kStanderDefault setObject:user[@"id"] forKey:@"userId"];
        
        UserModel *userModel = [[UserModel alloc]init];
        for (NSString *key in [user allKeys]) {
            [userModel setValue:user[key] forKey:key];
        }
        
        kSocketTCP.userSn = [NSString stringWithFormat:@"%ld" , userModel.sn];
        [kSocketTCP socketConnectHost];
        
        AddSViewController *addServiceVC = [[AddSViewController alloc]init];
        [self.navigationController pushViewController:addServiceVC animated:YES];
        
    }
}


@end
