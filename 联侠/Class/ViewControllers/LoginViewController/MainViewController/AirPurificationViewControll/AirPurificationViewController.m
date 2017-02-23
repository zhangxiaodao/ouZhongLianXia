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
@interface AirPurificationViewController ()<HelpFunctionDelegate , UITableViewDataSource , UITableViewDelegate>
@property (nonatomic , copy) NSString *isAnimation;
@property (nonatomic , strong) NSMutableDictionary *dic;
@property (nonatomic , copy)  NSString *lvWangJieDu;
@property (nonatomic , copy)  NSString *gengHaunLvWang;
@end

@implementation AirPurificationViewController
- (NSMutableDictionary *)dic {
    if (!_dic) {
        _dic = [NSMutableDictionary dictionary];
    }
    return _dic;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor clearColor];

    [self setUI];
}

- (void)getKongJingIsChongZhi:(NSNotification *)post {
    if ([post.userInfo[@"KongJingIsChongZhi"] isEqualToString:@"YES"]) {
        [self.tableView reloadData];
    }
}


- (void)setUI {
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getKongJingDataMain:) name:@"4231" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getKongJingIsChongZhi:) name:@"KongJingIsChongZhi" object:nil];
    
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.isAnimation = @"YES";
    
    for (int i = 1; i < 3; i++) {
        [self.dic setValue:@(0) forKey:[NSString stringWithFormat:@"%d" , i]];
    }
    
    
    
    [self.view addSubview:self.tiShiView];
}

#pragma mark - 知道了
- (void)zhiDaoLeAtcion:(UIButton *)btn {
    
    [kStanderDefault setObject:@"YES" forKey:@"first"];

    //    self.view.userInteractionEnabled = YES;
    self.tiShiView.hidden = YES;
    [self.tiShiView removeFromSuperview];
}

- (void)closeAtcion333:(UIButton *)btn {
    [kStanderDefault setObject:@"NO" forKey:@"offBtn"];
    [kSocketTCP sendDataToHost:[NSString stringWithFormat:@"HMFF%@%@S2#", self.serviceModel.devTypeSn,self.serviceModel.devSn] andType:kZhiLing andIsNewOrOld:kOld];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getKongJingDataMain:) name:@"4231" object:nil];
}

- (void)openAtcion3333:(UIButton *)btn {
    
//    NSLog(@"%@ , %@" , self.serviceModel.devSn , self.serviceModel.devTypeSn);
    
    if (btn.selected == 1) {
        [kStanderDefault setObject:@"NO" forKey:@"offBtn"];
        [kSocketTCP sendDataToHost:[NSString stringWithFormat:@"HMFF%@%@S2#", self.serviceModel.devTypeSn,self.serviceModel.devSn] andType:kZhiLing andIsNewOrOld:kOld];
    } else {
        [kStanderDefault setObject:@"YES" forKey:@"offBtn"];
        [kSocketTCP sendDataToHost:[NSString stringWithFormat:@"HMFF%@%@S1#", self.serviceModel.devTypeSn,self.serviceModel.devSn] andType:kZhiLing andIsNewOrOld:kOld];
    }
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getKongJingDataMain:) name:@"4231" object:nil];
    btn.selected = !btn.selected;
    
}

#pragma mark - 取得tcp返回的数据
- (void)getKongJingDataMain:(NSNotification *)post {
    NSString *str = post.userInfo[@"Message"];
    
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
            
            static NSString *celled = @"aaaa";
            AirPurificationFirstTableViewCell *cell
            =[tableView dequeueReusableCellWithIdentifier:celled];
            if (!cell) {
                cell = [[AirPurificationFirstTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:celled];
            }
            cell.isAnimation = self.isAnimation;
            cell.stateModel = self.stateModel;
            return cell;
        } else if (indexPath.row == 1) {
            
            static NSString *celled = @"cccc";
            AirPurificationThirtTableViewCell *cell
            =[tableView dequeueReusableCellWithIdentifier:celled];
            if (!cell) {
                cell = [[AirPurificationThirtTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:celled];
            }
            
            if (self.serviceModel) {
                cell.serviceModel = self.serviceModel;
            }
            cell.stateModel = self.stateModel;
            cell.serviceDataModel = self.serviceDataModel;
            
            return cell;
        } else if (indexPath.row == 2) {
            
            static NSString *celled = @"dddd";
            AirPurificationForthTableViewCell *cell
            =[tableView dequeueReusableCellWithIdentifier:celled];
            if (!cell) {
                cell = [[AirPurificationForthTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:celled];
            }
            
            cell.serviceModel = self.serviceModel;
            cell.stateModel = self.stateModel;
            cell.buttonSelected = @(self.bottomBtn.selected);
            return cell;
        } else if (indexPath.row == 3 ){
            static NSString *celled = @"eeee";
            AirPurificationFifthTableViewCell *cell
            =[tableView dequeueReusableCellWithIdentifier:celled];
            if (!cell) {
                cell = [[AirPurificationFifthTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:celled];
            }
            
            cell.serviceModel = self.serviceModel;
            cell.vc = self;
            cell.buttonSelected = @(self.bottomBtn.selected);
            
            return cell;
        } else if (indexPath.row == 4 ){
            static NSString *celled = @"ffff";
            AirThirtTableViewCell *cell
            =[tableView dequeueReusableCellWithIdentifier:celled];
            if (!cell) {
                cell = [[AirThirtTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:celled];
            }
            
            cell.airVC = self;
            cell.model = self.userModel;
            if (self.serviceModel) {
                cell.serviceModel = self.serviceModel;
            }
            cell.serviceDataModel = self.serviceDataModel;
            cell.stateModel = self.stateModel;
            
            
            return cell;
        } else {
            static NSString *celled = @"gggg";
            
            UITableViewCell *cell
            =[tableView dequeueReusableCellWithIdentifier:celled];
            if (!cell) {
                cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:celled];
            }
            
            return cell;
            
        }
    }  else if (indexPath.section == 1){
        static NSString *celled = @"hhhh";
        BingJingShouMingTableViewCell *cell
        =[tableView dequeueReusableCellWithIdentifier:celled];
        if (!cell) {
            cell = [[BingJingShouMingTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:celled];
        }
        
        cell.isKongJing = @"YES";
        
        [cell setUIbuJuWithNowUesrTime:self.stateModel.changeFilterScreen andViewController:self];
        
        return cell;
    } else {
        static NSString *celled = @"iiii";
        LvWangJieDuTableViewCell *cell
        =[tableView dequeueReusableCellWithIdentifier:celled];
        if (!cell) {
            cell = [[LvWangJieDuTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:celled];
        }
        
        cell.isKongJingLvWang = @"YES";
        long int a ;
        
        if (self.stateModel.cleanFilterScreen) {
            a = self.stateModel.cleanFilterScreen / 100;
        }
        
        [cell setZhiZhenView:a andViewController:self];
        
        return cell;
    }
    
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    self.isAnimation = @"NO";
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    if (section == 1 || section == 2 ) {
        NSArray *imageArray = @[@"iconfont-jiankanglvxin" , @"iconfont-jiankangqingsao" ];
        NSArray *nameArray = @[ @"滤网寿命" , @"滤网洁度"];
        UIView *view  = [ThirtView creatViewWithIconArray:imageArray andNameArray:nameArray andSection:(section - 1)];
        view.tag = section;
        view.backgroundColor = [UIColor whiteColor];
        view.userInteractionEnabled = YES;
        UIImageView *imageView = view.subviews[0];
        imageView.tintColor = kKongJingYanSe;
        imageView.size = CGSizeMake(view.height * 2 / 3, view.height * 2 / 3);
        
        
        UILabel *lable = view.subviews[1];
        lable.textColor = kKongJingYanSe;
        lable.font = [UIFont systemFontOfSize:k17];
        
        UIView *zheGaiView = [[UIView alloc] init];
        zheGaiView.layer.opacity = 0.2;
        [view addSubview:zheGaiView];
        [zheGaiView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(kScreenW - kScreenW / 10, (kScreenH / 20) * 3 / 4));
            make.left.mas_equalTo(view.mas_left).offset(kScreenW / 20);
            make.centerY.mas_equalTo(view.mas_centerY);
        }];
        
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction444:)];
        [view addGestureRecognizer:tap];
        return view;
        
    } else {
        return nil;
    }
    
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenW, 1)];
    view.backgroundColor = kFenGeXianYanSe;
    return view;
}

#pragma mark - 分区头的点击事件
- (void)tapAction444:(UITapGestureRecognizer *)tap
{
    tap.view.backgroundColor = kKongJingYanSe;
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
        return 0;
    }
}

#pragma mark - cell的高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            return kScreenH / 2.22333;
        } else if (indexPath.row == 1) {
            return kScreenH / 2.767634;
        } else if (indexPath.row == 2) {
            return kScreenH / 3.7 + kBtnW * 3 / 4 - 10;
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


#pragma mark - 尾部的高度
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 1;
}

@end
