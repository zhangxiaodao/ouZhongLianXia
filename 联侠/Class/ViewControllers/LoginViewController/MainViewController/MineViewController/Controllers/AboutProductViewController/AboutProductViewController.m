//
//  AboutProductViewController.m
//  AEFT冷风扇
//
//  Created by 杭州阿尔法特 on 16/5/5.
//  Copyright © 2016年 阿尔法特. All rights reserved.
//

#import "AboutProductViewController.h"
#import "AllTypeServiceViewController.h"
#import "MineYouHuiQuanViewController.h"
#import "UserFeedBackViewController.h"
#import "GengXinRiZhiViewController.h"
#import "AboutProductCell.h"

@interface AboutProductViewController ()<UITableViewDataSource , UITableViewDelegate>

@property (nonatomic , strong) UITableView *tableVIew;
@end

@implementation AboutProductViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithHexString:@"f2f4fb"];
    
    [self setUI];
    
}

- (void)setUI {
    self.tableVIew = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
    [self.view addSubview:self.tableVIew];
    self.tableVIew.contentInset = UIEdgeInsetsMake(10, 0, 0, 0);
    self.tableVIew.bounces = NO;
    self.tableVIew.delegate = self;
    self.tableVIew.dataSource = self;
    self.tableVIew.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableVIew.backgroundColor = [UIColor clearColor];
}

#pragma mark - TableView的点击事件
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *cellId = @"id";
    AboutProductCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (cell == nil) {
        cell = [[AboutProductCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    cell.indexpath = indexPath;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {

        
        AllTypeServiceViewController *allServicesVC = [[AllTypeServiceViewController alloc]init];
        allServicesVC.navigationItem.title = @"所有设备";
        [self.navigationController pushViewController:allServicesVC animated:YES];
        
        
    } else if (indexPath.row == 1) {
        MineYouHuiQuanViewController *youHuiQuanVC = [[MineYouHuiQuanViewController alloc]init];
        youHuiQuanVC.navigationItem.title = @"在线帮助";
        [self.navigationController pushViewController:youHuiQuanVC animated:YES];
    } else if (indexPath.row == 2) {
        UserFeedBackViewController *userVC = [[UserFeedBackViewController alloc]init];
        
        userVC.model = self.model;
        userVC.navigationItem.title = @"建议反馈";
        [self.navigationController pushViewController:userVC animated:YES];

    } else if (indexPath.row == 3) {
        GengXinRiZhiViewController *gengXinVC = [[GengXinRiZhiViewController alloc]init];
        gengXinVC.navigationItem.title = @"更新日志";
        [self.navigationController pushViewController:gengXinVC animated:YES];
    }
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return kScreenH / 14.46;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return kScreenW / 27;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    UIView *view = [[UIView alloc]init];
    view.backgroundColor = [UIColor clearColor];
    return view;
}

#pragma mark - rows的个数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 4;
}

@end
