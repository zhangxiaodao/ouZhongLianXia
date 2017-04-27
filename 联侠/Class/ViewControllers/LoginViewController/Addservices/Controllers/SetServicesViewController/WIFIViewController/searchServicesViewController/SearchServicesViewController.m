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

#import "LXGradientProcessView.h"

#import "ESPTouchTask.h"
#import "ESPTouchResult.h"
#import "ESP_NetUtil.h"
#import "ESPTouchDelegate.h"
#import <SystemConfiguration/CaptiveNetwork.h>
@interface SearchServicesViewController ()<AsyncUdpSocketDelegate , HelpFunctionDelegate>
@property (atomic, strong) ESPTouchTask *_esptouchTask;

@property (nonatomic, assign) BOOL _isConfirmState;

@property (nonatomic , strong) AsyncUdpSocket *updSocket;

@property (nonatomic , copy) NSString *devTypeSn;
@property (nonatomic, strong) LXGradientProcessView *processView;
@property (nonatomic , strong) NSTimer *myTimer;

@property (nonatomic , strong) NSTimer *progressTimer;
@property (nonatomic , assign) CGFloat index;
@property (nonatomic , strong) NSArray *protocolArray;

@property (nonatomic , strong) UILabel *searchLable;
@property (nonatomic , strong) UILabel *registerLable;
@property (nonatomic , strong) UILabel *addLable;
@end

@implementation SearchServicesViewController

- (NSArray *)protocolArray {
    if (!_protocolArray) {
        _protocolArray = [NSArray arrayWithObjects: @"HMSMARTB1" , @"HMSMARTB2" , @"HMSMARTC1" , @"HMSMARTC2" , @"HMCOLDFANA",@"HMSMARTALL", nil];
    }
    return _protocolArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self._isConfirmState = NO;

    [self enableConfirmBtn];
    
    [self setUI];
    [self tapConfirmForResults];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [_progressTimer invalidate];
    _progressTimer = nil;
}

- (void)progressValue {
    _index++;
    
    _processView.percent = _index / 100;
    
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
    
    _processView = [[LXGradientProcessView alloc] initWithFrame:CGRectMake(kScreenW / 3.58, kScreenW / 2.6, kScreenW / 2.35, kScreenW / 2.35)];
    self.processView.percent = 0;
    [self.view addSubview:self.processView];
    self.processView.backgroundColor = [UIColor whiteColor];
    
    UILabel *searchLable = [UILabel creatLableWithTitle:@"正在搜索设备..." andSuperView:self.view andFont:k15 andTextAligment:NSTextAlignmentCenter];
    searchLable.layer.borderWidth = 0;
    searchLable.textColor = [UIColor grayColor];
    [searchLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(kScreenW * 2 / 3, kScreenW / 14));
        make.top.mas_equalTo(_processView.mas_bottom).offset(kScreenH / 12.4);
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
    self.searchLable = searchLable;
    self.registerLable = registerLable;
    self.addLable = addLable;
    
    self._isConfirmState = NO;
    
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

- (void)onUdpSocket:(AsyncUdpSocket *)sock didSendDataWithTag:(long)tag {
    NSLog(@"onUdp--SendData");
}

- (void)onUdpSocketDidClose:(AsyncUdpSocket *)sock {
    NSLog(@"onUdp--DidClose");
}

-(BOOL)onUdpSocket:(AsyncUdpSocket *)sock didReceiveData:(NSData *)data withTag:(long)tag fromHost:(NSString *)host port:(UInt16)port
{
    
    [_progressTimer setFireDate:[NSDate distantPast]];
   
    _processView.percent = 0.66;
    self.registerLable.textColor = kMainColor;
    [_myTimer invalidate];
    _myTimer = nil;
    
    NSLog(@"%@" , data);
    
    NSString *str = [self convertDataToHexStr:data];
    NSString *devtypeSn = nil;
    NSString *devsn = nil;
    if (str.length == 24) {
        devtypeSn = [str substringWithRange:NSMakeRange(4, 4)];
        devsn = [str substringWithRange:NSMakeRange(10, 12)];
        //    self.devTypeSn = subStr2;
    } else {
        devtypeSn = [str substringWithRange:NSMakeRange(4, 4)];
        devsn = [str substringWithRange:NSMakeRange(8, 12)];
        //    self.devTypeSn = subStr2;
    }
    
//    self.deviceSn = [NSString stringWithString:subStr];
    NSLog(@" devsn --%@ ,  devtypeSn--%@ , self.deviceSn--%@ , str--%@" ,  devsn, devtypeSn , self.deviceSn , str);
    
    if ([devsn isEqualToString:self.deviceSn]) {
        self.devTypeSn = devtypeSn;
    } else {
        self.devTypeSn = nil;
    }
    
    if (self.devTypeSn) {
        
        
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
        if ([self.devTypeSn isEqualToString:@"4131"] || [self.devTypeSn isEqualToString:@"4132"] || [self.devTypeSn isEqualToString:@"4133"] || [self.devTypeSn isEqualToString:@"4134"]) {
            [HelpFunction requestDataWithUrlString:kBindLengFengShanURL andParames:parames andDelegate:self];
        } else if ([self.devTypeSn isEqualToString:@"4231"] || [self.devTypeSn isEqualToString:@"4232"]) {
            [HelpFunction requestDataWithUrlString:kBindKongQiJingHuaQiURL andParames:parames andDelegate:self];
        } else if ([self.devTypeSn isEqualToString:@"4331"] || [self.devTypeSn isEqualToString:@"4332"]) {
            [HelpFunction requestDataWithUrlString:kBindGanYiJiURL andParames:parames andDelegate:self];
        }
        
        [_progressTimer setFireDate:[NSDate distantPast]];
    } else {

        
        [self.updSocket close];
        self.updSocket = nil;
        [self openUDPServer];
        _myTimer = [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(chongFuSendUDP) userInfo:nil repeats:YES];
    }
    
    return YES;
}

#pragma mark - 代理反馈
- (void)requestData:(HelpFunction *)request didFinishLoadingDtaArray:(NSMutableArray *)data {
    
    _processView.percent = 1.00;
    self.addLable.textColor = kMainColor;
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
    
    
//    TabBarViewController *tabVC = [[TabBarViewController alloc]init];
//    tabVC.fromAddVC = @"YES";
//    [self.navigationController pushViewController:tabVC animated:YES];
    MineSerivesViewController *mineVC = [[MineSerivesViewController alloc]init];
    mineVC.fromAddVC = @"YES";
    [self.navigationController pushViewController:mineVC animated:YES];
    
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
        
        [NSThread sleepForTimeInterval:0.3];
        NSLog(@"%@" , self.protocolArray[i]);
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
                        
                        _processView.percent = 0.33;
                        self.searchLable.textColor = kMainColor;
                        
                        [self openUDPServer];
                       
//                      [self sendMessage:self.protocolArray[6]];
                        for (int i = 0; i < self.protocolArray.count; i++) {
                            [self sendMessage:self.protocolArray[i]];
                            [NSThread sleepForTimeInterval:0.3];
                        }
                        
                        _myTimer = [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(chongFuSendUDP) userInfo:nil repeats:YES];
                        
                        
                    }
                    else
                    {
                        
                        [UIAlertController creatRightAlertControllerWithHandle:^{
                            FailContextViewController *failVC = [[FailContextViewController alloc]init];
                            failVC.navigationItem.title = @"失败";
                            [self.navigationController pushViewController:failVC animated:YES];
                        } andSuperViewController:self Title:@"失败"];
                        
                    }
                }
                
            });
        });
    } else {
        
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

    NSArray * esptouchResults = [self._esptouchTask executeForResults:taskCount];
    return esptouchResults;
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
