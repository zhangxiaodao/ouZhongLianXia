//
//  HistoryViewController.m
//  AEFT冷风扇
//
//  Created by 杭州阿尔法特 on 16/3/11.
//  Copyright © 2016年 阿尔法特. All rights reserved.
//

#import "HistoryViewController.h"
#import "UUChart.h"
#import "LiShiModel.h"

@interface HistoryViewController ()< UUChartDataSource , HelpFunctionDelegate>{
    UUChart *chartView;
}
@property (nonatomic , strong) NSMutableArray *dataArray;
@property (nonatomic , strong) UIView *forthView;
@end

@implementation HistoryViewController

- (NSMutableArray *)dataArray{
    if (!_dataArray) {
        self.dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];

    NSDictionary *parames = @{@"devSn" : self.deviceSn , @"devTypeSn" : self.serviceModel.devTypeSn , @"days" : @7};
    
    [kNetWork requestPOSTUrlString:kLengFengShanLiShiJiLu parameters:parames isSuccess:^(NSDictionary * _Nullable responseObject) {
        
        NSDictionary *dddd = responseObject;
        if ([dddd[@"data"] isKindOfClass:[NSArray class]]) {
            NSArray *arr = dddd[@"data"];
            for (NSDictionary *dic in arr) {
                LiShiModel *lishiModel = [[LiShiModel alloc]init];
                [lishiModel setValuesForKeysWithDictionary:dic];
                NSString *date = [NSString stringWithFormat:@"%@" , lishiModel.useDate];
                NSString *sunDate = [date substringWithRange:NSMakeRange(5, 5)];
                
                NSInteger timeInterval = [NSString turnTimeToInterval:date];
                NSNumber *useTime = @(lishiModel.useTime / 3600000);
                
                int i = (int)(useTime.integerValue / 24);
                
                if (i >= 1) {
                    for (int j = i - 1;j >= 1; j--) {
                        
                        NSNumber *lastUseTime = @(24);
                        NSInteger lastTimeInterval = timeInterval - 3600 * 24 * j;
                        NSString *lastSubDate = [[NSString turnTimeIntervalToString:lastTimeInterval] substringWithRange:NSMakeRange(5, 5)];
                        NSArray *array = [NSArray arrayWithObjects:lastSubDate , lastUseTime, nil];
                        [self.dataArray addObject:array];
                    }
                }
                
                useTime = @(useTime.integerValue % 24);
                NSArray *arr = [NSArray arrayWithObjects:sunDate, useTime , nil];
                
                [self.dataArray addObject:arr];
            }
            [self.forthView removeFromSuperview];
            self.forthView = [[UIView alloc]initWithFrame:CGRectMake(0, kScreenH / 1.522831, kScreenW, kScreenH / 2.9)];
            [self.view addSubview:self.forthView];
            [self configUI:self.forthView];
        }
        
    } failure:nil];
    
}


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self setUI];
}

#pragma mark - 设置UI界面
- (void)setUI{
 
    
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenW, kScreenH / 2.575289)];
    view.backgroundColor = [UIColor redColor];
    [self.view addSubview:view];
    
    
    UIImageView *imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"历史记录背景.jpg"]];
    [view addSubview:imageView];
    imageView.frame = view.frame;
    
    UIView *backView = [UIView creatViewWithFrame:CGSizeMake(kScreenH / 13, kScreenH / 13) image:[UIImage imageNamed:@"iconfont-fanhui"] andSuperView:self.view];
    [backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(kScreenW / 30);
        make.top.mas_equalTo(kStatusbarH / 2);
        make.size.mas_equalTo(CGSizeMake(kScreenH / 13, kScreenH / 13));
    }];
    UITapGestureRecognizer *backTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(backTap:)];
    [backView addGestureRecognizer:backTap];
    
    UIView *titleView = [UIView creatViewWithBackViewandTitle:@"历史记录" andSuperView:self.view];
    [titleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.centerY.mas_equalTo(backView.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(kScreenW / 5, kScreenH / 32));
    }];
    
    UILabel *leiJiJiangWenLable = [UILabel creatLableWithTitle:@"累计降温" andSuperView:view andFont:k12 andTextAligment:NSTextAlignmentCenter];
    leiJiJiangWenLable.layer.borderWidth = 0;
    leiJiJiangWenLable.backgroundColor = [UIColor blackColor];
    leiJiJiangWenLable.textColor = [UIColor whiteColor];
    leiJiJiangWenLable.layer.cornerRadius = kScreenW / 36;
    [leiJiJiangWenLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kScreenW / 6, kScreenW / 18));
        make.centerX.mas_equalTo(view.mas_centerX);
        make.top.mas_equalTo(view.mas_top).offset(kScreenH / 6.0425531);
    }];
    
    UILabel *timeLable = [UILabel creatLableWithTitle:@"" andSuperView:view andFont:k20 andTextAligment:NSTextAlignmentCenter];
    timeLable.layer.borderWidth = 0;
    
    self.temperature =  (self.serviceDataModel.totalC / 3600000) * 6 + ((self.serviceDataModel.totalTime - self.serviceDataModel.totalC) / 3600000) * 2;

    
    [NSString setNSMutableAttributedString:self.temperature andSuperLabel:timeLable andDanWei:@"°C" andSize:k60 andTextColor:kMainColor isNeedTwoXiaoShuo:@"YES"];
    
    [timeLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kScreenW * 2 / 3, kScreenW / 8));
        make.centerX.mas_equalTo(view.mas_centerX);
        make.top.mas_equalTo(leiJiJiangWenLable.mas_bottom).offset(kScreenH / 33.35);
    }];
    
    UILabel *xiaBiaoLable = [UILabel creatLableWithTitle:[NSString stringWithFormat:@"可以煮熟%.2f个鸡蛋" , (self.temperature) / 90] andSuperView:view andFont:k14 andTextAligment:NSTextAlignmentCenter];
    xiaBiaoLable.layer.borderWidth = 0;
    [xiaBiaoLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(view.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(kScreenW / 3 + 20, kScreenW / 15));
        make.top.mas_equalTo(timeLable.mas_bottom);
    }];
    
    UIView *leftView = [[UIView alloc]init];
    leftView.backgroundColor = [UIColor whiteColor];
    [view addSubview:leftView];
    [leftView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kScreenW / 12.5, 1));
        make.right.mas_equalTo(xiaBiaoLable.mas_left);
        make.centerY.mas_equalTo(xiaBiaoLable.mas_centerY);
    }];
    
    UIView *rightView = [[UIView alloc]init];
    rightView.backgroundColor = [UIColor whiteColor];
    [view addSubview:rightView];
    [rightView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kScreenW / 12.5, 1));
        make.left.mas_equalTo(xiaBiaoLable.mas_right);
        make.centerY.mas_equalTo(xiaBiaoLable.mas_centerY);
    }];
    
    UIView *secondView = [[UIView alloc]initWithFrame:CGRectMake(0, kScreenH / 2.575289, kScreenW, kScreenH / 6.94791666)];
    [self.view addSubview:secondView];
    secondView.backgroundColor = [UIColor whiteColor];

    
    UILabel *fenChenLable = [UILabel creatLableWithTitle:@"" andSuperView:secondView andFont:k15 andTextAligment:NSTextAlignmentCenter];
    fenChenLable.layer.borderWidth = 0;
    
    self.text =  self.serviceDataModel.totalTime / 600000 * 0.1158 / 6;
    
   
    [NSString setNSMutableAttributedString:self.text andSuperLabel:fenChenLable andDanWei:@"mg" andSize:k20 andTextColor:kMainColor isNeedTwoXiaoShuo:@"YES"];
    
    
    [fenChenLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kScreenW / 3, kScreenW / 14));
        make.centerX.mas_equalTo(secondView.mas_centerX).offset(- kScreenW / 3.4090909);
        make.top.mas_equalTo(secondView.mas_top).offset(kScreenH / 22.23333);
    }];
    
    UIView *fenGeXianView = [[UIView alloc]init];
    [secondView addSubview:fenGeXianView];
    fenGeXianView.backgroundColor = kMainColor;
    [fenGeXianView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kScreenW / 4, 1));
        make.centerX.mas_equalTo(fenChenLable.mas_centerX);
        make.top.mas_equalTo(fenChenLable.mas_bottom);
    }];
    
    UILabel *yiGuoLvFenChenLable = [UILabel creatLableWithTitle:@"已过滤粉尘" andSuperView:secondView andFont:k12 andTextAligment:NSTextAlignmentCenter];
    yiGuoLvFenChenLable.layer.borderWidth = 0;
    yiGuoLvFenChenLable.textColor = [UIColor grayColor];
    [yiGuoLvFenChenLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kScreenW / 3, kScreenW / 14));
        make.centerX.mas_equalTo(fenChenLable.mas_centerX);
        make.top.mas_equalTo(fenGeXianView.mas_bottom);
    }];
    
    UIView *fenGeXianView3 = [[UIView alloc]init];
    [secondView addSubview:fenGeXianView3];
    fenGeXianView3.backgroundColor = kFenGeXianYanSe;
    [fenGeXianView3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(1, kScreenH / 9));
        make.centerX.mas_equalTo(secondView.mas_centerX);
        make.top.mas_equalTo(secondView.mas_top).offset(kScreenH / 44.4666666);
    }];
    
    UILabel *timeLable1 = [UILabel creatLableWithTitle:@"" andSuperView:secondView andFont:k14 andTextAligment:NSTextAlignmentCenter];
    timeLable1.layer.borderWidth = 0;
    
    self.nowUserTime =  self.serviceDataModel.totalTime / 3600000;
    
    [NSString setNSMutableAttributedString:self.nowUserTime andSuperLabel:timeLable1 andDanWei:@"小时" andSize:k20 andTextColor:kMainColor isNeedTwoXiaoShuo:@"YES"];
    
    [timeLable1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kScreenW / 3, kScreenW / 14));
        make.centerX.mas_equalTo(secondView.mas_centerX).offset( kScreenW / 3.4090909);
        make.top.mas_equalTo(secondView.mas_top).offset(kScreenH / 22.23333);
    }];
    
    UIView *fenGeXianView2 = [[UIView alloc]init];
    [secondView addSubview:fenGeXianView2];
    fenGeXianView2.backgroundColor = kMainColor;
    
    [fenGeXianView2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kScreenW / 4, 1));
        make.centerX.mas_equalTo(timeLable1.mas_centerX);
        make.top.mas_equalTo(timeLable1.mas_bottom);
    }];
    
    UILabel *sumTimeLable = [UILabel creatLableWithTitle:@"累计运行时间" andSuperView:secondView andFont:k12 andTextAligment:NSTextAlignmentCenter];
    sumTimeLable.textColor = [UIColor grayColor];
    sumTimeLable.layer.borderWidth = 0;
    [sumTimeLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kScreenW / 3, kScreenW / 14));
        make.centerX.mas_equalTo(timeLable1.mas_centerX);
        make.top.mas_equalTo(fenGeXianView2.mas_bottom);
        
    }];
    
    UIView *fenGeXianView4 = [[UIView alloc]init];
    [secondView addSubview:fenGeXianView4];
    fenGeXianView4.backgroundColor = kFenGeXianYanSe;
    
    [fenGeXianView4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kScreenW , 1));
        make.centerX.mas_equalTo(secondView.mas_centerX);
        make.top.mas_equalTo(secondView.mas_bottom);
    }];
    
    UIView *thirtView = [[UIView alloc]initWithFrame:CGRectMake(0, kScreenH / 1.8788732, kScreenW, kScreenH / 7.7558139)];
    [self.view addSubview:thirtView];

    
    UILabel *shuiWeiZhuangTaiLable = [UILabel creatLableWithTitle:@"冰晶剩余寿命" andSuperView:thirtView andFont:k14 andTextAligment:NSTextAlignmentLeft];
    shuiWeiZhuangTaiLable.textColor = [UIColor blackColor];
    shuiWeiZhuangTaiLable.layer.borderWidth = 0;
    [shuiWeiZhuangTaiLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(20);
        make.right.mas_equalTo(-kScreenW / 2);
        make.top.mas_equalTo(10);
        make.bottom.mas_equalTo(thirtView.mas_bottom).offset(- kScreenH / 16);
    }];
    
    
    self.shengYuTime = self.sumBingJingTime - self.serviceDataModel.iceCrystalTime / 3600000;
    

    UILabel *rightLable = [UILabel creatLableWithTitle:@"" andSuperView:thirtView andFont:k14 andTextAligment:NSTextAlignmentRight];
    rightLable.textColor = [UIColor blackColor];
    
    rightLable.layer.borderWidth = 0;
    
    [NSString setNSMutableAttributedString:self.shengYuTime andSuperLabel:rightLable andDanWei:@"小时" andSize:k20 andTextColor:kMainColor isNeedTwoXiaoShuo:@"YES"];
    
    [rightLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(kScreenW / 2);
        make.right.mas_equalTo(-20);
        make.top.mas_equalTo(10);
        make.bottom.mas_equalTo(thirtView.mas_bottom).offset(- kScreenH / 16);
    }];

    
    UIView *sumView = [[UIView alloc]init];
    sumView.backgroundColor = kFenGeXianYanSe;

    [thirtView addSubview:sumView];
    [sumView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(20);
        make.top.mas_equalTo(rightLable.mas_bottom);
        make.size.mas_equalTo(CGSizeMake(kScreenW - kScreenW / 10, thirtView.height / 5));

    }];


    UIView *nowView = [[UIView alloc]init];
    nowView.backgroundColor = kMainColor;
    [thirtView addSubview:nowView];
    [nowView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(20);
        make.size.mas_equalTo(CGSizeMake(((kScreenW - kScreenW / 10) - (((kScreenW - kScreenW  / 10) / self.sumBingJingTime) * self.serviceDataModel.iceCrystalTime / 3600000)), thirtView.height / 5));
        make.top.mas_equalTo(rightLable.mas_bottom);

    }];
    
    UIView *fenGeView5 = [[UIView alloc]init];
    [thirtView addSubview:fenGeView5];
    fenGeView5.backgroundColor = kFenGeXianYanSe;
    
    [fenGeView5 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kScreenW , 1));
        make.centerX.mas_equalTo(thirtView.mas_centerX);
        make.top.mas_equalTo(thirtView.mas_bottom);
    }];
    
    self.forthView = [[UIView alloc]initWithFrame:CGRectMake(0, kScreenH / 1.522831, kScreenW, kScreenH / 2.9)];
    [self.view addSubview:self.forthView];
    [self configUI:self.forthView];
    
}

#pragma mark - 返回上一节面
- (void)backTap:(UITapGestureRecognizer *)tap {
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - 生成线状图
- (void)configUI:(UIView *)superView
{
    if (chartView) {
        [chartView removeFromSuperview];
        chartView = nil;
    }
    
    
    chartView = [[UUChart alloc]initWithFrame:CGRectMake(10, 10, kScreenW - 20, kScreenH / 3.5)
                                   dataSource:self
                                        style:UUChartStyleLine];
    [chartView showInView:superView];
}

#pragma mark - 线状图的X坐标数据
- (NSArray *)getXTitles:(int)num
{
    NSMutableArray *xTitles = [NSMutableArray array];
    
    for (int i = 0; i < num; i++) {
        
        NSArray *arr = self.dataArray[i];
        [xTitles addObject:arr[0]];
    }
    return xTitles;
}

#pragma mark - @required
//横坐标标题数组
- (NSArray *)chartConfigAxisXLabel:(UUChart *)chart
{
    return [self getXTitles:(int)self.dataArray.count];
}
//数值多重数组
- (NSArray *)chartConfigAxisYValue:(UUChart *)chart
{
    
//    NSArray *arr = @[@"10" , @"14" , @"15" , @"2" , @"3" , @"4" , @"6" , @"2"];
    NSMutableArray *array = [NSMutableArray array];
    for (int i = 0; i < self.dataArray.count; i++) {
        
        NSArray *arr = self.dataArray[i];
        [array addObject:arr[1]];
    }
    
    return @[array];
    
}

#pragma mark - @optional
//颜色数组
- (NSArray *)chartConfigColors:(UUChart *)chart
{
    return @[kMainColor];
}
//显示数值范围
- (CGRange)chartRange:(UUChart *)chart
{
    return CGRangeMake(24, 0);
}

#pragma mark 折线图专享功能

//标记数值区域
- (CGRange)chartHighlightRangeInLine:(UUChart *)chart
{
    return CGRangeZero;
}

//判断显示横线条
- (BOOL)chart:(UUChart *)chart showHorizonLineAtIndex:(NSInteger)index
{
    return YES;
}

//判断显示最大最小值
- (BOOL)chart:(UUChart *)chart showMaxMinAtIndex:(NSInteger)index
{
    return YES;
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    
    NSArray *array = [NSArray arrayWithArray:self.view.subviews];
    for (int i = 0; i < array.count; i++) {
        [array[i] removeFromSuperview];
    }
}

@end
