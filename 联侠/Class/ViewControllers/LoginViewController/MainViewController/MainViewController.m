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

@interface MainViewController ()<UIScrollViewDelegate , HelpFunctionDelegate>{
    UIImageView *imageBG;
    UIView *banTouMingLableView;
    UIView *setVIew;
}
@property (nonatomic , strong) UIImage *werthImage;
@property (nonatomic , strong) NSMutableArray *zhuYeArray;
@property (nonatomic , strong) NSArray *arrImage;
@property (nonatomic , strong) NSMutableDictionary *wearthDic;

@property (nonatomic , strong) UIImageView *firstView;
@property (nonatomic , strong) UIImageView *headImageView;

@property (nonatomic , strong) RollLabel* testLabel;
@end

@implementation MainViewController

- (NSArray *)arrImage {
    if (!_arrImage) {
        _arrImage = [NSArray arrayWithObjects:[UIImage imageNamed:@"qing"], [UIImage imageNamed:@"leiZhenYu"], [UIImage imageNamed:@"yangChen"], [UIImage imageNamed:@"duoYun"], [UIImage imageNamed:@"xue"], [UIImage imageNamed:@"yu"], [UIImage imageNamed:@"wu"], [UIImage imageNamed:@"feng"],  nil];
    }
    return _arrImage;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [kStanderDefault setObject:@"YES" forKey:@"Login"];
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.navigationController.navigationBarHidden = YES;
    
    
    NSDictionary *parames = @{@"loginName" : [kStanderDefault objectForKey:@"phone"] , @"password" : [kStanderDefault objectForKey:@"password"] , @"ua.clientId" : [kStanderDefault objectForKey:@"GeTuiClientId"], @"ua.phoneType" : @(2)};
    NSLog(@"%@" , parames);
    [HelpFunction requestDataWithUrlString:kLogin andParames:parames andDelegate:self];
            
    
    [self setMainUI];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getHeadImage:) name:@"headImage" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getNiCheng:) name:@"niCheng" object:nil];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    NSInteger nowTimeInterval = [NSString getNowTimeInterval];
    if ([kStanderDefault objectForKey:@"requestWeatherTime"]) {
        NSInteger weatherTime = [[kStanderDefault objectForKey:@"requestWeatherTime"] integerValue];
        NSLog(@"%ld , %ld , %ld" , nowTimeInterval , weatherTime , weatherTime + 2 * 3600);
        if (nowTimeInterval > weatherTime + 2 * 3600) {
            [kStanderDefault setObject:@(nowTimeInterval) forKey:@"requestWeatherTime"];
            [self startWearthData];
        }
    } else {
        [kStanderDefault setObject:@(nowTimeInterval) forKey:@"requestWeatherTime"];
        [self startWearthData];
    }
    
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getWeartherImage:) name:@"weartherImage" object:nil];
    
    if ([kStanderDefault objectForKey:@"zhuYe"]) {
        NSNumber *aa = [kStanderDefault objectForKey:@"zhuYe"];
        imageBG.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@" , [self.zhuYeArray objectAtIndex:[aa integerValue]]]];
    } else {
        imageBG.image=[UIImage imageNamed:@"主页背景图4"];
    }

    
    
    if (_serviceModel.devSn.length > 0 && _serviceModel.devTypeSn.length != 0) {
        
        [kSocketTCP sendDataToHost:[NSString stringWithFormat:@"HM%ld%@%@N#" , self.userModel.sn , _serviceModel.devTypeSn , _serviceModel.devSn] andType:kAddService andIsNewOrOld:nil];
        
        NSDictionary *parames = @{@"devSn" : _serviceModel.devSn , @"devTypeSn" : _serviceModel.devTypeSn};
        
        if ([_serviceModel.devTypeSn isEqualToString:@"4131"] || [_serviceModel.devTypeSn isEqualToString:@"4132"]) {
            
            [HelpFunction requestDataWithUrlString:kChaXunLengFengShanDangQianZhuangTai andParames:parames andDelegate:self];
            
            [HelpFunction requestDataWithUrlString:kChaXunLengFengShanDangQianShuJu andParames:parames andDelegate:self];
        } else if ([_serviceModel.devTypeSn isEqualToString:@"4231"]) {
            
            [HelpFunction requestDataWithUrlString:kChaXunKongJingDangQianZhuangTai andParames:parames andDelegate:self];
            
            [HelpFunction requestDataWithUrlString:kChaXunKongJingDangQianShuJu andParames:parames andDelegate:self];
        } else if ([_serviceModel.devTypeSn isEqualToString:@"4331"]) {
            
            [HelpFunction requestDataWithUrlString:kChaXunGanYiJiZhuangTai andParames:parames andDelegate:self];
            
            [HelpFunction requestDataWithUrlString:kChaXunGanYiJiShuJu andParames:parames andDelegate:self];
        }
        
    }
    
}


#pragma mark - 请求天气参数
- (void)startWearthData {
    
    [[CCLocationManager shareLocation]getCity:^(NSString *cityString) {
        
        [kStanderDefault setObject:cityString forKey:@"cityName"];
        [HelpFunction requestWeatherDataWithDelegate:self andCityName:cityString];
        
    }];
    
}


#pragma mark - 获取代理的数据
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
        
//        NSLog(@"%@" , _userModel);
        
        kSocketTCP.userSn = [NSString stringWithFormat:@"%ld" , _userModel.sn];
        [kSocketTCP socketConnectHost];

        
        [kApplicate initUserModel:_userModel];
        
        
        [HelpFunction requestDataWithUrlString:kQueryTheUserdevice andParames:@{@"userSn" : @(_userModel.sn)} andDelegate:self];
    }
}


- (void)requestData:(HelpFunction *)requset queryUserdevice:(NSDictionary *)dddd {
    
//    NSLog(@"%@" , dddd);
    
    NSInteger state = [dddd[@"state"] integerValue];
    if (state == 0) {
        NSMutableArray *dataArray = dddd[@"data"];
        
        if (dataArray.count > 0) {
            [self.serviceArray removeAllObjects];
            [dataArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                NSDictionary *dic = obj;
                ServicesModel *serviceModel = [[ServicesModel alloc]init];
                [serviceModel setValuesForKeysWithDictionary:dic];
                
                [self.serviceArray addObject:serviceModel];
            }];
            
            if (_indexPath) {
                _serviceModel = [[ServicesModel alloc]init];
                _serviceModel = self.serviceArray[_indexPath.row];
            }
            
            [kStanderDefault setObject:@"YES" forKey:@"isHaveService"];
            kSocketTCP.serviceModel = _serviceModel;
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [kSocketTCP sendDataToHost:[NSString stringWithFormat:@"HM%ld%@%@N#" , self.userModel.sn , _serviceModel.devTypeSn , _serviceModel.devSn] andType:kAddService andIsNewOrOld:nil];
            });
            
            [kApplicate initServiceModel:self.serviceModel];
            NSDictionary *parames = @{@"devSn" : _serviceModel.devSn , @"devTypeSn" : _serviceModel.devTypeSn};
            if ([_serviceModel.devTypeSn isEqualToString:@"4131"] || [_serviceModel.devTypeSn isEqualToString:@"4132"]) {
                
                [HelpFunction requestDataWithUrlString:kChaXunLengFengShanDangQianZhuangTai andParames:parames andDelegate:self];
                
                [HelpFunction requestDataWithUrlString:kChaXunLengFengShanDangQianShuJu andParames:parames andDelegate:self];
            } else if ([_serviceModel.devTypeSn isEqualToString:@"4231"]) {
                
                [HelpFunction requestDataWithUrlString:kChaXunKongJingDangQianZhuangTai andParames:parames andDelegate:self];
                
                [HelpFunction requestDataWithUrlString:kChaXunKongJingDangQianShuJu andParames:parames andDelegate:self];
            } else if ([_serviceModel.devTypeSn isEqualToString:@"4331"]) {
                
                [HelpFunction requestDataWithUrlString:kChaXunGanYiJiZhuangTai andParames:parames andDelegate:self];
                
                [HelpFunction requestDataWithUrlString:kChaXunGanYiJiShuJu andParames:parames andDelegate:self];
            }
            
            if (![self.userModel.headImageUrl isKindOfClass:[NSNull class]]) {
                [self.headImageView sd_setImageWithURL:[NSURL URLWithString:self.userModel.headImageUrl] placeholderImage:[UIImage new]];
                if (self.headImageView.image.size.width == 0) {
                    self.headImageView.image = [UIImage imageNamed:@"iconfont-touxiang"];
                }
                
            } else {
                self.headImageView.image = [UIImage imageNamed:@"iconfont-touxiang"];
            }
            
            
            [self.tableView reloadData];
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

#pragma mark - 查询设备数据
- (void)requestServicesData:(HelpFunction *)request didOK:(NSDictionary *)dic {
    
    if ([dic[@"data"] isKindOfClass:[NSDictionary class]]) {
        self.serviceDataModel = [[ServicesDataModel alloc]init];
        [self.serviceDataModel setValuesForKeysWithDictionary:dic[@"data"]];
        [self.tableView reloadData];
    }
}

#pragma mark - 查询设备状态
- (void)requestData:(HelpFunction *)request didSuccess:(NSDictionary *)dddd {
    
    if ([dddd[@"data"] isKindOfClass:[NSDictionary class]]) {
        NSDictionary *dic = dddd[@"data"];
        
        self.stateModel = [[StateModel alloc]init];
        
        for (NSString *key in [dic allKeys]) {
            [self.stateModel setValue:dic[key] forKey:key];
        }
        
        if ([_serviceModel.devTypeSn isEqualToString:@"4231"]) {
            if (self.stateModel.fSwitch == 2  || self.stateModel.fSwitch == 0) {
                self.bottomBtn.backgroundColor = [UIColor grayColor];
                self.bottomBtn.selected = 0;
                [kStanderDefault setObject:@"NO" forKey:@"offBtn"];
            } else if (self.stateModel.fSwitch == 1){
                self.bottomBtn.backgroundColor = kKongJingYanSe;
                self.bottomBtn.selected = 1;
                [kStanderDefault setObject:@"YES" forKey:@"offBtn"];
            }
            [self.bottomBtn addTarget:self action:@selector(openAtcion3333:) forControlEvents:UIControlEventTouchUpInside];
        } else if ([_serviceModel.devTypeSn isEqualToString:@"4131"] || [_serviceModel.devTypeSn isEqualToString:@"4132"]) {
            if (self.stateModel.fSwitch == 2  || self.stateModel.fSwitch == 0) {
                self.bottomBtn.backgroundColor = [UIColor grayColor];
                self.bottomBtn.selected = 0;
                [self.bottomBtn addTarget:self action:@selector(btnAtcion3333:) forControlEvents:UIControlEventTouchUpInside];
            } else if (self.stateModel.fSwitch == 1){
                
                self.bottomBtn.backgroundColor = kMainColor;
                [self.bottomBtn addTarget:self action:@selector(xxxxAtcion:) forControlEvents:UIControlEventTouchUpInside];
            }
            
        } else if ([_serviceModel.devTypeSn isEqualToString:@"4331"]) {
            if (self.stateModel.fSwitch == 2  || self.stateModel.fSwitch == 0) {
                self.bottomBtn.backgroundColor = [UIColor grayColor];
                self.bottomBtn.selected = 0;
                [kStanderDefault setObject:@"NO" forKey:@"offBtn"];
            } else if (self.stateModel.fSwitch == 1){
                
                self.bottomBtn.backgroundColor = kKongJingYanSe;
                self.bottomBtn.selected = 1;
                [kStanderDefault setObject:@"YES" forKey:@"offBtn"];
            }
            
            [self.bottomBtn addTarget:self action:@selector(ganYiJiOpenAtcion:) forControlEvents:UIControlEventTouchUpInside];
        }
        
        [self.tableView reloadData];
        
    } else {
        
        if ([_serviceModel.devTypeSn isEqualToString:@"4231"]) {
            
            [kStanderDefault setObject:@"NO" forKey:@"offBtn"];
            self.bottomBtn.backgroundColor = [UIColor grayColor];
            [self.bottomBtn addTarget:self action:@selector(openAtcion3333:) forControlEvents:UIControlEventTouchUpInside];
        } else if ([_serviceModel.devTypeSn isEqualToString:@"4131"] || [_serviceModel.devTypeSn isEqualToString:@"4132"]) {
            [kStanderDefault setObject:@"NO" forKey:@"offBtn"];
            self.bottomBtn.backgroundColor = [UIColor grayColor];
            [self.bottomBtn addTarget:self action:@selector(btnAtcion3333:) forControlEvents:UIControlEventTouchUpInside];
        } else if ([_serviceModel.devTypeSn isEqualToString:@"4331"]) {
            [kStanderDefault setObject:@"NO" forKey:@"offBtn"];
                self.bottomBtn.backgroundColor = [UIColor grayColor];
                [self.bottomBtn addTarget:self action:@selector(ganYiJiOpenAtcion:) forControlEvents:UIControlEventTouchUpInside];
        }
        self.bottomBtn.selected = 0;
    }
    
}


#pragma mark - 获取天气数据
- (void)getWeartherImage:(NSNotification *)post {
    self.werthImage = self.arrImage[[post.userInfo[@"weartherImage"] integerValue]];
    [kStanderDefault setObject:post.userInfo[@"weartherImage"] forKey:@"weartherImage"];
    
}

- (void)requestWearthData:(HelpFunction *)request didDone:(NSMutableArray *)array {
    NSMutableDictionary *ddd = [NSMutableDictionary dictionary];
    ddd = array[0];
    
    NSArray *chuanyi = array[1];
    [ddd setObject:chuanyi[1] forKey:@"chuanYi"];
    [kStanderDefault setObject:ddd forKey:@"wearthDic"];
    
    
    NSInteger i = [[kStanderDefault objectForKey:@"weartherImage"] integerValue];
    self.werthImage = self.arrImage[i];
    
    if (self.werthImage == nil) {
        self.werthImage = [UIImage imageNamed:@"duoYun"];
    }
    
    
    NSArray *subviewsArray = [NSArray arrayWithArray:_touMingImageVIew.subviews];
    for (int i = 0; i < subviewsArray.count; i++) {
        [subviewsArray[i] removeFromSuperview];
    }
    [banTouMingLableView removeFromSuperview];
    [self.testLabel removeFromSuperview];
    [_touMingImageVIew removeFromSuperview];
//    self.tabView.backgroundView = imageBG;
    [self getWeatherDic:ddd];
    
}

#pragma mark - 设置滚动Lable 
- (void)setScrollLable:(NSMutableDictionary *)dic {
    self.testLabel = [[RollLabel alloc] initWithFrame:CGRectMake(0 , 0 , kScreenW - kScreenW * 2 / 8.72093 , kScreenH / 29) text:dic[@"chuanYi"] font:[UIFont systemFontOfSize:15] textColor:[UIColor whiteColor]];
    [self.testLabel startRoll];
    
    [imageBG addSubview:self.testLabel];
    self.testLabel.tag = 2;
    [self.testLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kScreenW - kScreenW * 2 / 8.72093, kScreenH / 29));
        make.centerY.mas_equalTo(banTouMingLableView.mas_centerY);
        make.left.mas_equalTo(kScreenW / 8.72093);
    }];
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
    banTouMingLableView.frame = CGRectMake(kScreenW / 8.72093, kScreenH / 22.72 - kScreenH / 58 , kScreenW - kScreenW * 2 / 8.72093, kScreenH / 29);
    
    banTouMingLableView.layer.cornerRadius = kScreenH / 59;
    
    [self setScrollLable:dic];
    
    
    _touMingImageVIew = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"主页透明.jpg"]];
    _touMingImageVIew.frame=CGRectMake(0, -BackGroupHeight, self.view.frame.size.width, BackGroupHeight);
    
    
    NSInteger i = [[kStanderDefault objectForKey:@"weartherImage"] integerValue];
    self.werthImage = self.arrImage[i];
//    NSLog(@"%@" , self.werthImage);
    if (self.werthImage == nil) {
        self.werthImage = [UIImage imageNamed:@"duoYun"];
    }
    
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
    setVIew.userInteractionEnabled = NO;
    [setVIew mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kScreenH / 29, kScreenH / 29));
        make.right.mas_equalTo(-5);
        make.centerY.mas_equalTo(self.view.mas_top).offset(kScreenH / 22.72);
    }];
    
    UIImageView *zheGaiView = [[UIImageView alloc]init];
    [imageBG addSubview:zheGaiView];
    zheGaiView.backgroundColor = [UIColor clearColor];
    [zheGaiView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kScreenW / 6, kScreenW / 6));
        make.right.mas_equalTo(-5);
        make.centerY.mas_equalTo(self.view.mas_top).offset(kScreenH / 22.72);
    }];
    
    zheGaiView.userInteractionEnabled = YES;
    
    UITapGestureRecognizer *tap4 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapImageAtcion)];
    [zheGaiView addGestureRecognizer:tap4];
    
    
    
    UITapGestureRecognizer *gengHuanTuPianTap =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(gengHuanTuPianTapAction:)];
    
    //添加到指定视图
    [imageBG addGestureRecognizer:gengHuanTuPianTap];
    
    
    
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
    
    
    UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapImageAtcion)];
    [self.headImageView addGestureRecognizer:tap1];
    
    
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenW, kScreenH - kScreenH / 12.3518518) style:UITableViewStyleGrouped];
    self.tableView.tag = 234;
    [self.view addSubview:self.tableView];
    self.tableView.tableHeaderView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 0, 1)];
    self.tableView.contentInset=UIEdgeInsetsMake(BackGroupHeight, 0, 0, 0);
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundView = imageBG;
    
    
    
    self.wearthDic = [kStanderDefault objectForKey:@"wearthDic"];
    
    if ([kStanderDefault objectForKey:@"wearthDic"]) {
        self.wearthDic = [kStanderDefault objectForKey:@"wearthDic"];
    } else {
        
        [self.wearthDic setObject:@"==" forKey:@"quality"];
        [self.wearthDic setObject:@"==" forKey:@"humidity"];
        [self.wearthDic setObject:@"==" forKey:@"info"];
        [self.wearthDic setObject:@"==" forKey:@"temperature"];
        [self.wearthDic setObject:@"==" forKey:@"cityName"];
    }

    
    
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
        
    
    if (![kStanderDefault objectForKey:@"first"] ) {
        
        self.tiShiView = [[UIView alloc]init];
        self.tiShiView.frame = kScreenFrame;
        [self.view addSubview:self.tiShiView];
        
        UIImageView *iiiii = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"主页提示"]];
        [self.tiShiView addSubview:iiiii];
        iiiii.frame = self.tiShiView.bounds;
        
        UIButton *btn = [UIButton initWithTitle:@"" andColor:[UIColor clearColor] andSuperView:self.tiShiView];
        btn.userInteractionEnabled = YES;
        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(kScreenW / 1.78571, kScreenH  /11.11666666));
            make.top.mas_equalTo(self.view.mas_top).offset(kScreenH / 1.2472);
            make.centerX.mas_equalTo(self.view.mas_centerX);
        }];
        
        [btn addTarget:self action:@selector(zhiDaoLeAtcion:) forControlEvents:UIControlEventTouchUpInside];
    }
    
}

#pragma mark - 长按手势  更换图片
- (void)gengHuanTuPianTapAction:(UITapGestureRecognizer *)longPress {
    ExchangeCollectionViewController *exchangeVC = [[UIStoryboard storyboardWithName:@"ExchangeCollectionViewController" bundle:nil]instantiateViewControllerWithIdentifier:@"ExchangeCollectionViewController"];
    
    exchangeVC.fromMainVC = [NSString stringWithFormat:@"1"];
    
    [self.navigationController pushViewController:exchangeVC animated:YES];
}

#pragma mark - 向左滑动推出界面
- (void)swipeGesture11:(UISwipeGestureRecognizer *)swipe {
    
    if (_sendVCDelegate && [_sendVCDelegate respondsToSelector:@selector(sendViewControllerToParentVC:)]) {
        [_sendVCDelegate sendViewControllerToParentVC:self];
    }
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

#pragma mark - 头像和设置的点击事件
- (void)tapImageAtcion{
    MineViewController *mineVC = [[MineViewController alloc]init];
    mineVC.fromMainVC = [NSString stringWithFormat:@"YES"];
    mineVC.headImage = self.headImageView.image;
   
    mineVC.userModel = [[UserModel alloc]init];
    mineVC.userModel = self.userModel;
    [self.navigationController pushViewController:mineVC animated:YES];
}

#pragma mark - 修改昵称
- (void)getNiCheng:(NSNotification *)post {
    self.userModel.nickname = post.userInfo[@"niCheng"];
}


#pragma mark - 获取头像
- (void)getHeadImage:(NSNotification *)post {
    self.headImageView.image = post.userInfo[@"headImage"];
}



#pragma mark - 懒加载
- (NSMutableDictionary *)wearthDic{
    if (!_wearthDic) {
        self.wearthDic = [NSMutableDictionary dictionary];
    }
    return _wearthDic;
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
- (void)swipeGesture:(UISwipeGestureRecognizer *)swipe {
    
}
- (void)zhiDaoLeAtcion:(UIButton *)btn {
    
}
- (void)openAtcion3333:(UIButton *)btn {
    
}
- (void)btnAtcion3333:(UIButton *)btn {
    
}
- (void)xxxxAtcion:(UIButton *)btn {
    
}
- (void)ganYiJiOpenAtcion:(UIButton *)btn {
    
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

@end
