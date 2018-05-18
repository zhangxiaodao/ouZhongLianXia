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
#import "AboutOusTableViewCell.h"

@interface AboutOusTableViewController ()<UITableViewDelegate , UITableViewDataSource>
@property (nonatomic , strong) NSIndexPath *selectedIndexPath;
@end

#define STOREAPPID @"1113948983"
NSString static * const cellid = @"cellid";

@implementation AboutOusTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor  =[UIColor colorWithHexString:@"f2f4fb"];
    [self setUpTable];
    
}

- (void)setUpTable {
    UITableView *tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
    [self.view addSubview:tableView];
    tableView.backgroundColor = [UIColor clearColor];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.sectionHeaderHeight = kScreenH / 4.43;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [tableView registerClass:[AboutOusTableViewCell class] forCellReuseIdentifier:cellid];
    
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    AboutOusTableViewCell *cell
    =[tableView dequeueReusableCellWithIdentifier:cellid];
    
    cell.indexpath = indexPath;
    
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    TableViewHeaderView *headerView = [[TableViewHeaderView alloc]init];
    headerView.frame = CGRectMake(0, 0, kScreenW, kScreenH / 5);
    headerView.version = [[NSBundle mainBundle] infoDictionary][@"CFBundleShortVersionString"];
    
    return headerView;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2;
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return kScreenH / 4.43;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return kScreenH / 14.46;
}

- (BOOL)tableView:(UITableView *)tableView shouldHighlightRowAtIndexPath:(NSIndexPath *)indexPath {
    
    AboutOusTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    cell.selectedImage.hidden = NO;
    self.selectedIndexPath = indexPath;
    return YES;
}

- (void)tableView:(UITableView *)tableView didUnhighlightRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.selectedIndexPath) {
        AboutOusTableViewCell *cell = [tableView cellForRowAtIndexPath:self.selectedIndexPath];
        cell.selectedImage.hidden = YES;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    if (indexPath.row == 0) {
        NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"https://itunes.apple.com/us/app/id%@?ls=1&mt=8", STOREAPPID]];
        [[UIApplication sharedApplication] openURL:url];
    } else if (indexPath.row == 1) {
        ConnectWeViewController *connectOurVC = [[ConnectWeViewController alloc]init];
        connectOurVC.navigationItem.title = @"联系我们";
        [self.navigationController pushViewController:connectOurVC animated:YES];
    }
}

@end
