//
//  XinFengCaiDengViewController.m
//  联侠
//
//  Created by 杭州阿尔法特 on 2017/3/22.
//  Copyright © 2017年 张海昌. All rights reserved.
//

#import "XinFengCaiDengViewController.h"
#import "XinFengCaiDengFirstTableViewCell.h"
#import "XinFengCaiDengHeaderView.h"
@interface XinFengCaiDengViewController ()<UITableViewDelegate , UITableViewDataSource , HelpFunctionDelegate>
@property (nonatomic , strong) UITableView *tableView;
@property (nonatomic , strong) StateModel *stateModel;
@property (nonatomic , strong) NSMutableArray *nameArray;
@property (nonatomic,strong) UIView *bottomView;
    
@property (nonatomic,strong) UIButton *bottomBtn;
@property (nonatomic,strong) UIImageView *exitImgvi;

@end

@implementation XinFengCaiDengViewController

- (NSMutableArray *)nameArray {
    if (!_nameArray) {
        _nameArray = [NSMutableArray arrayWithArray:@[@"七彩渐变" , @"幻彩转动" , @"红绿蓝" , @"黄青紫" , @"七色转动" , @"红" , @"绿" , @"蓝" , @"黄" , @"青" ,@"紫" , @"白"]];
    }
    return _nameArray;
}
    
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"智能彩灯";
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenW, kScreenH - 10) style:UITableViewStyleGrouped];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;

    
    _bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, kScreenH-49, kScreenW, 49)];
    _bottomView.backgroundColor = kFenGeXianYanSe;
    [self.view addSubview:_bottomView];
    
    
    _exitImgvi = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"exit"]];
    _exitImgvi.frame = CGRectMake(kScreenW/2-29/2.0, 10, 29, 29);
    [_bottomView addSubview:_exitImgvi];
    
    
    _bottomBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _bottomBtn.frame = _bottomView.bounds;
    [_bottomBtn addTarget:self action:@selector(alertDismiss) forControlEvents:UIControlEventTouchUpInside];
    [_bottomView addSubview:_bottomBtn];
    
}
    
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self requestServiceState];
    
    dispatch_queue_t queue = dispatch_get_global_queue(0, 0);
    
    dispatch_async(queue, ^{
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            
            [UIView animateWithDuration:0.2 animations:^{
                
                _exitImgvi.transform = CGAffineTransformRotate(_exitImgvi.transform, M_PI_4);
                
            } completion:nil];
        });
    });
}
    
    
- (void)alertDismiss {
    dispatch_queue_t queue1 = dispatch_get_global_queue(0, 0);
    
    dispatch_async(queue1, ^{
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [UIView animateWithDuration:0.2 animations:^{
                _exitImgvi.transform = CGAffineTransformIdentity;
                
            }];
            [self dismissViewControllerAnimated:YES completion:nil];
        });
    });
}

    
- (void)requestServiceState {
    NSDictionary *parames = @{@"devSn" : self.serviceModel.devSn , @"devTypeSn" : self.serviceModel.devTypeSn};
    [HelpFunction requestDataWithUrlString:kChaXunKongJingDangQianZhuangTai andParames:parames andDelegate:self];
}
    
- (void)requestData:(HelpFunction *)request didSuccess:(NSDictionary *)dddd {
    
//            NSLog(@"%@" , dddd);
    if ([dddd[@"data"] isKindOfClass:[NSDictionary class]]) {
        NSDictionary *dataDic = dddd[@"data"];
        
        self.stateModel = [[StateModel alloc]init];
        
        for (NSString *key in [dataDic allKeys]) {
            [self.stateModel setValue:dataDic[key] forKey:key];
        }
        [self.tableView reloadData];
    }
}

- (void)requestData:(HelpFunction *)request didFailLoadData:(NSError *)error {
    NSLog(@"%@" , error);
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
    
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.nameArray.count;
}
    
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    XinFengCaiDengHeaderView *view = [[XinFengCaiDengHeaderView alloc]initWithFrame:CGRectMake(0, 0, kScreenW, kScreenW / 6)];
    view.serviceModel = self.serviceModel;
    view.stateModel = self.stateModel;
//    view.backgroundColor = [UIColor cyanColor];
    return view;
}
    
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *celled = @"celled";
    
    XinFengCaiDengFirstTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:celled];
    if (!cell) {
        cell = [[XinFengCaiDengFirstTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:celled];
        
        if (indexPath.row >= 2) {
            cell.tag = indexPath.row + 4;
        } else {
            cell.tag = indexPath.row + 3;
        }
        
    }
    cell.titleString = self.nameArray[indexPath.row];
    cell.serviceModel = self.serviceModel;
    cell.stateModel = self.stateModel;
//    cell.indexPath = indexPath;
    
    
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return kScreenW / 8;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return kScreenW / 6;
}
    
- (void)setServiceModel:(ServicesModel *)serviceModel {
    _serviceModel = serviceModel;
}
        
@end
