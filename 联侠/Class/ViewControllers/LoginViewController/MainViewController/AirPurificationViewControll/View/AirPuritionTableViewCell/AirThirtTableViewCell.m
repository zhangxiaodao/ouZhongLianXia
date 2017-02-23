//
//  AirThirtTableViewCell.m
//  联侠
//
//  Created by 杭州阿尔法特 on 16/6/1.
//  Copyright © 2016年 张海昌. All rights reserved.
//

#import "AirThirtTableViewCell.h"
#import "UUChart.h"
#import "AirgengDuoViewController.h"


#define kBtnW (((kScreenW - kScreenW / 8) / 4) - 5)
#define kContentViewHeight kBtnW * 2 + kBtnW * 2 / 3
@interface AirThirtTableViewCell ()< UUChartDataSource , HelpFunctionDelegate>{
    UUChart *chartView;
}
@property (nonatomic , strong) NSMutableArray *shiWaiDataArray;
@property (nonatomic , strong) NSMutableArray *shiNeiDataArray;
@property (nonatomic , strong) NSMutableArray *dateArray;
@end

@implementation AirThirtTableViewCell

- (NSMutableArray *)dateArray {
    if (!_dateArray) {
        _dateArray = [NSMutableArray array];
        
        
        [_dateArray removeAllObjects];
        for (int i = (int)self.shiWaiDataArray.count - 1; i >= 0; i--) {
           [_dateArray addObject:@[[self timeAndAfterDays:i]]];
        }
        
    }
    return _dateArray;
}

- (NSMutableArray *)shiNeiDataArray{
    if (!_shiNeiDataArray) {
        self.shiNeiDataArray = [NSMutableArray arrayWithObjects:@[@"12"] , @[@"23"] , @[@"31"] , @[@"42"] , @[@"14"], nil];
    }
    return _shiNeiDataArray;
}
- (NSMutableArray *)shiWaiDataArray{
    if (!_shiWaiDataArray) {
        self.shiWaiDataArray = [NSMutableArray arrayWithObjects:@[@"20"] , @[@"25"] , @[@"56"] , @[@"56"] , @[@"45"], nil];
    }
    return _shiWaiDataArray;
}


- (NSString *)timeAndAfterDays:(NSInteger)i{
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *comps = nil;
    
    comps = [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay fromDate:[NSDate date]];
    
    NSDateComponents *adcomps = [[NSDateComponents alloc] init];
    [adcomps setYear:0];
    
    [adcomps setMonth:0];
    
    [adcomps setDay:-i];
    
    NSDate *newdate = [calendar dateByAddingComponents:adcomps toDate:[NSDate date] options:0];
    NSDateFormatter *formatyer = [[NSDateFormatter alloc]init];
    [formatyer setDateFormat:@"yyyy-MM-dd"];
    NSString *dateTime = [formatyer stringFromDate:newdate];
    NSString *subStr = [dateTime substringFromIndex:5];
    return subStr;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self customUI];
        NSDateFormatter *formatyer = [[NSDateFormatter alloc]init];
        [formatyer setDateFormat:@"yyyy-MM-dd"];
        NSString *dateTime = [formatyer stringFromDate:[NSDate date]];
        NSString *subStr = [dateTime substringFromIndex:5];
        
        NSLog(@"%@ , %@" , dateTime , subStr);
        
        
    }
    return self;
}


- (void)customUI{
    
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    UIView *view = [[UIView alloc]init];
    view.backgroundColor = [UIColor whiteColor];
    view.frame = CGRectMake(0, 0, kScreenW, kBtnW * 2 + kBtnW * 3 / 4);
    [self.contentView addSubview:view];
    
    UILabel *titleLable = [UILabel creatLableWithTitle:@"PM2.5走势对比图" andSuperView:view andFont:k20 andTextAligment:NSTextAlignmentLeft];
    [titleLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kScreenW * 2 / 3, kScreenW / 10));
        make.left.mas_equalTo(view.mas_left).offset(20);
        make.top.mas_equalTo(view.mas_top);
    }];
    
    UIImageView *imageView = [[UIImageView alloc]init];
    imageView.image = [UIImage imageNamed:@"shengLueHao"];
    [view addSubview:imageView];
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kScreenW / 10, kScreenW / 10));
        make.centerY.mas_equalTo(titleLable.mas_centerY);
        make.right.mas_equalTo(view.mas_right).offset(-20);
    }];
    imageView.userInteractionEnabled = YES;
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAtcion:)];
    [imageView addGestureRecognizer:tap];
    
    [self configUI:view];
    
    UIImageView *shiNeiHeShiWai = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"shiNeiHeShiWai"]];
    [view addSubview:shiNeiHeShiWai];
    [shiNeiHeShiWai mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kScreenW / 4, kScreenW / 28));
        make.centerX.mas_equalTo(view.mas_centerX);
        make.top.mas_equalTo(chartView.mas_bottom).offset(4);
    }];
}

#pragma mark - 更多的点击事件
- (void)tapAtcion:(UITapGestureRecognizer *)tap {
    AirgengDuoViewController *airGengDuoVC = [[AirgengDuoViewController alloc]init];
    [self.airVC.navigationController pushViewController:airGengDuoVC animated:YES];
}

#pragma mark - 生成线状图
- (void)configUI:(UIView *)superView
{
    if (chartView) {
        [chartView removeFromSuperview];
        chartView = nil;
    }
    
    
    chartView = [[UUChart alloc]initWithFrame:CGRectMake(20, kScreenW / 10, kScreenW - 40, kContentViewHeight - 40) dataSource:self style:UUChartStyleLine];
    
    [chartView showInView:superView];
    
    
    
    
    
}

#pragma mark - 线状图的X坐标数据
- (NSArray *)getXTitles:(int)num
{
    NSMutableArray *xTitles = [NSMutableArray array];
    
    for (int i = 0; i < num; i++) {
        
        NSArray *arr = self.dateArray[i];
        [xTitles addObject:arr[0]];
    }
    return xTitles;
}

#pragma mark - @required
//横坐标标题数组
- (NSArray *)chartConfigAxisXLabel:(UUChart *)chart
{
    return [self getXTitles:(int)self.dateArray.count];
}
//数值多重数组
- (NSArray *)chartConfigAxisYValue:(UUChart *)chart
{
    
    //    NSArray *arr = @[@"10" , @"14" , @"15" , @"2" , @"3" , @"4" , @"6" , @"2"];
    NSMutableArray *array = [NSMutableArray array];
    NSMutableArray *array1 = [NSMutableArray array];
    for (int i = 0; i < self.shiNeiDataArray.count; i++) {
        
        NSArray *arr = self.shiNeiDataArray[i];
        [array addObject:arr[0]];
    }
    
    for (int i = 0; i < self.shiWaiDataArray.count; i++) {
        
        NSArray *arr = self.shiWaiDataArray[i];
        [array1 addObject:arr[0]];
    }
    
    return @[array , array1];
    
}

#pragma mark - @optional
//颜色数组
- (NSArray *)chartConfigColors:(UUChart *)chart
{
    return @[[UUColor colorWithRed:50/255.0 green:201/255.0 blue:218/255.0 alpha:1.0] , [UUColor colorWithRed:182/255.0 green:157/255.0 blue:221/255.0 alpha:1.0]];
}
//显示数值范围
- (CGRange)chartRange:(UUChart *)chart
{
    return CGRangeMake(100, -50);
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

@end
