//
//  HelpFunction.m
//  知晓时代
//
//  Created by laouhn on 15/12/16.
//  Copyright (c) 2015年 laouhn. All rights reserved.
//

#import "HelpFunction.h"
#import "MessageModel.h"
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>
#import <CoreLocation/CLLocation.h>
#import "AFNetworking.h"

@interface HelpFunction ()
@property (nonatomic,strong) NSMutableArray *dataArray;
@property (nonatomic,strong) NSMutableArray *shouYeDataArray;
@property (nonatomic,strong) NSMutableArray *typesArray;
@property (nonatomic,strong) NSMutableDictionary *numArray;
@property (nonatomic,strong) NSError *error;
@property (nonatomic , strong) NSMutableArray *wearthArray;

@property (strong, nonatomic)  UILabel *longitude;
@property (strong, nonatomic)  UILabel *latitude;
@property (strong, nonatomic)  UILabel *location;

@property (nonatomic , strong) NSString *cityName;
@property (nonatomic , strong) NSMutableDictionary *wearthDic;

@end

static HelpFunction *_request = nil;

@implementation HelpFunction

#pragma mark - 单例
+ (HelpFunction *)shareHelpFunction{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _request = [[HelpFunction alloc]init];
    });
    return _request;
}

#pragma mark - 初始化方法
- (HelpFunction *)initWithUrlString:(NSString *)urlString andPage:(NSInteger)page andDelegate:(id<HelpFunctionDelegate>)delegate{
    self = [super init];
    if (self) {
        self.urlString = urlString;
        self.page = page;
        self.delegate = delegate;
    }
    return self;
}

#pragma mark - 另一个初始化方法
- (HelpFunction *)initWithUrl:(NSString *)str andParames:(NSDictionary *)parames andDelegate:(id<HelpFunctionDelegate>)delegate {
    self = [super init];
    if (self) {
        self.urlString = str;
        self.parames = parames;
        self.delegate = delegate;
    }
    return self;
}

+ (HelpFunction *)requestDataWithUrlString:(NSString *)urlString andParames:(NSDictionary *)parames andDelegate:(id<HelpFunctionDelegate>)delegate{
    HelpFunction *requestData = [[HelpFunction alloc]initWithUrl:urlString andParames:parames andDelegate:delegate];
    [requestData startRequestData:parames];
    return requestData;
}

#pragma mark - 类方法
//第三个初始化方法
- (HelpFunction *)initWithUrl:(NSString *)str andParames:(NSDictionary *)parames andImage:(UIImage *)image andDelegate:(id<HelpFunctionDelegate>)delegate {
    self = [super init];
    if (self) {
        self.urlString = str;
        self.parames = parames;
        self.image = image;
        self.delegate = delegate;
    }
    return self;
}

+ (HelpFunction *)requestDataWithUrlString:(NSString *)urlString andParames:(NSDictionary *)parames andImage:(UIImage *)image andDelegate:(id<HelpFunctionDelegate>)delegate{
    HelpFunction *requsst = [[HelpFunction alloc]initWithUrl:urlString andParames:parames andImage:image andDelegate:delegate];
    [requsst startRequestData:parames andImage:image];

    return requsst;
}

- (HelpFunction *)initWearthDataWithDelegate:(id<HelpFunctionDelegate>)delegate andCityName:(NSString *)cityName{
    self = [super init];
    if (self) {
        self.delegate = delegate;
        self.cityName = cityName;
    }
    return self;
}

+ (HelpFunction *)requestWeatherDataWithDelegate:(id<HelpFunctionDelegate>)delegate andCityName:(NSString *)cityName{
    HelpFunction *request = [[HelpFunction alloc]initWearthDataWithDelegate:delegate andCityName:cityName];
    
    [request getCityWeather];
    return request;
    
}


#pragma mark - 获取所在城市天气状况
- (void)getCityWeather{
    
    
    [self.wearthDic setObject:self.cityName forKey:@"cityName"];
   
    NSString *httpUrl = @"http://api.k780.com:88/";
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    if ([self.cityName isKindOfClass:[NSNull class]]) {
        return ;
    }
    
    self.cityName = [self.cityName substringToIndex:self.cityName.length - 1];
    
    NSDictionary *parames = @{@"app" : @"weather.today" , @"weaid" : self.cityName , @"appkey" : @"24331" , @"sign" : @"9565f573f3b10e63f5bed3cf04551a3c" , @"format" : @"json"};
    
    [manager POST:httpUrl parameters:parames progress:^(NSProgress * _Nonnull uploadProgress) {
        return ;
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSLog(@"%@" , dic);
        
        if ([dic[@"success"] integerValue] == 0) {
            return ;
        }
        
        NSDictionary *result = dic[@"result"];
        NSString *str = result[@"weather"];
        UIImage *image = nil;
        if ([str containsString:@"晴"]) {
            image = [UIImage imageNamed:@"icon_qing"];
        } else if ([str containsString:@"雷"]) {
            image = [UIImage imageNamed:@"icon_leiyu"];
        } else if ([str containsString:@"雨夹雪"]) {
            image = [UIImage imageNamed:@"icon_yuxue"];
        } else if ([str containsString:@"多云"] || [str containsString:@"阴"]) {
                image = [UIImage imageNamed:@"icon_duoyun"];
        } else if ([str containsString:@"雪"]) {
                image = [UIImage imageNamed:@"icon_xue"];
        }  else if ([str containsString:@"多云转晴"]) {
                image = [UIImage imageNamed:@"icon_duoyunzhuanqing"];
        } else if ([str containsString:@"雨"]) {
                image = [UIImage imageNamed:@"icon_yu"];
        }
        NSArray *arrImage = [NSArray arrayWithObjects:[UIImage imageNamed:@"icon_qing"], [UIImage imageNamed:@"icon_leiyu"], [UIImage imageNamed:@"icon_yuxue"], [UIImage imageNamed:@"icon_duoyun"], [UIImage imageNamed:@"icon_xue"], [UIImage imageNamed:@"icon_yu"], [UIImage imageNamed:@"icon_duoyunzhuanqing"],  nil];
        NSUInteger index = [arrImage indexOfObject:image];
        
        [self.wearthDic setObject:result[@"humidity"] forKey:@"humidity"];
        [self.wearthDic setObject:result[@"temp_curr"] forKey:@"temp_curr"];
        [self.wearthDic setObject:result[@"weather_curr"] forKey:@"weather_curr"];
        [self.wearthDic setObject:result[@"weather"] forKey:@"weather"];
    
        NSString *path = [[NSBundle mainBundle]pathForResource:@"Wind" ofType:@"plist"];
        NSDictionary *windDic = [NSDictionary dictionaryWithContentsOfFile:path];
        
        [self.wearthDic setObject:windDic[result[@"winp"]] forKey:@"winp"];
        
        [self.wearthDic setObject:@(index) forKey:@"weather_icon"];
        
        NSString *pm25URL = @"http://api.k780.com:88/";
        AFHTTPSessionManager *pm25manager = [AFHTTPSessionManager manager];
        pm25manager.responseSerializer = [AFHTTPResponseSerializer serializer];
        
        if ([self.cityName isKindOfClass:[NSNull class]]) {
            return ;
        }
        NSDictionary *pm25parames = @{@"app" : @"weather.pm25" , @"weaid" : self.cityName , @"appkey" : @"24331" , @"sign" : @"9565f573f3b10e63f5bed3cf04551a3c" , @"format" : @"json"};
        [pm25manager POST:pm25URL parameters:pm25parames progress:^(NSProgress * _Nonnull uploadProgress) {
            return ;
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            NSDictionary *dicc = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
            
            if ([dicc[@"result"] isKindOfClass:[NSNull class]]) {
                return ;
            }
            NSDictionary *result = dicc[@"result"];
            [self.wearthDic setObject:result[@"aqi_levnm"] forKey:@"quality"];
            
            [self.wearthArray addObject:self.wearthDic];
            NSLog(@"%@" , self.wearthDic);
            if (self.wearthArray.count > 0 && _delegate && [_delegate respondsToSelector:@selector(requestWearthData:didDone:)]) {
                [_delegate requestWearthData:self didDone:self.wearthArray];
            } else {
                [_delegate requestData:self didFailLoadData:self.error];
            }
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            return ;
        }];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        return ;
    }];
    
    
}

- (void)startRequestData:(NSDictionary *)parames andImage:(UIImage *)image {
    if (self.urlString.length == 0) {
        return ;
    }
    //图片缩放
    NSData *data = UIImageJPEGRepresentation(image, 0.5);
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyyMMddHHmmss";
    NSString *str = [formatter stringFromDate:[NSDate date]];
    NSString *fileName = [NSString stringWithFormat:@"%@.jpg", str];
    
    NSString *strUrl = [self.urlString stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];

    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [manager POST:strUrl parameters:parames constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        [formData appendPartWithFileData:data name:@"files" fileName:fileName mimeType:@"image/jpg"];
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        NSLog(@"");
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        
        
        if ( _delegate && [_delegate respondsToSelector:@selector(requestData:didSuccess:)]) {
            [_delegate requestData:self didSuccess:dic];
        } else {
            [_delegate requestData:self didFailLoadData:self.error];
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"头像上传失败");
    }];
    
}

#pragma mark - 请求数据
- (void)startRequestData:(NSDictionary *)parames{
    if (self.urlString.length == 0) {
        return ;
    }
    
    
    AFHTTPSessionManager *mananger = [AFHTTPSessionManager manager];
    mananger.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [mananger POST:self.urlString parameters:parames progress:^(NSProgress * _Nonnull uploadProgress) {
        NSLog(@"");
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        
        if ([self.urlString isEqualToString:kXiaoXiJieKou] || [self.urlString isEqualToString:kXiuGaiXinXi] || [self.urlString isEqualToString:kYongHuFanKui] || [self.urlString isEqualToString:kJiaoYanZhangHu] || [self.urlString isEqualToString:kChaXunLengFengShanDangQianZhuangTai] || [self.urlString isEqualToString:kChaXunKongJingDangQianZhuangTai] || [self.urlString isEqualToString:kChaXunGanYiJiZhuangTai] || [self.urlString isEqualToString:kXiuGaiYongHuDiZhi] || [self.urlString isEqualToString:kChongZhiMiMa] || [self.urlString isEqualToString:kShangChuanTouXiang] || [self.urlString isEqualToString:kLengFengShanDingShiYuYue] || [self.urlString isEqualToString:kGanYiJiDeDingShiURL]|| [self.urlString isEqualToString:kChaXunBanBenHao] || [self.urlString isEqualToString:kKongJingPM25State] || [self.urlString isEqualToString:kSystemMessageJieKou]) {
            
            if ( _delegate && [_delegate respondsToSelector:@selector(requestData:didSuccess:)]) {
                [_delegate requestData:self didSuccess:dic];
            }
            
            
        } else if ([self.urlString isEqualToString:kLogin] || [self.urlString isEqualToString:kFaSongDuanXin] || [self.urlString isEqualToString:kGengDuoChanPin] || [self.urlString isEqualToString:kChaXunYongHuDiZhi] || [self.urlString isEqualToString:kLengFengShanLiShiJiLu] || [self.urlString isEqualToString:kKongJingLiShiJiLu] || [self.urlString isEqualToString:kChaXunGanYiJiLiShiShuJu] || [self.urlString isEqualToString:kAllTypeServiceURL] || [self.urlString isEqualToString:kBindLengFengShanURL] || [self.urlString isEqualToString:kBindGanYiJiURL] || [self.urlString isEqualToString:kBindKongQiJingHuaQiURL]) {
            
            if (dic) {
                [self.dataArray addObject:dic];
            }

            if (self.dataArray.count > 0 && _delegate && [_delegate respondsToSelector:@selector(requestData:didFinishLoadingDtaArray:)]) {
                [_delegate requestData:self didFinishLoadingDtaArray:self.dataArray];
            } else {
                [_delegate requestData:self didFailLoadData:self.error];
            }
            
            
            
        } else if ([self.urlString isEqualToString:kChaXunLengFengShanDangQianShuJu] || [self.urlString isEqualToString:kChaXunKongJingDangQianShuJu] || [self.urlString isEqualToString:kChaXunGanYiJiShuJu] || [self.urlString isEqualToString:kKongJingDingShiYuYue] || [self.urlString isEqualToString:kRegisterURL]) {
            
            [self.dataArray addObject:dic];
            if (self.dataArray.count > 0 && _delegate && [_delegate respondsToSelector:@selector(requestServicesData:didOK:)]) {
                [_delegate requestServicesData:self didOK:dic];
            } else {
                [_delegate requestData:self didFailLoadData:self.error];
            }
            
        } else if ([self.urlString isEqualToString:kGetKongJingTiming]) {
            if (_delegate && [_delegate respondsToSelector:@selector(requestServicesTimeing:)]) {
                [_delegate requestServicesTimeing:dic];
            } else {
                [_delegate requestData:self didFailLoadData:self.error];
            }
        } else if ([self.urlString isEqualToString:kLengFengShanFuWi]) {
            if (_delegate && [_delegate respondsToSelector:@selector(requestFuWeiShuJu:didYes:)]) {
                [_delegate requestFuWeiShuJu:self didYes:dic];
            } else {
                [_delegate requestData:self didFailLoadData:self.error];
            }
        } else if ([self.urlString isEqualToString:kLiShiKongQiZhiLiang]) {
            if (_delegate && [_delegate respondsToSelector:@selector(requestKongQiZhiLiangShuJu:didYes:)]) {
                [_delegate requestKongQiZhiLiangShuJu:self didYes:dic];;
            } else {
                [_delegate requestData:self didFailLoadData:self.error];
            }
        } else if ([self.urlString isEqualToString:kDangTianKongQiZhiLiang]) {
            if (_delegate && [_delegate respondsToSelector:@selector(requestKongQiZhiLiangShuJu:didYes:)]) {
                [_delegate requestKongQiZhiLiangShuJu:self didYes:dic];
            } else {
                [_delegate requestData:self didFailLoadData:self.error];
            }
        } else if ([self.urlString isEqualToString:kDeleteServiceURL]) {
            if (_delegate && [_delegate respondsToSelector:@selector(requestRemoveService:didDone:)]) {

                [_delegate requestRemoveService:self didDone:dic];
            } else {
                [_delegate requestData:self didFailLoadData:self.error];
            }
        } else if ([self.urlString isEqualToString:kQueryTheUserdevice]) {
            if (_delegate && [_delegate respondsToSelector:@selector(requestData:queryUserdevice:)]) {
                [_delegate requestData:self queryUserdevice:dic];
            } else {
                [_delegate requestData:self didFailLoadData:self.error];
            }
        } else if ([self.urlString isEqualToString:kUserReadSystemMessageCount]) {
            if (_delegate && [_delegate respondsToSelector:@selector(requestDataWithDontHaveReturnValue:)]) {
                [_delegate requestDataWithDontHaveReturnValue:self];
            }
        } else if ([self.urlString isEqualToString:kChangeServiceName]) {
            if (_delegate && [_delegate respondsToSelector:@selector(requestData:changeServiceName:)]) {
                [_delegate requestData:self changeServiceName:dic];
            }
        } else {
            [self.dataArray addObject:dic];
            if (self.dataArray.count > 0 && _delegate && [_delegate respondsToSelector:@selector(requestData:didFinishLoadingDtaArray:)]) {
                [_delegate requestData:self didFinishLoadingDtaArray:self.dataArray];
            } else {
                [_delegate requestData:self didFailLoadData:self.error];
            }
            
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"CCCCCCCC");
        
        [_delegate requestData:self didFailLoadData:self.error];
    }];
    
}




- (NSMutableDictionary *)numArray{
    if (!_numArray) {
        self.numArray =[NSMutableDictionary dictionary];
    }
    return _numArray;
}

- (NSMutableArray *)shouYeDataArray{
    if (!_shouYeDataArray) {
        self.shouYeDataArray = [NSMutableArray array];
    }
    return _shouYeDataArray;
}

- (NSMutableArray *)dataArray{
    if (!_dataArray) {
        self.dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

- (NSMutableArray *)typesArray{
    if (!_typesArray) {
        self.typesArray = [NSMutableArray array];
    }
    return _typesArray;
}

- (NSMutableArray *)wearthArray {
    if (!_wearthArray) {
        self.wearthArray = [NSMutableArray array];
    }
    return _wearthArray;
}

- (NSMutableDictionary *)wearthDic {
    if (!_wearthDic) {
        self.wearthDic = [NSMutableDictionary dictionary];
    }
    return _wearthDic;
}

@end

