//
//  FailContextViewController.m
//  AEFT冷风扇
//
//  Created by 杭州阿尔法特 on 16/3/26.
//  Copyright © 2016年 阿尔法特. All rights reserved.
//

#import "FailContextViewController.h"
#import "MineSerivesViewController.h"
#import "UserFeedBackViewController.h"
@interface FailContextViewController ()
@property (nonatomic , strong) UIView *navView;
@end

@implementation FailContextViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.navView = [UIView creatNavView:self.view WithTarget:self action:@selector(backTap:) andTitle:@"添加失败"];
    UIView *backView = [[UIView alloc]init];
    backView = [_navView.subviews objectAtIndex:0];
    
    UIImageView *iiii = [backView.subviews objectAtIndex:1];
    iiii.image = [UIImage new];
    [self setUI];
}
#pragma mark - 返回主界面
- (void)backTap:(UITapGestureRecognizer *)tap {
//    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - 设置UI
- (void)setUI {
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, kHeight, kScreenW, kScreenH / 8.7619047)];
    [self.view addSubview:view];
    view.backgroundColor = [UIColor redColor];
    
    UILabel *lable1 = [UILabel creatLableWithTitle:@"产品名称+型号" andSuperView:view andFont:k17 andTextAligment:NSTextAlignmentLeft];
    lable1.layer.borderWidth = 0;
    [lable1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(kScreenW / 15);
        make.size.mas_equalTo(CGSizeMake(kScreenW / 2, kScreenW / 12));
        make.top.mas_equalTo(self.view.mas_top).offset(kScreenH / 9.945945);
    }];
    
    UILabel *lable2 = [UILabel creatLableWithTitle:@"添加失败!" andSuperView:view andFont:k17 andTextAligment:NSTextAlignmentLeft];
    lable2.layer.borderWidth = 0;
    [lable2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(kScreenW / 15);
        make.size.mas_equalTo(CGSizeMake(kScreenW / 2, kScreenW / 12));
        make.top.mas_equalTo(lable1.mas_bottom);
    }];
    
    UIImageView *jingGaoIamgeView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"iconfont-jinggao"]];
    [view addSubview:jingGaoIamgeView];
    [jingGaoIamgeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kScreenW / 10, kScreenW / 10));
        make.right.mas_equalTo(-kScreenW / 15);
        make.top.mas_equalTo(lable1.mas_top);
    }];
    
    UILabel *jingGaoLable = [UILabel creatLableWithTitle:@"警告" andSuperView:view andFont:k14 andTextAligment:NSTextAlignmentCenter];
    jingGaoLable.layer.borderWidth = 0;
    [jingGaoLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(jingGaoIamgeView.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(kScreenW / 4, kScreenW / 14));
        make.top.mas_equalTo(jingGaoIamgeView.mas_bottom);
    }];
    
    UILabel *tiShiLable = [UILabel creatLableWithTitle:@"请按以下步骤排查可能的问题并重试" andSuperView:view andFont:k17 andTextAligment:NSTextAlignmentLeft];
    tiShiLable.layer.borderWidth = 0;
    [tiShiLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(kScreenW / 15);
        make.size.mas_equalTo(CGSizeMake(kScreenW - kScreenW * 2 / 15, kScreenW / 14));
        make.top.mas_equalTo(self.view.mas_top).offset(kScreenH / 4.46060606);
    }];
    
    UILabel *firstLable = [UILabel creatLableWithTitle:@"1.请确保您的设备已按照开始时的提示，设置到配网状态;" andSuperView:view andFont:k16 andTextAligment:NSTextAlignmentLeft];
    firstLable.numberOfLines = 0;
    firstLable.layer.borderWidth = 0;
    [firstLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(kScreenW / 15);
        make.size.mas_equalTo(CGSizeMake(kScreenW - kScreenW * 2 / 15, kScreenW / 7));
        make.top.mas_equalTo(tiShiLable.mas_bottom);
    }];
    
    
    UILabel *secondLable = [UILabel creatLableWithTitle:@"2.确保之前输入的WIFI账号密码无误;" andSuperView:view andFont:k16 andTextAligment:NSTextAlignmentLeft];
    secondLable.layer.borderWidth = 0;
    [secondLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(kScreenW / 15);
        make.size.mas_equalTo(CGSizeMake(kScreenW - kScreenW * 2 / 15, kScreenW / 14));
        make.top.mas_equalTo(firstLable.mas_bottom);
    }];
    
    UILabel *thirtLable = [UILabel creatLableWithTitle:@"3.确保设备与家庭路由器的距离不要太远;" andSuperView:view andFont:k16 andTextAligment:NSTextAlignmentLeft];
    thirtLable.layer.borderWidth = 0;
    [thirtLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(kScreenW / 15);
        make.size.mas_equalTo(CGSizeMake(kScreenW - kScreenW * 2 / 15, kScreenW / 14));
        make.top.mas_equalTo(secondLable.mas_bottom);
    }];
    
    UILabel *forthLable = [UILabel creatLableWithTitle:@"4.您的路由器是否设置到了5GHz，可以进入路由器设置管理检查，确保是2.4GHz;" andSuperView:view andFont:k16 andTextAligment:NSTextAlignmentLeft];
    forthLable.numberOfLines = 0;
    forthLable.layer.borderWidth = 0;
    [forthLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(kScreenW / 15);
        make.size.mas_equalTo(CGSizeMake(kScreenW - kScreenW * 2 / 15, kScreenW / 7));
        make.top.mas_equalTo(thirtLable.mas_bottom);
    }];
    
    //创建注册按钮
    UIButton *againBtn = [UIButton initWithTitle:@"重试" andColor:[UIColor redColor] andSuperView:self.view];
    againBtn.layer.cornerRadius = kScreenW / 16;
    againBtn.backgroundColor = kMainColor;
    
    [againBtn addTarget:self action:@selector(againBtnAction) forControlEvents:UIControlEventTouchUpInside];
    //注册按钮的约束
    [againBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kScreenW - kScreenW * 2 / 8, kScreenW / 8));
        make.left.mas_equalTo(kScreenW / 8);
        make.top.mas_equalTo(forthLable.mas_bottom).offset(kScreenH / 14.72);
    }];
    
    UIButton *fanKuiBtn = [UIButton initWithTitle:@"在线反馈" andColor:[UIColor clearColor] andSuperView:self.view];
    [fanKuiBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    fanKuiBtn.layer.cornerRadius = kScreenW / 16;
    fanKuiBtn.layer.borderWidth = 2;
    CGFloat R1  = (CGFloat) 0/255.0;
    CGFloat G1 = (CGFloat) 62/255.0;
    CGFloat B1 = (CGFloat) 233/255.0;
    CGFloat alpha1 = (CGFloat) 1.0;
    
    fanKuiBtn.layer.borderColor = [ UIColor colorWithRed: R1  green: G1  blue: B1  alpha: alpha1].CGColor;
    
    [fanKuiBtn addTarget:self action:@selector(fanKuiBtnAction) forControlEvents:UIControlEventTouchUpInside];
    //注册按钮的约束
    [fanKuiBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kScreenW - kScreenW * 2 / 8, kScreenW / 8));
        make.left.mas_equalTo(kScreenW / 8);
        make.top.mas_equalTo(againBtn.mas_bottom).offset(kScreenH / 36.8);
    }];
    
}

#pragma mark - 重试按钮点击事件
- (void)againBtnAction {
    
    MineSerivesViewController *allServicesVC = [[MineSerivesViewController alloc]init];
    
    [self.navigationController pushViewController:allServicesVC animated:YES];
    
}

#pragma mark - 在线反馈按钮点击事件
- (void)fanKuiBtnAction {
    
    UserFeedBackViewController *fanKuiVC = [[UserFeedBackViewController alloc]init];
    [self.navigationController pushViewController:fanKuiVC animated:YES];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
