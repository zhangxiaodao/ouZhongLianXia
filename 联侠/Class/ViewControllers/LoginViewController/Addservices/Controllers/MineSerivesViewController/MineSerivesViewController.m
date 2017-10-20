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
#import "AllTypeServiceViewController.h"
#import "MainViewController.h"
#import "AirPurificationViewController.h"
#import "GanYiJiViewController.h"
#import "XinFengViewController.h"
#import "LengFengShanViewController.h"
#import "HTMLBaseViewController.h"

#import "CCLocationManager.h"

#import "WeatherView.h"
#import "FirstUserAlertView.h"

@interface MineSerivesViewController ()<UICollectionViewDataSource , UICollectionViewDelegate , UICollectionViewDelegateFlowLayout , HelpFunctionDelegate , SendViewControllerToParentVCDelegate , SendServiceModelToParentVCDelegate ,
    UIGestureRecognizerDelegate>
@property (nonatomic , strong) UICollectionView *collectionView;
@property (nonatomic , strong) WeatherView *weatherView;
@property (nonatomic , strong) UIImage *werthImage;

@property (nonatomic , strong) NSMutableDictionary *wearthDic;

@property (nonatomic , strong) UIViewController *childViewController;
@property (nonatomic , strong) NSMutableArray *haveArray;
@property (nonatomic , copy) NSString *userSn;
@property (nonatomic , strong) ServicesModel *serviceModel;

@property (nonatomic , strong) UIView *markView;

@property (nonatomic , strong) NSArray *arrImage;
@end

@implementation MineSerivesViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithHexString:@"f2f4fb"];

    [self setOther];
    [self setNav];
    [self setUI];
    [self setAlertView];
}

- (void)setOther {
    [kStanderDefault setObject:@"YES" forKey:@"Login"];
    
    if ([kStanderDefault objectForKey:@"userSn"] && kSocketTCP.socket.isConnected == NO) {
        self.userSn = [kStanderDefault objectForKey:@"userSn"];
        
        kSocketTCP.userSn = [NSString stringWithFormat:@"%@" , [kStanderDefault objectForKey:@"userSn"]];
        [kSocketTCP socketConnectHost];
    }
}

- (void)setNav {
    self.navigationItem.title = @"联侠";
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithTarget:self action:@selector(addSerViceAtcion) image:@"addService_high" highImage:nil];
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithTarget:self action:@selector(backAtcion) image:nil highImage:nil];
    self.navigationController.
    interactivePopGestureRecognizer.
    delegate = self;
}

- (void)backAtcion {
    
}

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
    if ([self.fromAddVC isEqualToString:@"YES"]) {
        return NO;
    } else {
        return YES;
    }
}

- (void)setAlertView {

    [[FirstUserAlertView alloc]creatAlertViewwithImage:@"alert1" deleteFirstObj:@"NO"];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = NO;
    
    [self requestWeather];
    if (self.userSn && self.serviceModel) {
        [kSocketTCP sendDataToHost:[NSString stringWithFormat:@"HM%@%@%@Q#" , self.userSn , self.serviceModel.devTypeSn , self.serviceModel.devSn] andType:kQuite andIsNewOrOld:nil];
    }
    
    
    NSDictionary *parameters = @{@"userSn": [kStanderDefault objectForKey:@"userSn"]};
    [kNetWork requestGETUrlString:kQueryTheUserdevice parameters:parameters isSuccess:^(NSDictionary * _Nullable responseObject) {
        NSInteger state = [responseObject[@"state"] integerValue];
        if (state != 0) {
            return ;
        }
        
        if ([responseObject[@"data"] isKindOfClass:[NSNull class]]) {
            self.markView.hidden = NO;
            return ;
        }
        NSArray *dataArray = responseObject[@"data"];
        if (dataArray.count == 0) return ;

        [self.haveArray removeAllObjects];
        
        [dataArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            NSDictionary *dic = obj;
            
            ServicesModel *serviceModel = [[ServicesModel alloc]init];
            [serviceModel setValuesForKeysWithDictionary:dic];
            serviceModel.userDeviceID = [obj[@"id"] integerValue];
            serviceModel.ifConn = [obj[@"ifConn"] integerValue];
            [_haveArray addObject:serviceModel];
            
        }];
        
        [kStanderDefault setObject:@"YES" forKey:@"isHaveService"];
        self.markView.hidden = YES;
        [self.collectionView reloadData];
    } failure:nil];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    for (int i = 0; i < self.haveArray.count; i++) {
        MineServiceCollectionViewCell *cell = (MineServiceCollectionViewCell *)[self.collectionView cellForItemAtIndexPath:[NSIndexPath indexPathForRow:i inSection:0]];
        cell.selectedImage.hidden = YES;
    }
}




#pragma mark - 设置UI界面
- (void)setUI{
    
    //0.天气信息块
    UIImageView *backImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"weather_bg"]];
    [self.view addSubview:backImageView];
    backImageView.frame = CGRectMake(0, 0, kScreenW, kScreenW / 2);
    backImageView.contentMode = UIViewContentModeScaleAspectFill;
    
    WeatherView *weatherView = [[WeatherView alloc]initWithFrame:backImageView.bounds];
    [backImageView addSubview:weatherView];
    self.weatherView = weatherView;
    
    if ([kStanderDefault objectForKey:@"wearthDic"]) {
        [self.wearthDic removeAllObjects];
        self.wearthDic = [kStanderDefault objectForKey:@"wearthDic"];
    }
    
    [self getWeatherDic:self.wearthDic];
    
    //1.CollectionView
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.itemSize = CGSizeMake((kScreenW - kScreenW * 3 / 25) / 2, kScreenW / 2.6);
    layout.sectionInset = UIEdgeInsetsMake(kScreenW / 25, kScreenW / 25, kScreenW / 25, kScreenW / 25);
    //2.初始化collectionView
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, kScreenW / 2 - kScreenW / 10, kScreenW, kScreenH - kScreenW / 2 - kNavibarH - kTabbarH + kScreenW / 10) collectionViewLayout:layout];
    [self.view insertSubview:self.collectionView atIndex:0];
    self.collectionView.backgroundColor = [UIColor colorWithHexString:@"f2f4fb"];

    [self.collectionView registerClass:[MineServiceCollectionViewCell class] forCellWithReuseIdentifier:@"cellId"];
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    
    
    UISwipeGestureRecognizer *swipeGesture1 = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeGesture22:)];
    //设置轻扫的方向
    swipeGesture1.direction = UISwipeGestureRecognizerDirectionLeft;
    [self.view addGestureRecognizer:swipeGesture1];
    
    
    UIView *markView = [[UIView alloc]initWithFrame:self.collectionView.frame];
    [self.view addSubview:markView];
    markView.backgroundColor = [UIColor colorWithHexString:@"f6f6f6"];
    self.markView = markView;
    
    
    UILabel *lable = [UILabel creatLableWithTitle:@"暂未添加任何设备" andSuperView:markView andFont:k17 andTextAligment:NSTextAlignmentCenter];
    [lable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(markView.mas_top).offset(kScreenH / 8.5);
        make.centerX.mas_equalTo(markView.mas_centerX);
    }];
    lable.textColor = [UIColor colorWithHexString:@"b4b4b4"];
    
    UIButton *button = [UIButton initWithTitle:@"添加设备" andColor:kFenGeXianYanSe andSuperView:markView];
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kScreenW / 2.6, kScreenW / 11));
        make.top.mas_equalTo(lable.mas_bottom).offset(kScreenH / 4);
        make.centerX.mas_equalTo(self.view.mas_centerX);
    }];
    button.layer.cornerRadius = kScreenW / 22;
    button.layer.masksToBounds = YES;
    button.backgroundColor = kCOLOR(28, 164, 252);
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    [button addTarget:self action:@selector(addSerViceAtcion) forControlEvents:UIControlEventTouchUpInside];
    self.markView.hidden = YES;
    
    
    
}

#pragma mark - 请求天气参数并定位位置信息
- (void)requestWeather {
    NSInteger nowTimeInterval = [NSString getNowTimeInterval];
    NSString *requestWeatherTime = [kStanderDefault objectForKey:@"requestWeatherTime"];
    if (requestWeatherTime != nil) {
        NSInteger weatherTime = [requestWeatherTime integerValue];
        NSLog(@"%@ , %@" , [NSString turnTimeIntervalToString:nowTimeInterval] , [NSString turnTimeIntervalToString:weatherTime]);
        [self startWearthData];
        if (nowTimeInterval > weatherTime + 1 * 3600) {
            [kStanderDefault setObject:@(nowTimeInterval) forKey:@"requestWeatherTime"];
            [self startWearthData];
        }
    } else {
        [kStanderDefault setObject:@(nowTimeInterval) forKey:@"requestWeatherTime"];
        [self startWearthData];
    }
}

- (void)startWearthData {
    [[CCLocationManager shareLocation] getNowCityNameAndProvienceName:^(NSArray *address) {
        NSString *cityName = address[0];
        
        if ([cityName containsString:@"市"]) {
            cityName = [cityName substringToIndex:cityName.length - 1];
        }
        [kStanderDefault setObject:cityName forKey:@"cityName"];
        
        [kNetWork requestWetherParameters:cityName isSuccess:^(NSDictionary * _Nullable responseObject) {
            [kStanderDefault setObject:responseObject forKey:@"wearthDic"];
            self.wearthDic = [NSMutableDictionary dictionaryWithDictionary:responseObject];
            [self getWeatherDic:self.wearthDic];
        } failure:nil];
        
    }];
}

- (void)getWeatherDic:(NSMutableDictionary *)dic {
    
    NSString *imagetr = self.arrImage[[dic[@"weather_icon"] integerValue]];
    self.werthImage = [UIImage imageNamed:imagetr];
    self.weatherView.weartherImage = self.werthImage;
    if ([[dic objectForKey:@"quality"] isEqualToString:@"=="]) {
        return ;
    }
    self.weatherView.weatherDic = dic;
}


#pragma mark - 向右滑动返回主界面
- (void)swipeGesture22:(UISwipeGestureRecognizer *)swipe {
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

#pragma mark - 添加设备的点击事件
- (void)addSerViceAtcion{
    AllTypeServiceViewController *allTypeVC = [[AllTypeServiceViewController alloc]init];
    allTypeVC.navigationItem.title = @"添加设备";
    [self.navigationController pushViewController:allTypeVC animated:YES];
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


- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
    MineServiceCollectionViewCell *cell = (MineServiceCollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
    cell.selectedImage.hidden = NO;
    
    return YES;
}

- (void)collectionView:(UICollectionView *)collectionView didUnhighlightItemAtIndexPath:(NSIndexPath *)indexPath {
    MineServiceCollectionViewCell *cell = (MineServiceCollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
    cell.selectedImage.hidden = YES;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    MineServiceCollectionViewCell *cell = (MineServiceCollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
    cell.selectedImage.hidden = NO;
    
    ServicesModel *model = [[ServicesModel alloc]init];
    model = self.haveArray[indexPath.row];
    
    [kApplicate initServiceModel:model];
    kSocketTCP.serviceModel = model;
    [kSocketTCP sendDataToHost:[NSString stringWithFormat:@"HM%@%@%@N#" , [kStanderDefault objectForKey:@"userSn"] , model.devTypeSn , model.devSn] andType:kAddService andIsNewOrOld:nil];
    
//    self.tabBarController.tabBar.hidden = YES;
    if ([model.devTypeSn isEqualToString:@"4131"])
    {

        LengFengShanViewController *lengFengShanVC = [[LengFengShanViewController alloc]init];
        lengFengShanVC.sendVCDelegate = self;
        lengFengShanVC.sendServiceModelToParentVCDelegate = self;
        lengFengShanVC.serviceModel = model;
        lengFengShanVC.wearthDic = self.wearthDic;
        [self.navigationController pushViewController:lengFengShanVC animated:YES];
    }
    else if ([model.devTypeSn isEqualToString:@"4231"])
    {
        AirPurificationViewController *testAirDeviceVC = [[AirPurificationViewController alloc]init];
        testAirDeviceVC.serviceModel = model;
        testAirDeviceVC.sendVCDelegate = self;
        testAirDeviceVC.sendServiceModelToParentVCDelegate = self;
        testAirDeviceVC.wearthDic = self.wearthDic;

        [self.navigationController pushViewController:testAirDeviceVC animated:YES];
    }
    else if ([model.devTypeSn isEqualToString:@"4232"])
    {
        XinFengViewController *xinFengAirVC = [[XinFengViewController alloc]init];
        xinFengAirVC.sendServiceModelToParentVCDelegate = self;
        xinFengAirVC.serviceModel = model;
        if (self.serviceModel.definedName) {
            xinFengAirVC.navigationItem.title = [NSString stringWithFormat:@"%@%@" , model.definedName , model.typeName];
        } else {
            xinFengAirVC.navigationItem.title = [NSString stringWithFormat:@"%@%@" , model.brand , model.typeName];
        }
        
        [self.navigationController pushViewController:xinFengAirVC animated:YES];
    }
    else if ([model.devTypeSn isEqualToString:@"4331"])
    {
        GanYiJiViewController *ganYiJiVC = [[GanYiJiViewController alloc]init];
        ganYiJiVC.sendServiceModelToParentVCDelegate = self;
        ganYiJiVC.serviceModel = model;
        ganYiJiVC.sendVCDelegate = self;
        ganYiJiVC.wearthDic = self.wearthDic;

        [self.navigationController pushViewController:ganYiJiVC animated:YES];
    } else  {
        HTMLBaseViewController *htmlVC = [[HTMLBaseViewController alloc]init];
        htmlVC.sendServiceModelToParentVCDelegate = self;
        htmlVC.serviceModel = model;
        [self.navigationController pushViewController:htmlVC animated:YES];
    }
}


//定义每个UICollectionView 的 margin
//-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
//    return UIEdgeInsetsMake(kScreenW / 25, kScreenW / 25, kScreenW / 25, kScreenW / 25);
//}

//- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
//    return kScreenW / 25;
//}

//- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
//    return kScreenW / 25;
//}

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
        _arrImage = [NSArray arrayWithObjects:@"qing", @"dayu", @"duoyun", @"feng", @"leiyu", @"mai", @"daxue",@"qingjianduoyun",@"wu",@"xiaoxue",@"xiaoyu",@"yin",@"yujiaxue",@"zhenyu",@"zhongxue",@"zhongyu", nil];
        
    }
    return _arrImage;
}

- (NSMutableDictionary *)wearthDic {
    if (!_wearthDic) {
        _wearthDic = [NSMutableDictionary dictionary];
        [_wearthDic setObject:@"==" forKey:@"quality"];
        [_wearthDic setObject:@"==" forKey:@"humidity"];
        [_wearthDic setObject:@"==" forKey:@"temp_curr"];
        [_wearthDic setObject:@"==" forKey:@"weather_curr"];
        [_wearthDic setObject:@"==" forKey:@"weather"];
        [_wearthDic setObject:@"==" forKey:@"winp"];
        [_wearthDic setObject:@(0) forKey:@"weather_icon"];
        [_wearthDic setObject:@"==" forKey:@"cityName"];
    }
    return _wearthDic;
}

@end
