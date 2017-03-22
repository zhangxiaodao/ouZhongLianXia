//
//  MineSerivesViewController.m
//  AEFT冷风扇
//
//  Created by 杭州阿尔法特 on 16/4/1.
//  Copyright © 2016年 阿尔法特. All rights reserved.
//

#import "MineSerivesViewController.h"
#import "MineServiceCollectionViewCell.h"

#import "MineViewController.h"

//#import "AllServicesViewController.h"
#import "AllTypeServiceViewController.h"
#import "SetServicesViewController.h"
#import "WiFiViewController.h"

#import "MainViewController.h"
#import "LengFengShanViewController.h"
#import "AirPurificationViewController.h"
#import "GanYiJiViewController.h"
#import "XinFengViewController.h"
#import "HTMLGanYiJiViewController.h"

#import "CCLocationManager.h"

#import "WeatherView.h"

@interface MineSerivesViewController ()<UICollectionViewDataSource , UICollectionViewDelegate , UICollectionViewDelegateFlowLayout , HelpFunctionDelegate , SendViewControllerToParentVCDelegate , CCLocationManagerZHCDelegate , SendServiceModelToParentVCDelegate>
@property (nonatomic , strong) UICollectionView *collectionView;

@property (nonatomic , strong) UIView *topView;
@property (nonatomic , strong) UIImageView *backImageView;
@property (nonatomic , strong) UIImage *werthImage;
@property (nonatomic , strong) NSArray *arrImage;
@property (nonatomic , strong) NSMutableDictionary *wearthDic;

@property (nonatomic , strong) UIViewController *childViewController;
@property (nonatomic , strong) NSMutableArray *haveArray;
@property (nonatomic , copy) NSString *userSn;
@property (nonatomic , strong) ServicesModel *serviceModel;

@property (nonatomic , strong) UIView *markView;
@end

@implementation MineSerivesViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [kStanderDefault setObject:@"YES" forKey:@"Login"];
    
    
    if ([kStanderDefault objectForKey:@"userSn"]) {
        self.userSn = [kStanderDefault objectForKey:@"userSn"];
        
//        NSLog(@"%@" , self.userSn);
        kSocketTCP.userSn = [NSString stringWithFormat:@"%@" , [kStanderDefault objectForKey:@"userSn"]];
        [kSocketTCP socketConnectHost];
    }
    [self setUI];
    

}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];

    MineSerivesViewController *mineServiceVC = [[MineSerivesViewController alloc]init];
    mineServiceVC.tabBarController.tabBar.hidden = YES;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = NO;
    
//    NSLog(@"%@ , %@" , self.userSn , self.serviceModel);
    
    if (self.userSn && self.serviceModel) {
        [kSocketTCP sendDataToHost:[NSString stringWithFormat:@"HM%@%@%@Q#" , self.userSn , self.serviceModel.devTypeSn , self.serviceModel.devSn] andType:kQuite andIsNewOrOld:nil];
    }

    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        // 耗时的操作
        dispatch_async(dispatch_get_main_queue(), ^{
            
//            [self startWearthData];
            
            NSInteger nowTimeInterval = [NSString getNowTimeInterval];
            if ([kStanderDefault objectForKey:@"requestWeatherTime"]) {
                NSInteger weatherTime = [[kStanderDefault objectForKey:@"requestWeatherTime"] integerValue];
                NSLog(@"%@ , %@" , [NSString turnTimeIntervalToString:nowTimeInterval] , [NSString turnTimeIntervalToString:weatherTime]);
                if (nowTimeInterval > weatherTime + 2 * 3600) {
                    [kStanderDefault setObject:@(nowTimeInterval) forKey:@"requestWeatherTime"];
                    [self startWearthData];
                }
            } else {
                [kStanderDefault setObject:@(nowTimeInterval) forKey:@"requestWeatherTime"];
                [self startWearthData];
            }
        });
    });
    
    
    
    
    NSDictionary *parameters = @{@"userSn": [kStanderDefault objectForKey:@"userSn"]};
    NSLog(@"%@" , parameters);
    [HelpFunction requestDataWithUrlString:kQueryTheUserdevice andParames:parameters andDelegate:self];
    
}


#pragma mark - 获取代理的数据
- (void)requestData:(HelpFunction *)requset queryUserdevice:(NSDictionary *)dddd{
    
//    NSLog(@"%@" , dddd);
    NSInteger state = [dddd[@"state"] integerValue];
    if (state == 0) {
        
        if ([dddd[@"data"] isKindOfClass:[NSNull class]]) {
            self.markView.hidden = NO;
            return ;
        }
        NSMutableArray *dataArray = dddd[@"data"];
        
        if (dataArray.count > 0) {
            [self.haveArray removeAllObjects];
            [dataArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                NSDictionary *dic = obj;
                
                if ([dic[@"brand"] isKindOfClass:[NSNull class]]) {
                    [dic setValue:@"" forKey:@"brand"];
                }
                
                ServicesModel *serviceModel = [[ServicesModel alloc]init];
                [serviceModel setValuesForKeysWithDictionary:dic];
                serviceModel.userDeviceID = [obj[@"id"] integerValue];
                [_haveArray addObject:serviceModel];
                
            }];
            [kStanderDefault setObject:@"YES" forKey:@"isHaveService"];
            
            if (self.haveArray.count > 0) {
                [self.collectionView reloadData];
            } else {
                self.markView.hidden = NO;
            }
            
        }
    }
}


#pragma mark - 设置UI界面
- (void)setUI{
    
    //1.初始化layout
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.headerReferenceSize = CGSizeMake(self.view.frame.size.width, 0);
    
    //2.初始化collectionView
    self.collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:layout];
    [self.view addSubview:self.collectionView];
    self.collectionView.backgroundColor = [UIColor clearColor];
    
    UIView *topView = [[UIView alloc]init];
    [self.view addSubview:topView];
    [topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kScreenW, kScreenH / 4));
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.top.mas_equalTo(self.view.mas_top).offset(20);
    }];
    _topView = topView;
    
    UIImageView *backImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"mymachine_back"]];
    [topView addSubview:backImageView];
    [backImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kScreenW, kScreenH / 4));
        make.centerX.mas_equalTo(topView.mas_centerX);
        make.centerY.mas_equalTo(topView.mas_centerY);
    }];
    _backImageView = backImageView;
    
    
    
    self.collectionView.backgroundColor = [UIColor clearColor];
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kScreenW, kScreenH - kScreenH / 4));
        make.top.mas_equalTo(topView.mas_bottom);
        make.left.mas_equalTo(0);
    }];
    //注意，此处的ReuseIdentifier 必须和 cellForItemAtIndexPath 方法中 一致 均为 cellId
    [self.collectionView registerClass:[MineServiceCollectionViewCell class] forCellWithReuseIdentifier:@"cellId"];
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    
    //添加轻扫手势
    UISwipeGestureRecognizer *swipeGesture1 = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeGesture22:)];
    //设置轻扫的方向
    swipeGesture1.direction = UISwipeGestureRecognizerDirectionLeft; //默认向右
    [self.view addGestureRecognizer:swipeGesture1];
    
    UIButton *offBtn = [UIButton initWithTitle:@"＋" andColor:[UIColor clearColor] andSuperView:_topView];
    offBtn.titleLabel.font = [UIFont systemFontOfSize:k25];
    [offBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [offBtn addTarget:self action:@selector(addSerViceAtcion:) forControlEvents:UIControlEventTouchUpInside];
    [offBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kNavHidth * 4 / 5, kNavHidth * 4 / 5));
        make.right.mas_equalTo(_topView.mas_right).offset(- kScreenW / 30);
        make.top.mas_equalTo(_topView.mas_top).offset(kScreenW / 100);
        
    }];
    
    UIView *markView = [[UIView alloc]init];
    [self.view addSubview:markView];
    [markView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kScreenW, kScreenH * 3 / 4));
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.top.mas_equalTo(topView.mas_bottom);
    }];
    markView.backgroundColor = kFenGeXianYanSe;
    self.markView = markView;
    
    UIImageView *imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"meiYouSheBei"]];
    [markView addSubview:imageView];
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kScreenW / 4, kScreenH / 11));
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.top.mas_equalTo(self.view.mas_top).offset(kScreenH / 2.3);
    }];
    
    UILabel *lable = [UILabel creatLableWithTitle:@"暂时没有添加设备" andSuperView:markView andFont:k17 andTextAligment:NSTextAlignmentCenter];
    [lable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kScreenW / 2, kScreenW / 10));
        make.top.mas_equalTo(imageView.mas_bottom).offset(kScreenW / 20);
        make.centerX.mas_equalTo(self.view.mas_centerX);
    }];
    lable.textColor = kCOLOR(212, 204, 196);
    lable.layer.borderWidth = 0;
    
    UIButton *button = [UIButton initWithTitle:@"添加设备" andColor:kFenGeXianYanSe andSuperView:markView];
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kScreenW / 2, kScreenW / 10));
        make.top.mas_equalTo(lable.mas_bottom).offset(kScreenW / 10);
        make.centerX.mas_equalTo(self.view.mas_centerX);
    }];
    button.layer.cornerRadius = 5;
    button.layer.masksToBounds = YES;
    button.layer.borderWidth = 1;
    button.backgroundColor = [UIColor whiteColor];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    [button addTarget:self action:@selector(addSerViceAtcion:) forControlEvents:UIControlEventTouchUpInside];
    
    
    self.markView.hidden = YES;
    
    if ([kStanderDefault objectForKey:@"wearthDic"]) {
        self.wearthDic = [kStanderDefault objectForKey:@"wearthDic"];
    } else {
        
        [self.wearthDic setObject:@"==" forKey:@"quality"];
        [self.wearthDic setObject:@"==" forKey:@"humidity"];
        [self.wearthDic setObject:@"==" forKey:@"info"];
        [self.wearthDic setObject:@"==" forKey:@"temperature"];
        [self.wearthDic setObject:@"==" forKey:@"cityName"];
    }
    
    [self getWeatherDic:self.wearthDic];
}

#pragma mark - 请求天气参数
- (void)startWearthData {
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getWeartherImage:) name:@"weartherImage" object:nil];
    
    [[CCLocationManager shareLocation] getNowCityNameAndProvienceName:self];
    
}

- (void)getCityNameAndProvience:(NSArray *)address {
    NSString *cityName = address[0];
    [HelpFunction requestWeatherDataWithDelegate:self andCityName:cityName];
    [kStanderDefault setObject:cityName forKey:@"cityName"];
}

- (void)getWeartherImage:(NSNotification *)post {
    self.werthImage = self.arrImage[[post.userInfo[@"weartherImage"] integerValue]];
    [kStanderDefault setObject:post.userInfo[@"weartherImage"] forKey:@"weartherImage"];
}


- (void)requestWearthData:(HelpFunction *)request didDone:(NSMutableArray *)array {
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    dic = array[0];
    
    
    NSArray *chuanyi = array[1];
    [dic setObject:chuanyi[1] forKey:@"chuanYi"];
    
    [kStanderDefault setObject:dic forKey:@"wearthDic"];
    
    NSLog(@"%@" , self.wearthDic);

//    if (self.wearthDic.count > 0) {
//        [self.wearthDic removeAllObjects];
//    }
    
    self.wearthDic = dic;
    
    NSInteger i = [[kStanderDefault objectForKey:@"weartherImage"] integerValue];
    self.werthImage = self.arrImage[i];
    
    if (self.werthImage == nil) {
        self.werthImage = [UIImage imageNamed:@"duoYun"];
    }
    
    [self getWeatherDic:dic];
    
}

- (void)getWeatherDic:(NSMutableDictionary *)dic {
    
    NSInteger i = [[kStanderDefault objectForKey:@"weartherImage"] integerValue];
    self.werthImage = self.arrImage[i];
    //    NSLog(@"%@" , self.werthImage);
    if (self.werthImage == nil) {
        self.werthImage = [UIImage imageNamed:@"duoYun"];
    }
    
    NSArray *array = _backImageView.subviews;
    for (int i = 0; i < array.count; i++) {
        [array[i] removeFromSuperview];
    }
    
    [WeatherView creatViewWeatherDic:dic andSuperView:_backImageView andWearthImage:self.werthImage andMainColor:[UIColor whiteColor]];
    
}


#pragma mark - 向右滑动返回主界面
- (void)swipeGesture22:(UISwipeGestureRecognizer *)swipe {
    
    self.tabBarController.tabBar.hidden = YES;
    
    if (_childViewController) {
        [self.navigationController pushViewController:_childViewController animated:YES];
    }
    
}

- (void)sendViewControllerToParentVC:(UIViewController *)viewController {
    _childViewController = viewController;
    
}

- (void)sendServiceModelToParentVC:(ServicesModel *)serviceModel {
    self.serviceModel = serviceModel;
}

#pragma mark - 开关的点击事件
- (void)addSerViceAtcion:(UIButton *)btn{
    self.tabBarController.tabBar.hidden = YES;
    SetServicesViewController *setServiceVC = [[SetServicesViewController alloc]init];
//    AllTypeServiceViewController *alll = [[AllTypeServiceViewController alloc]init];
    [self.navigationController pushViewController:setServiceVC animated:YES];
}

#pragma mark - collectionView有多少分区
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

#pragma mark - 每个分区rows的个数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return self.haveArray.count;
}

#pragma mark - 生成items
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{

    
   MineServiceCollectionViewCell *cell = (MineServiceCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"cellId" forIndexPath:indexPath];
    
    ServicesModel *model1 = [[ServicesModel alloc]init];
    
    model1 = self.haveArray[indexPath.row];
    
    cell.indexPath = indexPath;
    
    cell.serviceModel = model1;
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    ServicesModel *model = [[ServicesModel alloc]init];
    model = self.haveArray[indexPath.row];
    
    [kApplicate initServiceModel:model];
    kSocketTCP.serviceModel = model;
    [kSocketTCP sendDataToHost:[NSString stringWithFormat:@"HM%@%@%@N#" , [kStanderDefault objectForKey:@"userSn"] , model.devTypeSn , model.devSn] andType:kAddService andIsNewOrOld:nil];
    
    
    
    self.tabBarController.tabBar.hidden = YES;
    if ([model.devTypeSn isEqualToString:@"4131"] || [model.devTypeSn isEqualToString:@"4132"]) {
        LengFengShanViewController *lengFengShanVC = [[LengFengShanViewController alloc]init];
        lengFengShanVC.serviceArray = [NSMutableArray arrayWithArray:self.haveArray];
        lengFengShanVC.sendVCDelegate = self;
        lengFengShanVC.sendServiceModelToParentVCDelegate = self;
        lengFengShanVC.serviceModel = model;
        lengFengShanVC.wearthDic = self.wearthDic;
        [self.navigationController pushViewController:lengFengShanVC animated:YES];
    } else if ([model.devTypeSn isEqualToString:@"4231"]) {
        AirPurificationViewController *testAirDeviceVC = [[AirPurificationViewController alloc]init];
        testAirDeviceVC.serviceModel = model;
        testAirDeviceVC.serviceArray = [NSMutableArray arrayWithArray:self.haveArray];
        testAirDeviceVC.sendVCDelegate = self;
        testAirDeviceVC.sendServiceModelToParentVCDelegate = self;
        testAirDeviceVC.wearthDic = self.wearthDic;
        [self.navigationController pushViewController:testAirDeviceVC animated:YES];
    } else if ([model.devTypeSn isEqualToString:@"4232"]) {
        XinFengViewController *xinFengAirVC = [[XinFengViewController alloc]init];
        xinFengAirVC.sendServiceModelToParentVCDelegate = self;
        xinFengAirVC.serviceArray = [NSMutableArray arrayWithArray:self.haveArray];
        xinFengAirVC.serviceModel = model;
        
        [self.navigationController pushViewController:xinFengAirVC animated:YES];
    }  else if ([model.devTypeSn isEqualToString:@"4331"]) {
        GanYiJiViewController *ganYiJiVC = [[GanYiJiViewController alloc]init];
        ganYiJiVC.sendServiceModelToParentVCDelegate = self;
        ganYiJiVC.serviceModel = model;
        ganYiJiVC.serviceArray = [NSMutableArray arrayWithArray:self.haveArray];
        ganYiJiVC.sendVCDelegate = self;
        ganYiJiVC.wearthDic = self.wearthDic;
        [self.navigationController pushViewController:ganYiJiVC animated:YES];
    } else if ([model.devTypeSn isEqualToString:@"4332"]) {
        HTMLGanYiJiViewController *htmlGanYiJiVC = [[HTMLGanYiJiViewController alloc]init];
        
        htmlGanYiJiVC.serviceModel = model;
        [self.navigationController pushViewController:htmlGanYiJiVC animated:YES];
    }
}


- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake((kScreenW - kScreenW * 2 / 15) / 3, ((kScreenW - kScreenW * 2 / 15) / 3) * 1.25);
}

//定义每个UICollectionView 的 margin
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(kScreenW / 30, kScreenW / 30, kScreenW / 30, kScreenW / 30);
}

- (NSMutableArray *)haveArray {
    if (!_haveArray) {
        _haveArray = [NSMutableArray array];
    }
    return _haveArray;
}

- (void)setServiceModel:(ServicesModel *)serviceModel {
    _serviceModel = serviceModel;
}

- (NSArray *)arrImage {
    if (!_arrImage) {
        _arrImage = [NSArray arrayWithObjects:[UIImage imageNamed:@"qing"], [UIImage imageNamed:@"leiZhenYu"], [UIImage imageNamed:@"yangChen"], [UIImage imageNamed:@"duoYun"], [UIImage imageNamed:@"xue"], [UIImage imageNamed:@"yu"], [UIImage imageNamed:@"wu"], [UIImage imageNamed:@"feng"],  nil];
    }
    return _arrImage;
}

- (NSMutableDictionary *)wearthDic {
    if (!_wearthDic) {
        _wearthDic = [NSMutableDictionary dictionary];
    }
    return _wearthDic;
}

@end
