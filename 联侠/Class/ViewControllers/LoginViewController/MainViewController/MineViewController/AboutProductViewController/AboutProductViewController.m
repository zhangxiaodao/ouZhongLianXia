//
//  AboutProductViewController.m
//  AEFT冷风扇
//
//  Created by 杭州阿尔法特 on 16/5/5.
//  Copyright © 2016年 阿尔法特. All rights reserved.
//

#import "AboutProductViewController.h"
#import "EnterForthTableViewCell.h"
#import "AllTypeServiceViewController.h"
#import "MineYouHuiQuanViewController.h"
#import "UserFeedBackViewController.h"
#import "GengXinRiZhiViewController.h"

@interface AboutProductViewController ()<UITableViewDataSource , UITableViewDelegate>
@property (nonatomic , strong) UIView *navView;
@property (nonatomic , strong) UITableView *tableVIew;
@end

@implementation AboutProductViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor  =[UIColor whiteColor];
    self.navView = [UIView creatNavView:self.view WithTarget:self action:@selector(backTap:) andTitle:@"关于产品"];
    [self setUI];
    
}

#pragma mark - 返回主界面
- (void)backTap:(UITapGestureRecognizer *)tap {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)setUI {
    self.tableVIew = [[UITableView alloc]init];
    [self.view addSubview:self.tableVIew];
    [self.tableVIew mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kScreenW, 4 * kScreenH / 14.2));
        make.left.mas_equalTo(0);
        make.top.mas_equalTo(self.navView.mas_bottom);
    }];
    self.tableVIew.bounces = NO;
    self.tableVIew.delegate = self;
    self.tableVIew.dataSource = self;
    self.tableVIew.separatorStyle = UITableViewCellSeparatorStyleNone;
}

#pragma mark - TableView的点击事件
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *cellId = @"id";
    EnterForthTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (cell == nil) {
        cell = [[EnterForthTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId
                ];
    }
    
    if (indexPath.row == 0) {
        cell.imageViw.image = [UIImage imageNamed:@"shuoming"];
        cell.lable.text = @"产品说明";
    } else if (indexPath.row == 1) {
        cell.imageViw.image = [UIImage imageNamed:@"help"];
        cell.lable.text = @"在线帮助";
    } else if (indexPath.row == 2) {
        cell.imageViw.image = [UIImage imageNamed:@"fankui"];
        cell.lable.text = @"建议反馈";
    } else if (indexPath.row == 3) {
        cell.imageViw.image = [UIImage imageNamed:@"rizhi" ];
        cell.lable.text = @"更新日志";
    }
    cell.lable.textColor = [UIColor blackColor];
    cell.jianTouImage.tintColor = [UIColor blackColor];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {

        
        AllTypeServiceViewController *allServicesVC = [[AllTypeServiceViewController alloc]init];
        allServicesVC.fromAboutVC = @"YES";
        [self.navigationController pushViewController:allServicesVC animated:YES];
        
        
    } else if (indexPath.row == 1) {
        MineYouHuiQuanViewController *youHuiQuanVC = [[MineYouHuiQuanViewController alloc]init];
        [self.navigationController pushViewController:youHuiQuanVC animated:YES];
    } else if (indexPath.row == 2) {
        UserFeedBackViewController *userVC = [[UserFeedBackViewController alloc]init];
        userVC.model = [[UserModel alloc]init];
        userVC.model = self.model;
        [self.navigationController pushViewController:userVC animated:YES];

    } else if (indexPath.row == 3) {
        GengXinRiZhiViewController *gengXinVC = [[GengXinRiZhiViewController alloc]init];
        [self.navigationController pushViewController:gengXinVC animated:YES];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return kScreenH / 14.2;
}

#pragma mark - rows的个数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 4;
}

@end
