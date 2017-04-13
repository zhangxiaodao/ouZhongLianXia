//
//  AirPuritionGengDuoForthTableViewCell.m
//  联侠
//
//  Created by 杭州阿尔法特 on 16/6/14.
//  Copyright © 2016年 张海昌. All rights reserved.
//

#import "AirPuritionGengDuoForthTableViewCell.h"
#import "UUChart.h"
#import "LiShiModel.h"


#define kBtnW (((kScreenW - kScreenW / 8) / 4) - 5)
#define kContentViewHeight kBtnW * 2 + kBtnW * 2 / 3
@interface AirPuritionGengDuoForthTableViewCell ()<UUChartDataSource , HelpFunctionDelegate>
@property (nonatomic , strong) UIView *forthView;
@property (nonatomic , strong) NSMutableArray *shiWaiDataArray;
@property (nonatomic , strong) NSMutableArray *shiNeiDataArray;
@property (nonatomic , strong) UUChart *chartView;
//@property (nonatomic , strong) NSMutableArray *dateArray;

@end

@implementation AirPuritionGengDuoForthTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        NSDictionary *parames = @{@"city" : [kStanderDefault objectForKey:@"cityName"]};
        [HelpFunction requestDataWithUrlString:kLiShiKongQiZhiLiang andParames:parames andDelegate:self];
        
        
        [self customUI];
    }
    return self;
}

- (void)customUI {
    
    //    [self creatDateArray];
    
    
    self.forthView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenW, kScreenH / 2.9)];
    [self.contentView addSubview:self.forthView];
}

- (void)requestKongQiZhiLiangShuJu:(HelpFunction *)request didYes:(NSDictionary *)dic {
//    NSLog(@"%@" , dic);
    
    NSArray *data = dic[@"data"];
    _shiWaiDataArray = [NSMutableArray array];
    for (NSDictionary *ddd in data) {
        LiShiModel *liShiModel = [[LiShiModel alloc]init];
        [liShiModel setValuesForKeysWithDictionary:ddd];
        [_shiWaiDataArray addObject:liShiModel];
//        NSLog(@"%@" , liShiModel.aqiDate);
    }
//    NSLog(@"%@" , self.shiWaiDataArray);
    [self configUI:self.forthView];
}

- (void)requestData:(HelpFunction *)request didFailLoadData:(NSError *)error {
    NSLog(@"%@" , error);
}

#pragma mark - 生成线状图
- (void)configUI:(UIView *)superView
{
    _titleLable = [UILabel creatLableWithTitle:@"PM2.5一周走势对比图" andSuperView:self.forthView andFont:k15 andTextAligment:NSTextAlignmentLeft];
    [_titleLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kScreenW * 1 / 2, kScreenW / 10));
        make.left.mas_equalTo(self.forthView.mas_left).offset(20);
        make.top.mas_equalTo(self.forthView.mas_top);
    }];
    
    
    _shiNeiHeShiWai = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"shiNeiHeShiWai"]];
    [self.forthView addSubview:_shiNeiHeShiWai];
    [_shiNeiHeShiWai mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kScreenW / 4, kScreenW / 28));
        make.centerY.mas_equalTo(_titleLable.mas_centerY);
        make.left.mas_equalTo(_titleLable.mas_right);
    }];
    
    if (_chartView) {
        [_chartView removeFromSuperview];
        _chartView = nil;
    }
    
    
    _chartView = [[UUChart alloc]initWithFrame:CGRectMake(20, kScreenW / 10, kScreenW - 40, kContentViewHeight - 40) dataSource:self style:UUChartStyleLine];
    
    [_chartView showInView:superView];
    
    [UIView creatBottomFenGeView:self.forthView andBackGroundColor:[UIColor whiteColor] isOrNotAllLenth:@"YES"];
}

#pragma mark - 线状图的X坐标数据
- (NSArray *)getXTitles:(int)num
{
    NSMutableArray *xTitles = [NSMutableArray array];
//    NSLog(@"%@" , self.shiWaiDataArray);
    for (int i = 0; i < num; i++) {
        LiShiModel *model = [[LiShiModel alloc]init];
        model = self.shiWaiDataArray[i];
        model.aqiDate = [model.aqiDate substringWithRange:NSMakeRange(5, 5)];
        [xTitles addObject:model.aqiDate];
//        NSLog(@"%@" , model.aqiDate);
    }
    return xTitles;
}

#pragma mark - @required
//横坐标标题数组
- (NSArray *)chartConfigAxisXLabel:(UUChart *)chart
{
    return [self getXTitles:(int)self.shiWaiDataArray.count];
}
//数值多重数组
- (NSArray *)chartConfigAxisYValue:(UUChart *)chart
{
    NSMutableArray *array = [NSMutableArray array];
    NSMutableArray *array1 = [NSMutableArray array];
    for (int i = 0; i < self.shiNeiDataArray.count; i++) {
        
        NSArray *arr = self.shiNeiDataArray[i];
        [array addObject:arr[0]];
    }
    
    for (int i = 0; i < self.shiWaiDataArray.count; i++) {
        
        LiShiModel *model = [[LiShiModel alloc]init];
        model = self.shiWaiDataArray[i];
        
//        NSArray *arr = self.shiWaiDataArray[i];
        [array1 addObject:model.aqi];
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
    return CGRangeMake(350, -50);
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



- (NSString *)timeAndAfterHours:(NSNumber *)hour andAfterDays:(NSNumber *)day andMonth:(NSNumber *)month {
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *comps = nil;
    
    comps = [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay|NSCalendarUnitWeekday fromDate:[NSDate date]];
    
    NSDateComponents *adcomps = [[NSDateComponents alloc] init];
    
    if (hour) {
        [adcomps setHour:-hour.intValue];
    } else {
        [adcomps setHour:0];
    }
    
    if (day) {
        [adcomps setDay:-day.intValue];
    } else {
        [adcomps setDay:0];
    }
    
    if (month) {
        [adcomps setMonth:-month.intValue];
    } else {
        [adcomps setMonth:0];
    }
    
    NSDate *newdate = [calendar dateByAddingComponents:adcomps toDate:[NSDate date] options:0];
    NSDateFormatter *formatyer = [[NSDateFormatter alloc]init];
    [formatyer setDateFormat:@"yyyy-MM-dd HH:mm"];
    
    NSString *dateTime = [formatyer stringFromDate:newdate];
    
    NSString *subStr = nil;
    
    if (hour) {
        subStr = [NSString stringWithFormat:@"%@点" , [dateTime substringWithRange:NSMakeRange(11, 2)]];
    } else if (day) {
        subStr = [dateTime substringWithRange:NSMakeRange(5, 5)];
    } else if (month) {
        subStr = [NSString stringWithFormat:@"%@月份" , [dateTime substringWithRange:NSMakeRange(5, 2)]];
    }
    
    return subStr;
}


- (NSMutableArray *)shiNeiDataArray{
    if (!_shiNeiDataArray) {
        self.shiNeiDataArray = [NSMutableArray arrayWithObjects:@[@"12"] , @[@"23"] , @[@"31"] , nil];
    }
    return _shiNeiDataArray;
}

@end
