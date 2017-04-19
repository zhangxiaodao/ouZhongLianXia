//
//  SystemMessageViewController.m
//  联侠
//
//  Created by 杭州阿尔法特 on 2017/2/5.
//  Copyright © 2017年 张海昌. All rights reserved.
//

#import "SystemMessageViewController.h"
#import "SystemMessageAndMineMessageTableViewCell.h"
#import "SystemMessageModel.h"
#import "SystemMessageWebViewController.h"
#import "XMGRefreshFooter.h"
#import "XMGRefreshHeader.h"

@interface SystemMessageViewController ()<UITableViewDataSource , UITableViewDelegate , HelpFunctionDelegate>{
    NSUInteger pages;
}
@property (nonatomic , strong) NSMutableArray *dataArray;

@end

@implementation SystemMessageViewController

- (NSMutableArray *)dataArray {
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithHexString:@"f2f4fb"];
    
    [self setUI];
}

#pragma mark - 设置UI
- (void)setUI{
    
    self.tableView.backgroundColor = [UIColor colorWithHexString:@"f2f4fb"];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.contentInset = UIEdgeInsetsMake(10, 0, 49, 0);
    [self setRefresh];
    
}

- (void)setRefresh{
    
    self.tableView.mj_header = [XMGRefreshHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewTopics)];
    [self.tableView.mj_header beginRefreshing];
    
    self.tableView.mj_footer = [XMGRefreshFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreTopics)];
}

- (void)loadNewTopics {
    pages = 1;
 
    //调用读取数据的方法
    NSDictionary *parames = @{@"page" : @(pages) , @"rows" : @10};
    
    
    if ([self.navigationItem.title isEqualToString:@"系统消息"]) {
        [HelpFunction requestDataWithUrlString:kSystemMessageJieKou andParames:parames andDelegate:self];
    } else {
        [HelpFunction requestDataWithUrlString:kXiaoXiJieKou andParames:parames andDelegate:self];
    }
    
}

- (void)loadMoreTopics {
    
    pages++;
    NSDictionary *parames = @{@"page" : @(pages) , @"rows" : @10};
    [HelpFunction requestDataWithUrlString:kSystemMessageJieKou andParames:parames andDelegate:self];
}

- (void)requestData:(HelpFunction *)request didSuccess:(NSDictionary *)dddd {
    
    if ([dddd[@"total"] isKindOfClass:[NSNull class]]) {        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        UIAlertController *alert = [UIAlertController creatRightAlertControllerWithHandle:nil andSuperViewController:self Title:@"暂无消息"];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [alert dismissViewControllerAnimated:YES completion:nil];
        });
        return ;
    }
    
    NSInteger total = [dddd[@"total"] integerValue];
    if (total > 0) {
        
        NSArray *data = dddd[@"rows"];
        
        if (data.count > 0) {
            
            if (pages == 1) [self.dataArray removeAllObjects];
            [data enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                SystemMessageModel *model = [[SystemMessageModel alloc]init];
                [model setValuesForKeysWithDictionary:obj];
                NSLog(@"%@" , model);
                [self.dataArray addObject:model];
            }];
            
            SystemMessageModel *model = [[SystemMessageModel alloc]init];
            model = [self.dataArray firstObject];
            [kStanderDefault setValue:model.addTime forKey:@"SystemMessageTime"];
            
            [self.tableView reloadData];
            [self.tableView.mj_header endRefreshing];
            [self.tableView.mj_footer endRefreshing];
        } else {
            [self.tableView.mj_header endRefreshing];
            [self.tableView.mj_footer endRefreshing];
           UIAlertController *alert = [UIAlertController creatRightAlertControllerWithHandle:nil andSuperViewController:self Title:@"暂无消息"];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [alert dismissViewControllerAnimated:YES completion:nil];
            });
            
        }
    } else if (total == 0) {
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        UIAlertController *alert = [UIAlertController creatRightAlertControllerWithHandle:nil andSuperViewController:self Title:@"暂无消息"];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [alert dismissViewControllerAnimated:YES completion:nil];
        });

    }
    
}

- (void)requestData:(HelpFunction *)request didFailLoadData:(NSError *)error {
    [self.tableView.mj_header endRefreshing];
    [self.tableView.mj_footer endRefreshing];
    UIAlertController *alert = [UIAlertController creatRightAlertControllerWithHandle:nil andSuperViewController:self Title:@"暂无消息"];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [alert dismissViewControllerAnimated:YES completion:nil];
    });
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.dataArray.count;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    UIView *view = [[UIView alloc]init];
    view.backgroundColor = kCOLOR(244, 244, 244);
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return kScreenH / 8;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *celled = @"celled";
    
    SystemMessageAndMineMessageTableViewCell *cell
    =[tableView dequeueReusableCellWithIdentifier:celled];
    if (!cell) {
        cell = [[SystemMessageAndMineMessageTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:celled];
    }
    
    
    SystemMessageModel *model = [[SystemMessageModel alloc]init];
    model = self.dataArray[indexPath.section];
    cell.systemMessageModel = model;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    SystemMessageModel *model = [[SystemMessageModel alloc]init];
    model = self.dataArray[indexPath.section];
    
    NSLog(@"%@" , @(model.idd.integerValue));
    
    [HelpFunction requestDataWithUrlString:kUserReadSystemMessageCount andParames:@{@"id" : @(model.idd.integerValue)} andDelegate:self];
    
    SystemMessageWebViewController *systemWebVC = [[SystemMessageWebViewController alloc]init];
    systemWebVC.model = model;
    
    systemWebVC.navigationItem.title = self.navigationItem.title;
    [self.navigationController pushViewController:systemWebVC animated:YES];
    
}
- (void)requestDataWithDontHaveReturnValue:(HelpFunction *)request {
    
}
@end
