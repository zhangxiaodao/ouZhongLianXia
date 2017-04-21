//
//  AirThirtTableViewCell.m
//  联侠
//
//  Created by 杭州阿尔法特 on 16/6/1.
//  Copyright © 2016年 张海昌. All rights reserved.
//

#import "AirThirtTableViewCell.h"
#import "AirgengDuoViewController.h"
#import "LiShiModel.h"

#define kBtnW (((kScreenW - kScreenW / 8) / 4) - 5)
#define kContentViewHeight kBtnW * 2 + kBtnW * 2 / 3
@interface AirThirtTableViewCell ()< UUChartDataSource , HelpFunctionDelegate>{
    UIView *view;
//    NSMutableArray *pm25Key;
//    NSMutableArray *pm25Value;
}

@property (nonatomic , strong) NSMutableArray *shiNeiPm25Value;
@property (nonatomic , strong) NSMutableArray *shiNeiPm25Key;

@property (nonatomic , strong) NSMutableArray *shiWaipm25Key;
@property (nonatomic , strong) NSMutableArray *shiWaiPm25Value;

@property (nonatomic , strong) UUChart *chartView;
@property (nonatomic , strong) UILabel *titleLable;
@property (nonatomic , strong) UILabel *gengDuoLable;
//@property (nonatomic , strong) NSMutableArray *dateArray;
@end

@implementation AirThirtTableViewCell

- (NSMutableArray *)shiNeiPm25Key {
    if (!_shiNeiPm25Key) {
        _shiNeiPm25Key = [NSMutableArray array];
    }
    return _shiNeiPm25Key;
}

- (NSMutableArray *)shiNeiPm25Value {
    if (!_shiNeiPm25Value) {
        _shiNeiPm25Value = [NSMutableArray array];
    }
    return _shiNeiPm25Value;
}

- (NSMutableArray *)shiWaipm25Key {
    if (!_shiWaipm25Key) {
        _shiWaipm25Key = [NSMutableArray array];
    }
    return _shiWaipm25Key;
}

- (NSMutableArray *)shiWaiPm25Value {
    if (!_shiWaiPm25Value) {
        _shiWaiPm25Value = [NSMutableArray array];
    }
    return _shiWaiPm25Value;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self customUI];
    }
    return self;
}

- (void)customUI{
    
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    view = [[UIView alloc]init];
    view.backgroundColor = [UIColor whiteColor];
    view.frame = CGRectMake(0, 0, kScreenW, kBtnW * 2 + kBtnW * 3 / 4);
    [self.contentView addSubview:view];
    
    _titleLable = [UILabel creatLableWithTitle:@"PM2.5走势对比图" andSuperView:view andFont:k15 andTextAligment:NSTextAlignmentLeft];
    [_titleLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kScreenW * 1 / 3 + 30, kScreenW / 10));
        make.left.mas_equalTo(view.mas_left).offset(20);
        make.top.mas_equalTo(view.mas_top);
    }];
    _titleLable.textColor = [UIColor blackColor];
//    _titleLable.backgroundColor = [UIColor redColor];
    

    UIImageView *shiNeiHeShiWai = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"shiNeiHeShiWai"]];
    [view addSubview:shiNeiHeShiWai];
    [shiNeiHeShiWai mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kScreenW / 4, kScreenW / 28));
        make.centerY.mas_equalTo(_titleLable.mas_centerY);
        make.left.mas_equalTo(_titleLable.mas_right);
    }];
//    shiNeiHeShiWai.backgroundColor = [UIColor greenColor];

    _gengDuoLable = [UILabel creatLableWithTitle:@"更多数据" andSuperView:view andFont:k15 andTextAligment:NSTextAlignmentCenter];
    [_gengDuoLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kScreenW / 5, kScreenW / 10));
        make.centerY.mas_equalTo(_titleLable.mas_centerY);
        make.right.mas_equalTo(view.mas_right).offset(-20);
    }];
    _gengDuoLable.userInteractionEnabled = YES;
    _gengDuoLable.textColor = kKongJingYanSe;
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAtcion:)];
    [_gengDuoLable addGestureRecognizer:tap];
    
    [self configUI:view];
    
    
}

#pragma mark - 更多的点击事件
- (void)tapAtcion:(UITapGestureRecognizer *)tap {
    AirgengDuoViewController *airGengDuoVC = [[AirgengDuoViewController alloc]init];
    
//    airGengDuoVC.shiNeiPm25 = @{[_shiNeiPm25Key lastObject] : [_shiNeiPm25Value lastObject]};
    
    
    if (_shiNeiPm25Value.count > 0 && _shiWaiPm25Value.count > 0) {
        airGengDuoVC.shiWaiPm25 = [_shiWaiPm25Value lastObject];
        airGengDuoVC.shiNeiPm25 = [_shiNeiPm25Value lastObject];
    }
    
    airGengDuoVC.userModel = [[UserModel alloc]init];
    airGengDuoVC.userModel = self.model;
    airGengDuoVC.serviceDataModel = [[ServicesDataModel alloc]init];
    airGengDuoVC.serviceDataModel = self.serviceDataModel;
    
    airGengDuoVC.serviceModel = [[ServicesModel alloc]init];
    airGengDuoVC.serviceModel = self.serviceModel;
    
    airGengDuoVC.stateModel = self.stateModel;
    
    airGengDuoVC.sumLvXinTime = kKongJingLvXinShouMing;
    [self.airVC.navigationController pushViewController:airGengDuoVC animated:YES];
}

#pragma mark - 生成线状图
- (void)configUI:(UIView *)superView
{
    if (_chartView) {
        [_chartView removeFromSuperview];
        _chartView = nil;
    }
    
    
    _chartView = [[UUChart alloc]initWithFrame:CGRectMake(20, kScreenW / 10, kScreenW - 40, kContentViewHeight - 40) dataSource:self style:UUChartStyleLine];
    
    [_chartView showInView:superView];
    
}

#pragma mark - 线状图的X坐标数据
- (NSArray *)getXTitles:(int)num
{
    NSMutableArray *xTitles = [NSMutableArray array];
   
    for (int i = 0; i < num; i++) {
        
        if (_shiNeiPm25Key.count == _shiWaipm25Key.count) {
            [xTitles addObject:_shiNeiPm25Key[i]];
        } else {
            
            if (_shiNeiPm25Key.count < _shiWaipm25Key.count) {
                [xTitles addObject:_shiNeiPm25Key[i]];
            } else if (_shiNeiPm25Key.count > _shiWaipm25Key.count) {
                [xTitles addObject:_shiWaipm25Key[i]];
            }
            
        }
    }
    return xTitles;
}

#pragma mark - @required
//横坐标标题数组
- (NSArray *)chartConfigAxisXLabel:(UUChart *)chart
{
    
    if (_shiNeiPm25Key.count == _shiWaipm25Key.count) {
        return [self getXTitles:(int)_shiNeiPm25Key.count];
    } else {
        NSInteger count = _shiNeiPm25Key.count < _shiWaipm25Key.count ? _shiNeiPm25Key.count : _shiWaipm25Key.count;
        return [self getXTitles:(int)count];
    }
    
    
}
//数值多重数组
- (NSArray *)chartConfigAxisYValue:(UUChart *)chart
{
    
    NSMutableArray *array = [NSMutableArray array];
    NSMutableArray *array1 = [NSMutableArray array];
    
    NSInteger count = _shiNeiPm25Value.count < _shiWaiPm25Value.count ? _shiNeiPm25Value.count : _shiWaiPm25Value.count;
    for (int i = 0; i < count; i++) {
        [array addObject:_shiNeiPm25Value[i]];
        [array1 addObject: _shiWaiPm25Value[i]];
    }
    

    return @[array , array1];
}

#pragma mark - @optional
//颜色数组
- (NSArray *)chartConfigColors:(UUChart *)chart
{
    if (_shiNeiPm25Value.count > 0 && _shiWaiPm25Value.count > 0) {
        return @[kKongJingYanSe , kZiSe];
    } else if (_shiNeiPm25Value.count > 0) {
        return @[kKongJingYanSe];
    } else  {
        return @[kZiSe];
    }
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
    return NO;
}

- (void)setModel:(UserModel *)model {
    _model = model;
}

- (void)setServiceDataModel:(ServicesDataModel *)serviceDataModel {
    _serviceDataModel = serviceDataModel;
}

- (void)setServiceModel:(ServicesModel *)serviceModel {
    _serviceModel = serviceModel;
    
    
    if ([kStanderDefault objectForKey:@"cityName"]) {
        NSString *city = [kStanderDefault objectForKey:@"cityName"];
        NSDictionary *parames2 = @{@"city" : city , @"times" : @12};
        NSLog(@"%@" , parames2);
        [HelpFunction requestDataWithUrlString:kDangTianKongQiZhiLiang andParames:parames2 andDelegate:self];
    }
    
}


- (void)requestKongQiZhiLiangShuJu:(HelpFunction *)request didYes:(NSDictionary *)dic {
//    NSLog(@"室外%@" , dic);
    
    
    [self shiWaipm25Key];
    [self shiWaiPm25Value];
    if ([dic[@"data"] isKindOfClass:[NSDictionary class]]) {
        NSDictionary *data = dic[@"data"];
        NSDictionary *pm25 = data[@"pm25"];
        NSArray *pm25AllKeys = [pm25 allKeys];
        NSMutableArray *timeArray = [self get24TimesFromNowTime];
        
        
        [_shiWaipm25Key removeAllObjects];
        [_shiWaiPm25Value removeAllObjects];
        for (NSString *times in timeArray) {
            for (NSString *key in pm25AllKeys) {
                if ([times isEqualToString:key]) {
                    
                    if (![pm25[times] isKindOfClass:[NSNull class]]) {
                        [_shiWaipm25Key addObject:times];
                        [_shiWaiPm25Value addObject:@([pm25[times] integerValue])];
                    }
                    
                }
            }
        }
        
        
        if (timeArray.count > 0) {
            
            NSString *lastTime = [timeArray lastObject];
            NSDictionary *parames = @{@"devTypeSn" : _serviceModel.devTypeSn , @"devSn" : _serviceModel.devSn , @"times" : @12  , @"lastTime" : @(lastTime.integerValue)};
            
            [HelpFunction requestDataWithUrlString:kKongJingPM25State andParames:parames andDelegate:self];
        }
    }
    
}

- (void)requestData:(HelpFunction *)request didSuccess:(NSDictionary *)dddd {

//    NSLog(@"室内%@" , dddd);
    
    [self shiNeiPm25Key];
    [self shiNeiPm25Value];
    
    if ([dddd[@"data"] isKindOfClass:[NSDictionary class]]) {
        NSDictionary *data = dddd[@"data"];
        
//        self.dateArray = [self dateArray];
        
        NSMutableArray *keys = [[data allKeys] mutableCopy];
        
        NSMutableArray *timeArray = [self get24TimesFromNowTime];
       
//        NSLog(@"%@" , timeArray);
        [_shiNeiPm25Key removeAllObjects];
        [_shiNeiPm25Value removeAllObjects];
        for (NSString *times in timeArray) {
            for (NSString *key in keys) {
                if ([times isEqualToString:key]) {
                    
                    
                    if (![data[times] isKindOfClass:[NSNull class]]) {
                        [_shiNeiPm25Key addObject:times];
                        [_shiNeiPm25Value addObject:@([data[times] integerValue] / 4) ];
                    }
                    
                }
            }
        }
        
        NSInteger length = _shiNeiPm25Value.count;
        for (NSInteger i = length - 1; i >= 0; i--) {
            
            if ([_shiNeiPm25Value[length - 1] isKindOfClass:[NSNull class]]) {
                [_shiNeiPm25Key removeAllObjects];
                
            } else {
                
                if ([_shiNeiPm25Value[i] isKindOfClass:[NSNull class]] ) {
                    
                    _shiNeiPm25Value[i] = _shiNeiPm25Value[i + 1];
                }
            }
            
            
        }
        
        if (_shiNeiPm25Key.count > 0 && _shiNeiPm25Value.count > 0) {
            [self configUI:view];
        }
        
//        NSLog(@"AAAAA室内KEY%@ , 室内值%@ , 室外KEY%@ , 室外值%@" , _shiNeiPm25Key , _shiNeiPm25Value , _shiWaipm25Key , _shiWaiPm25Value);
        
    }
}

- (void)requestData:(HelpFunction *)request didFailLoadData:(NSError *)error {
    NSLog(@"%@" , error);
}

- (NSMutableArray *)get24TimesFromNowTime{
    
    NSMutableArray *timeArray = [NSMutableArray array];
    for (int i = 24; i > 0; i = i - 2) {
        
        NSString *time = [NSString timeAndAfterHours:@(i) andAfterDays:nil andMonth:nil];
        time = [time substringToIndex:time.length - 1];
        
        if (time.intValue < 10) {
            time = [time substringFromIndex:1];
        }
        if (time.intValue % 2 != 0 ) {
            time = [NSString stringWithFormat:@"%d" , time.intValue - 1];
        }
        [timeArray addObject:time];
    }
    return timeArray;
    
}

- (void)setStateModel:(StateModel *)stateModel {
    _stateModel = stateModel;
}

@end
