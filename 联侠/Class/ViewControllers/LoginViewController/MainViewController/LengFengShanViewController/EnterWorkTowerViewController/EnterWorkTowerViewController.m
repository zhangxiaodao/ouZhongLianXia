//
//  EnterWorkTowerViewController.m
//  AEFT冷风扇
//
//  Created by 杭州阿尔法特 on 16/3/11.
//  Copyright © 2016年 阿尔法特. All rights reserved.
//

#import "EnterWorkTowerViewController.h"
#import "EnterWorkTowerFirsetView.h"
#import "EnterFirstTableViewCell.h"
#import "EnterSecondTableViewCell.h"
#import "EnterThirtTableViewCell.h"
#import "EnterForthTableViewCell.h"
#import "HistoryViewController.h"
#import "ExchangeCollectionViewController.h"
#import "MainViewController.h"
#import "ThirtView.h"
#import "DingShiYuYueCell.h"
@interface EnterWorkTowerViewController ()<UITableViewDataSource , UITableViewDelegate , HelpFunctionDelegate , ModelDelegate , WindTypeDelegate , StateTypeDelegate>
@property (nonatomic , strong) UITableView *tableView;
@property (nonatomic , strong) NSMutableArray *kongZhiTaiArray;
@property (nonatomic , strong) UIImageView *imageVIew;
@property (nonatomic , strong) NSArray *modelArray;
@property (nonatomic , strong) NSArray *windArray;
@property (nonatomic , strong) NSArray *baiFnegArray;
@property (nonatomic , strong) NSArray *uvShaJunArray;
@property (nonatomic , strong) NSArray *tongSuoArray;
@property (nonatomic , strong) NSArray *switchArray;
@property (nonatomic , strong) NSArray *zhiLengArray;
@property (nonatomic , strong) NSMutableArray *stateArray;
@property (nonatomic , strong) EnterWorkTowerFirsetView *firstBackView;

@property (nonatomic , strong) UILabel *modelLable;
@property (nonatomic , strong) UILabel *windLable;
@property (nonatomic , strong) UILabel *baiFengLable;
@property (nonatomic , strong) UILabel *zhiLengLable;

@property (nonatomic , strong) UIView *backView;

@property (nonatomic , strong) NSMutableDictionary *dic;
@property (nonatomic , copy) NSString *isAnimation;

@property (nonatomic , strong) UIView *placeholderView;
@end


static NSString *firstCelled = @"first";
static NSString *secondCelled = @"second";
static NSString *thirtCelled = @"thirt";
static NSString *forthCelled = @"forth";
static NSString *fifthCelled = @"fifth";


@implementation EnterWorkTowerViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.automaticallyAdjustsScrollViewInsets = NO;
    
//    [kApplicate initLa stEnterWorkViewController:self];

    self.imageVIew = [[UIImageView alloc]initWithFrame:kScreenFrame];
    [self.view insertSubview:self.imageVIew atIndex:0];
   
    [self setUI];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getLengFengShanFunction:) name:kServiceOrder object:nil];
    [self requestServiceState];
    
}

- (void)requestServiceState {
    NSDictionary *parames = @{@"devSn" : self.serviceModel.devSn , @"devTypeSn" : self.serviceModel.devTypeSn};
    
    [HelpFunction requestDataWithUrlString:kChaXunLengFengShanDangQianZhuangTai andParames:parames andDelegate:self];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    
    self.isAnimation = @"YES";
    
    
    if ([kStanderDefault objectForKey:@"kongZhiTai"]) {
        NSNumber *aa = [kStanderDefault objectForKey:@"kongZhiTai"];
        self.imageVIew.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@" , [self.kongZhiTaiArray objectAtIndex:[aa integerValue]]]];
    } else {
        self.imageVIew.image = [UIImage imageNamed:@"工作台背景1.jpg"];
    }

    
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    
    [[NSNotificationCenter defaultCenter]postNotification:[NSNotification notificationWithName:@"offBtn" object:self userInfo:[NSDictionary dictionaryWithObject:@(self.offBtn.tag) forKey:@"offBtn"]]];
    
}

#pragma mark - 代理返回数据
- (void)requestData:(HelpFunction *)request didSuccess:(NSDictionary *)dddd {
    
//    NSLog(@"%@" , dddd);
    if ([dddd[@"data"] isKindOfClass:[NSDictionary class]]) {
        NSDictionary *dic = dddd[@"data"];
        
        self.stateModel = [[StateModel alloc]init];
        
        for (NSString *key in [dic allKeys]) {
            [self.stateModel setValue:dic[key] forKey:key];
        }
        
        if (self.stateModel.fSwitch == 2 || self.stateModel.fSwitch == 0) {
            self.offBtn.alpha = 0.4;
            self.offBtn.tag = 2;
            [self.offBtn addTarget:self action:@selector(openLFSAtcion:) forControlEvents:UIControlEventTouchUpInside];
        } else if (self.stateModel.fSwitch == 1){
            self.offBtn.alpha = 1.0;
            self.offBtn.tag = 1;
            [self.offBtn addTarget:self action:@selector(closeLFSAtcion:) forControlEvents:UIControlEventTouchUpInside];
        }
        
        self.firstBackView.stateArray = self.stateArray;
        
        [self.tableView reloadData];
    }
}

- (void)requestData:(HelpFunction *)request didFailLoadData:(NSError *)error {
    NSLog(@"%@" , error);
}

- (void)drawStateView {
    self.firstBackView = [EnterWorkTowerFirsetView creatViewWithColor:[UIColor clearColor] withSuperView:self.placeholderView];
    [self.firstBackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.backView.mas_bottom);
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(kScreenW, kScreenH / 5.558333));
    }];
    
    self.offBtn = self.firstBackView.subviews[9];
    self.modelLable = self.firstBackView.subviews[1];
    self.windLable = self.firstBackView.subviews[3];
    self.baiFengLable = self.firstBackView.subviews[5];
    self.zhiLengLable = self.firstBackView.subviews[7];
    
    
    
}

- (void)setNavView {
    self.backView = [UIView creatViewWithBackView:[UIImage imageNamed:@"iconfont-fanhui"] andSuperView:self.view];
    [self.backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(kScreenW / 30);
        make.top.mas_equalTo(kScreenH / 33.35);
        make.size.mas_equalTo(CGSizeMake(kScreenH / 31.7619, kScreenH / 31.7619));
    }];
    UITapGestureRecognizer *backTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(backTap:)];
    [self.backView addGestureRecognizer:backTap];
    
    UIView *titleView = [UIView creatViewWithBackViewandTitle:@"控制台" andSuperView:self.view];
    [titleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.centerY.mas_equalTo(self.backView.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(kScreenW / 5, kScreenH / 31.7619));
    }];
    
    
    UIImageView *huanTuPianView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"iconfont-tupian"]];
    [self.view addSubview:huanTuPianView];
    
    huanTuPianView = [UIImageView setImageViewColor:huanTuPianView andColor:[UIColor whiteColor]];
    huanTuPianView.userInteractionEnabled = YES;
    [huanTuPianView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-kScreenW / 30);
        make.centerY.mas_equalTo(titleView.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(kScreenH / 31.7619, kScreenH / 31.7619));
    }];
    UITapGestureRecognizer *huanTuPianTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(huanTuPianTap:)];
    [huanTuPianView addGestureRecognizer:huanTuPianTap];
}

#pragma mark - 设置UI
- (void)setUI{
    
    [self setNavView];
    self.placeholderView = [[UIView alloc]init];
    [self.view addSubview:self.placeholderView];
    [self.placeholderView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.backView.mas_bottom);
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(kScreenW, kScreenH / 5.558333));
    }];
    
    [self drawStateView];
    
    UIView *view = [[UIView alloc]init];
    view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:view];
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.top.mas_equalTo(self.placeholderView.mas_bottom);
        make.size.mas_equalTo(CGSizeMake(kScreenW, 1));
    }];
    
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    self.tableView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:self.tableView];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView setTableHeaderView:[[UIView alloc]initWithFrame:CGRectMake(0, 0, 0, 0.1)]];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.placeholderView.mas_bottom);
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(self.view.mas_right);
        make.bottom.mas_equalTo(self.view.mas_bottom);
    }];
    
    [self setTableViewRegisterCell];
    
    for (int i = 1; i < 3; i++) {
        [self.dic setValue:@(0) forKey:[NSString stringWithFormat:@"%d" , i]];
    }
    
    UISwipeGestureRecognizer *swipGesture = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(swipAtcion:)];
    [self.view addGestureRecognizer:swipGesture];
    
}

#pragma mark - 有滑到主页
- (void)swipAtcion:(UISwipeGestureRecognizer *)swipe {
    [self.navigationController popViewControllerAnimated:YES];
    
}



#pragma mark - 返回主界面
- (void)backTap:(UITapGestureRecognizer *)tap {
    [self.navigationController popViewControllerAnimated:YES];
}


#pragma mark - 开关的点击事件
- (void)openLFSAtcion:(UIButton *)btn {
    
    self.offBtn.tag = 1;
    self.isAnimation = @"NO";
    [kSocketTCP sendDataToHost:[NSString stringWithFormat:@"HMFF%@%@S1#", self.serviceModel.devTypeSn,self.serviceModel.devSn] andType:kZhiLing andIsNewOrOld:kOld];
    NSIndexSet *indexSet = [[NSIndexSet alloc]initWithIndex:0];
    [self.tableView reloadSections:indexSet withRowAnimation:UITableViewRowAnimationNone];
        
}

- (void)closeLFSAtcion:(UIButton *)btn {
    self.offBtn.tag = 2;
    self.isAnimation = @"NO";
    
    [kSocketTCP sendDataToHost:[NSString stringWithFormat:@"HMFF%@%@S0#", self.serviceModel.devTypeSn,self.serviceModel.devSn] andType:kZhiLing andIsNewOrOld:kOld];
   
    NSIndexSet *indexSet = [[NSIndexSet alloc]initWithIndex:0];
    [self.tableView reloadSections:indexSet withRowAnimation:UITableViewRowAnimationNone];
}

#pragma mark - 取得tcp返回的数据
- (void)getLengFengShanFunction:(NSNotification *)post {
    NSString *str = post.userInfo[@"Message"];
    
    if (str.length != 42) {
        return;
    }
    
    NSString *kaiGuan = [str substringWithRange:NSMakeRange(26, 2)];
    NSString *devSn = [str substringWithRange:NSMakeRange(12, 12)];
    if ([self.serviceModel.devSn isEqualToString:devSn]) {
        if ([kaiGuan isEqualToString:@"01"]) {
            
            self.offBtn.alpha = 1.0;
            
            [self.offBtn removeTarget:self action:@selector(openLFSAtcion:) forControlEvents:UIControlEventTouchUpInside];
            [self.offBtn addTarget:self action:@selector(closeLFSAtcion:) forControlEvents:UIControlEventTouchUpInside];
        } else if ([kaiGuan isEqualToString:@"02"]) {
            
            self.offBtn.alpha = 0.4;
            
            [self.offBtn removeTarget:self action:@selector(closeLFSAtcion:) forControlEvents:UIControlEventTouchUpInside];
            [self.offBtn addTarget:self action:@selector(openLFSAtcion:) forControlEvents:UIControlEventTouchUpInside];
        }
        
        
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
        
        if (section == 1 || section == 2) {
            NSArray *imageArray = @[@"iconfont-dingshi" , @"iconfont-linechart"];
            NSArray *nameArray = @[@"定时预约" , @"历史数据"];
            UIView *view  = [ThirtView creatViewWithIconArray:imageArray andNameArray:nameArray andSection:(section - 1)];
            view.tag = section;
            view.backgroundColor = [UIColor clearColor];
            view.userInteractionEnabled = YES;
            
            UIImageView *imageView = view.subviews[0];
            imageView.tintColor = [UIColor whiteColor];
            
            UILabel *lable = view.subviews[1];
            lable.textColor = [UIColor whiteColor];
            
            
            UIImageView *jianTouImageView = view.subviews[2];
            jianTouImageView.tintColor = [UIColor whiteColor];
            
            UIView *zheGaiView = [[UIView alloc] init];
            zheGaiView.backgroundColor = [UIColor whiteColor];
            zheGaiView.layer.opacity = 0.2;
            [view addSubview:zheGaiView];
            [zheGaiView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.size.mas_equalTo(CGSizeMake(kScreenW - kScreenW / 10, (kScreenH / 20) * 3 / 4));
                make.left.mas_equalTo(view.mas_left).offset(kScreenW / 20);
                make.centerY.mas_equalTo(view.mas_centerY);
            }];
            
            
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction222:)];
            [view addGestureRecognizer:tap];
            return view;

        } else {
            return nil;
        }
}

#pragma mark - 分区头的点击事件
- (void)tapAction222:(UITapGestureRecognizer *)tap
{
    NSString *section = [NSString stringWithFormat:@"%ld" , tap.view.tag];
    
    if ([section isEqualToString:@"2"]) {
        HistoryViewController *historyVC = [[HistoryViewController alloc]init];
        historyVC.userModel = [[UserModel alloc]init];
        historyVC.userModel = self.model;
        historyVC.serviceDataModel = [[ServicesDataModel alloc]init];
        historyVC.serviceDataModel = self.serviceDataModel;
        
        historyVC.serviceModel = [[ServicesModel alloc]init];
        historyVC.serviceModel = self.serviceModel;
        
        historyVC.sumBingJingTime = kLengFengShanBingJing;
        historyVC.deviceSn = self.serviceModel.devSn;
        [self.navigationController pushViewController:historyVC animated:YES];
    } else {
        if ([self.dic[section] integerValue] == 0) {
            [self.dic setValue:@(1) forKey:section];
        } else{
            [self.dic setValue:@(0) forKey:section];
        }
        NSIndexSet *set = [NSIndexSet indexSetWithIndex:tap.view.tag];
        [self.tableView reloadSections:set withRowAnimation:UITableViewRowAnimationFade];
    }
    
    
    
}

- (void)sendTheModelType:(NSString *)modelType {
    self.modelLable.text = modelType;
}

- (void)sendWindType:(NSString *)windType {
    self.windLable.text = windType;
}

- (void)sendStateType:(NSArray *)stateTypeArray {
    self.zhiLengLable.text = stateTypeArray[0];
    self.baiFengLable.text = stateTypeArray[1];
}

- (void)setTableViewRegisterCell {
    [self.tableView registerClass:[EnterFirstTableViewCell class] forCellReuseIdentifier:firstCelled];
    [self.tableView registerClass:[EnterThirtTableViewCell class] forCellReuseIdentifier:secondCelled];
    [self.tableView registerClass:[EnterSecondTableViewCell class] forCellReuseIdentifier:thirtCelled];
    [self.tableView registerClass:[EnterThirtTableViewCell class] forCellReuseIdentifier:forthCelled];
    [self.tableView registerClass:[DingShiYuYueCell class] forCellReuseIdentifier:fifthCelled];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.section == 0) {
        
        if (indexPath.row == 0) {
            
            EnterFirstTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:firstCelled];
            cell.currentVC = self;
            cell.serviceModel =  self.serviceModel;
            cell.isAnimation = self.isAnimation;
            cell.model = self.stateModel;
            if (self.offBtn.tag == 2) {
                cell.userInteractionEnabled = NO;
            }
            cell.delegate = self;
            
            return cell;
        } else if (indexPath.row == 1) {
            
            EnterThirtTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:secondCelled];
            
            cell.serviceModel = self.serviceModel;
            cell.model = self.stateModel;
            if (self.offBtn.tag == 2) {
                cell.userInteractionEnabled = NO;
            }
            cell.delegate = self;
            
            return cell;
        }  else {
            
            EnterSecondTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:thirtCelled];
            
            cell.serviceModel =  self.serviceModel;
            cell.isAimation = self.isAnimation;
            cell.model = self.stateModel;
            if (self.offBtn.tag == 2) {
                cell.userInteractionEnabled = NO;
            }
            cell.delegate = self;

            return cell;
        }
    } else {
        
        DingShiYuYueCell *cell = [tableView dequeueReusableCellWithIdentifier:fifthCelled];
     
        cell.currentVC = self;
        cell.serviceModel = [[ServicesModel alloc]init];
        cell.serviceModel =  self.serviceModel;
        
        return cell;
        
    }
}

#pragma mark - cell将要显示
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    cell.backgroundColor = [UIColor clearColor];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 1) {
        return kScreenH / 2 + kScreenW / 10 + 30;
    } else {
        return kScreenH / 4.6;
    }
    
}

#pragma mark - 分区头的高度
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 1 || section == 2) {
        return  kScreenH / 20;
    } else {
        return 0;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 1 || section == 2) {
        NSString *key = [NSString stringWithFormat:@"%ld" , (long)section];
        if ([self.dic[key] integerValue] == 1) {
            return 1;
        }
        return 0;

    } else {
        return 3;
    }
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 3;
}


- (NSMutableArray *)kongZhiTaiArray{
    if (!_kongZhiTaiArray) {
        self.kongZhiTaiArray = [NSMutableArray arrayWithObjects:@"控制台1.jpg", @"控制台2.jpg" , @"控制台3.jpg", @"工作台背景1.jpg" , @"壁纸1.jpg" , @"壁纸2.jpg" , @"壁纸3.jpg" , @"壁纸4.jpg" , @"壁纸5.jpg" , @"壁纸6.jpg" , nil];
    }
    return _kongZhiTaiArray;
}

- (NSMutableDictionary *)dic {
    if (!_dic) {
        _dic = [NSMutableDictionary dictionary];
    }
    return _dic;
}

- (NSArray *)zhiLengArray {
    if (!_zhiLengArray) {
        _zhiLengArray = [NSArray arrayWithObjects:@"关闭", @"制冷" , nil];
    }
    return _zhiLengArray;
}

- (NSArray *)switchArray {
    if (!_switchArray) {
        _switchArray = [NSArray arrayWithObjects:@"关闭",@"开启" , nil];
    }
    return _switchArray;
}

- (NSMutableArray *)stateArray {
    if (!_stateArray) {
        _stateArray = [NSMutableArray array];
        [_stateArray addObject:[NSString stringWithFormat:@"%@" , self.modelArray[self.stateModel.fMode]]];
        [_stateArray addObject:[NSString stringWithFormat:@"%@" , self.windArray[self.stateModel.fWind]]];
        [_stateArray addObject:[NSString stringWithFormat:@"%@" , self.switchArray[self.stateModel.fSwing]]];
        [_stateArray addObject:[NSString stringWithFormat:@"%@" , self.zhiLengArray[self.stateModel.fCold]]];
        [_stateArray addObject:self.baiFnegArray[self.stateModel.fSwitch]];
        [_stateArray addObject:[NSString stringWithFormat:@"%@" , self.uvShaJunArray[self.stateModel.fUV]]];
        [_stateArray addObject:[NSString stringWithFormat:@"%@" , self.tongSuoArray[self.stateModel.fLock]]];
    }
    return _stateArray;
}

- (NSArray *)modelArray {
    if (!_modelArray) {
        _modelArray = [NSArray arrayWithObjects: @"未开",@"正常", @"自然" , @"睡眠" ,  nil];
    }
    return _modelArray;
}

- (NSArray *)windArray {
    if (!_windArray) {
        _windArray = [NSArray arrayWithObjects: @"未开", @"低速", @"中速" , @"高速" , nil];
    }
    return _windArray;
}

- (NSArray *)baiFnegArray {
    if (!_baiFnegArray) {
        _baiFnegArray = [NSArray arrayWithObjects:@"关闭", @"开启" ,  nil];
    }
    return _baiFnegArray;
}

- (NSArray *)uvShaJunArray {
    if (!_uvShaJunArray) {
        _uvShaJunArray = [NSArray arrayWithObjects:@"关闭", @"开启" , nil];
    }
    return _uvShaJunArray;
}

- (NSArray *)tongSuoArray {
    if (!_tongSuoArray) {
        _tongSuoArray = [NSArray arrayWithObjects:@"关闭", @"开启" , nil];
    }
    return _tongSuoArray;
}



#pragma mark - 更换图片
- (void)huanTuPianTap:(UITapGestureRecognizer *)tap {
    ExchangeCollectionViewController *exchangeVC = [[UIStoryboard storyboardWithName:@"ExchangeCollectionViewController" bundle:nil] instantiateViewControllerWithIdentifier:@"ExchangeCollectionViewController"];
    exchangeVC.fromEnterVC = [NSString stringWithFormat:@"1"];
    
    [self.navigationController pushViewController:exchangeVC animated:YES];
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
