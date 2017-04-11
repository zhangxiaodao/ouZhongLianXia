//
//  AboutOusTableViewController.m
//  联侠
//
//  Created by 杭州阿尔法特 on 2017/2/10.
//  Copyright © 2017年 张海昌. All rights reserved.
//

#import "AboutOusTableViewController.h"
#import "ConnectWeViewController.h"
#import "TableViewHeaderView.h"
#import "EnterForthTableViewCell.h"

@interface AboutOusTableViewController ()<UITableViewDelegate , UITableViewDataSource>
@property (nonatomic , strong) UIView *navView;

@end

#define STOREAPPID @"1113948983"
NSString static * const cellid = @"cellid";

@implementation AboutOusTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpTable];
    
}

- (void)backTap:(UITapGestureRecognizer *)tap {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)setUpTable {
    UITableView *tableView = [[UITableView alloc]initWithFrame:kScreenFrame style:UITableViewStyleGrouped];
    [self.view addSubview:tableView];
    tableView.backgroundColor = kCOLOR(244, 244, 244);
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.contentInset = UIEdgeInsetsMake(kScreenH / 14, 0, 0, 0);
    [tableView registerClass:[EnterForthTableViewCell class] forCellReuseIdentifier:cellid];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.sectionHeaderHeight = kScreenH / 5;
    
    self.navView = [UIView creatNavView:self.view WithTarget:self action:@selector(backTap:) andTitle:@"关于我们"];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    EnterForthTableViewCell *cell
    =[tableView dequeueReusableCellWithIdentifier:cellid];
    
//    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    if (indexPath.row == 0) {
        cell.imageViw.image = [UIImage imageNamed:@"evaluate"];
        cell.lable.text = @"去评价";
    } else if (indexPath.row == 1) {
        cell.imageViw.image = [UIImage imageNamed:@"lianxiwomen"];
        cell.lable.text = @"联系我们";
    }
    
    cell.lable.textColor = [UIColor blackColor];
    cell.jianTouImage.tintColor = [UIColor blackColor];
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    TableViewHeaderView *headerView = [[TableViewHeaderView alloc]init];
    headerView.frame = CGRectMake(0, 0, kScreenW, kScreenH / 5);
    headerView.version = kVersion;
    
    return headerView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return kScreenH / 5;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return kScreenH / 14.2;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    if (indexPath.row == 0) {
        NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"https://itunes.apple.com/us/app/id%@?ls=1&mt=8", STOREAPPID]];
        [[UIApplication sharedApplication] openURL:url];
    } else if (indexPath.row == 1) {
        ConnectWeViewController *connectOurVC = [[ConnectWeViewController alloc]init];
        [self.navigationController pushViewController:connectOurVC animated:YES];
    }
}

@end
