//
//  AirgengDuoViewController.m
//  联侠
//
//  Created by 杭州阿尔法特 on 16/6/1.
//  Copyright © 2016年 张海昌. All rights reserved.
//

#import "AirgengDuoViewController.h"
#import "AirPuritionGengDuoFirstTableViewCell.h"
#import "AirPuritionGengDuoSecondTableViewCell.h"
#import "AirPuritionGengDuoThirtTableViewCell.h"
#import "AirPuritionGengDuoForthTableViewCell.h"
#import "AirPuritionGengDuoFifthTableViewCell.h"


@interface AirgengDuoViewController ()< HelpFunctionDelegate , UITableViewDataSource , UITableViewDelegate>
@property (nonatomic , strong) UIView *navView;
@property (nonatomic , assign) CGFloat temperature;
@property (nonatomic , strong) UITableView *tableView;
@end

@implementation AirgengDuoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];

    [self setUI];
}


- (void)requestData:(HelpFunction *)request didSuccess:(NSDictionary *)dddd {
//    NSLog(@"%@" , dddd);
}

#pragma mark - 返回主界面
- (void)backTap:(UITapGestureRecognizer *)tap {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)setUI {
    
    
    
    self.tableView = [[UITableView alloc]initWithFrame:kScreenFrame style:UITableViewStylePlain];
    [self.view addSubview:self.tableView];
    
    self.tableView.tableHeaderView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 0, 0.5)];
    self.tableView.contentInset=UIEdgeInsetsMake(-kScreenW / 15, 0, 0, 0);
//    self.tableView.backgroundColor = kKongJingYanSe
    ;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.scrollEnabled = NO;
    
    self.navView = [UIView creatNavView:self.view WithTarget:self action:@selector(backTap:) andTitle:@"统计图表"];
    
    UIView *iii = [self.navView.subviews objectAtIndex:0];
    UIImageView *jjj = [iii.subviews objectAtIndex:1];

    [UIImageView setImageViewColor:jjj andColor:[UIColor whiteColor]];
    
    UILabel *lable222 = self.navView.subviews[2];
    lable222.textColor = [UIColor whiteColor];
    
}


#pragma mark - 生成cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    if (indexPath.row == 0) {
        
        static NSString *celled = @"aaaaa";
        
        AirPuritionGengDuoFirstTableViewCell *cell
        =[tableView dequeueReusableCellWithIdentifier:celled];
        if (!cell) {
            cell = [[AirPuritionGengDuoFirstTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:celled];
        }
        cell.serviceataModel = self.serviceDataModel;
        return cell;

    } else if (indexPath.row == 1) {
        
        static NSString *celled = @"bbbbb";
        
        AirPuritionGengDuoSecondTableViewCell *cell
        =[tableView dequeueReusableCellWithIdentifier:celled];
        if (!cell) {
            cell = [[AirPuritionGengDuoSecondTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:celled];
        }
        
        
        if (_shiNeiPm25 && _shiWaiPm25) {
            cell.shiWaiPm25 = _shiWaiPm25;
            cell.shiNeiPm25 = _shiNeiPm25;
        }
        
        cell.stateModel = self.stateModel;
        cell.serviceDataModel = self.serviceDataModel;
        
        return cell;
        
    } else if (indexPath.row == 2) {
        
        static NSString *celled = @"ccccc";
        
        AirPuritionGengDuoThirtTableViewCell *cell
        =[tableView dequeueReusableCellWithIdentifier:celled];
        if (!cell) {
            cell = [[AirPuritionGengDuoThirtTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:celled];
        }
        cell.stateModel = self.stateModel;

        return cell;
        
    } else if (indexPath.row == 3) {
        
        static NSString *celled = @"ddddd";
        
        AirPuritionGengDuoFifthTableViewCell *cell
        =[tableView dequeueReusableCellWithIdentifier:celled];
        if (!cell) {
            cell = [[AirPuritionGengDuoFifthTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:celled];
        }
        cell.liearColor = kKongJingYanSe;
        cell.chaXunLishiJiLu = kKongJingLiShiJiLu;
        cell.serviceModel = self.serviceModel;

        return cell;
        
    } else {
        static NSString *celled = @"celled";
            
            UITableViewCell *cell
            =[tableView dequeueReusableCellWithIdentifier:celled];
            if (!cell) {
                cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:celled];
            }
            
            return cell;
        
    }
    
}

#pragma mark - cell的高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row == 0) {
        return kScreenH / 2.575289;
    } else if (indexPath.row == 1) {
        return kScreenH / 6.94791666;
    } else if (indexPath.row == 2) {
        return kScreenH / 7.7558139;
    } else {
        return kScreenH / 2.9;
    }
    
}


#pragma mark - cell的个数
- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 4;
}

#pragma mark - 取消cell的选中状态
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];// 取消选中
    //其他代码
}

- (void)setUserModel:(UserModel *)userModel {
    _userModel = userModel;
}

- (void)setServiceModel:(ServicesModel *)serviceModel {
    _serviceModel = serviceModel;
//    NSLog(@"%@ , %@" , _serviceModel.devTypeSn , _serviceModel.devSn);
}

- (void)setServiceDataModel:(ServicesDataModel *)serviceDataModel {
    _serviceDataModel = serviceDataModel;
}


@end
