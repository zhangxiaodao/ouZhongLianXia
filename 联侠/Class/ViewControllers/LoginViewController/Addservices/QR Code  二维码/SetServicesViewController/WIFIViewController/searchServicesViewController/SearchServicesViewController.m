//
//  searchServicesViewController.m
//  AEFT冷风扇
//
//  Created by 杭州阿尔法特 on 16/3/26.
//  Copyright © 2016年 阿尔法特. All rights reserved.
//

#import "SearchServicesViewController.h"
#import "FailContextViewController.h"
#import "AsyncUdpSocket.h"
#import "MineSerivesViewController.h"

#import "CircleView.h"

#import "ESPTouchTask.h"
#import "ESPTouchResult.h"
#import "ESP_NetUtil.h"
#import "ESPTouchDelegate.h"

#import <SystemConfiguration/CaptiveNetwork.h>

// the three constants are used to hide soft-keyboard when user tap Enter or Return
#define HEIGHT_KEYBOARD 216
#define HEIGHT_TEXT_FIELD 30
#define HEIGHT_SPACE (6+HEIGHT_TEXT_FIELD)


@interface EspTouchDelegateImpl : NSObject<ESPTouchDelegate>

@end

@implementation EspTouchDelegateImpl

-(void) dismissAlert:(UIAlertView *)alertView
{
//    [alertView dismissWithClickedButtonIndex:[alertView cancelButtonIndex] animated:YES];
}

-(void) onEsptouchResultAddedWithResult: (ESPTouchResult *) result
{
    //    NSLog(@"EspTouchDelegateImpl onEsptouchResultAddedWithResult bssid: %@", result.bssid);
    dispatch_async(dispatch_get_main_queue(), ^{
//        [self showAlertWithResult:result];
    });
}

@end


@interface SearchServicesViewController ()<AsyncUdpSocketDelegate , HelpFunctionDelegate> {
    
}

@property (atomic, strong) ESPTouchTask *_esptouchTask;

@property (nonatomic, assign) BOOL _isConfirmState;


@property (nonatomic, strong) UIButton *_doneButton;
@property (nonatomic, strong) EspTouchDelegateImpl *_esptouchDelegate;
@property (nonatomic , strong) AsyncUdpSocket *updSocket;
@property (nonatomic , strong) UIView *navView;


@property (nonatomic , copy) NSString *devTypeSn;

@property (nonatomic , strong) NSTimer *myTimer;
@property (nonatomic , strong) CircleView *circleView;
@property (nonatomic , strong) UILabel *circleLabel;
@property (nonatomic , strong) NSTimer *progressTimer;
@property (nonatomic , assign) CGFloat index;
@property (nonatomic , strong) NSArray *protocolArray;
@end

@implementation SearchServicesViewController

- (NSArray *)protocolArray {
    if (!_protocolArray) {
        _protocolArray = [NSArray arrayWithObjects:@"HMCOLDFANA" , @"HMSMARTA2" , @"HMSMARTB1" , @"HMSMARTB2" , @"HMSMARTC1" , @"HMSMARTC2" , @"HMSMARTALL" ,nil];
    }
    return _protocolArray;
}

//- (void)setAddServiceModel:(AddServiceModel *)addServiceModel {
//    _addServiceModel = addServiceModel;
//    NSLog(@"%@" , _addServiceModel);
//
//}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.navView = [UIView creatNavView:self.view WithTarget:self action:@selector(backTap:) andTitle:@"添加设备"];
    
    
    self._isConfirmState = NO;
    self._esptouchDelegate = [[EspTouchDelegateImpl alloc]init];
    [self enableConfirmBtn];
    
    [self setUI];
    [self tapConfirmForResults];
    
    
    
}

#pragma mark - 返回主界面
- (void)backTap:(UITapGestureRecognizer *)tap {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)progressValue {
    _index++;
    _circleLabel.text = [NSString stringWithFormat:@"%.0f%%" , _index];
    _circleView.progress = _index / 100;
    
    if (_index == 32) {
        [_progressTimer setFireDate:[NSDate distantFuture]];
    }
    
    if (_index == 65) {
        [_progressTimer setFireDate:[NSDate distantFuture]];
    }
    
    if (_index == 100.0) {
        [_progressTimer invalidate];
        _progressTimer = nil;
    }
}

#pragma mark - 设置UI
- (void)setUI {
    
    _index = 0.0;
    
    
    _progressTimer = [NSTimer scheduledTimerWithTimeInterval:(double)arc4random() / 0x100000000 target:self selector:@selector(progressValue) userInfo:nil repeats:YES];
    
    _circleView = [[CircleView alloc]initWithFrame:CGRectMake((kScreenW - kScreenH / 7.4) / 2, kScreenH / 2.52, kScreenH / 7.4, kScreenH / 7.4)];
    [self.view addSubview:_circleView];
    _circleView.backgroundColor = [UIColor whiteColor];
    
    
    _circleLabel = [UILabel creatLableWithTitle:@"" andSuperView:_circleView andFont:k20 andTextAligment:NSTextAlignmentCenter];
    [_circleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kScreenW / 4, kScreenW / 20));
        make.centerX.mas_equalTo(_circleView.mas_centerX);
        make.centerY.mas_equalTo(_circleView.mas_centerY);
    }];
    _circleLabel.textColor = kMainColor;
    _circleLabel.layer.borderWidth = 0;
    
    UILabel *searchLable = [UILabel creatLableWithTitle:@"正在搜索设备..." andSuperView:self.view andFont:k15 andTextAligment:NSTextAlignmentCenter];
    searchLable.layer.borderWidth = 0;
    searchLable.textColor = [UIColor grayColor];
    [searchLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(kScreenW * 2 / 3, kScreenW / 14));
        make.top.mas_equalTo(_circleView.mas_bottom).offset(kScreenH / 12.4);
    }];
    
    
    UILabel *registerLable = [UILabel creatLableWithTitle:@"正在连接设备..." andSuperView:self.view andFont:k15 andTextAligment:NSTextAlignmentCenter];
    registerLable.layer.borderWidth = 0;
    registerLable.textColor = [UIColor grayColor];
    [registerLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(kScreenW * 2 / 3, kScreenW / 14));
        make.top.mas_equalTo(searchLable.mas_bottom);
    }];
    
    
    UILabel *addLable = [UILabel creatLableWithTitle:@"将设备添加到云端..." andSuperView:self.view andFont:k15 andTextAligment:NSTextAlignmentCenter];
    addLable.layer.borderWidth = 0;
    addLable.textColor = [UIColor grayColor];
    [addLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(kScreenW * 2 / 3, kScreenW / 14));
        make.top.mas_equalTo(registerLable.mas_bottom);
    }];
    
    
    self._isConfirmState = NO;
    
    self._esptouchDelegate = [[EspTouchDelegateImpl alloc]init];
    [self enableConfirmBtn];
}



-(void)openUDPServer{
    
    //初始化udp
    AsyncUdpSocket *tempSocket=[[AsyncUdpSocket alloc] initWithDelegate:self];
    self.updSocket=tempSocket;
    
    //绑定端口
    NSError *error = nil;
    [self.updSocket bindToPort:6004 error:&error];
    
    [self.updSocket enableBroadcast:YES error:nil];
    
    [self.updSocket joinMulticastGroup:@"255.255.255.255" error:&error];
    
    //启动接收线程
    [self.updSocket receiveWithTimeout:-1 tag:0];
    
}


//连接建好后处理相应send Events
-(void)sendMessage:(NSString*)message
{
    NSMutableString *sendString = [NSMutableString stringWithCapacity:100];
    [sendString appendString:message];
    //开始发送
    [self.updSocket sendData:[sendString dataUsingEncoding:NSUTF8StringEncoding] toHost:@"255.255.255.255"
                        port:3001
                 withTimeout:-1
                         tag:0];
    
}

-(BOOL)onUdpSocket:(AsyncUdpSocket *)sock didReceiveData:(NSData *)data withTag:(long)tag fromHost:(NSString *)host port:(UInt16)port
{
    
    [_progressTimer setFireDate:[NSDate distantPast]];
    _circleLabel.text = @"66%";
    _circleView.progress = 0.66;
    [_myTimer invalidate];
    _myTimer = nil;
    
    NSLog(@"%@" , data);
    
    NSString *str = [self convertDataToHexStr:data];
    
    NSString *subStr2 = [str substringWithRange:NSMakeRange(4, 4)];
    
    self.devTypeSn = subStr2;
    
    NSString *subStr = [str substringWithRange:NSMakeRange(10, 12)];
//    self.deviceSn = [NSString stringWithString:subStr];
    NSLog(@" devsn -- devtypeSn---%@, %@ , %@" ,  str, subStr , self.protocolArray);
    
    if ([self.devTypeSn isEqualToString:@"412a"]) {
        self.devTypeSn = @"4131";
//        self.deviceSn = [NSString stringWithString:[str substringWithRange:NSMakeRange(8, 12)]];
    }
    
    NSDictionary *parames = @{@"ud.userSn" : [kStanderDefault objectForKey:@"userSn"] ,  @"ud.devSn" : self.deviceSn , @"ud.devTypeSn" : self.devTypeSn};
    
    NSLog(@"userSn--%@ , deviceSn--%@ , devTypeSn--%@ , provience--%@ , cityName--%@ " ,[kStanderDefault objectForKey:@"userSn"] , self.deviceSn , self.devTypeSn , [kStanderDefault objectForKey:@"provience"] , [kStanderDefault objectForKey:@"cityName"]);
    
    
    if ([kStanderDefault objectForKey:@"cityName"] && [kStanderDefault objectForKey:@"provience"]) {
        parames = @{@"ud.userSn" : [kStanderDefault objectForKey:@"userSn"] ,  @"ud.devSn" : self.deviceSn , @"ud.devTypeSn" : self.devTypeSn , @"province" : [kStanderDefault objectForKey:@"provience"] , @"city" : [kStanderDefault objectForKey:@"cityName"]};
    } else {
        parames = @{@"ud.userSn" : [kStanderDefault objectForKey:@"userSn"] ,  @"ud.devSn" : self.deviceSn , @"ud.devTypeSn" : self.devTypeSn};
    }
    
    NSLog(@"%@" , parames);
    if ([self.devTypeSn isEqualToString:@"4131"] || [self.devTypeSn isEqualToString:@"4132"]) {
        [HelpFunction requestDataWithUrlString:kBindLengFengShanURL andParames:parames andDelegate:self];
    } else if ([self.devTypeSn isEqualToString:@"4231"] || [self.devTypeSn isEqualToString:@"4232"]) {
        [HelpFunction requestDataWithUrlString:kBindKongQiJingHuaQiURL andParames:parames andDelegate:self];
    } else if ([self.devTypeSn isEqualToString:@"4331"] || [self.devTypeSn isEqualToString:@"4332"]) {
        [HelpFunction requestDataWithUrlString:kBindGanYiJiURL andParames:parames andDelegate:self];
    }
    
    [_progressTimer setFireDate:[NSDate distantPast]];
    return YES;
}

#pragma mark - 代理反馈
- (void)requestData:(HelpFunction *)request didFinishLoadingDtaArray:(NSMutableArray *)data {
    
    _circleLabel.text = @"100%";
    _circleView.progress = 1.00;
    [_progressTimer invalidate];
    _progressTimer = nil;
    
    NSDictionary *dic = data[0];
    NSLog(@"%@" , dic);
    
    if ([dic[@"state"] integerValue] == 0) {
        [self determineAndBindTheDevice];
    } else if ([dic[@"state"] integerValue] == 2 ) {
        [UIAlertController creatRightAlertControllerWithHandle:^{
            [self determineAndBindTheDevice];
        } andSuperViewController:self Title:@"此设备已绑定"];
        
    } else if ([dic[@"state"] integerValue] == 1){
        
        [UIAlertController creatRightAlertControllerWithHandle:^{
            FailContextViewController *failVC = [[FailContextViewController alloc]init];
            [self.navigationController pushViewController:failVC animated:YES];
            [self.updSocket close];
        } andSuperViewController:self Title:@"此设备绑定失败"];
        
    }
}

#pragma mark - 判断并绑定设备
- (void)determineAndBindTheDevice {
    
    [kStanderDefault setObject:@"YES" forKey:@"isHaveServices"];
    [kStanderDefault setObject:@"YES" forKey:@"Login"];
    
    MineSerivesViewController *mineSerVC = [[MineSerivesViewController alloc]init];
    [self.navigationController pushViewController:mineSerVC animated:YES];
    
    [self.updSocket close];
}

#pragma mark - NSData转16进制字符串
- (NSString *)convertDataToHexStr:(NSData *)data {
    if (!data || [data length] == 0) {
        return @"";
    }
    NSMutableString *string = [[NSMutableString alloc] initWithCapacity:[data length]];
    
    [data enumerateByteRangesUsingBlock:^(const void *bytes, NSRange byteRange, BOOL *stop) {
        unsigned char *dataBytes = (unsigned char*)bytes;
        for (NSInteger i = 0; i < byteRange.length; i++) {
            NSString *hexStr = [NSString stringWithFormat:@"%x", (dataBytes[i]) & 0xff];
            if ([hexStr length] == 2) {
                [string appendString:hexStr];
            } else {
                [string appendFormat:@"0%@", hexStr];
            }
        }
    }];
    
    return string;
}


- (void)chongFuSendUDP {

//    [self sendMessage:self.protocolArray[6]];
    
    for (int i = 0; i < self.protocolArray.count; i++) {
        [self sendMessage:self.protocolArray[i]];
    }
    
}

- (void) tapConfirmForResults
{
    
    
    if (self._isConfirmState)
    {
        
        [self enableCancelBtn];
        
        dispatch_queue_t  queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
        dispatch_async(queue, ^{
            
            
            NSArray *esptouchResultArray = [self executeForResults];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                [self enableConfirmBtn];
                
                ESPTouchResult *firstResult = [esptouchResultArray objectAtIndex:0];
                
                if (!firstResult.isCancelled)
                {
                    NSMutableString *mutableStr = [[NSMutableString alloc]init];
                    NSUInteger count = 0;
                   
                    const int maxDisplayCount = 5;
                    if ([firstResult isSuc])
                    {
                        
                        for (int i = 0; i < [esptouchResultArray count]; ++i)
                        {
                            ESPTouchResult *resultInArray = [esptouchResultArray objectAtIndex:i];
                            [mutableStr appendString:[resultInArray description]];
                            [mutableStr appendString:@"\n"];
                            count++;
                            if (count >= maxDisplayCount)
                            {
                                break;
                            }
                            self.deviceSn = [mutableStr substringWithRange:NSMakeRange(35, 12)];
                            
//                            NSLog(@"%@" , mutableStr);
                            
                        }
                        
                        if (count < [esptouchResultArray count])
                        {
                           
                        }
                        
                        [_progressTimer setFireDate:[NSDate distantPast]];
                        
                        _circleLabel.text = @"33%";
                        _circleView.progress = 0.33;
                        
                        [self openUDPServer];
                       
//                      [self sendMessage:self.protocolArray[6]];
                        for (int i = 0; i < self.protocolArray.count; i++) {
                            [self sendMessage:self.protocolArray[i]];
                        }
                        
                        _myTimer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(chongFuSendUDP) userInfo:nil repeats:YES];
                        
                        
                    }
                    
                    else
                    {
                        
                        [UIAlertController creatRightAlertControllerWithHandle:^{
                            FailContextViewController *failVC = [[FailContextViewController alloc]init];
                            [self.navigationController pushViewController:failVC animated:YES];
                        } andSuperViewController:self Title:@"失败"];
                        
                    }
                }
                
            });
        });
    }
    
    else
    {
        
        [self enableConfirmBtn];
        [self cancel];
    }
}

- (void) tapConfirmForResult
{
    
    if (self._isConfirmState)
    {
        [self enableCancelBtn];
        
        dispatch_queue_t  queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
        dispatch_async(queue, ^{
            
            ESPTouchResult *esptouchResult = [self executeForResult];
            dispatch_async(dispatch_get_main_queue(), ^{
                [self enableConfirmBtn];
                if (!esptouchResult.isCancelled)
                {
                    
                }
            });
        });
    }
    
    else
    {
        
        [self enableConfirmBtn];
        
        [self cancel];
    }
}

#pragma mark - the example of how to cancel the executing task

- (void) cancel
{
    
    if (self._esptouchTask != nil)
    {
        [self._esptouchTask interrupt];
    }
    
}

#pragma mark - the example of how to use executeForResults
- (NSArray *) executeForResults
{
    
    NSString *apSsid = self.ssidText;
    NSString *apPwd = self.bssid;
    NSString *apBssid = self.apSsid;
    BOOL isSsidHidden = NO;
    int taskCount = 1;
    self._esptouchTask =
    [[ESPTouchTask alloc]initWithApSsid:apSsid andApBssid:apBssid andApPwd:apPwd andIsSsidHiden:isSsidHidden];
    // set delegate
    [self._esptouchTask setEsptouchDelegate:self._esptouchDelegate];
    //    [self._condition unlock];
    NSArray * esptouchResults = [self._esptouchTask executeForResults:taskCount];
    return esptouchResults;
}

#pragma mark - the example of how to use executeForResult

- (ESPTouchResult *) executeForResult
{
    
    NSString *apSsid = self.ssidText;
    NSString *apPwd = self.bssid;
    NSString *apBssid = self.apSsid;
    BOOL isSsidHidden = NO;
    self._esptouchTask =
    [[ESPTouchTask alloc]initWithApSsid:apSsid andApBssid:apBssid andApPwd:apPwd andIsSsidHiden:isSsidHidden];
    
    [self._esptouchTask setEsptouchDelegate:self._esptouchDelegate];
    
    ESPTouchResult * esptouchResult = [self._esptouchTask executeForResult];
    
    return esptouchResult;
}



- (void)enableConfirmBtn
{
    self._isConfirmState = YES;
}


- (void)enableCancelBtn
{
    self._isConfirmState = NO;
}



@end
