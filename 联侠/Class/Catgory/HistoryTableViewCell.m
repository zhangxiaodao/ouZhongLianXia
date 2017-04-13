//
//  HistoryTableViewCell.m
//  联侠
//
//  Created by 杭州阿尔法特 on 2017/2/22.
//  Copyright © 2017年 张海昌. All rights reserved.
//

#import "HistoryTableViewCell.h"
#import "UUChart.h"
#import "LiShiModel.h"
#define kBtnW (((kScreenW - kScreenW / 8) / 4) - 5)
#define kContentViewHeight kBtnW * 2 + kBtnW * 2 / 3

@interface HistoryTableViewCell ()<HelpFunctionDelegate , UUChartDataSource>

@property (nonatomic , strong) UIView *forthView;
@property (nonatomic , strong) NSMutableArray *dataArray;
@property (nonatomic , strong) UUChart *chaView;
@property (nonatomic , strong) UILabel *titleLable;
@end

@implementation HistoryTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self customUI];
    }
    return self;
}

- (void)customUI {
    
    self.forthView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenW, kScreenH / 2.9 - 5)];
    [self.contentView addSubview:self.forthView];
    
    _titleLable = [UILabel creatLableWithTitle:@"设备运行历史数据" andSuperView:self.forthView andFont:k15 andTextAligment:NSTextAlignmentLeft];
    [_titleLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kScreenW * 1 / 2, kScreenW / 10));
        make.left.mas_equalTo(self.forthView.mas_left).offset(20);
        make.top.mas_equalTo(self.forthView.mas_top);
    }];
    
    
    [self creatChartView];
    
    
    [UIView creatBottomFenGeView:_forthView andBackGroundColor:kFenGeXianYanSe isOrNotAllLenth:@"YES"];
}

- (void)setLiearColor:(UIColor *)liearColor {
    _liearColor = liearColor;

    if (_liearColor) {
        _titleLable.textColor = _liearColor;
    }
}

- (void)setChaXunLishiJiLu:(NSString *)chaXunLishiJiLu {
    _chaXunLishiJiLu = chaXunLishiJiLu;
}

- (void)setServiceModel:(ServicesModel *)serviceModel {
    _serviceModel = serviceModel;
    
    //    NSLog(@"%@ , %@" , _serviceModel.devTypeSn , _serviceModel.devSn);
    if (_serviceModel.devTypeSn && _serviceModel.devSn) {
        NSDictionary *parames = @{@"devTypeSn" : _serviceModel.devTypeSn , @"devSn" : _serviceModel.devSn , @"days" : @7};
        [HelpFunction requestDataWithUrlString:_chaXunLishiJiLu andParames:parames andDelegate:self];
    }
}

- (void)requestData:(HelpFunction *)request didFinishLoadingDtaArray:(NSMutableArray *)data {
    
//    NSLog(@"%@" , data);
    
    NSMutableDictionary *dddd = data[0];
    if ([dddd[@"data"] isKindOfClass:[NSArray class]]) {
        NSArray *arr = dddd[@"data"];
        
        [self.dataArray removeAllObjects];
        for (NSDictionary *dic in arr) {
            
            LiShiModel *lishiModel = [[LiShiModel alloc]init];
            [lishiModel setValuesForKeysWithDictionary:dic];
            NSString *date = [NSString stringWithFormat:@"%@" , lishiModel.useDate];
            
            NSInteger timeInterval = [NSString turnTimeToInterval:date];
            
            NSString *sunDate = [date substringWithRange:NSMakeRange(5, 5)];
            
            NSNumber *useTime = @(lishiModel.useTime / 3600000);
            
            int i = (int)(useTime.integerValue / 24);
            
            if (i >= 1 && i <= 7) {
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
        
        [self creatChartView];
    }
    
}

- (void)requestData:(HelpFunction *)request didFailLoadData:(NSError *)error {
    
}

- (void)creatChartView {
    
    if (_chaView) {
        [_chaView removeFromSuperview];
        _chaView = nil;
    }
    
    _chaView = [[UUChart alloc]initWithFrame:CGRectMake(20, kScreenW / 10, kScreenW - 40, kContentViewHeight - 40) dataSource:self style:UUChartStyleLine];
    
    [_chaView showInView:self.contentView];
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
    
    
    if (self.liearColor) {
        return @[self.liearColor];
    } else {
        return @[[UIColor whiteColor]];
    }
    
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

- (NSMutableArray *)dataArray {
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}
@end
