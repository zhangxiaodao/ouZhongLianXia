//
//  UserMessageViewController.m
//  AEFT冷风扇
//
//  Created by 杭州阿尔法特 on 16/3/16.
//  Copyright © 2016年 阿尔法特. All rights reserved.
//

#import "UserMessageViewController.h"
#import "UserMessageTableViewCell.h"
#import "MineYouHuiQuanViewController.h"
#import "ForgetPwdViewController.h"
#import "AgainSendViewController.h"
#import "MineViewController.h"

#import "LocationPickerVC.h"
#import "NiChengViewController.h"
#import "BDImagePicker.h"
#import "LoginViewController.h"
#import "EmailViewController.h"

#import "GeRenModel.h"

#import <AVFoundation/AVFoundation.h>
@interface UserMessageViewController ()<UITableViewDataSource , UITableViewDelegate , HelpFunctionDelegate , SendDiZhiDataToProvienceVCDelegate , SendNickNameToPreviousVCDelegate ,
    SendEmailAddressToPreviousVCDelegate>
@property (nonatomic , strong) UIView *navView;
@property (nonatomic , strong) UITableView *tableVIew;
@property (nonatomic , strong) NSMutableDictionary *dic;

@property (nonatomic , strong) UILabel *birthdayLabel;
@property (nonatomic , strong) UILabel *emailLabel;
@property (nonatomic , strong) UILabel *diZhiLabel;
@property (nonatomic , strong) UILabel *niChengLabel;

@property (nonatomic , strong) NSString *idd;

@property (strong, nonatomic)  UIDatePicker *myPicker;
@property (strong, nonatomic)  UIView *pickerBgView;
@property (strong, nonatomic) UIView *maskView;

@property (nonatomic , strong) GeRenModel *geRenModel;
@property (nonatomic , strong) DiZhiModel *diZhiModel;
@property (nonatomic , assign) BOOL sex;
@end

@implementation UserMessageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    if ([kStanderDefault objectForKey:@"GeRenModel"]) {
        self.geRenModel = [[GeRenModel alloc]init];
        [self.geRenModel setValuesForKeysWithDictionary:[kStanderDefault objectForKey:@"GeRenModel"]];
        NSLog(@"%@" , self.geRenModel);
    }
    
    
    [HelpFunction requestDataWithUrlString:kChaXunYongHuDiZhi andParames:@{@"userSn" : [kStanderDefault objectForKey:@"userSn"]} andDelegate:self];
    
    
    [self setUI];
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = YES;
}

#pragma mark - 代理返回数据
- (void)requestData:(HelpFunction *)request didFinishLoadingDtaArray:(NSMutableArray *)data {
//    NSLog(@"%@" , data[0]);
    NSDictionary *dic = data[0];
    
    if (![dic[@"data"] isKindOfClass:[NSArray class]]) {
        return ;
    } else {
        NSArray *aray = [NSArray arrayWithArray:dic[@"data"]];
        NSDictionary *dd = aray[0];
    
        self.diZhiModel = [[DiZhiModel alloc]init];
        [self.diZhiModel setValuesForKeysWithDictionary:dd];
        
        for (NSString *key in dd) {
            if ([key isEqualToString:@"id"]) {
                self.diZhiModel.idd = [dd[key] integerValue];
            }
        }
        
        [self.tableVIew reloadData];
    }
    
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    NSMutableDictionary *parames = [NSMutableDictionary dictionary];
    
    [parames setObject:@(self.userModel.sn) forKey:@"user.sn"];
    [parames setObject:@(self.sex) forKey:@"user.sex"];
    if (self.niChengLabel.text) {
        [parames setObject:self.niChengLabel.text forKey:@"user.nickname"];
    } if (self.birthdayLabel.text) {
        [parames setObject:self.birthdayLabel.text forKey:@"user.birthdate"];
    } if (self.emailLabel.text) {
        [parames setObject:self.emailLabel.text forKey:@"user.email"];
    }
    
    NSLog(@"%@" , parames);
    
    [kStanderDefault setObject:parames forKey:@"GeRenModel"];
    
    [HelpFunction requestDataWithUrlString:kXiuGaiXinXi andParames:parames andDelegate:self];
    
    
    [[NSNotificationCenter defaultCenter] postNotification:[NSNotification notificationWithName:@"headImage" object:self userInfo:[NSDictionary dictionaryWithObject:self.headImageView.image forKey:@"headImage"]]];
    
    [[NSNotificationCenter defaultCenter] postNotification:[NSNotification notificationWithName:@"niCheng" object:self userInfo:[NSDictionary dictionaryWithObject:self.niChengLabel.text forKey:@"niCheng"]]];
}

#pragma mark - 返回主界面
- (void)backTap:(UITapGestureRecognizer *)tap {
   
    [self.navigationController popViewControllerAnimated:YES];
    
}
- (void)requestServicesData:(HelpFunction *)request didOK:(NSDictionary *)dic {
    NSLog(@"%@" , dic);
}

- (void)requestData:(HelpFunction *)request didSuccess:(NSDictionary *)dddd {
    NSLog(@"%@" , dddd);
}

#pragma mark - 设置UI
- (void)setUI  {
    
    self.navView = [UIView creatNavView:self.view WithTarget:self action:@selector(backTap:) andTitle:@"用户信息"];
    
    self.headImageView = [[UIImageView alloc]initWithImage:self.headImage];
    
    [self.view addSubview:self.headImageView];
    self.headImageView.layer.masksToBounds = YES;
    self.headImageView.layer.cornerRadius = kScreenW / 10;
    self.headImageView.userInteractionEnabled = YES;
    
    [self.headImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kScreenW / 5, kScreenW / 5));
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.top.mas_equalTo(self.navView.mas_bottom).offset(kScreenH / 56.8);
    }];
    
    UILabel *tiShiLable = [UILabel creatLableWithTitle:@"点此更换头像" andSuperView:self.view andFont:k12 andTextAligment:NSTextAlignmentCenter];
    tiShiLable.textColor = [UIColor blackColor];
    tiShiLable.userInteractionEnabled = YES;
    tiShiLable.layer.borderWidth = 0;
    [tiShiLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.headImageView.mas_centerX);
        make.top.mas_equalTo(self.headImageView.mas_bottom);
        make.size.mas_equalTo(CGSizeMake(kScreenW / 2, kScreenW / 20));
    }];
    
    UITapGestureRecognizer *headTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(headTapAtcion:)];
    [self.headImageView addGestureRecognizer:headTap];
    
    UITapGestureRecognizer *lableTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(headTapAtcion:)];
    [tiShiLable addGestureRecognizer:lableTap];
    
    
    UIView *vvvView = [[UIView alloc]init];
    vvvView.backgroundColor = kCOLOR(244, 244, 244);
    [self.view addSubview:vvvView];
    [vvvView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kScreenW, 1));
        make.left.mas_equalTo(0);
        make.top.mas_equalTo(tiShiLable.mas_bottom).offset(-1);
    }];
    
    self.tableVIew = [[UITableView alloc]init];
    [self.view addSubview:self.tableVIew];
    [self.tableVIew mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kScreenW, kScreenH - vvvView.y));
        make.left.mas_equalTo(0);
        make.top.mas_equalTo(vvvView.mas_bottom);
    }];
    
    self.tableVIew.bounces = NO;
    self.tableVIew.delegate = self;
    self.tableVIew.dataSource = self;
    self.tableVIew.separatorStyle = UITableViewCellSeparatorStyleNone;
}

#pragma mark - 点击头像换取并上传
- (void)headTapAtcion:(UITapGestureRecognizer *)tap {
    
    [BDImagePicker showImagePickerFromViewController:self allowsEditing:YES finishAtcion:^(UIImage *image) {
        if (image) {
            self.headImageView.image = image;
            NSData *data = [NSData data];
            if (UIImagePNGRepresentation(image) == nil) {
                data = UIImageJPEGRepresentation(image, 1);
            } else {
                data = UIImagePNGRepresentation(image);
            }
          
            NSDictionary *parems = @{@"userSn" : @(self.userModel.sn) , @"files" : data};
            
            [HelpFunction requestDataWithUrlString:kShangChuanTouXiang andParames:parems andImage:self.headImageView.image andDelegate:self];
        }
    }];
    
}

#pragma mark - TableView的代理事件
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 5;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 2) {
        return 4;
    } else if (section == 3) {
        return 2;
    } else {
        return 1;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *celled = @"celled";
    UserMessageTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:celled];
    if (!cell) {
        cell = [[UserMessageTableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:celled];
    }
    
    cell.indexPath = indexPath;
    
    if (indexPath.section == 0) {
        cell.leftLable.text = @"Z币";
        cell.rightLable.text = @" ";
    } else if (indexPath.section == 1) {
        cell.dizhiModel = self.diZhiModel;
    
    } else if (indexPath.section == 2) {
        
        if (indexPath.row == 0) {
            cell.leftLable.text = @"昵称";
            cell.dizhiModel = self.diZhiModel;
            
            self.niChengLabel = cell.rightLable;
        } else if (indexPath.row == 1) {
            cell.leftLable.text = @"性别";
            cell.rightLable.text = @"男";
        } else if (indexPath.row == 2) {
            cell.leftLable.text = @"我的邮箱";
            cell.userModel = self.userModel;
            
            self.emailLabel = cell.rightLable;
        } else if (indexPath.row == 3) {
            cell.leftLable.text = @"生日";
            cell.userModel = self.userModel;
            
            self.birthdayLabel = cell.rightLable;
        }
        
        if (self.geRenModel) {
            cell.geRenModel = self.geRenModel;
        }
        
    }else if (indexPath.section == 3) {
        if (indexPath.row == 0) {
            cell.leftLable.text = @"修改密码";
        } else if (indexPath.row == 1) {
            cell.leftLable.text = @"我的ID";
            cell.rightLable.text = [NSString stringWithFormat:@"%ld" , (long)self.userModel.sn];
            
            cell.rightImage.image = [UIImage imageNamed:@""];
        }
    } if (indexPath.section == 4) {
        cell.leftLable.text = @"退出当前账号";
    }
    cell.rightImage.tintColor = [UIColor blackColor];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return kScreenH / 14.2;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 10;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    if (indexPath.section == 0) {
        MineYouHuiQuanViewController *youHuiQuanVC = [[MineYouHuiQuanViewController alloc]init];
        [self.navigationController pushViewController:youHuiQuanVC animated:YES];
    } else if (indexPath.section == 3) {
        if (indexPath.row == 0) {
            AgainSendViewController *subVC = [[AgainSendViewController alloc]init];
//            subVC.phoneNumber = [kStanderDefault objectForKey:@"phone"];
            subVC.changePwd = @"YES";
            [self.navigationController pushViewController:subVC animated:YES];
        }
    } else if (indexPath.section == 4) {
        LoginViewController *loginVC = [[LoginViewController alloc]init];
        
       
        [kStanderDefault removeObjectForKey:@"Login"];
        [kStanderDefault removeObjectForKey:@"cityName"];
        [kStanderDefault removeObjectForKey:@"password"];
        [kStanderDefault removeObjectForKey:@"phone"];
        [kStanderDefault removeObjectForKey:@"userSn"];
        [kStanderDefault removeObjectForKey:@"userId"];
        
        [kStanderDefault removeObjectForKey:@"first"];
        [kStanderDefault removeObjectForKey:@"zhuYe"];
        
        [kStanderDefault removeObjectForKey:@"offBtn"];
        [kStanderDefault removeObjectForKey:@"GanYiJiData"];
        [kStanderDefault removeObjectForKey:@"ganYiJiHongGanDic"];
        [kStanderDefault removeObjectForKey:@"GanYiJiIsWork"];
        [kStanderDefault removeObjectForKey:@"AirData"];
        [kStanderDefault removeObjectForKey:@"AirDingShiData"];
        [kStanderDefault removeObjectForKey:@"kongZhiTai"];
        [kStanderDefault removeObjectForKey:@"modelString"];
        
        [kStanderDefault removeObjectForKey:@"data"];
        [kStanderDefault removeObjectForKey:@"requestWeatherTime"];
        [kStanderDefault removeObjectForKey:@"GeRenModel"];
        [kSocketTCP cutOffSocket];
        loginVC.fromUserVC = [NSString stringWithFormat:@"YES"];
        

        [self.navigationController pushViewController:loginVC animated:YES];
    } else if (indexPath.section == 1) {
        LocationPickerVC *diZhiVC = [[LocationPickerVC alloc]init];
        diZhiVC.delegate = self;
        diZhiVC.diZhiModel = [[DiZhiModel alloc]init];
        diZhiVC.diZhiModel = self.diZhiModel;
        
        [self.navigationController pushViewController:diZhiVC animated:YES];
    } else if (indexPath.section == 2) {
        if (indexPath.row == 0) {
            NiChengViewController *niVC = [[NiChengViewController alloc]init];
            niVC.delegate = self;
            [self.navigationController pushViewController:niVC animated:YES];
        } else if (indexPath.row == 1) {
            [self setSex];
            
        } else if (indexPath.row == 2) {
            EmailViewController *emailVC = [[EmailViewController alloc]init];
            emailVC.delegate = self;
            emailVC.userModel = self.userModel;
            [self.navigationController pushViewController:emailVC animated:YES];
        } else if (indexPath.row == 3) {
            [self creatPickView];
        }
    }
}

- (void)setSex {
    _sex = !_sex;
    NSArray *sexArray = @[@"男" , @"女"];
    NSIndexPath *indexpath = [NSIndexPath indexPathForRow:1 inSection:2];
    UserMessageTableViewCell *cell = (UserMessageTableViewCell *)[_tableVIew cellForRowAtIndexPath:indexpath];
    cell.rightLable.text = [NSString stringWithFormat:@"%@" , sexArray[_sex]];
}

- (void)sendDiZhiDataToProvienceVC:(NSString *)diZhiStr {
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:1];
    UserMessageTableViewCell *cell = [_tableVIew cellForRowAtIndexPath:indexPath];
    cell.rightLable.text = diZhiStr;
}

- (void)sendNickNameToPreviousVC:(NSString *)nickName {
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:2];
    UserMessageTableViewCell *cell = [_tableVIew cellForRowAtIndexPath:indexPath];
    cell.rightLable.text = nickName;
}

- (void)sendEmailAddressToPreviousVC:(NSString *)emailAddress {
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:2 inSection:2];
    UserMessageTableViewCell *cell = [_tableVIew cellForRowAtIndexPath:indexPath];
    cell.rightLable.text = emailAddress;
}







#pragma mark - 创建UIPickView
- (void)creatPickView{
    
    self.maskView = [[UIView alloc] initWithFrame:kScreenFrame];
    self.maskView.backgroundColor = [UIColor clearColor];
    //    self.maskView.alpha = 0;
    self.maskView.userInteractionEnabled = YES;
    //    [self.view addSubview:self.maskView];
    [self.maskView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideMyPicker11)]];
    
    
    self.pickerBgView = [[UIView alloc]initWithFrame:CGRectMake(0, kScreenH - kScreenH / 2.61568, kScreenW, kScreenH / 2.61568)];
    
    
    self.pickerBgView.backgroundColor = [UIColor whiteColor];
    
    UIDatePicker *myPicker = [[UIDatePicker alloc] init];
    myPicker.locale = [[NSLocale alloc]initWithLocaleIdentifier:@"zh_ch"];
    // 设置时区，中国在东八区
    myPicker.timeZone = [NSTimeZone timeZoneWithName:@"GTM+8"];
    [_pickerBgView addSubview:myPicker];
    [myPicker mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kScreenW, kScreenH / 3.08796));
        make.left.mas_equalTo(0);
        make.top.mas_equalTo(kScreenH / 17.1025);
    }];
    myPicker.datePickerMode = UIDatePickerModeDate;
    NSDate *maxDate = [[NSDate alloc]initWithTimeIntervalSinceNow:24*60*60];
    myPicker.maximumDate = maxDate;
    NSDate *minDate = [NSDate date];
    myPicker.maximumDate = minDate;
    
    [UIView animateWithDuration:0.3 animations:^{
        self.pickerBgView.alpha = 1.0;
    }];
    
    
    UIView *view  =[[UIView alloc]init];
    view.backgroundColor = [UIColor colorWithRed:224/255.0 green:224/255.0 blue:224/255.0 alpha:1.0];
    [self.pickerBgView addSubview:view];
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kScreenW, kScreenH / 17.1025));
        make.left.mas_equalTo(0);
        make.top.mas_equalTo(0);
    }];
    
    UIButton *cancleBtn = [UIButton initWithTitle:@"取消" andColor:[UIColor clearColor] andSuperView:view]
    ;
    [cancleBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [cancleBtn addTarget:self action:@selector(cancel11:) forControlEvents:UIControlEventTouchUpInside];
    [cancleBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.size.mas_equalTo(CGSizeMake(kScreenW / 4, kScreenH / 17.1025));
        make.top.mas_equalTo(0);
    }];
    
    UIButton *sureBtn = [UIButton initWithTitle:@"确定" andColor:[UIColor clearColor] andSuperView:view]
    ;
    [sureBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [sureBtn addTarget:self action:@selector(ensure11:) forControlEvents:UIControlEventTouchUpInside];
    [sureBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(0);
        make.size.mas_equalTo(CGSizeMake(kScreenW / 4, kScreenH / 17.1025));
        make.top.mas_equalTo(0);
    }];
    
    [self.view addSubview:self.maskView];
    [self.view addSubview:self.pickerBgView];
    
    self.pickerBgView.top = self.view.height;
    
    [UIView animateWithDuration:0.3 animations:^{
        
        self.myPicker.alpha = 1.0;
        self.pickerBgView.bottom = self.view.height;
    }];
    
    self.myPicker = myPicker;
    
}

- (void)seletedBirthyDate {
    NSDate *date = self.myPicker.date;
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"YYYY-MM-dd"];
    NSString *time = [dateFormatter stringFromDate:date];
    self.birthdayLabel.text = time;
    
}

#pragma mark - 确定  取消  的点击事件
- (void)cancel11:(UIButton *)btn {
    [self hideMyPicker11];
}

- (void)ensure11:(UIButton *)btn {
    [self seletedBirthyDate];
    [self hideMyPicker11];
}


#pragma mark - 隐藏UIPickView
- (void)hideMyPicker11 {
    [UIView animateWithDuration:0.3 animations:^{
        self.maskView.alpha = 0;
        self.pickerBgView.top = self.view.height;
    } completion:^(BOOL finished) {
        [self.maskView removeFromSuperview];
        [self.pickerBgView removeFromSuperview];
    }];
}

- (NSMutableDictionary *)dic{
    if (!_dic) {
        self.dic = [NSMutableDictionary dictionary];
    }
    return _dic;
}


- (void)setUserModel:(UserModel *)userModel {
    _userModel = userModel;
    
    NSLog(@"%@" , _userModel);
    
}

@end
