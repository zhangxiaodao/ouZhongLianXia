//
//  MineMessageViewController.m
//  AEFT冷风扇
//
//  Created by 杭州阿尔法特 on 16/3/16.
//  Copyright © 2016年 阿尔法特. All rights reserved.
//

#import "MineMessageViewController.h"
#import "ThirtView.h"
#import "MessageModel.h"
#import "Message2TableViewCell.h"
#import "UITableViewCell+WHC_AutoHeightForCell.h"
//#import <MJRefresh.h>

#import "MJRefresh.h"



@interface MineMessageViewController ()<UITableViewDataSource , UITableViewDelegate , HelpFunctionDelegate>{
    NSUInteger pages;
}
@property (nonatomic , strong) UITableView *tableView;
@property (nonatomic , strong) NSMutableDictionary *dic;
@property (nonatomic , strong) UIView *navView;
//@property (nonatomic , assign) NSInteger pages;
@property (nonatomic , retain) NSMutableArray *dataArray;
@property (nonatomic , assign) CGSize expectSize;
@property (nonatomic , strong) UILabel *textLabel;
@property (nonatomic , strong) UILabel *lable;
@end

@implementation MineMessageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navView = [UIView creatNavView:self.view WithTarget:self action:@selector(backTap:) andTitle:@"我的消息"];
    
    [self setUI];
}


#pragma mark - 返回主界面
- (void)backTap:(UITapGestureRecognizer *)tap {
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - 设置UI
- (void)setUI{
    
    self.lable = [UILabel creatLableWithTitle:@"" andSuperView:self.view andFont:k12 andTextAligment:NSTextAlignmentCenter];
    self.lable.layer.borderWidth = 0;
    [self.lable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kScreenW * 2 / 3, kScreenW / 100));
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.top.mas_equalTo(self.navView.mas_bottom);
    }];
    
    [self setTableView];
    
    //    [self getData];
    
}

- (void)setTableView {
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0,self.lable.y - self.lable.height, kScreenW, kScreenH - (self.lable.y - self.lable.height)) style:UITableViewStyleGrouped];
    [self.view addSubview:self.tableView];
    self.tableView.backgroundColor = [UIColor clearColor];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kScreenW, kScreenH - (self.lable.y - self.lable.height)));
        make.left.mas_equalTo(0);
        make.top.mas_equalTo(self.lable.mas_bottom);
    }];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    
    [self setRefresh];
}

- (void)setRefresh{
    //下拉刷新
    
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        pages = 1;
        
        NSNumber *papp = [NSNumber numberWithInteger:pages];
        //调用读取数据的方法
        NSDictionary *parames = @{@"page" : @(pages) , @"rows" : @10};
        [HelpFunction requestDataWithUrlString:kXiaoXiJieKou andParames:parames andDelegate:self];
    }];
    
    //上拉加载
    
    self.tableView.mj_footer = [MJRefreshBackFooter footerWithRefreshingBlock:^{
        
        //加载时，页数是1
        pages = pages + 1;
        NSNumber *papp = [NSNumber numberWithInteger:pages];
        //调用读取数据的方法
        NSDictionary *parames = @{@"page" : @(pages) , @"rows" : @10};
        NSLog(@"%@" , parames);
        [HelpFunction requestDataWithUrlString:kXiaoXiJieKou andParames:parames andDelegate:self];
    }];
    //开始加载（自动进入加载状态）
    //下拉刷新的三种状态，
//    self.tableView.headerPullToRefreshText = @"下拉刷新";
//    self.tableView.headerRefreshingText = @"刷新中........";
//    self.tableView.headerReleaseToRefreshText = @"松开马上刷新";
//    
//    //上拉加载的三种状态
//    self.tableView.footerPullToRefreshText = @"上拉加载更多数据";
//    self.tableView.footerRefreshingText = @"加载中........";
//    self.tableView.footerReleaseToRefreshText = @"松开马上加载更多数据";
    
    
}



#pragma mark - 数据返回代理
- (void)requestData:(HelpFunction *)request didFailLoadData:(NSError *)error{
    NSLog(@"消息数据请求失败");
}

- (void)requestData:(HelpFunction *)request didSuccess:(NSDictionary *)dddd {
    NSLog(@"%@" , dddd);
    
    NSInteger state = [dddd[@"state"] integerValue];
    
    if (state == 0) {

        NSArray *data = dddd[@"data"];
        
        if (data.count > 0) {
            if (pages == 0) {
                self.dataArray = [NSMutableArray arrayWithArray:data];
                [self.tableView.mj_header endRefreshing];
            } else {
                [self.dataArray addObjectsFromArray:data];
                [self.tableView.mj_footer endRefreshing];
            }
            
            for (int i = 0; i < self.dataArray.count; i++) {
                [self.dic setValue:@(0) forKey:[NSString stringWithFormat:@"%d" , i]];
            }
            
            [self.tableView reloadData];
        } else {
           [self.tableView.mj_header endRefreshing];
           
            [UIAlertController creatRightAlertControllerWithHandle:nil andSuperViewController:self Title:@"暂无消息"];
            
        }
    } else if (state == 2) {
        [self.tableView.mj_header endRefreshing];
        [UIAlertController creatRightAlertControllerWithHandle:nil andSuperViewController:self Title:@"暂无消息"];
    }
    
}

//- (void)requestData:(HelpFunction *)request didFinishLoadingDtaArray:(NSMutableArray *)data{
//    NSLog(@"%@" , data);
//    
//}

#pragma mark - table的代理
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    
    UIView *view = [[UIView alloc]init];
    view.frame = CGRectMake(0, 0, kScreenW, kScreenW / 8 );
    //    UILabel *label = [UILabel initWithTitle:[NSString stringWithFormat:@"%@" , nameArray[section]] andSuperView:view andFont:15 andtextAlignment:NSTextAlignmentLeft andMas_Left:10];
    
    MessageModel *model = [[MessageModel alloc]init];
    model = self.dataArray[section];
    
    
    UILabel *label = [UILabel creatLableWithTitle:[NSString stringWithFormat:@"%@" , model.title] andSuperView:view andFont:k15 andTextAligment:NSTextAlignmentLeft];
    label.layer.borderWidth = 0;
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kScreenW  / 2, kScreenW / 13));
        make.left.mas_equalTo(view.mas_left).offset(kScreenW / 20);
        make.centerY.mas_equalTo(view.mas_centerY);
    }];
    
    UILabel *titmeLable = [UILabel creatLableWithTitle:[NSString stringWithFormat:@"%@" , model.sendTime] andSuperView:view andFont:k14 andTextAligment:NSTextAlignmentLeft];
    titmeLable.layer.borderWidth = 0;
    [titmeLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kScreenW  / 2, kScreenW / 13));
        make.left.mas_equalTo(view.mas_centerX);
        make.centerY.mas_equalTo(view.mas_centerY);
    }];
    
    
    UIImageView *jianTouImage = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"iconfont-qianjin"]];
    [view addSubview:jianTouImage];
    
    [jianTouImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(view.height * 1 / 3, view.height * 1 / 3));
        make.right.mas_equalTo(view.mas_right).offset(-20);
        make.centerY.mas_equalTo(view.mas_centerY);
    }];
    
    UIView *xiaHuaXianView = [[UIView alloc]init];
    xiaHuaXianView.backgroundColor = [UIColor grayColor];
    [view addSubview:xiaHuaXianView];
    [xiaHuaXianView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kScreenW, 1));
        make.left.mas_equalTo(0);
        make.top.mas_equalTo(view.mas_bottom);
    }];
    
    
    
    view.backgroundColor = [UIColor clearColor];
    view.tag = section;
    
    view.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
    [view addGestureRecognizer:tap];
    return view;
    
}


#pragma mark - 分区头的高度
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    
    return  kScreenW / 8;
    
}
#pragma mark - 分区的数量
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.dataArray.count;
}
#pragma mark - 尾部的高度
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 2;
}
#pragma mark - 分区头的点击事件
- (void)tapAction:(UITapGestureRecognizer *)tap
{
    NSString *section = [NSString stringWithFormat:@"%ld" , tap.view.tag];
    
    if ([self.dic[section] integerValue] == 0) {
        [self.dic setValue:@(1) forKey:section];
    } else{
        [self.dic setValue:@(0) forKey:section];
    }
    NSIndexSet *set = [NSIndexSet indexSetWithIndex:tap.view.tag];
    [self.tableView reloadSections:set withRowAnimation:UITableViewRowAnimationFade];
    
}
#pragma mark - cell的高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [Message2TableViewCell whc_CellHeightForIndexPath:indexPath tableView:tableView];
}
#pragma mark - cell的个数
- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSString *key = [NSString stringWithFormat:@"%ld" , (long)section];
    if ([self.dic[key] integerValue] == 1) {
        return 1;
    }
    return 0;
}
#pragma mark - 生成cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellId = @"id";
    Message2TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (cell == nil) {
        cell = [[Message2TableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId
                ];
    }
    cell.model = self.dataArray[indexPath.section];
    return cell;
}
#pragma mark - 取消cell的选中状态
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];// 取消选中
    //其他代码
}



#pragma mark - 懒加载
- (NSMutableDictionary *)dic{
    if (!_dic) {
        self.dic = [NSMutableDictionary dictionary];
    }
    return _dic;
}

@end
