//
//  AllTypeServiceViewController.m
//  联侠
//
//  Created by 杭州阿尔法特 on 2016/11/7.
//  Copyright © 2016年 张海昌. All rights reserved.
//

#import "AllTypeServiceViewController.h"
#import "AllServicesViewController.h"
#import "AllTypeServiceTableViewCell.h"
#import "AllTypeServiceModel.h"
#import "FirstUserAlertView.h"

@interface AllTypeServiceViewController ()<UITableViewDelegate , UITableViewDataSource , HelpFunctionDelegate>
@property (nonatomic , copy) NSString *devType;
@property (nonatomic , strong) NSIndexPath *selectedIndexPath;

@property (nonatomic , strong) NSMutableArray *dataArray;

@end

@implementation AllTypeServiceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor colorWithHexString:@"f2f4fb"];
    
    [self setAlertView];
    [self setUI];
    
    [HelpFunction requestDataWithUrlString:kAllTypeServiceURL andParames:nil andDelegate:self];
    
}

- (void)setAlertView {
    [[FirstUserAlertView alloc]creatAlertViewwithImage:@"alert2"deleteFirstObj:@"YES"];
}

#pragma mark - 代理返回的数据
- (void)requestData:(HelpFunction *)request didFinishLoadingDtaArray:(NSMutableArray *)data {
    NSDictionary *dic = data[0];
//    NSLog(@"%@" , dic);
    
    if ([dic[@"data"] isKindOfClass:[NSArray class]]) {
        NSArray *arr = [NSArray arrayWithArray:dic[@"data"]];
        
        for (NSDictionary *dd in arr) {
            AllTypeServiceModel *model = [[AllTypeServiceModel alloc]init];
            [model setValuesForKeysWithDictionary:dd];
            [self.dataArray addObject:model];
        }
        
        [self.tableView reloadData];
    }
    
}

- (void)requestData:(HelpFunction *)request didFailLoadData:(NSError *)error {
    NSLog(@"%@" , error);
}

- (void)setUI {
    
    self.tableView.contentInset = UIEdgeInsetsMake(10, 0, 10, 0);
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dataArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *celled = @"celled";
    
    AllTypeServiceTableViewCell *cell
    =[tableView dequeueReusableCellWithIdentifier:celled];
    if (!cell) {
        cell = [[AllTypeServiceTableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:celled];
    }
    cell.count = self.dataArray.count;
    cell.indePath = indexPath;
    AllTypeServiceModel *allTypeServiceModel = _dataArray[indexPath.row];
    cell.allTypeServiceModel = allTypeServiceModel;
    
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView shouldHighlightRowAtIndexPath:(NSIndexPath *)indexPath {
    
    AllTypeServiceTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    cell.selectedImage.hidden = NO;
    self.selectedIndexPath = indexPath;
    return YES;
}

- (void)tableView:(UITableView *)tableView didUnhighlightRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.selectedIndexPath) {
        AllTypeServiceTableViewCell *cell = [tableView cellForRowAtIndexPath:self.selectedIndexPath];
        cell.selectedImage.hidden = YES;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    AllTypeServiceModel *allTypeServiceModel = _dataArray[indexPath.row];
    AllServicesViewController *allServiceVC = [[AllServicesViewController alloc]init];
    allServiceVC.navigationItem.title = self.navigationItem.title;
    allServiceVC.typeSn = [NSString stringWithFormat:@"%@" , allTypeServiceModel.typeSn];
    
    [self.navigationController pushViewController:allServiceVC animated:YES];
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    return kScreenH / 13;
}

- (NSMutableArray *)dataArray {
    if (_dataArray == nil) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

@end
