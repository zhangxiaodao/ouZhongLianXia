//
//  LengFengShanViewController.m
//  联侠
//
//  Created by 杭州阿尔法特 on 16/5/27.
//  Copyright © 2016年 张海昌. All rights reserved.
//

#import "LengFengShanViewController.h"
#import "FirstSectionView.h"
#import "ThirtView.h"
#import "ShuiWeiZhuangTaiTableViewCell.h"
#import "LvWangJieDuTableViewCell.h"
#import "BingJingShouMingTableViewCell.h"
#import "EnterWorkTowerViewController.h"


#import "BottomNavViewController.h"

@interface LengFengShanViewController ()<HelpFunctionDelegate , UITableViewDataSource , UITableViewDelegate>

@property (nonatomic , assign) NSInteger sumShuiWei;
@property (nonatomic , assign) NSInteger shuiWei;
@property (nonatomic , assign) NSInteger sumLVWang;
@property (nonatomic , assign) NSInteger sumBingJingTime;
@property (nonatomic , strong) NSMutableDictionary *dic;
@end

@implementation LengFengShanViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.sumShuiWei = 720;
    self.sumLVWang = 700;
    self.sumBingJingTime = 2400;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getBingJing:) name:@"bingJing" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getShuiWei:) name:@"ShuiWei" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getLvWang:) name:@"lvWang" object:nil];
    
    
    [self setUI];
}

- (void)viewWillDisappear:(BOOL)animated {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"LFSTableView" object:nil];
    
}

- (void)setUI {
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getDate111:) name:@"4131" object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getDate111:) name:@"4132" object:nil];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    
    for (int i = 0; i < 5; i++) {
        [self.dic setValue:@(0) forKey:[NSString stringWithFormat:@"%d" , i]];
    }
    
    

    [self.view addSubview:self.tiShiView];
    
}

#pragma mark - 知道了
- (void)zhiDaoLeAtcion:(UIButton *)btn {
    
    [kStanderDefault setObject:@"YES" forKey:@"first"];

    self.tiShiView.hidden = YES;
    [self.tiShiView removeFromSuperview];
}

- (void)xxxxAtcion:(UIButton *)btn {
    [kStanderDefault setObject:@"NO" forKey:@"offBtn"];
    [kSocketTCP sendDataToHost:[NSString stringWithFormat:@"HMFF%@%@S0#", self.serviceModel.devTypeSn,self.serviceModel.devSn] andType:kZhiLing andIsNewOrOld:kOld];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getDate111:) name:@"4131" object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getDate111:) name:@"4132" object:nil];
}

- (void)btnAtcion3333:(UIButton *)btn {
    
    [kStanderDefault setObject:@"YES" forKey:@"offBtn"];
    [kSocketTCP sendDataToHost:[NSString stringWithFormat:@"HMFF%@%@S1#", self.serviceModel.devTypeSn,self.serviceModel.devSn] andType:kZhiLing andIsNewOrOld:kOld];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getDate111:) name:@"4131" object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getDate111:) name:@"4132" object:nil];
}

#pragma mark - 取得tcp返回的数据
- (void)getDate111:(NSNotification *)post {
    NSString *str = post.userInfo[@"Message"];
    
    NSString *kaiGuan = [str substringWithRange:NSMakeRange(26, 2)];
    NSString *devSn = [str substringWithRange:NSMakeRange(12, 12)];
    
    if ([self.serviceModel.devSn isEqualToString:devSn]) {
        if ([kaiGuan isEqualToString:@"02"]) {
            [self.bottomBtn removeTarget:nil action:nil forControlEvents:UIControlEventTouchUpInside];
            self.bottomBtn.backgroundColor = [UIColor grayColor];
            [self.bottomBtn addTarget:self action:@selector(btnAtcion3333:) forControlEvents:UIControlEventTouchUpInside];
        } else if ([kaiGuan isEqualToString:@"01"]) {
            [self.bottomBtn removeTarget:nil action:nil forControlEvents:UIControlEventTouchUpInside];
            self.bottomBtn.backgroundColor = kMainColor;
            [self.bottomBtn addTarget:self action:@selector(xxxxAtcion:) forControlEvents:UIControlEventTouchUpInside];
        }
        
    }
}


#pragma mark - 轻扫手势触发方法
-(void)swipeGesture:(UISwipeGestureRecognizer *)sender
{
    
    EnterWorkTowerViewController *enterVC = [[EnterWorkTowerViewController alloc]init];
    enterVC.model = [[UserModel alloc]init];
    enterVC.model = self.userModel;
    
    enterVC.serviceDataModel = [[ServicesDataModel alloc]init];
    enterVC.serviceDataModel = self.serviceDataModel;
    
    enterVC.serviceModel = [[ServicesModel alloc]init];
    enterVC.serviceModel = self.serviceModel;
    
    enterVC.sumBingJingTime = self.sumBingJingTime;
    enterVC.deviceSn = [NSString stringWithString:self.serviceModel.devSn];
    
    [self.navigationController pushViewController:enterVC animated:YES];
}



#pragma mark - 复位通知传值
- (void)getBingJing:(NSNotification *)post {
    if ([post.userInfo[@"bingJing"] isEqualToString:@"YES"]) {
        self.serviceDataModel.iceCrystalTime = 0;
        [self.tableView reloadData];
        
    }
}

- (void)getShuiWei:(NSNotification *)post {
    if ([post.userInfo[@"ShuiWei"] isEqualToString:@"YES"]) {
        self.serviceDataModel.waterStateTime = 0;
        [self.tableView reloadData];
    }
}

- (void)getLvWang:(NSNotification *)post {
    if ([post.userInfo[@"lvWang"] isEqualToString:@"YES"]) {
        self.serviceDataModel.filterScreenNeat = 0;
        [self.tableView reloadData];
    }
}


#pragma mark - 通知获得offBtn的状态
- (void)getOffBtn:(NSNotification *)post {
    if ([post.userInfo[@"offBtn"] integerValue] == 1) {
        self.bottomBtn.backgroundColor = kMainColor;
        [self.bottomBtn addTarget:self action:@selector(xxxxAtcion:) forControlEvents:UIControlEventTouchUpInside];
    } else if ([post.userInfo[@"offBtn"] integerValue] == 2) {
        self.bottomBtn.backgroundColor = [UIColor grayColor];
        [self.bottomBtn addTarget:self action:@selector(btnAtcion3333:) forControlEvents:UIControlEventTouchUpInside];
    }
}


#pragma mark - table的代理
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    
    if (section == 0) {
        
        UIView *view = [FirstSectionView creatViewWithFenChen:self.serviceDataModel.totalTime andTemperature:self.serviceDataModel.totalC andTime:self.serviceDataModel.totalTime];
        view.tag = section;
        return view;
    } else {
        NSArray *imageArray = [[NSArray alloc]initWithObjects: @"", @"iconfont-jiankanglvxin",@"iconfont-jiankang",@"iconfont-jiankangqingsao", nil];
        NSArray *nameArray = nil;
        
        
        if ([self.serviceModel.devTypeSn isEqualToString:@"4131"]) {
            nameArray = [[NSArray alloc]initWithObjects: @"", @"冰晶寿命",@"水位状态",@"水帘洁度", nil];
        } else {
            nameArray = [[NSArray alloc]initWithObjects:@"",@"冰晶寿命",@"水位状态",@"滤网洁度", nil];
        }
        
        UIView *view = [ThirtView creatViewWithIconArray:imageArray andNameArray:nameArray andSection:section];
        view.backgroundColor = [UIColor whiteColor];
        view.tag = section;
        
        view.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
        [view addGestureRecognizer:tap];
        return view;
    }
}

#pragma mark - tableView的底部图片
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *view = [[UIView alloc]init];
    view.backgroundColor = [UIColor lightGrayColor];
    return view;
}

#pragma mark - 分区头的高度
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return kScreenH / 2.767634;
    } else {
        return  kScreenH / 13.34;
    }
}
#pragma mark - 分区的数量
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 4;
}
#pragma mark - 尾部的高度
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.5;
}
#pragma mark - 分区头的点击事件
- (void)tapAction:(UITapGestureRecognizer *)tap
{
    NSString *section = [NSString stringWithFormat:@"%ld" , tap.view.tag];
    
    if ([self.dic[section] integerValue] == 0) {
        [self.dic setValue:@(1) forKey:section];
    } else{
        [self.dic setValue:@(0) forKey:section];
    }
    NSIndexSet *set = [NSIndexSet indexSetWithIndex:tap.view.tag];
    [self.tableView reloadSections:set withRowAnimation:UITableViewRowAnimationFade];
    
}
#pragma mark - cell的高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return kScreenH / 5;
}
#pragma mark - cell的个数
- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSString *key = [NSString stringWithFormat:@"%ld" , (long)section];
    if ([self.dic[key] integerValue] == 1) {
        
        if (section == 0) {
            return 0;
        }
        return 1;
    }
    return 0;
}
#pragma mark - 生成cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    if (indexPath.section == 1 && indexPath.row == 0) {
        static NSString *cellId1 = @"1";
        BingJingShouMingTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId1];
        if (cell == nil) {
            cell = [[BingJingShouMingTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId1
                    ];
        }
        
        cell.devSn = self.serviceModel.devSn;
        [cell setUIbuJuWithNowUesrTime:self.serviceDataModel.iceCrystalTime andViewController:self];
        return cell;
    }  if (indexPath.section == 2 && indexPath.row == 0) {
        static NSString *cellId2 = @"2";
        ShuiWeiZhuangTaiTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId2];
        if (cell == nil) {
            cell = [[ShuiWeiZhuangTaiTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId2
                    ];
        }
        
        cell.devSn = self.serviceModel.devSn;
        [cell setUIBuJuWith:self.serviceDataModel.waterStateTime andSumShuiWei:self.sumShuiWei andImage:[UIImage imageNamed:@"shuiWei1.png"] andViewController:self];
        return cell;
    } if (indexPath.section == 3 && indexPath.row == 0) {
        static NSString *cellId3 = @"3";
        LvWangJieDuTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId3];
        if (cell == nil) {
            cell = [[LvWangJieDuTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId3
                    ];
        }
        
        cell.devSn = self.serviceModel.devSn;
        NSInteger i = self.serviceDataModel.totalTime / (self.sumLVWang * 3600000);
        
        [cell setZhiZhenView:i andViewController:self];
        return cell;
    } else {
        NSString *celled = @"ceclled";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:celled];
        if (cell == nil) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:celled];
        }
        return cell;
    }
    
}

#pragma mark - 取消cell的选中状态
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];// 取消选中
    //其他代码
}

- (NSMutableDictionary *)dic{
    if (!_dic) {
        self.dic = [NSMutableDictionary dictionary];
    }
    return _dic;
}


@end
