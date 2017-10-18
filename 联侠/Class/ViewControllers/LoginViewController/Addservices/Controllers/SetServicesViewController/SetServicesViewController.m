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
#import <SystemConfiguration/CaptiveNetwork.h>
#import "MineSerivesViewController.h"
@interface SetServicesViewController ()
@property (nonatomic , strong) NSMutableArray *array;
@property (nonatomic , strong) UIImageView *imageView;
@property (nonatomic , copy) NSString *alertMessage;
@end

@implementation SetServicesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
     [self setUI];
}

#pragma mark - 设置UI
- (void)setUI {

    UIImage *image1 = [UIImage imageNamed:@"wifianjianpeiwangmoshi0"];
    UIImage *image2 = [UIImage imageNamed:@"wifianjianpeiwangmoshi1"];
    _imageView = [[UIImageView alloc]initWithImage:image1];
    [self.view addSubview:_imageView];
    [_imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake( kScreenW * 2 / 3, kScreenW * 2 / 3));
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.top.mas_equalTo(self.view.mas_top)
        .offset(kScreenW / 6.25);
    }];
    _imageView.animationImages = @[image1 , image2];
    _imageView.animationDuration = 1;
    _imageView.animationRepeatCount = MAXFLOAT;
    [_imageView startAnimating];
    
    UILabel *firstLable = [UILabel creatLableWithTitle:[NSString stringWithFormat:@"请开机长按%@，听到“滴”的声音后指示灯闪烁，进入配网模式。" , self.alertMessage] andSuperView:self.view andFont:k15 andTextAligment:NSTextAlignmentCenter];
    firstLable.textColor = [UIColor blackColor];
    firstLable.numberOfLines = 0;
    [firstLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kStandardW, kStandardW / 5));
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.top.mas_equalTo(_imageView.mas_bottom)
        .offset(kScreenW / 4.7);
    }];
    
    UIButton *neaxtBtn = [UIButton initWithTitle:@"下一步" andColor:[UIColor redColor] andSuperView:self.view];
    neaxtBtn.layer.cornerRadius = kScreenW / 18;
    neaxtBtn.backgroundColor = kMainColor;
    [neaxtBtn addTarget:self action:@selector(neaxtBtnAction) forControlEvents:UIControlEventTouchUpInside];
    
    [neaxtBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kStandardW, kScreenW / 9));
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.top.mas_equalTo(firstLable.mas_bottom)
        .offset(kScreenW /  12.5);
    }];
    
}



- (void)viewWillDisappear:(BOOL)animated{
    [_imageView stopAnimating];
}

#pragma mark - 下一步按钮点击事件
- (void)neaxtBtnAction {
    
    if (self.addServiceModel.bindUrl == nil || [self.addServiceModel.bindUrl isKindOfClass:[NSNull class]]) {
        [UIAlertController creatRightAlertControllerWithHandle:^{
            [self.navigationController popViewControllerAnimated:YES];
        } andSuperViewController:self Title:@"暂无此设备"];
    } else {
        WiFiViewController *wifiVC = [[WiFiViewController alloc]init];
        wifiVC.addServiceModel = self.addServiceModel;
        wifiVC.navigationItem.title = @"添加设备";
        [self.navigationController pushViewController:wifiVC animated:YES];
    }
    
}

- (void)setAddServiceModel:(AddServiceModel *)addServiceModel {
    _addServiceModel = addServiceModel;
    
    switch (_addServiceModel.slType) {
        case 0:
            self.alertMessage = @"定时3秒";
            break;
        case 1:
            self.alertMessage = @"定时3秒";
            break;
        case 2:
            self.alertMessage = @"开关3秒";
            break;
        case 3:
            self.alertMessage = @"wifi3秒";
            break;
        default:
            break;
    }
}

@end
