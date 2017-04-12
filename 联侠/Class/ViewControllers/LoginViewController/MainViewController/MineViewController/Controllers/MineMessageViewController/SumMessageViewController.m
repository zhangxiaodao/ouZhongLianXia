//
//  SumMessageViewController.m
//  联侠
//
//  Created by 杭州阿尔法特 on 2017/2/5.
//  Copyright © 2017年 张海昌. All rights reserved.
//

#import "SumMessageViewController.h"
#import "SystemMessageModel.h"
#import "SystemMessageViewController.h"
#import "MessageCell.h"

@interface SumMessageViewController ()<UITableViewDataSource , UITableViewDelegate>
@property (nonatomic , strong) UITableView *tableView;

@end

@implementation SumMessageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor colorWithHexString:@"f2f4fb"];
        
    [self setUI];
}

#pragma mark - 设置UI
- (void)setUI{
    
    self.tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
    [self.view addSubview:self.tableView];
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.contentInset = UIEdgeInsetsMake(10, 0, 0, 0);
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.contentInset = UIEdgeInsetsMake(10, 0, 0, 0);
    
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *celled = @"celled";
    
    MessageCell *cell
    =[tableView dequeueReusableCellWithIdentifier:celled];
    if (!cell) {
        cell = [[MessageCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:celled];
    }
    
    cell.indexpath = indexPath;
    if (indexPath.row == 0) {
        cell.isShowPromptImageView = self.systemMessageIsShowPrompt;
    }
    
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    self.systemMessageIsShowPrompt = @"NO";
    NSIndexPath *index = [NSIndexPath indexPathForRow:0 inSection:0];
    [tableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:index,nil] withRowAnimation:UITableViewRowAnimationNone];
    
    SystemMessageViewController *systemVC = [[SystemMessageViewController alloc]init];
    
    if (indexPath.row == 1) {
        systemVC.navigationItem.title = @"我的消息";
    } else if (indexPath.row == 0) {
        systemVC.navigationItem.title = @"系统消息";
    }
    [self.navigationController pushViewController:systemVC animated:YES];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2;
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

@end
