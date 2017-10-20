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
#import "AllServicesViewController.h"
#import "FirstUserAlertView.h"

@interface MainViewController ()<UIScrollViewDelegate , HelpFunctionDelegate>{
    UIImageView *tableViewBackView;
    UIView *setVIew;
}
@property (nonatomic , strong) UIImage *werthImage;
@property (nonatomic , strong) NSMutableArray *zhuYeArray;
@property (nonatomic , strong) NSArray *arrImage;

@property (nonatomic , strong) UIImageView *firstView;
@property (nonatomic , strong) UIImageView *headImageView;

@property (nonatomic , copy) NSString *deviceName;

@end

static CGFloat tableViewContentOffsetY = 0;

@implementation MainViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self setRequestUserInfo];
    
    [self setMainUI];
    
    [self setAlertView];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getHeadImage:) name:@"headImage" object:nil];

}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = YES;
    self.navigationController.navigationBar.hidden = YES;
    
    
    if ([kStanderDefault objectForKey:@"zhuYe"]) {
        NSNumber *aa = [kStanderDefault objectForKey:@"zhuYe"];
        tableViewBackView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@" , [self.zhuYeArray objectAtIndex:[aa integerValue]]]];
    } else {
        tableViewBackView.image=[UIImage imageNamed:@"主页背景图4"];
    }

    if (self.serviceModel && self.userModel) {
        [kSocketTCP sendDataToHost:[NSString stringWithFormat:@"HM%ld%@%@N#" , (long)self.userModel.sn , _serviceModel.devTypeSn , _serviceModel.devSn] andType:kAddService andIsNewOrOld:nil];
    }
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    tableViewContentOffsetY = self.tableView.contentOffset.y;
//    NSLog(@"%.2f" , self.tableView.contentOffset.y);
}

#pragma mark - 获取用户信息
- (void)setRequestUserInfo {
    NSDictionary *parames = @{@"userSn":[kStanderDefault objectForKey:@"userSn"]};
    [kNetWork requestPOSTUrlString:kUserInfoURL parameters:parames isSuccess:^(NSDictionary * _Nullable responseObject) {
        NSDictionary *dic = responseObject;
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
            
            [self setAvertImage];
        }
    } failure:nil];
}

#pragma mark - 设置用户头像
- (void)setAvertImage {
    if (![self.userModel.headImageUrl isKindOfClass:[NSNull class]]) {
        [self.headImageView sd_setImageWithURL:[NSURL URLWithString:self.userModel.headImageUrl] placeholderImage:[UIImage new]];
        if (self.headImageView.image.size.width == 0) {
            self.headImageView.image = [UIImage imageNamed:@"iconfont-touxiang"];
        }
    } else {
        self.headImageView.image = [UIImage imageNamed:@"iconfont-touxiang"];
    }
}

#pragma mark - 查询设备状态
- (void)requestMainVCServiceState {
    NSDictionary *parames = @{@"devSn" : self.serviceModel.devSn , @"devTypeSn" : self.serviceModel.devTypeSn};
    NSDictionary *urlStringDic = @{ @"4131":kChaXunLengFengShanDangQianZhuangTai ,@"4231":kChaXunKongJingDangQianZhuangTai ,@"4331":kChaXunGanYiJiZhuangTai};
    
    [kNetWork requestPOSTUrlString:urlStringDic[self.serviceModel.devTypeSn] parameters:parames isSuccess:^(NSDictionary * _Nullable responseObject) {
        if ([responseObject[@"data"] isKindOfClass:[NSDictionary class]]) {
            NSDictionary *dic = responseObject[@"data"];
            
            self.stateModel = [[StateModel alloc]init];
            
            for (NSString *key in [dic allKeys]) {
                [self.stateModel setValue:dic[key] forKey:key];
            }
            
            if (self.stateModel.fSwitch == 2  || self.stateModel.fSwitch == 0) {
                [self setBottomBackGroundColor:[UIColor grayColor] andSelected:0 andState:@"NO"];
            } else if (self.stateModel.fSwitch == 1){
                [self setBottomBackGroundColor:kKongJingYanSe andSelected:1 andState:@"YES"];
            }
            [self.tableView reloadData];
        } else {
            [self setBottomBackGroundColor:[UIColor grayColor] andSelected:0 andState:@"NO"];
        }
    } failure:nil];
    
}



#pragma mark - 查询设备数据
- (void)requestMainVCServiceData {
    NSDictionary *parames = @{@"devSn" : self.serviceModel.devSn , @"devTypeSn" : self.serviceModel.devTypeSn};
    NSDictionary *urlStringDic = @{ @"4131":kChaXunLengFengShanDangQianShuJu ,@"4231":kChaXunKongJingDangQianShuJu ,@"4331":kChaXunGanYiJiShuJu};
    
    [kNetWork requestPOSTUrlString:urlStringDic[self.serviceModel.devTypeSn] parameters:parames isSuccess:^(NSDictionary * _Nullable responseObject) {
        if ([responseObject[@"data"] isKindOfClass:[NSDictionary class]]) {
            self.serviceDataModel = [[ServicesDataModel alloc]init];
            [self.serviceDataModel setValuesForKeysWithDictionary:responseObject[@"data"]];
            [self.tableView reloadData];
        }
    } failure:nil];
}

#pragma mark - 设置开关按钮的不同状态
- (void)setBottomBackGroundColor:(UIColor *)color andSelected:(BOOL)selected andState:(NSString *)state {
    self.bottomBtn.backgroundColor = color;
    self.bottomBtn.selected = selected;
    [kStanderDefault setObject:state forKey:@"offBtn"];
}

#pragma mark - 设置UI
- (void)setMainUI {
    
    [self setTableViewBackView];
    
    [self setTableView];
    
    NSArray *subviewsArray = [NSArray arrayWithArray:_touMingImageVIew.subviews];
    for (int i = 0; i < subviewsArray.count; i++) {
        [subviewsArray[i] removeFromSuperview];
    }
    [_touMingImageVIew removeFromSuperview];
    [self getWeatherDic:self.wearthDic];
    [self setBottomView];
    [self setSwipeGesture];
}
#pragma mark - 设置 tableView 的背景图片
- (void)setTableViewBackView {
    tableViewBackView=[[UIImageView alloc]init];
    [self.view addSubview:tableViewBackView];
    tableViewBackView.frame = CGRectMake(0, 0, kScreenW, kScreenH);
    tableViewBackView.contentMode = UIViewContentModeTop;
    tableViewBackView.userInteractionEnabled = YES;
    
    setVIew = [UIView creatViewWithFrame:CGSizeMake(kScreenH / 13, kScreenH / 13) image:[UIImage imageNamed:@"iconfont-ordinaryset"] andSuperView:tableViewBackView];
    [setVIew mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kScreenH / 13, kScreenH / 13));
        make.right.mas_equalTo(tableViewBackView.mas_right)
        .offset(-5);
        make.top.mas_equalTo(kStatusbarH);
    }];
    
    UITapGestureRecognizer *setTap =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(setTapAction)];
    [setVIew addGestureRecognizer:setTap];
    
    self.headImageView = [[UIImageView alloc]init];
    self.headImageView.image = [UIImage imageNamed:@"iconfont-touxiang"];
    [tableViewBackView addSubview:self.headImageView];
    [self.headImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kScreenW / 6, kScreenW / 6));
        make.top.mas_equalTo(kStatusbarH + kScreenW / 30);
        make.left.mas_equalTo(kScreenW / 20);
    }];
    self.headImageView.layer.cornerRadius = kScreenW / 12;
    self.headImageView.layer.masksToBounds = YES;
}
#pragma mark - 设置tableView
- (void)setTableView {
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenW, kScreenH - kScreenW / 6.8) style:UITableViewStyleGrouped];
    self.tableView.tag = 234;
    [self.view addSubview:self.tableView];
    self.tableView.contentInset = UIEdgeInsetsMake(BackGroupHeight, 0, 0, 0);
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundView = tableViewBackView;
}
#pragma mark - 设置天气UI
- (void)getWeatherDic:(NSMutableDictionary *)dic {
    
    _touMingImageVIew = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"主页透明.jpg"]];
    _touMingImageVIew.frame=CGRectMake(0, -BackGroupHeight, self.view.frame.size.width, BackGroupHeight);
    
    NSString *imagetr = self.arrImage[[dic[@"weather_icon"] integerValue]];
    self.werthImage = [UIImage imageNamed:imagetr];
    
    [MainFirstView creatViewWeatherDic:dic andSuperView:_touMingImageVIew andWearthImage:self.werthImage];
    
    _touMingImageVIew.contentMode = UIViewContentModeScaleAspectFill;
    [self.tableView addSubview:_touMingImageVIew];
    _touMingImageVIew.tag = 3;
}
#pragma mark - 设置底部开关UI
- (void)setBottomView {
    UIView *bottomView = [[UIView alloc]init];
    [self.view addSubview:bottomView];
    [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.view.mas_bottom);
        make.size.mas_equalTo(CGSizeMake(kScreenW, kScreenW / 6.8));
        make.centerX.mas_equalTo(self.view.mas_centerX);
    }];
    bottomView.backgroundColor = [UIColor whiteColor];
    
    self.bottomBtn = [UIButton initWithTitle:@"开启" andColor:[UIColor grayColor] andSuperView:bottomView];
    self.bottomBtn.layer.cornerRadius = kScreenW / 18;
    [self.bottomBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kScreenW - kScreenW * 2 / 15, kScreenW / 9));
        make.centerX.mas_equalTo(bottomView.mas_centerX);
        make.centerY.mas_equalTo(bottomView.mas_centerY);
    }];
    [self.bottomBtn setImage:[UIImage imageNamed:@"iconfont-kaiguan222"] forState:UIControlStateNormal];
    [self.bottomBtn setImage:[UIImage imageNamed:@"iconfont-kaiguan222"] forState:UIControlStateHighlighted];
    self.bottomBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 5, 0, 0);
    [self bottomBtnAddAtcion];
}
#pragma mark - 开关按钮的点击事件
- (void)bottomBtnAddAtcion {
    NSDictionary *atcionDic = @{@"4131":@"lengFengShanOpenAtcion" , @"4231":@"kongQiJingHuaQiOpenAtcion" , @"4331":@"ganYiJiOpenAtcion"};
    NSString *actionStr = atcionDic[_serviceModel.devTypeSn];
    [self.bottomBtn addTarget:self action:NSSelectorFromString(actionStr) forControlEvents:UIControlEventTouchUpInside];
}

#pragma mark - 左右滑动事件
- (void)setSwipeGesture {
    UISwipeGestureRecognizer *leftSwipeGesture = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(leftSwipeAtcion:)];
    leftSwipeGesture.direction = UISwipeGestureRecognizerDirectionLeft;
    [self.view addGestureRecognizer:leftSwipeGesture];
    
    UISwipeGestureRecognizer *rightSwipeGesture = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(rightSwipeAtcion:)];
    //设置轻扫的方向
    rightSwipeGesture.direction = UISwipeGestureRecognizerDirectionRight; //默认向右
    [self.view addGestureRecognizer:rightSwipeGesture];
}
#pragma mark - 第一次进入主页的提示图片
- (void)setAlertView {
    [[FirstUserAlertView alloc]creatAlertViewwithImage:@"主页提示" deleteFirstObj:@"move"];
}

#pragma mark - 设置功能的点击事件
- (void)setTapAction {
    [UIAlertController creatSheetControllerWithFirstHandle:^{
        
        NSString *name = nil;
        
        if (self.serviceModel.brand == NULL || self.serviceModel.brand == nil) {
            name = self.serviceModel.typeName;
        } else {
            name = [NSString stringWithFormat:@"%@%@" , self.serviceModel.brand , self.serviceModel.typeName];
        }
        
        [UIAlertController creatAlertControllerWithFirstTextfiledPlaceholder:nil andFirstTextfiledText:name andFirstAtcion:nil andWhetherEdite:NO WithSecondTextfiledPlaceholder:@"请输入修改名称" andSecondTextfiledText:nil andSecondAtcion:@selector(secondTextFieldsValueDidChange:) andAlertTitle:@"修改设备名称" andAlertMessage:@"你可以再次修改设备名称，便于区分。" andTextfiledAtcionTarget:self andSureHandle:^{
            if (self.deviceName) {
                NSDictionary *parames = @{@"ud.devTypeSn" :  self.serviceModel.devTypeSn, @"ud.devSn" :  self.serviceModel.devSn, @"ud.definedName" : self.deviceName};
                NSLog(@"修改设备名称---%@" , parames);
                
                [kNetWork requestPOSTUrlString:kChangeServiceName parameters:parames isSuccess:^(NSDictionary * _Nullable responseObject) {
                    
                    if ([responseObject[@"state"] isKindOfClass:[NSNull class]]) {
                        return ;
                    }
                    
                    NSInteger index = [responseObject[@"state"] integerValue];
                    if (index == 0) {
                        if (self.deviceName) {
                            self.navigationItem.title = [NSString stringWithFormat:@"%@%@" , self.deviceName , self.serviceModel.typeName];
                        } else {
                            self.navigationItem.title = [NSString stringWithFormat:@"%@%@" , self.serviceModel.brand , self.serviceModel.typeName];
                        }
                    }
                    
                } failure:nil];
            }
        } andSuperViewController:self];
        
    } andFirstTitle:@"修改名称" andSecondHandle:^{
        
        [UIAlertController creatCancleAndRightAlertControllerWithHandle:^{
            NSDictionary *parames = @{@"id" : @(self.serviceModel.userDeviceID)};
            [kNetWork requestPOSTUrlString:kDeleteServiceURL parameters:parames isSuccess:^(NSDictionary * _Nullable responseObject) {
                if ([responseObject[@"state"] integerValue] == 0) {
                    [UIAlertController creatRightAlertControllerWithHandle:^{
                        [self.navigationController popViewControllerAnimated:YES];
                    } andSuperViewController:self Title:@"设备删除成功"];
                }
            } failure:nil];
            
        } andSuperViewController:self Title:@"是否移除设备"];
        
    } andSecondTitle:@"移除设备" andThirtHandle:^{
        ExchangeCollectionViewController *exchangeVC = [[UIStoryboard storyboardWithName:@"ExchangeCollectionViewController" bundle:nil]instantiateViewControllerWithIdentifier:@"ExchangeCollectionViewController"];
        exchangeVC.fromMainVC = [NSString stringWithFormat:@"1"];
        exchangeVC.navigationItem.title = @"更换背景图片";
        [self.navigationController pushViewController:exchangeVC animated:YES];
    } andThirtTitle:@"更换背景" andForthHandle:nil andForthTitle:nil andSuperViewController:self];
}

#pragma mark - 修改设备名称的代理
- (void)secondTextFieldsValueDidChange:(UITextField *)textfiled {
    self.deviceName = textfiled.text;
}

#pragma mark - 向右滑动推出界面
- (void)rightSwipeAtcion:(UISwipeGestureRecognizer *)swipe {
    
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

#pragma mark - 获取头像
- (void)getHeadImage:(NSNotification *)post {
    self.headImageView.image = post.userInfo[@"headImage"];
}

#pragma mark - 懒加载
- (void)setWearthDic:(NSMutableDictionary *)wearthDic {
    _wearthDic = wearthDic;
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
    if (yOffset <= tableViewContentOffsetY) {
        self.tableView.bounces = YES;
    }
    else if (yOffset >= tableViewContentOffsetY){
        self.tableView.bounces = NO;
    }
}

#pragma mark - 懒加载
- (void)setServiceModel:(ServicesModel *)serviceModel {
    _serviceModel = serviceModel;
    if (_serviceModel) {
        [kApplicate initServiceModel:self.serviceModel];
        [self requestMainVCServiceData];
        [self requestMainVCServiceState];
    }
}

- (NSArray *)arrImage {
    if (!_arrImage) {
        _arrImage = [NSArray arrayWithObjects:@"qing", @"dayu", @"duoyun", @"feng", @"leiyu", @"mai", @"daxue",@"qingjianduoyun",@"wu",@"xiaoxue",@"xiaoyu",@"yin",@"yujiaxue",@"zhenyu",@"zhongxue",@"zhongyu", nil];
        
    }
    return _arrImage;
}

- (void)leftSwipeAtcion:(UISwipeGestureRecognizer *)swipe{}
- (void)kongQiJingHuaQiOpenAtcion{}
- (void)lengFengShanOpenAtcion{}
- (void)lengFengShanCloseAtcion{}
- (void)ganYiJiOpenAtcion{}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:nil object:nil];
}

@end
