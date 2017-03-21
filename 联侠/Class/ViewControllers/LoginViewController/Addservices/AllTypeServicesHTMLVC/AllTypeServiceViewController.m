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


@interface AllTypeServiceViewController ()<UITableViewDelegate , UITableViewDataSource , HelpFunctionDelegate>
@property (nonatomic , strong) UIView *navView;
@property (nonatomic , copy) NSString *devType;
@property (nonatomic , strong) UITableView *tableView;
@property (nonatomic , strong) NSMutableArray *dataArray;

@end

@implementation AllTypeServiceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self setUI];
    
    [HelpFunction requestDataWithUrlString:kAllTypeServiceURL andParames:nil andDelegate:self];
    
}


- (void)backTap:(UITapGestureRecognizer *)tap {
    [self.navigationController popViewControllerAnimated:YES];
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


- (void)setUI {
    self.navView = [UIView creatNavView:self.view WithTarget:self action:@selector(backTap:) andTitle:@"所有设备"];
    
    _tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
    [self.view addSubview:_tableView];
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kScreenW, kScreenH - kScreenH / 10));
        make.top.mas_equalTo(self.navView.mas_bottom);
        make.centerX.mas_equalTo(self.view.mas_centerX);
    }];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
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
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    AllTypeServiceModel *allTypeServiceModel = _dataArray[indexPath.row];
    cell.allTypeServiceModel = allTypeServiceModel;
    
   
   
    
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    AllTypeServiceModel *allTypeServiceModel = _dataArray[indexPath.row];
    AllServicesViewController *allServiceVC = [[AllServicesViewController alloc]init];
    allServiceVC.devType = [NSString stringWithFormat:@"%ld" , (long)allTypeServiceModel.typeSn];
    allServiceVC.fromAboutVC = self.fromAboutVC;
    [self.navigationController pushViewController:allServiceVC animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    return kScreenH / 12;
}

- (NSMutableArray *)dataArray {
    if (_dataArray == nil) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

@end
