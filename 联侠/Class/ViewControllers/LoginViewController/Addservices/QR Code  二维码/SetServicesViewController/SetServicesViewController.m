//
//  SetServicesViewController.m
//  AEFT冷风扇
//
//  Created by 杭州阿尔法特 on 16/3/26.
//  Copyright © 2016年 阿尔法特. All rights reserved.
//

#import "SetServicesViewController.h"
#import "WiFiViewController.h"
#import "ESP_NetUtil.h"
#import "AddSViewController.h"
#import <SystemConfiguration/CaptiveNetwork.h>
@interface SetServicesViewController ()
@property (nonatomic , strong) UIView *navView;
@property (nonatomic , strong) NSMutableArray *array;
@property (nonatomic , strong) NSTimer *myTimer;
@property (nonatomic , strong) UIImageView *imageView;
@end

@implementation SetServicesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navView = [UIView creatNavView:self.view WithTarget:self action:@selector(backTap:) andTitle:@"设置设备"];
    
     [self setUI];
}
#pragma mark - 返回主界面
- (void)backTap:(UITapGestureRecognizer *)tap {

    if ([self.fromErWeiMa isEqualToString:@"YES"]) {
        for (UIViewController *temp in self.navigationController.viewControllers) {
            if ([temp isKindOfClass:[[[AddSViewController alloc]init] class]]) {
                [self.navigationController popToViewController:temp animated:YES];
            }
        }
    } else {
        [self.navigationController popViewControllerAnimated:YES];
    }
    
}

#pragma mark - 设置UI
- (void)setUI {
    
    UIImage *image = nil;
//    if (self.addServiceModel.slType == 3) {
//        image = [UIImage imageNamed:@"wifianjianpeiwangmoshi0"];
//    } else {
//        image = [UIImage imageNamed:@"peiWangMoShiKai"];
//    }
    
    image = [UIImage imageNamed:@"wifianjianpeiwangmoshi0"];
    
    _imageView = [[UIImageView alloc]initWithImage:image];
    [self.view addSubview:_imageView];
    [_imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake( kScreenW * 2 / 3, kScreenW * 2 / 3));
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.centerY.mas_equalTo(self.view.mas_centerY).offset(-kScreenW / 5);
    }];
    
//    NSString *brandName = self.addServiceModel.typeName;
//    NSString *typePosition = nil;
//    
//    if (self.addServiceModel.slType == 1) {
//        typePosition = @"定时";
//    } else if (self.addServiceModel.slType == 2) {
//        typePosition = @"开关";
//    } else if (self.addServiceModel.slType == 3) {
//        typePosition = @"WIFI按钮";
//    }
    
    
//    UILabel *firstLable = [UILabel creatLableWithTitle:[NSString stringWithFormat:@"%@设备通电后,长按“%@“键约3秒后,“滴”声响后松开,进入无线配网状态." , brandName , typePosition] andSuperView:self.view andFont:k15 andTextAligment:NSTextAlignmentCenter];
    UILabel *firstLable = [UILabel creatLableWithTitle:[NSString stringWithFormat:@"请开机长按功能按键3秒，听到“滴”的声音后指示灯闪烁，进入配网模式。（wifi功能按键请查看说明书）"] andSuperView:self.view andFont:k15 andTextAligment:NSTextAlignmentCenter];
    firstLable.textColor = [UIColor blackColor];
    firstLable.layer.borderWidth = 0;
    
    [firstLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kStandardW, kScreenW / 5));
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.top.mas_equalTo(_imageView.mas_bottom).offset(kScreenW / 10);
    }];
    
    //创建注册按钮
    UIButton *neaxtBtn = [UIButton initWithTitle:@"下一步" andColor:[UIColor redColor] andSuperView:self.view];
    neaxtBtn.layer.cornerRadius = kScreenW / 18;
    
    neaxtBtn.backgroundColor = kMainColor;
    
    [neaxtBtn addTarget:self action:@selector(neaxtBtnAction) forControlEvents:UIControlEventTouchUpInside];
    //注册按钮的约束
    [neaxtBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kStandardW, kScreenW / 9));
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.top.mas_equalTo(firstLable.mas_bottom).offset(kScreenH /  22.30303);
    }];
    
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    _myTimer = [NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(qieHuanTuPian) userInfo:nil repeats:YES];
}

- (void)viewWillDisappear:(BOOL)animated{
    [_myTimer invalidate];
    _myTimer = nil;
}

- (void)qieHuanTuPian{
    
//    if (self.addServiceModel.slType == 3) {
//        if ([_imageView.image isEqual:[UIImage imageNamed:@"wifianjianpeiwangmoshi0"]]) {
//            [self qieHuanTuPianGuan];
//        } else{
//            [self qieHuanTuPianKai];
//        }
//    } else {
//        
//        if ([_imageView.image isEqual:[UIImage imageNamed:@"peiWangMoShiKai"]]) {
//            [self qieHuanTuPianGuan];
//        } else{
//            [self qieHuanTuPianKai];
//        }
//    }
    
    if ([_imageView.image isEqual:[UIImage imageNamed:@"wifianjianpeiwangmoshi1"]]) {
        [self qieHuanTuPianGuan];
    } else{
        [self qieHuanTuPianKai];
    }
}

- (void)qieHuanTuPianKai{
    
//    if (self.addServiceModel.slType == 3) {
//        _imageView.image = [UIImage imageNamed:@"wifianjianpeiwangmoshi0"];
//    } else {
//        _imageView.image = [UIImage imageNamed:@"peiWangMoShiKai"];
//    }
    
    _imageView.image = [UIImage imageNamed:@"wifianjianpeiwangmoshi1"];
    
}

- (void)qieHuanTuPianGuan{
    
//    if (self.addServiceModel.slType == 3) {
//        _imageView.image = [UIImage imageNamed:@"wifianjianpeiwangmoshi1"];
//    } else {
//        _imageView.image = [UIImage imageNamed:@"peiWangMoShiGuan"];
//    }
    
    _imageView.image = [UIImage imageNamed:@"wifianjianpeiwangmoshi0"];
    
}

#pragma mark - 下一步按钮点击事件
- (void)neaxtBtnAction {

    WiFiViewController *wifiVC = [[WiFiViewController alloc]init];
//    wifiVC.addServiceModel = self.addServiceModel;
    
    [self.navigationController pushViewController:wifiVC animated:YES];
}

//- (void)setAddServiceModel:(AddServiceModel *)addServiceModel {
//    _addServiceModel = addServiceModel;
//}

@end
