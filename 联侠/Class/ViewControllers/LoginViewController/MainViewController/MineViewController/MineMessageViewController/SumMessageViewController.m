//
//  SumMessageViewController.m
//  联侠
//
//  Created by 杭州阿尔法特 on 2017/2/5.
//  Copyright © 2017年 张海昌. All rights reserved.
//

#import "SumMessageViewController.h"
#import "MineMessageViewController.h"
#import "SystemMessageModel.h"
#import "SystemMessageViewController.h"
#import "MessageTableViewCell.h"

@interface SumMessageViewController ()<UITableViewDataSource , UITableViewDelegate>
@property (nonatomic , strong) UITableView *tableView;
@property (nonatomic , strong) UIView *navView;
@end

@implementation SumMessageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
        
    [self setUI];
}

#pragma mark - 返回主界面
- (void)backTap:(UITapGestureRecognizer *)tap {
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - 设置UI
- (void)setUI{
    
    self.tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    [self.view addSubview:self.tableView];
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.contentInset = UIEdgeInsetsMake(10, 0, 49, 0);
    
    self.navView = [UIView creatNavView:self.view WithTarget:self action:@selector(backTap:) andTitle:@"消息通知"];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return kScreenH / 14.2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *celled = @"celled";
    
    MessageTableViewCell *cell
    =[tableView dequeueReusableCellWithIdentifier:celled];
    if (!cell) {
        cell = [[MessageTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:celled];
    }
    
    if (indexPath.row == 0) {
        cell.imageViw.image = [UIImage imageNamed:@"systemMessage"];
        cell.lable.text = @"系统通知";
        cell.isShowPromptImageView = self.systemMessageIsShowPrompt;
    } else if (indexPath.row == 1) {
        cell.imageViw.image = [UIImage imageNamed:@"myMessage"];
        cell.lable.text = @"我的消息";
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 1) {
        MineMessageViewController *mineMessageVC = [[MineMessageViewController alloc]init];
        [self.navigationController pushViewController:mineMessageVC animated:YES];
    } else if (indexPath.row == 0) {
        
        self.systemMessageIsShowPrompt = @"NO";
        NSIndexPath *indexPath=[NSIndexPath indexPathForRow:0 inSection:0];
        [tableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath,nil] withRowAnimation:UITableViewRowAnimationNone];
        
        SystemMessageViewController *systemVC = [[SystemMessageViewController alloc]init];
        [self.navigationController pushViewController:systemVC animated:YES];
    }
}

@end
