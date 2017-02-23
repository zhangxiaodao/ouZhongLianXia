//
//  GanYiJiDingShiViewController.m
//  联侠
//
//  Created by 杭州阿尔法特 on 16/7/19.
//  Copyright © 2016年 张海昌. All rights reserved.
//

#import "GanYiJiDingShiViewController.h"
#import "GanYiJiCommonTableViewCell.h"

@interface GanYiJiDingShiViewController ()<UITableViewDataSource , UITableViewDelegate , HelpFunctionDelegate , GanYiJiCommonTableViewCellDelegate>

@property (nonatomic , strong) UITableView *tableView;
@property (nonatomic , strong) UIView *navView;
@property (nonatomic , strong) UIButton *doneBtn;
@property (nonatomic , strong) UIButton *cancleBtn;
@property (nonatomic , copy) NSString *isChongZhi;
@property (nonatomic , strong) NSArray *clothesArray;
@end

@implementation GanYiJiDingShiViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.navView = [UIView creatNavView:self.view WithTarget:self action:@selector(backTap:) andTitle:[NSString stringWithFormat:@"%@" , _titleText]];
    
    [self setUI];
}

#pragma mark - 返回主界面
- (void)backTap:(UITapGestureRecognizer *)tap {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    UIImageView *backImage = [[UIImageView alloc]initWithImage:[UIImage new]];
    if ([_fromWhich isEqualToString:@"first"]) {
        backImage.image = [UIImage imageNamed:@"yinger.jpg"];
    } else if ([_fromWhich isEqualToString:@"second"]) {
        backImage.image = [UIImage imageNamed:@"cunyi.jpg"];
    } else if ([_fromWhich isEqualToString:@"thirt"]) {
        backImage.image = [UIImage imageNamed:@"zidingyi.jpg"];
    }
    backImage.frame = CGRectMake(0, 0, kScreenW, BackGroupHeight + BackGroupHeight / 2);
    
    backImage.contentMode = UIViewContentModeScaleToFill;
    
    [self.view insertSubview:backImage atIndex:0];
    
    
}

- (void)setUI {
    
    self.isChongZhi = @"NO";
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    [self.view addSubview:self.tableView];
    self.tableView.backgroundColor = [UIColor clearColor];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kScreenW, kScreenH - kScreenH / 16.70588));
        make.left.mas_equalTo(0);
        make.top.mas_equalTo(self.navView.mas_bottom);
    }];
    self.tableView.scrollEnabled = NO;
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.tableHeaderView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 0, 1)];
    
    self.tableView.contentInset = UIEdgeInsetsMake(BackGroupHeight + 20, 0, 0, 0);
    
    
    
    self.doneBtn = [UIButton initWithTitle:@"开启模式" andColor:kKongJingYanSe andSuperView:self.view];
    [self.doneBtn setBackgroundImage:[UIImage imageWithColor:kACOLOR(215, 132, 110, 1.0)] forState:UIControlStateHighlighted];
    
    [self.doneBtn addTarget:self action:@selector(doneGaiYiJiAtcion:) forControlEvents:UIControlEventTouchUpInside];
    [self.doneBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake((kScreenW - kScreenW * 4 / 20) / 2, kScreenW / 9));
        make.bottom.mas_equalTo(self.view.mas_bottom).offset(-kScreenW / 20);
        make.left.mas_equalTo(self.view.mas_centerX).offset(kScreenW / 20);
    }];
    
    self.cancleBtn = [UIButton initWithTitle:@"重新选择" andColor:kKongJingHuangSe andSuperView:self.view];
    [self.cancleBtn addTarget:self action:@selector(cancleGaiYiJiAtcion:) forControlEvents:UIControlEventTouchUpInside];
    [self.cancleBtn setBackgroundImage:[UIImage imageWithColor:kCangBaiSe] forState:UIControlStateHighlighted];
    [self.cancleBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake((kScreenW - kScreenW * 4 / 20) / 2, kScreenW / 9));
        make.bottom.mas_equalTo(self.view.mas_bottom).offset(-kScreenW / 20);
        make.right.mas_equalTo(self.view.mas_centerX).offset(-kScreenW / 20);
    }];
    
    
}

- (void)getGaiYiJiCommonClothesData:(GanYiJiCommonTableViewCell *)ganYiJiCommonVC andClothesData:(NSArray *)dataArray {
    _clothesArray = dataArray;
}

- (void)doneGaiYiJiAtcion:(UIButton *)btn {
    btn.selected = !btn.selected;
    
    if ([kStanderDefault objectForKey:@"GanYiJiData"]) {
        NSDictionary *dic = [kStanderDefault objectForKey:@"GanYiJiData"];

        NSArray *array = [NSArray arrayWithObjects:self.fromWhich, [dic objectForKey:@"time"] , [dic objectForKey:@"openTime"] , [dic objectForKey:@"closeTime"] , [dic objectForKey:@"formWhich"] , nil];
        
        if ([self.fromWhich isEqualToString:array[4]]) {
            if (self.serviceModel.devSn && _clothesArray.count != 0) {
                
                if ([kStanderDefault objectForKey:@"offBtn"]) {
                    NSString *isOpen = [kStanderDefault objectForKey:@"offBtn"];
                    if ([isOpen isEqualToString:@"NO"]) {
                        
                        [kSocketTCP sendDataToHost:GanYiJiXieYi(self.serviceModel.devTypeSn, self.serviceModel.devSn, @"01", @"00", @"02", @"02") andType:kZhiLing andIsNewOrOld:kNew];
                        [kStanderDefault setObject:@"YES" forKey:@"offBtn"];
                    }
                }
                
                
                NSDictionary *parames = @{@"devSn" : self.serviceModel.devSn , @"task.fSwitchOn" : @(0) , @"task.fSwitchOff" : @(1) , @"task.onJobTime" : _clothesArray[2] , @"task.offJobTime" : _clothesArray[3]};
                
//                NSLog(@"%@" , parames);
                [HelpFunction requestDataWithUrlString:kGanYiJiDeDingShiURL andParames:parames andDelegate:self];
            }
            
            [kStanderDefault removeObjectForKey:@"ganYiJiHongGanDic"];
            
            [[NSNotificationCenter defaultCenter] postNotification:[NSNotification notificationWithName:@"commonGanYiJiData" object:self userInfo:@{@"commonGanYiJiData" : array}]];
            [[NSNotificationCenter defaultCenter] postNotification:[NSNotification notificationWithName:@"GanYiJiBeginWork" object:nil userInfo:@{@"GanYiJiBeginWork" : @"YES"}]];
        } else {
            [UIAlertController creatRightAlertControllerWithHandle:nil andSuperViewController:self Title:@"请选择衣服数量"];
        }
    } else {
       
        [UIAlertController creatRightAlertControllerWithHandle:nil andSuperViewController:self Title:@"请选择衣服数量"];
    }
    
    
}

- (void)cancleGaiYiJiAtcion:(UIButton *)btn {
    btn.selected = !btn.selected;
    
    [kStanderDefault removeObjectForKey:@"GanYiJiIsWork"];
    [kStanderDefault removeObjectForKey:@"GanYiJiData"];
    [kStanderDefault removeObjectForKey:@"ganYiJiHongGanDic"];
    
    self.isChongZhi = @"YES";
    [self.tableView reloadData];
    
    [[NSNotificationCenter defaultCenter] postNotification:[NSNotification notificationWithName:@"GanYiJiChongZhi" object:nil userInfo:@{@"GanYiJiChongZhi" : @"YES"}]];
    
}

- (void)requestData:(HelpFunction *)request didSuccess:(NSDictionary *)dddd {
//    NSLog(@"%@" , dddd);
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenW, kScreenH / 6.67)];
    
    UIView *fenGeView = [[UIView alloc]init];
    fenGeView.backgroundColor = kFenGeXianYanSe;
    [view addSubview:fenGeView];
    [fenGeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kScreenW, 1));
        make.left.mas_equalTo(0);
        make.bottom.mas_equalTo(view.mas_bottom);
    }];
    
    if ([_fromWhich isEqualToString:@"thirt"]) {
        fenGeView.backgroundColor = [UIColor whiteColor];
    }
    
    
    UILabel *lable = [UILabel creatLableWithTitle:@"" andSuperView:view andFont:k15 andTextAligment:NSTextAlignmentLeft];
    [lable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kScreenW - kScreenW / 15, view.height));
        make.centerX.mas_equalTo(view.mas_centerX);
        make.centerY.mas_equalTo(view.mas_centerY);
    }];
    lable.layer.borderWidth = 0;
    lable.textColor = [UIColor lightGrayColor];
    
    NSArray *array = nil;
    
    array = @[@"让孩子感受到您温暖的爱" , @"让您所有的衣服温暖如初" , @"您自己选择烘干的时长"];
    
    
    if ([_fromWhich isEqualToString:@"first"]) {
        lable.text = array[0];
    } else if ([_fromWhich isEqualToString:@"second"]) {
        lable.text = array[1];
    } else if ([_fromWhich isEqualToString:@"thirt"]) {
        lable.text = array[2];
    }
    view.backgroundColor = [UIColor whiteColor];
    return view;
    
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenW, kScreenH / 6.67)];
    view.backgroundColor = [UIColor whiteColor];
    
    UIView *fenGeView = [[UIView alloc]init];
    fenGeView.backgroundColor = kFenGeXianYanSe;
    [view addSubview:fenGeView];
    [fenGeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kScreenW, 1));
        make.left.mas_equalTo(0);
        make.top.mas_equalTo(view.mas_top);
    }];
    
    return view;
}

#pragma mark - 生成cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *celled = @"celled";
    
    GanYiJiCommonTableViewCell *cell
    =[tableView dequeueReusableCellWithIdentifier:celled];
    if (!cell) {
        cell = [[GanYiJiCommonTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:celled];
    }
    
    cell.delegate = self;
    cell.vc = self;
    cell.isFromWhich = self.fromWhich;
    cell.isChongZhi = self.isChongZhi;
    return cell;
}

#pragma mark - cell的高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return kScreenH / 4.16875;
}
#pragma mark - cell的个数
- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

#pragma mark - 取消cell的选中状态
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];// 取消选中
    //其他代码
}


#pragma mark - 尾部的高度
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return kScreenH / 6.67;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return kScreenH / 6.67;
}


- (void)setServiceModel:(ServicesModel *)serviceModel {
    _serviceModel = serviceModel;
}

- (NSArray *)clothesArray {
    if (!_clothesArray) {
        _clothesArray = [NSArray array];
    }
    return _clothesArray;
}

- (void)setFromWhich:(NSString *)fromWhich {
    _fromWhich = fromWhich;
}

@end
