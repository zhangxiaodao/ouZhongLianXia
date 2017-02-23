//
//  ErWeiMaSaoMiaoViewController.m
//  AEFT冷风扇
//
//  Created by 杭州阿尔法特 on 16/4/1.
//  Copyright © 2016年 阿尔法特. All rights reserved.
//

#import "ErWeiMaSaoMiaoViewController.h"
#import "QRCodeReaderView.h"

#import <AVFoundation/AVFoundation.h>
#import <AudioToolbox/AudioToolbox.h>

#import "SetServicesViewController.h"



#define widthRate DeviceMaxWidth/320
#define IOS8 ([[UIDevice currentDevice].systemVersion intValue] >= 8 ? YES : NO)
@interface ErWeiMaSaoMiaoViewController ()<QRCodeReaderViewDelegate,AVCaptureMetadataOutputObjectsDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate,UIAlertViewDelegate , HelpFunctionDelegate>{
    QRCodeReaderView * readview;//二维码扫描对象
    
    BOOL isFirst;//第一次进入该页面
    BOOL isPush;//跳转到下一级页面
}
@property (nonatomic , strong) UIView *navView;
@property (strong, nonatomic) CIDetector *detector;
@end

@implementation ErWeiMaSaoMiaoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];

    
    
    
    isFirst = YES;
    isPush = NO;
    [self InitScan];
    
}


#pragma mark - 返回主界面
- (void)backTap:(UITapGestureRecognizer *)tap {
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark 初始化扫描
- (void)InitScan
{
    if (readview) {
        [readview removeFromSuperview];
        readview = nil;
    }
    
    readview = [[QRCodeReaderView alloc]initWithFrame:CGRectMake(0, 0, kScreenW, kScreenH)];
    readview.is_AnmotionFinished = YES;
    readview.backgroundColor = [UIColor clearColor];
    readview.delegate = self;
    readview.alpha = 0;
    
    [self.view addSubview:readview];
    
    
    self.navView = [UIView creatNavView:self.view WithTarget:self action:@selector(backTap:) andTitle:@"添加设备"];
    UIView *backView = [self.navView.subviews objectAtIndex:0];
    [backView.subviews objectAtIndex:1].tintColor = [UIColor whiteColor];
    UILabel *lable = [self.navView.subviews objectAtIndex:2];
    lable.textColor = [UIColor whiteColor];
    
    [UIView animateWithDuration:0.5 animations:^{
        readview.alpha = 1;
    }completion:^(BOOL finished) {
        
    }];
    
}

#pragma mark -QRCodeReaderViewDelegate
- (void)readerScanResult:(NSString *)result
{
    readview.is_Anmotion = YES;
    [readview stop];
    
    
    [self accordingQcode:result];
    
    [self performSelector:@selector(reStartScan) withObject:nil afterDelay:1.5];
}

#pragma mark - 扫描结果处理
- (void)accordingQcode:(NSString *)str
{
    NSLog(@"%@" , str);
    
    NSData *jsonData = [str dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *dddd = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:nil];
    
    AddServiceModel *model = [[AddServiceModel alloc]init];
    [model setValuesForKeysWithDictionary:dddd];
    
    if (model.typeSn) {
        SetServicesViewController *setVC = [[SetServicesViewController alloc]init];
        setVC.addServiceModel = model;
        [self.navigationController pushViewController:setVC animated:YES];
    } else {
        UIAlertView * alertView = [[UIAlertView alloc]initWithTitle:@"扫描结果" message:@"二维码扫描错误，请重新扫描" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alertView show];
    }

    
//    [HelpFunction requestDataWithUrlString:str andParames:nil andDelegate:self];
    
}

#pragma mark - 二维码数据请求结果
- (void)requestData:(HelpFunction *)request didSuccess:(NSDictionary *)dddd {
    NSLog(@"%@" , dddd);
    
    AddServiceModel *model = [[AddServiceModel alloc]init];
    [model setValuesForKeysWithDictionary:dddd];
    
    if (model.typeSn) {
        SetServicesViewController *setVC = [[SetServicesViewController alloc]init];
        setVC.addServiceModel = model;
        [self.navigationController pushViewController:setVC animated:YES];
    } else {
        UIAlertView * alertView = [[UIAlertView alloc]initWithTitle:@"扫描结果" message:@"二维码扫描错误，请重新扫描" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alertView show];
    }
    
}

- (void)reStartScan
{
    readview.is_Anmotion = NO;
    
    if (readview.is_AnmotionFinished) {
        [readview loopDrawLine];
    }
    
    [readview start];
}

#pragma mark - view
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    if (isFirst || isPush) {
        if (readview) {
            [self reStartScan];
        }
    }
    
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    
    if (readview) {
        [readview stop];
        readview.is_Anmotion = YES;
    }
    
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    if (isFirst) {
        isFirst = NO;
    }
    if (isPush) {
        isPush = NO;
    }
}

@end
