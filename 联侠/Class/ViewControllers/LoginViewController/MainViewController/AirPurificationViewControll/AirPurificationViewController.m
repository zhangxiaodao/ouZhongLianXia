//
//  AirPurificationViewController.m
//  联侠
//
//  Created by 杭州阿尔法特 on 16/5/27.
//  Copyright © 2016年 张海昌. All rights reserved.
//

#import "AirPurificationViewController.h"
#import "AirThirtTableViewCell.h"
#import "ThirtView.h"
#import "BingJingShouMingTableViewCell.h"
#import "LvWangJieDuTableViewCell.h"
#import "AirPurificationFirstTableViewCell.h"
#import "AirPurificationForthTableViewCell.h"
#import "AirPurificationThirtTableViewCell.h"
#import "AirPurificationFifthTableViewCell.h"


#define kBtnW (((kScreenW - kScreenW / 8) / 4) - 5)
@interface AirPurificationViewController ()<UITableViewDataSource , UITableViewDelegate>
@property (nonatomic , copy) NSString *isAnimation;
@property (nonatomic , strong) NSMutableDictionary *dic;
@property (nonatomic , copy)  NSString *lvWangJieDu;
@property (nonatomic , copy)  NSString *gengHaunLvWang;
@end

static NSString *firstCelled = @"first";
static NSString *secondCelled = @"second";
static NSString *thirtCelled = @"thirt";
static NSString *forthCelled = @"forth";
static NSString *fifthCelled = @"fifth";
static NSString *sexthCelled = @"sexedth";
static NSString *seventhCelled = @"seventhCelled";
@implementation AirPurificationViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self addNotification];
    
    [self setUI];
}

- (void)getKongJingIsChongZhi:(NSNotification *)post {
    if ([post.userInfo[@"KongJingIsChongZhi"] isEqualToString:@"YES"]) {
        [self.tableView reloadData];
    }
}

- (void)addNotification {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getKongJingDataMain:) name:kServiceOrder object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getKongJingIsChongZhi:) name:@"KongJingIsChongZhi" object:nil];
}

- (void)setUI {
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.isAnimation = @"YES";
    
    
    [self setTableViewRegisterCell];
    
}

#pragma mark - 注册tableViewCell
- (void)setTableViewRegisterCell {
    [self.tableView registerClass:[AirPurificationFirstTableViewCell class] forCellReuseIdentifier:firstCelled];
    [self.tableView registerClass:[AirPurificationThirtTableViewCell class] forCellReuseIdentifier:secondCelled];
    [self.tableView registerClass:[AirPurificationForthTableViewCell class] forCellReuseIdentifier:thirtCelled];
    [self.tableView registerClass:[AirPurificationFifthTableViewCell class] forCellReuseIdentifier:forthCelled];
    [self.tableView registerClass:[AirThirtTableViewCell class] forCellReuseIdentifier:fifthCelled];
    [self.tableView registerClass:[BingJingShouMingTableViewCell class] forCellReuseIdentifier:sexthCelled];
    [self.tableView registerClass:[LvWangJieDuTableViewCell class] forCellReuseIdentifier:seventhCelled];
    self.dic = [NSMutableDictionary dictionary];
    for (int i = 1; i < 3; i++) {
        [self.dic setValue:@(0) forKey:[NSString stringWithFormat:@"%d" , i]];
    }
}

- (void)kongQiJingHuaQiOpenAtcion:(UIButton *)btn {
    
    if (btn.selected == 1) {
        [kStanderDefault setObject:@"NO" forKey:@"offBtn"];
        [kSocketTCP sendDataToHost:[NSString stringWithFormat:@"HMFF%@%@S2#", self.serviceModel.devTypeSn,self.serviceModel.devSn] andType:kZhiLing andIsNewOrOld:kOld];
    } else {
        [kStanderDefault setObject:@"YES" forKey:@"offBtn"];
        [kSocketTCP sendDataToHost:[NSString stringWithFormat:@"HMFF%@%@S1#", self.serviceModel.devTypeSn,self.serviceModel.devSn] andType:kZhiLing andIsNewOrOld:kOld];
    }
    btn.selected = !btn.selected;
}

#pragma mark - 取得tcp返回的数据
- (void)getKongJingDataMain:(NSNotification *)post {
    NSString *str = post.userInfo[@"Message"];
    if (str.length != 56) {
        return ;
    }
    NSString *kaiGuan = [str substringWithRange:NSMakeRange(26, 2)];
    NSString *devSn = [str substringWithRange:NSMakeRange(12, 12)];
//    NSLog(@"%@ , %@" , kaiGuan , str);
    
    if ([self.serviceModel.devSn isEqualToString:devSn]) {
        if ([kaiGuan isEqualToString:@"02"]) {
            
            self.bottomBtn.backgroundColor = [UIColor grayColor];

        } else if ([kaiGuan isEqualToString:@"01"]) {
            self.bottomBtn.backgroundColor = kKongJingYanSe;
        }

        [[NSNotificationCenter defaultCenter] postNotification:[NSNotification notificationWithName:@"AnNiuZhuangTai" object:self userInfo:@{@"AnNiuZhuangTai" : @(self.bottomBtn.selected)}]];
    }
}

- (void)swipeGesture:(UISwipeGestureRecognizer *)swipe {
    return ;
}

#pragma mark - 生成cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            AirPurificationFirstTableViewCell *cell
            =[tableView dequeueReusableCellWithIdentifier:firstCelled];
            cell.stateModel = self.stateModel;
            return cell;
        } else if (indexPath.row == 1) {
            AirPurificationThirtTableViewCell *cell
            =[tableView dequeueReusableCellWithIdentifier:secondCelled];
            
            if (self.serviceModel) {
                cell.serviceModel = self.serviceModel;
            }
            cell.stateModel = self.stateModel;
            cell.serviceDataModel = self.serviceDataModel;
            
            return cell;
        } else if (indexPath.row == 2) {
            
            AirPurificationForthTableViewCell *cell
            =[tableView dequeueReusableCellWithIdentifier:thirtCelled];
         
            cell.serviceModel = self.serviceModel;
            cell.stateModel = self.stateModel;
            cell.buttonSelected = @(self.bottomBtn.selected);
            return cell;
        } else if (indexPath.row == 3 ){
            AirPurificationFifthTableViewCell *cell
            =[tableView dequeueReusableCellWithIdentifier:forthCelled];
            cell.serviceModel = self.serviceModel;
            cell.vc = self;
            cell.buttonSelected = @(self.bottomBtn.selected);
            
            return cell;
        } else {
            AirThirtTableViewCell *cell
            =[tableView dequeueReusableCellWithIdentifier:fifthCelled];
            cell.airVC = self;
            cell.model = self.userModel;
            if (self.serviceModel) {
                cell.serviceModel = self.serviceModel;
            }
            cell.serviceDataModel = self.serviceDataModel;
            cell.stateModel = self.stateModel;
            
            return cell;
        }
    }  else if (indexPath.section == 1 && indexPath.row == 0){
        BingJingShouMingTableViewCell *cell
        =[tableView dequeueReusableCellWithIdentifier:sexthCelled];
        cell.isKongJing = @"YES";
        cell.serviceModel = self.serviceModel;
        cell.alertVC = self;
        cell.cellType = CellTypeBingJing;
        cell.nowUserTime = self.stateModel.sChangeFilterScreen;
        
        return cell;
    } else {
        LvWangJieDuTableViewCell *cell
        =[tableView dequeueReusableCellWithIdentifier:seventhCelled];
        cell.isKongJing = @"YES";
        cell.serviceModel = self.serviceModel;
        cell.alertVC = self;
        cell.cellType = CellTypeLvWang;
        cell.totalTime = self.serviceDataModel.totalTime;
        
        return cell;
    }
    
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    if (section == 0) {
        UIView *view = [[UIView alloc]init];
        view.backgroundColor = kWhiteColor;
        
        return view;
    } else {
     
        
        NSArray *imageArray = @[@"iconfont-jiankanglvxin" , @"iconfont-jiankangqingsao"];
        NSArray *nameArray = @[@"滤网寿命" , @"滤网洁度"];
        
        UIView *view = [ThirtView creatViewWithIconArray:imageArray andNameArray:nameArray andSection:section andColor:kKongJingYanSe];
        view.backgroundColor = kWhiteColor;
        view.tag = section;
        
        view.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
        [view addGestureRecognizer:tap];
        return view;
        
    }
    
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

#pragma mark - 分区头的高度
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 1 || section == 2 ) {
        return  kScreenH / 15;
    } else {
        return 1;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *view = [[UIView alloc]init];
    view.backgroundColor = [UIColor lightGrayColor];
    return view;
}
#pragma mark - 尾部的高度
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.5;
}

#pragma mark - cell的高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            return kScreenH / 2.5;
        } else if (indexPath.row == 1) {
            return kScreenH / 2.8;
        } else if (indexPath.row == 2) {
            return kScreenH / 3;
        } else if (indexPath.row == 3) {
            return kScreenH * 4 / 9.57142 + kScreenH / 13.34 + 10;
        } else {
            return kBtnW * 2 + kBtnW * 3 / 4;
        }
    }  else {
        return kScreenH / 5;
    }
}
#pragma mark - cell的个数
- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 1 || section == 2 ) {
        NSString *key = [NSString stringWithFormat:@"%ld" , (long)section];
        if ([self.dic[key] integerValue] == 1) {
            return 1;
        }
        return 0;
        
    } else {
        return 5;
    }
}

#pragma mark - 分区的个数
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}
- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
