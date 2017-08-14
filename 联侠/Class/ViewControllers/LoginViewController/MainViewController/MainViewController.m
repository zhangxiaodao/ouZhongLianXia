//
//  MainViewController.m
//  AEFT冷风扇
//
//  Created by 杭州阿尔法特 on 16/3/8.
//  Copyright © 2016年 阿尔法特. All rights reserved.
//

#import "MainViewController.h"
#import "MainFirstView.h"
#import "MineViewController.h"
#import "MineSerivesViewController.h"
#import "ExchangeCollectionViewController.h"
#import "RollLabel.h"
#import "CCLocationManager.h"
#import "LoginViewController.h"
#import "AllServicesViewController.h"
#import "FirstUserAlertView.h"

@interface MainViewController ()<UIScrollViewDelegate , HelpFunctionDelegate , CCLocationManagerZHCDelegate>{
    UIImageView *imageBG;
    UIView *banTouMingLableView;
    UIView *setVIew;
}
@property (nonatomic , strong) UIImage *werthImage;
@property (nonatomic , strong) NSMutableArray *zhuYeArray;
@property (nonatomic , strong) NSArray *arrImage;

@property (nonatomic , strong) UIImageView *firstView;
@property (nonatomic , strong) UIImageView *headImageView;

@property (nonatomic , copy) NSString *deviceName;

@property (nonatomic , strong) RollLabel* testLabel;
@end

@implementation MainViewController

//- (NSArray *)arrImage {
//    if (!_arrImage) {
//        _arrImage = [NSArray arrayWithObjects:[UIImage imageNamed:@"icon_qing"], [UIImage imageNamed:@"icon_leiZhenYu"], [UIImage imageNamed:@"icon_yangChen"], [UIImage imageNamed:@"icon_duoYun"], [UIImage imageNamed:@"icon_xue"], [UIImage imageNamed:@"icon_yu"], [UIImage imageNamed:@"icon_wu"], [UIImage imageNamed:@"icon_feng"],  nil];
//    }
//    return _arrImage;
//}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    NSDictionary *parames = nil;
    if ([kStanderDefault objectForKey:@"GeTuiClientId"]) {
        parames = @{@"loginName" : [kStanderDefault objectForKey:@"phone"] , @"password" : [kStanderDefault objectForKey:@"password"] , @"ua.clientId" : [kStanderDefault objectForKey:@"GeTuiClientId"], @"ua.phoneType" : @(2), @"ua.phoneBrand":@"iPhone" , @"ua.phoneModel":[NSString getDeviceName] , @"ua.phoneSystem":[NSString getDeviceSystemVersion]};
    } else {
        parames = @{@"loginName" : [kStanderDefault objectForKey:@"phone"] , @"password" : [kStanderDefault objectForKey:@"password"] , @"ua.phoneType" : @(2), @"ua.phoneBrand":@"iPhone" , @"ua.phoneModel":[NSString getDeviceName] , @"ua.phoneSystem":[NSString getDeviceSystemVersion]};
    }
    
    [HelpFunction requestDataWithUrlString:kLogin andParames:parames andDelegate:self];
    
    [self setMainUI];
    
    [self setAlertView];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getHeadImage:) name:@"headImage" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getNiCheng:) name:@"niCheng" object:nil];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = YES;
    self.navigationController.navigationBar.hidden = YES;
    if ([kStanderDefault objectForKey:@"zhuYe"]) {
        NSNumber *aa = [kStanderDefault objectForKey:@"zhuYe"];
        imageBG.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@" , [self.zhuYeArray objectAtIndex:[aa integerValue]]]];
    } else {
        imageBG.image=[UIImage imageNamed:@"主页背景图4"];
    }

    if (self.serviceModel && self.userModel) {
        [kSocketTCP sendDataToHost:[NSString stringWithFormat:@"HM%ld%@%@N#" , (long)self.userModel.sn , _serviceModel.devTypeSn , _serviceModel.devSn] andType:kAddService andIsNewOrOld:nil];
    }
}


#pragma mark - 获取代理的数据
- (void)requestData:(HelpFunction *)request didFinishLoadingDtaArray:(NSMutableArray *)data {
    NSDictionary *dic = data[0];
//        NSLog(@"%@" , dic);
    if ([dic[@"state"] integerValue] == 0) {
        
        NSDictionary *user = dic[@"data"];
        
        [kStanderDefault setObject:user[@"sn"] forKey:@"userSn"];
        [kStanderDefault setObject:user[@"id"] forKey:@"userId"];
        
        _userModel = [[UserModel alloc]init];
        for (NSString *key in [user allKeys]) {
            [_userModel setValue:user[key] forKey:key];
        }
        
        [kApplicate initLastMainViewController:self];
        [kApplicate initUserModel:_userModel];
        if (![self.userModel.headImageUrl isKindOfClass:[NSNull class]]) {
            [self.headImageView sd_setImageWithURL:[NSURL URLWithString:self.userModel.headImageUrl] placeholderImage:[UIImage new]];
            if (self.headImageView.image.size.width == 0) {
                self.headImageView.image = [UIImage imageNamed:@"iconfont-touxiang"];
            }
            
        } else {
            self.headImageView.image = [UIImage imageNamed:@"iconfont-touxiang"];
        }
    }
}

- (void)setServiceModel:(ServicesModel *)serviceModel {
    _serviceModel = serviceModel;
    
    if (_serviceModel) {
        
        [kApplicate initServiceModel:self.serviceModel];
        [self requestMainVCServiceData];
        [self requestMainVCServiceState];
    }
}

- (void)requestMainVCServiceState {
    NSDictionary *parames = @{@"devSn" : self.serviceModel.devSn , @"devTypeSn" : self.serviceModel.devTypeSn};

    if ([self.serviceModel.devTypeSn isEqualToString:@"4131"]) {
        
        [HelpFunction requestDataWithUrlString:kChaXunLengFengShanDangQianZhuangTai andParames:parames andDelegate:self];
 
    } else if ([self.serviceModel.devTypeSn isEqualToString:@"4231"]) {
        
        [HelpFunction requestDataWithUrlString:kChaXunKongJingDangQianZhuangTai andParames:parames andDelegate:self];
        
    } else if ([self.serviceModel.devTypeSn isEqualToString:@"4331"]) {
        
        [HelpFunction requestDataWithUrlString:kChaXunGanYiJiZhuangTai andParames:parames andDelegate:self];
    }
    
}

- (void)requestMainVCServiceData {
    NSDictionary *parames = @{@"devSn" : self.serviceModel.devSn , @"devTypeSn" : self.serviceModel.devTypeSn};
    
    if ([self.serviceModel.devTypeSn isEqualToString:@"4131"]) {

        [HelpFunction requestDataWithUrlString:kChaXunLengFengShanDangQianShuJu andParames:parames andDelegate:self];
    } else if ([self.serviceModel.devTypeSn isEqualToString:@"4231"]) {

        [HelpFunction requestDataWithUrlString:kChaXunKongJingDangQianShuJu andParames:parames andDelegate:self];
    } else if ([self.serviceModel.devTypeSn isEqualToString:@"4331"]) {
        [HelpFunction requestDataWithUrlString:kChaXunGanYiJiShuJu andParames:parames andDelegate:self];
    }
}


#pragma mark - 查询设备数据
- (void)requestServicesData:(HelpFunction *)request didOK:(NSDictionary *)dic {
//    NSLog(@"%@" , dic);
    if ([dic[@"data"] isKindOfClass:[NSDictionary class]]) {
        self.serviceDataModel = [[ServicesDataModel alloc]init];
        [self.serviceDataModel setValuesForKeysWithDictionary:dic[@"data"]];
        [self.tableView reloadData];
    }
}

- (void)requestData:(HelpFunction *)request didFailLoadData:(NSError *)error {
    NSLog(@"%@" , error);
}

- (void)setBottomBackGroundColor:(UIColor *)color andSelected:(BOOL)selected andState:(NSString *)state {
    self.bottomBtn.backgroundColor = color;
    self.bottomBtn.selected = selected;
    [kStanderDefault setObject:state forKey:@"offBtn"];
}

#pragma mark - 查询设备状态
- (void)requestData:(HelpFunction *)request didSuccess:(NSDictionary *)dddd {
//    NSLog(@"%@" , dddd);
    if ([dddd[@"data"] isKindOfClass:[NSDictionary class]]) {
        NSDictionary *dic = dddd[@"data"];
        
        self.stateModel = [[StateModel alloc]init];
        
        for (NSString *key in [dic allKeys]) {
            [self.stateModel setValue:dic[key] forKey:key];
        }
        
        if ([_serviceModel.devTypeSn isEqualToString:@"4231"]) {
            if (self.stateModel.fSwitch == 2  || self.stateModel.fSwitch == 0) {
                [self setBottomBackGroundColor:[UIColor grayColor] andSelected:0 andState:@"NO"];
                
            } else if (self.stateModel.fSwitch == 1){
             
                [self setBottomBackGroundColor:kKongJingYanSe andSelected:1 andState:@"YES"];
            }
            [self.bottomBtn addTarget:self action:@selector(kongQiJingHuaQiOpenAtcion:) forControlEvents:UIControlEventTouchUpInside];
        } else if ([_serviceModel.devTypeSn isEqualToString:@"4131"]) {
            if (self.stateModel.fSwitch == 2  || self.stateModel.fSwitch == 0) {
                [self setBottomBackGroundColor:[UIColor grayColor] andSelected:0 andState:@"NO"];
                [self.bottomBtn addTarget:self action:@selector(lengFengShanOpenAtcion:) forControlEvents:UIControlEventTouchUpInside];
            } else if (self.stateModel.fSwitch == 1){
                [self setBottomBackGroundColor:kMainColor andSelected:1 andState:@"YES"];
                [self.bottomBtn addTarget:self action:@selector(lengFengShanCloseAtcion:) forControlEvents:UIControlEventTouchUpInside];
            }
            
        } else if ([_serviceModel.devTypeSn isEqualToString:@"4331"]) {
            if (self.stateModel.fSwitch == 2  || self.stateModel.fSwitch == 0) {

                [self setBottomBackGroundColor:[UIColor grayColor] andSelected:0 andState:@"NO"];
            } else if (self.stateModel.fSwitch == 1){

                [self setBottomBackGroundColor:kKongJingYanSe andSelected:1 andState:@"YES"];
            }
            
            [self.bottomBtn addTarget:self action:@selector(ganYiJiOpenAtcion:) forControlEvents:UIControlEventTouchUpInside];
        }
        
        [self.tableView reloadData];
        
    } else {
        
        if ([_serviceModel.devTypeSn isEqualToString:@"4231"]) {

            [self.bottomBtn addTarget:self action:@selector(kongQiJingHuaQiOpenAtcion:) forControlEvents:UIControlEventTouchUpInside];
        } else if ([_serviceModel.devTypeSn isEqualToString:@"4131"]) {
            
            [self.bottomBtn addTarget:self action:@selector(lengFengShanCloseAtcion:) forControlEvents:UIControlEventTouchUpInside];
        } else if ([_serviceModel.devTypeSn isEqualToString:@"4331"]) {
            [self.bottomBtn addTarget:self action:@selector(ganYiJiOpenAtcion:) forControlEvents:UIControlEventTouchUpInside];
        }
        self.bottomBtn.backgroundColor = [UIColor grayColor];
        [kStanderDefault setObject:@"NO" forKey:@"offBtn"];
        self.bottomBtn.selected = 0;
    }
    
}


#pragma mark - 设置滚动Lable 
- (void)setScrollLable:(NSMutableDictionary *)dic {
    self.testLabel = [[RollLabel alloc] initWithFrame:CGRectMake(kScreenW / 9 , kScreenH / 22.72 - kScreenH / 58 , kScreenW - kScreenW * 2 / 9 , kScreenH / 29) text:dic[@"chuanYi"] font:[UIFont systemFontOfSize:15] textColor:[UIColor whiteColor]];
    [self.testLabel startRoll];
    
    [imageBG addSubview:self.testLabel];
    self.testLabel.tag = 2;
    self.testLabel.backgroundColor = [UIColor clearColor];
    self.testLabel.layer.cornerRadius = kScreenH / 58;
    self.testLabel.layer.masksToBounds = YES;
}

#pragma mark - 天气数据
- (void)getWeatherDic:(NSMutableDictionary *)dic {
    banTouMingLableView = [[UIView alloc]init];
    banTouMingLableView.backgroundColor = [UIColor blackColor];
    banTouMingLableView.layer.opacity = 0.2;
    [imageBG addSubview:banTouMingLableView];
    banTouMingLableView.tag = 1;
    banTouMingLableView.frame = CGRectMake(kScreenW / 9, kScreenH / 22.72 - kScreenH / 58 , kScreenW - kScreenW * 2 / 9, kScreenH / 29);
    
    banTouMingLableView.layer.cornerRadius = kScreenH / 59;
    
    [self setScrollLable:dic];
    self.testLabel.hidden = YES;
    banTouMingLableView.hidden = YES;
    
    
    _touMingImageVIew = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"主页透明.jpg"]];
    _touMingImageVIew.frame=CGRectMake(0, -BackGroupHeight, self.view.frame.size.width, BackGroupHeight);
    
    NSString *imagetr = self.arrImage[[dic[@"weather_icon"] integerValue]];
    self.werthImage = [UIImage imageNamed:imagetr];

    [MainFirstView creatViewWeatherDic:dic andSuperView:_touMingImageVIew andWearthImage:self.werthImage];
    
    _touMingImageVIew.contentMode = UIViewContentModeScaleAspectFill;
    [self.tableView addSubview:_touMingImageVIew];
    _touMingImageVIew.tag = 3;
    
    //添加轻扫手势
    UISwipeGestureRecognizer *swipeGesture = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeGesture:)];
    //设置轻扫的方向
    swipeGesture.direction = UISwipeGestureRecognizerDirectionLeft; //默认向右
    [self.view addGestureRecognizer:swipeGesture];
    

    //添加轻扫手势
    UISwipeGestureRecognizer *swipeGesture1 = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeGesture11:)];
    //设置轻扫的方向
    swipeGesture1.direction = UISwipeGestureRecognizerDirectionRight; //默认向右
    [self.view addGestureRecognizer:swipeGesture1];
}

- (void)setMainUI {
    
    
    imageBG=[[UIImageView alloc]init];
    
    [self.view addSubview:imageBG];
    imageBG.frame=CGRectMake(0, 0, kScreenW, kScreenH);
    imageBG.contentMode = UIViewContentModeTop;
    imageBG.userInteractionEnabled = YES;
    
    setVIew = [UIView creatViewWithBackView:[UIImage imageNamed:[NSString stringWithFormat:@"iconfont-ordinaryset"]] andSuperView:imageBG];
    setVIew.userInteractionEnabled = YES;
    [setVIew mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kScreenH / 13, kScreenH / 13));
        make.right.mas_equalTo(-5);
        make.centerY.mas_equalTo(self.view.mas_top).offset(kScreenH / 22.72);
    }];
    
    UITapGestureRecognizer *gengHuanTuPianTap =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(gengHuanTuPianTapAction:)];
    
    //添加到指定视图
    [setVIew addGestureRecognizer:gengHuanTuPianTap];
    
    
    
    self.headImageView = [[UIImageView alloc]init];
//    self.headImageView.image = [UIImage imageNamed:@"iconfont-touxiang"];
    if (self.headImage == nil) {

        if (![self.userModel.headImageUrl isKindOfClass:[NSNull class]]) {
            [self.headImageView sd_setImageWithURL:[NSURL URLWithString:self.userModel.headImageUrl] placeholderImage:[UIImage new]];
        } else {
            self.headImageView.image = [UIImage imageNamed:@"iconfont-touxiang"];
        }
    } else if (self.headImage != nil) {
        self.headImageView.image = self.headImage;
    } else {
        
        if (![self.userModel.headImageUrl isKindOfClass:[NSNull class]]) {
            [self.headImageView sd_setImageWithURL:[NSURL URLWithString:self.userModel.headImageUrl] placeholderImage:[UIImage new]];
        }
        
        
    }
    
    
    [imageBG addSubview:self.headImageView];
    [self.headImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kScreenW / 6, kScreenW / 6));
        make.top.mas_equalTo(kScreenH / 15.15909);
        make.left.mas_equalTo(kScreenW / 20);
    }];
    self.headImageView.layer.cornerRadius = kScreenW / 12;
    self.headImageView.layer.masksToBounds = YES;
    self.headImageView.userInteractionEnabled = YES;
    
    
//    UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapImageAtcion)];
//    [self.headImageView addGestureRecognizer:tap1];
    
    
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenW, kScreenH - kScreenH / 12.3518518) style:UITableViewStyleGrouped];
    self.tableView.tag = 234;
    [self.view addSubview:self.tableView];
    self.tableView.tableHeaderView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 0, 1)];
    self.tableView.contentInset=UIEdgeInsetsMake(BackGroupHeight, 0, 0, 0);
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundView = imageBG;
    
    
    NSArray *subviewsArray = [NSArray arrayWithArray:_touMingImageVIew.subviews];
    for (int i = 0; i < subviewsArray.count; i++) {
        [subviewsArray[i] removeFromSuperview];
    }
    [banTouMingLableView removeFromSuperview];
    [self.testLabel removeFromSuperview];
    [_touMingImageVIew removeFromSuperview];
    [self getWeatherDic:self.wearthDic];
    
    self.bottomView = [[UIView alloc]init];
    [self.view addSubview:self.bottomView];
    [self.bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.bottom.mas_equalTo(self.view.mas_bottom);
        make.size.mas_equalTo(CGSizeMake(kScreenW, kScreenH / 12.3518518));
        make.right.mas_equalTo(self.view.mas_right);
    }];
    self.bottomView.backgroundColor = [UIColor whiteColor];
    
    self.bottomBtn = [UIButton initWithTitle:@"" andColor:[UIColor grayColor] andSuperView:self.view];
    self.bottomBtn.layer.cornerRadius = kScreenW / 18;
    //注册按钮的约束
    [self.bottomBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kScreenW - kScreenW * 2 / 15, kScreenW / 9));
        make.left.mas_equalTo(kScreenW / 15);
        make.bottom.mas_equalTo(self.view.mas_bottom).offset(-5);
    }];
    
    UILabel *lable = [UILabel creatLableWithTitle:@"开启" andSuperView:self.bottomBtn andFont:k17 andTextAligment:NSTextAlignmentLeft];
    lable.textColor = [UIColor whiteColor];
    lable.layer.borderWidth = 0;
    [lable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(self.bottomBtn.height / 2, self.bottomBtn.height / 2));
        make.left.mas_equalTo(self.bottomBtn.mas_centerX).offset(3);
        make.centerY.mas_equalTo(self.bottomBtn.mas_centerY);
    }];
    
    UIImageView *offImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"iconfont-kaiguan222"]];
    offImageView.image = [offImageView.image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    offImageView.tintColor = [UIColor whiteColor];
    [self.bottomBtn addSubview:offImageView];
    [offImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(self.bottomBtn.height / 4, self.bottomBtn.height / 4));
        make.right.mas_equalTo(self.bottomBtn.mas_centerX).offset(-3);
        make.centerY.mas_equalTo(self.bottomBtn.mas_centerY);
    }];
            
}

- (void)setAlertView {
    [[FirstUserAlertView alloc]creatAlertViewwithImage:@"主页提示" deleteFirstObj:@"move"];
}

#pragma mark - 长按手势  更换图片
- (void)gengHuanTuPianTapAction:(UITapGestureRecognizer *)longPress {
    
    
    
    [UIAlertController creatSheetControllerWithFirstHandle:^{
        
        [UIAlertController creatAlertControllerWithFirstTextfiledPlaceholder:nil andFirstTextfiledText:[NSString stringWithFormat:@"%@%@" , self.serviceModel.brand , self.serviceModel.typeName] andFirstAtcion:nil andWhetherEdite:NO WithSecondTextfiledPlaceholder:@"请输入修改名称" andSecondTextfiledText:nil andSecondAtcion:@selector(secondTextFieldsValueDidChange:) andAlertTitle:@"修改设备名称" andAlertMessage:@"你可以再次修改设备名称，便于区分。" andTextfiledAtcionTarget:self andSureHandle:^{
            if (self.deviceName) {
                NSDictionary *parames = @{@"ud.devTypeSn" :  self.serviceModel.devTypeSn, @"ud.devSn" :  self.serviceModel.devSn, @"ud.definedName" : self.deviceName};
                NSLog(@"修改设备名称---%@" , parames);
                [HelpFunction requestDataWithUrlString:kChangeServiceName andParames:parames andDelegate:self];
            }
        } andSuperViewController:self];
        
    } andFirstTitle:@"修改名称" andSecondHandle:^{
        
        [UIAlertController creatCancleAndRightAlertControllerWithHandle:^{
            NSDictionary *parames = @{@"id" : @(self.serviceModel.userDeviceID)};
            [HelpFunction requestDataWithUrlString:kDeleteServiceURL andParames:parames andDelegate:self];
        } andSuperViewController:self Title:@"是否移除设备"];
        
        
    } andSecondTitle:@"移除设备" andThirtHandle:^{
        ExchangeCollectionViewController *exchangeVC = [[UIStoryboard storyboardWithName:@"ExchangeCollectionViewController" bundle:nil]instantiateViewControllerWithIdentifier:@"ExchangeCollectionViewController"];
        
        exchangeVC.fromMainVC = [NSString stringWithFormat:@"1"];
        
        [self.navigationController pushViewController:exchangeVC animated:YES];
    } andThirtTitle:@"更换背景" andForthHandle:nil andForthTitle:nil andSuperViewController:self];
}

- (void)secondTextFieldsValueDidChange:(UITextField *)textfiled {
    self.deviceName = textfiled.text;
}

#pragma mark - 修改设备名称
- (void)requestData:(HelpFunction *)request changeServiceName:(NSDictionary *)dic {
    //    NSLog(@"%@" , dic);
    
    if ([dic[@"state"] isKindOfClass:[NSNull class]]) {
        return ;
    }
    
    NSInteger index = [dic[@"state"] integerValue];
    if (index == 0) {
        if (self.deviceName) {
            self.navigationItem.title = [NSString stringWithFormat:@"%@%@" , self.deviceName , self.serviceModel.typeName];
        } else {
            self.navigationItem.title = [NSString stringWithFormat:@"%@%@" , self.serviceModel.brand , self.serviceModel.typeName];
        }
    }
    
}


#pragma mark - 移除设备
- (void)requestRemoveService:(HelpFunction *)request didDone:(NSDictionary *)dic{
    //    NSLog(@"%@" , dic);
    
    if ([dic[@"state"] integerValue] == 0) {
        
        
        [UIAlertController creatRightAlertControllerWithHandle:^{
            [self.navigationController popViewControllerAnimated:YES];
        } andSuperViewController:self Title:@"设备删除成功"];
    }
}


#pragma mark - 向左滑动推出界面
- (void)swipeGesture11:(UISwipeGestureRecognizer *)swipe {
    
    if (_sendVCDelegate && [_sendVCDelegate respondsToSelector:@selector(sendViewControllerToParentVC:)]) {
        [_sendVCDelegate sendViewControllerToParentVC:self];
    }
    
    if (self.serviceModel) {
        if (_sendServiceModelToParentVCDelegate && [_sendServiceModelToParentVCDelegate respondsToSelector:@selector(sendServiceModelToParentVC:)]) {
            [_sendServiceModelToParentVCDelegate sendServiceModelToParentVC:self.serviceModel];
        }
    }
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

#pragma mark - 修改昵称
- (void)getNiCheng:(NSNotification *)post {
    self.userModel.nickname = post.userInfo[@"niCheng"];
}


#pragma mark - 获取头像
- (void)getHeadImage:(NSNotification *)post {
    self.headImageView.image = post.userInfo[@"headImage"];
}

- (void)setWearthDic:(NSMutableDictionary *)wearthDic {
    _wearthDic = wearthDic;
//    NSLog(@"%@" , _wearthDic);
    
}

#pragma mark - 懒加载
- (NSMutableArray *)serviceArray {
    if (!_serviceArray) {
        _serviceArray = [NSMutableArray array];
    }
    return _serviceArray;
}

- (NSMutableArray *)zhuYeArray {
    if (!_zhuYeArray) {
        self.zhuYeArray = [NSMutableArray arrayWithObjects:@"主页背景图1.jpg", @"主页背景图2.jpg" , @"主页背景图5.jpg" , @"主页背景图6.jpg" ,@"主页背景图4", @"主页背景图7.jpg" ,nil];
        
    }
    return _zhuYeArray;
}

#pragma mark - tableVIew滑动的代理
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat yOffset  = scrollView.contentOffset.y;
    
    if (yOffset < -BackGroupHeight) {
        
        CGRect rect = self.touMingImageVIew.frame;
        rect.origin.y = yOffset;
        rect.size.height =  -yOffset ;
        self.touMingImageVIew.frame = rect;
    }
    
    if (yOffset > scrollView.contentSize.height - self.tableView.height){
        
        // 取消上拉回弹
        [scrollView setContentOffset:CGPointMake(scrollView.contentOffset.x, scrollView.contentSize.height - self.tableView.height)];
    }
}

- (NSArray *)arrImage {
    if (!_arrImage) {
        _arrImage = [NSArray arrayWithObjects:@"qing", @"dayu", @"duoyun", @"feng", @"leiyu", @"mai", @"daxue",@"qingjianduoyun",@"wu",@"xiaoxue",@"xiaoyu",@"yin",@"yujiaxue",@"zhenyu",@"zhongxue",@"zhongyu", nil];
        
    }
    return _arrImage;
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:nil object:nil];
}

@end
