//
//  GanYiJiViewController.m
//  联侠
//
//  Created by 杭州阿尔法特 on 16/6/27.
//  Copyright © 2016年 张海昌. All rights reserved.
//

#import "GanYiJiViewController.h"
#import "GanYiJiFirstTableViewCell.h"
#import "GanYiJiSecondTableViewCell.h"
#import "GanYiJiYiWuXuanZeTableViewCell.h"
#import "AirPurificationFifthTableViewCell.h"
#import "BingJingShouMingTableViewCell.h"
#import "LvWangJieDuTableViewCell.h"
#import "ThirtView.h"
#import "EnterForthTableViewCell.h"
#import "GanYiJiDingShiViewController.h"
#import "GanYiJiForthTableViewCell.h"
#import "GanYiJiTwoSectionFirstRowTableViewCell.h"


#define kBtnW ((kScreenW + 4) / 4)
@interface GanYiJiViewController ()<UITableViewDelegate , UITableViewDataSource , GanYiJiFirstTableViewCellDelegate>
@property (nonatomic , copy)  NSString *lvWangJieDu;
@property (nonatomic , strong) NSMutableDictionary *dic;

@property (nonatomic , copy) NSString *isWork;
@end

@implementation GanYiJiViewController
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

- (void)ganYiJiBeginWork22:(NSNotification *)post {
    if ([post.userInfo[@"GanYiJiBeginWork"] isEqualToString:@"YES"]) {
        self.isWork = @"YES";
        [self.tableView reloadData];
    }
}

- (void)setUI {
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getGanYiJiData:) name:kServiceOrder object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(ganYiJiBeginWork22:) name:@"GanYiJiBeginWork" object:nil];
    
    self.isWork = @"NO";
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    for (int i = 1; i < 3; i++) {
        [self.dic setValue:@(0) forKey:[NSString stringWithFormat:@"%d" , i]];
    }
    
}

- (void)ganYiJiOpenAtcion:(UIButton *)btn {
    
    if (btn.selected == 1) {
        [kSocketTCP sendDataToHost:GanYiJiXieYi(self.serviceModel.devTypeSn, self.serviceModel.devSn, @"02", @"00", @"00", @"00") andType:kZhiLing andIsNewOrOld:kNew];
        [kStanderDefault setObject:@"NO" forKey:@"offBtn"];
    } else {
        [kSocketTCP sendDataToHost:GanYiJiXieYi(self.serviceModel.devTypeSn, self.serviceModel.devSn, @"01", @"00", @"02", @"02") andType:kZhiLing andIsNewOrOld:kNew];
        
        [kStanderDefault setObject:@"YES" forKey:@"offBtn"];
    }
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getGanYiJiData:) name:kServiceOrder object:nil];
    btn.selected = !btn.selected;
}

- (void)getGanYiJiData:(NSNotification *)post {
    NSString *str = post.userInfo[@"Message"];
    
    if (str.length != 62) {
        return ;
    }
    
    NSString *kaiGuan = [str substringWithRange:NSMakeRange(28, 2)];
    NSString *devSn = [str substringWithRange:NSMakeRange(14, 12)];
//    NSLog(@"%@ , %@" , kaiGuan , devSn);
    
    if ([self.serviceModel.devSn isEqualToString:devSn]) {
        if ([kaiGuan isEqualToString:@"02"]) {
            
            self.bottomBtn.backgroundColor = [UIColor grayColor];
        } else if ([kaiGuan isEqualToString:@"01"]) {
            
            self.bottomBtn.backgroundColor = kKongJingYanSe;
        }
    }
    
    [[NSNotificationCenter defaultCenter] postNotification:[NSNotification notificationWithName:@"GanYiJiAnNiuZhuangTai" object:self userInfo:@{@"GanYiJiAnNiuZhuangTai" : @(self.bottomBtn.selected)}]];
}

- (void)swipeGesture:(UISwipeGestureRecognizer *)swipe {
    return ;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    if (section == 1) {
        
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenW, kScreenH / 10)];
        view.tag = section;
        view.backgroundColor = kKongJingYanSe;
        view.userInteractionEnabled = YES;

        
        UIImageView *imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"yiwuxuanze"]];
        imageView.frame = view.bounds;
        [view addSubview:imageView];
        
        UILabel *nameLabel = [UILabel creatLableWithTitle:@"衣物选择" andSuperView:view andFont:k20 andTextAligment:NSTextAlignmentCenter];
        [nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(view.mas_centerX);
            make.bottom.mas_equalTo(view.mas_bottom);
            make.size.mas_equalTo(CGSizeMake(kScreenW / 2, kScreenW / 10));
        }];
        nameLabel.textColor = [UIColor whiteColor];
        nameLabel.layer.borderWidth = 0;
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction555:)];
        [view addGestureRecognizer:tap];
        return view;
    } else {
        
        UIView *view = [[UIView alloc]init];
        view.backgroundColor = kFenGeXianYanSe;
        
        return view;
    }
    
}

#pragma mark - 分区头的点击事件
- (void)tapAction555:(UITapGestureRecognizer *)tap
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
    
    
    if ([self.dic[section] isEqual:@(1)]) {
        NSIndexPath *scrollIndexpath = [NSIndexPath indexPathForRow:0 inSection:1];
        [self.tableView scrollToRowAtIndexPath:scrollIndexpath atScrollPosition:UITableViewScrollPositionTop animated:YES];
    }
    
    
}

- (void)getGanYiJiIsWorking:(GanYiJiFirstTableViewCell *)ganYiJiFirstTableViewCell andIswork:(NSString *)isWork {
    if ([isWork isEqualToString:@"NO"]) {
        [self.tableView reloadData];
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
        
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            static NSString *celled = @"aaaa";
            
            GanYiJiFirstTableViewCell *cell
            =[tableView dequeueReusableCellWithIdentifier:celled];
            if (!cell) {
                cell = [[GanYiJiFirstTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:celled];
            }
            
            cell.isWork = self.isWork;
            cell.serviceDataModel = self.serviceDataModel;
            cell.delegate = self;
            return cell;
        } else {
            static NSString *celled = @"bbbb";
            
            GanYiJiSecondTableViewCell *cell
            =[tableView dequeueReusableCellWithIdentifier:celled];
            if (!cell) {
                cell = [[GanYiJiSecondTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:celled];
            }
            cell.serviceModel = self.serviceModel;
            cell.stateModel = self.stateModel;
            return cell;
        }
    } else if (indexPath.section == 1){
        static NSString *celled = @"cccc";
        
        GanYiJiYiWuXuanZeTableViewCell *cell
        =[tableView dequeueReusableCellWithIdentifier:celled];
        if (!cell) {
            cell = [[GanYiJiYiWuXuanZeTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:celled];
        }

        cell.currentVC = self;
        cell.serviceModel = self.serviceModel;

        return cell;
    } else {
        
        if (indexPath.row == 0) {
            static NSString *celled = @"dddd";
            
            GanYiJiForthTableViewCell *cell
            =[tableView dequeueReusableCellWithIdentifier:celled];
            if (!cell) {
                cell = [[GanYiJiForthTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:celled];
            }
            cell.vc = self;
            cell.serviceModel = self.serviceModel;
            
            return cell;
        } else {
            
            static NSString *celled = @"eeee";
            
            GanYiJiTwoSectionFirstRowTableViewCell *cell
            =[tableView dequeueReusableCellWithIdentifier:celled];
            if (!cell) {
                cell = [[GanYiJiTwoSectionFirstRowTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:celled];
            }
            
            
            cell.liearColor = [UIColor colorWithRed:50/255.0 green:201/255.0 blue:218/255.0 alpha:1.0];
            cell.chaXunLishiJiLu = kChaXunGanYiJiLiShiShuJu;
            cell.serviceModel = self.serviceModel;
            return cell;
            
        }
        
    }
}

#pragma mark - cell的个数
- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 2;
    } else if (section == 1){
        NSString *key = [NSString stringWithFormat:@"%ld" , (long)section];
        if ([self.dic[key] integerValue] == 1) {
            return 1;
        }
        return 0;

    } else {
        return 2;
    }
    
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            return  (kScreenH - kScreenH / 12.3518518) / 4 + kScreenH / 32;
        } else {
             return kBtnW * 2;
        }
    } else if (indexPath.section == 1) {
        return kScreenH / 3.1761 + kScreenW / 8;
    } else {
        if (indexPath.row == 0) {
            return kScreenH * 3 / 9.57142;
        } else {
            return kScreenH / 2.9;
        }
    }
    
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenW, 1)];
    view.backgroundColor = kFenGeXianYanSe;
    return view;
}

#pragma mark - 分区头的高度
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 1) {
        return kScreenH / 10;
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
- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
