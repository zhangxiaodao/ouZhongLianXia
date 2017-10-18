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
#import "SetServicesViewController.h"
#import "LengFengShanMainBaseCell.h"

static NSString *bingJing = @"bingJing";
static NSString *water = @"water";
static NSString *lvWang = @"lvWang";

@interface LengFengShanViewController ()< UITableViewDataSource , UITableViewDelegate>

@property (nonatomic , strong) NSMutableDictionary *dic;
@end

@implementation LengFengShanViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUI];
    [self addNotification];
}

#pragma mark - 通知事件
- (void)addNotification {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getBingJing:) name:@"bingJing" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getShuiWei:) name:@"ShuiWei" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getLvWang:) name:@"lvWang" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getLengFengShanInfo:) name:kServiceOrder object:nil];
}

- (void)setUI {
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerClass:[BingJingShouMingTableViewCell class] forCellReuseIdentifier:bingJing];
    [self.tableView registerClass:[ShuiWeiZhuangTaiTableViewCell class] forCellReuseIdentifier:water];
    [self.tableView registerClass:[LvWangJieDuTableViewCell class] forCellReuseIdentifier:lvWang];
    
    for (int i = 0; i < 5; i++) {
        [self.dic setValue:@(0) forKey:[NSString stringWithFormat:@"%d" , i]];
    }
        
}

#pragma mark - 开关按钮的点击事件
- (void)lengFengShanOpenAtcion {
    
    if (self.bottomBtn.selected == 1) {
        [kStanderDefault setObject:@"NO" forKey:@"offBtn"];
        [kSocketTCP sendDataToHost:[NSString stringWithFormat:@"HMFF%@%@S0#", self.serviceModel.devTypeSn,self.serviceModel.devSn] andType:kZhiLing andIsNewOrOld:kOld];
    } else {
        [kStanderDefault setObject:@"YES" forKey:@"offBtn"];
        [kSocketTCP sendDataToHost:[NSString stringWithFormat:@"HMFF%@%@S1#", self.serviceModel.devTypeSn,self.serviceModel.devSn] andType:kZhiLing andIsNewOrOld:kOld];
    }
    self.bottomBtn.selected = !self.bottomBtn.selected;
    
}

#pragma mark - 取得tcp返回的数据
- (void)getLengFengShanInfo:(NSNotification *)post {
    NSString *str = post.userInfo[@"Message"];
    
    if (str.length != 42) {
        return;
    }
    
    NSString *kaiGuan = [str substringWithRange:NSMakeRange(26, 2)];
    NSString *devSn = [str substringWithRange:NSMakeRange(12, 12)];
    
    if ([self.serviceModel.devSn isEqualToString:devSn]) {
        if ([kaiGuan isEqualToString:@"02"]) {
            self.bottomBtn.backgroundColor = [UIColor grayColor];
        } else if ([kaiGuan isEqualToString:@"01"]) {
            self.bottomBtn.backgroundColor = kMainColor;
        }
    }
}


#pragma mark - 轻扫手势触发方法
-(void)leftSwipeAtcion:(UISwipeGestureRecognizer *)sender
{
    EnterWorkTowerViewController *enterVC = [[EnterWorkTowerViewController alloc]init];
    enterVC.model = self.userModel;
    enterVC.serviceDataModel = self.serviceDataModel;
    enterVC.serviceModel = self.serviceModel;
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

#pragma mark - table的代理
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    
    if (section == 0) {
        
        UIView *view = [FirstSectionView creatViewWithFenChen:self.serviceDataModel.totalTime andTemperature:self.serviceDataModel.totalC andTime:self.serviceDataModel.totalTime];
        
        view.tag = section;
        return view;
    } else {
        NSArray *imageArray = @[@"iconfont-jiankanglvxin",@"iconfont-jiankang",@"iconfont-jiankangqingsao"];
        NSArray *nameArray = @[@"冰晶寿命",@"水位状态",@"水帘洁度"];
        
        UIView *view = [ThirtView creatViewWithIconArray:imageArray andNameArray:nameArray andSection:section andColor:[UIColor grayColor]];
        view.backgroundColor = kWhiteColor;
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
        BingJingShouMingTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:bingJing];
        cell.serviceModel = self.serviceModel;
        cell.alertVC = self;
        cell.cellType = CellTypeBingJing;
        cell.nowUserTime = self.stateModel.sChangeFilterScreen;
        return cell;
    } else if (indexPath.section == 2 && indexPath.row == 0) {
        ShuiWeiZhuangTaiTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:water];
        cell.serviceModel = self.serviceModel;
        cell.alertVC = self;
        cell.cellType = CellTypeShuiWei;
        cell.userWaterData = self.serviceDataModel.waterStateTime;
        return cell;
    } else  {
        LvWangJieDuTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:lvWang];
        cell.serviceModel = self.serviceModel;
        cell.alertVC = self;
        cell.cellType = CellTypeLvWang;
        cell.totalTime = self.serviceDataModel.totalTime;
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
- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
