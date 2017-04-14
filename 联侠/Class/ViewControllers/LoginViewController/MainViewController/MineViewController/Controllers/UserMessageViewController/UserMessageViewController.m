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
#import "LoginViewController.h"
#import "UserInfoCommonCell.h"
#import "GeRenModel.h"

#import "CustomPickerView.h"

#import <AVFoundation/AVFoundation.h>
@interface UserMessageViewController ()<UITableViewDataSource , UITableViewDelegate , HelpFunctionDelegate , SendDiZhiDataToProvienceVCDelegate , SendNickOrEmailToPreviousVCDelegate, CustomPickerViewDelegate>
@property (nonatomic , strong) NSMutableDictionary *dic;

@property (nonatomic , strong) UILabel *birthdayLabel;
@property (nonatomic , strong) UILabel *emailLabel;
@property (nonatomic , strong) UILabel *diZhiLabel;
@property (nonatomic , strong) UILabel *niChengLabel;

@property (nonatomic , strong) NSString *idd;

@property (strong, nonatomic)  CustomPickerView *myDatePicker;
@property (nonatomic , strong) CustomPickerView *sexPicker;
@property (nonatomic , strong) NSArray *sexArray;
@property (nonatomic , strong) GeRenModel *geRenModel;
@property (nonatomic , strong) DiZhiModel *diZhiModel;

@end

static NSString *celled = @"celled";
@implementation UserMessageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithHexString:@"f2f4fb"];
    
    self.tableView.backgroundColor = [UIColor colorWithHexString:@"f2f4fb"];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.contentInset = UIEdgeInsetsMake(10, 0, 0, 0);
    [self.tableView registerClass:[UserInfoCommonCell class] forCellReuseIdentifier:celled];
    
    if ([kStanderDefault objectForKey:@"GeRenModel"]) {
        self.geRenModel = [[GeRenModel alloc]init];
        [self.geRenModel setValuesForKeysWithDictionary:[kStanderDefault objectForKey:@"GeRenModel"]];
        NSLog(@"%@" , self.geRenModel);
    }
    
    
    [HelpFunction requestDataWithUrlString:kChaXunYongHuDiZhi andParames:@{@"userSn" : @(self.userModel.sn)} andDelegate:self];
    
    
}

#pragma mark - 代理返回数据
- (void)requestData:(HelpFunction *)request didFinishLoadingDtaArray:(NSMutableArray *)data {
    NSLog(@"%@" , data[0]);
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
        
        [self.tableView reloadData];
    }
    
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
//    if (self.userModel && self.sex && self.niChengLabel.text && self.birthdayLabel.text && self.emailLabel.text) {
//        NSMutableDictionary *parames = [NSMutableDictionary dictionary];
//        [parames setObject:@(self.userModel.sn) forKey:@"user.sn"];
//        [parames setObject:@(self.sex) forKey:@"user.sex"];
//        if (self.niChengLabel.text) {
//            [parames setObject:self.niChengLabel.text forKey:@"user.nickname"];
//        } if (self.birthdayLabel.text) {
//            [parames setObject:self.birthdayLabel.text forKey:@"user.birthdate"];
//        } if (self.emailLabel.text) {
//            [parames setObject:self.emailLabel.text forKey:@"user.email"];
//        }
//        
//        NSLog(@"%@" , parames);
//        
//        [kStanderDefault setObject:parames forKey:@"GeRenModel"];
//        
//        [HelpFunction requestDataWithUrlString:kXiuGaiXinXi andParames:parames andDelegate:self];
//    }
//    
//    
//    if (self.niChengLabel.text) {
//        [[NSNotificationCenter defaultCenter] postNotification:[NSNotification notificationWithName:@"niCheng" object:self userInfo:[NSDictionary dictionaryWithObject:self.niChengLabel.text forKey:@"niCheng"]]];
//    }
    
}
- (void)requestServicesData:(HelpFunction *)request didOK:(NSDictionary *)dic {
    NSLog(@"%@" , dic);
}

- (void)requestData:(HelpFunction *)request didSuccess:(NSDictionary *)dddd {
    NSLog(@"%@" , dddd);
}

- (void)requestData:(HelpFunction *)request didFailLoadData:(NSError *)error {
    NSLog(@"%@" , error);
}

#pragma mark - TableView的代理事件
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UserInfoCommonCell *cell = [tableView dequeueReusableCellWithIdentifier:celled];
    cell.dizhiModel = self.diZhiModel;
    cell.userModel = self.userModel;
    cell.indexPath = indexPath;
    
    return cell;
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) return 6;
    else if (section == 1) return 2;
    else return 1;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0 && indexPath.row == 0) {
        return kScreenH / 8.3;
    } else return kScreenH / 14.46;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return kScreenW / 27;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    UIView *view = [[UIView alloc]init];
    view.backgroundColor = [UIColor clearColor];
    return view;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    if (indexPath.section == 0 && (indexPath.row == 1 || indexPath.row == 5)) {

        NiChengViewController *nickNameVC = [[NiChengViewController alloc]init];
        if (indexPath.row == 5) {
            nickNameVC.navigationItem.title = @"邮箱";
        } else if (indexPath.row == 1) {
            nickNameVC.navigationItem.title = @"昵称";
        }
        nickNameVC.delegate = self;
        nickNameVC.userModel = self.userModel;
        [self.navigationController pushViewController:nickNameVC animated:YES];
    } else if (indexPath.section == 0 && (indexPath.row == 2 || indexPath.row == 3)) {
        
        if (indexPath.row == 2) {
            self.sexPicker = [[CustomPickerView alloc]initWithPickerViewType:2 andBackColor:kMainColor];
            [kWindowRoot.view addSubview:self.sexPicker];
            self.sexPicker.delegate = self;
        } else if (indexPath.row == 3) {
            self.myDatePicker = [[CustomPickerView alloc]initWithPickerViewType:3 andBackColor:kMainColor];
            [kWindowRoot.view addSubview:self.myDatePicker];
            self.myDatePicker.delegate = self;
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
        [kStanderDefault removeObjectForKey:@"wearthDic"];
        [kStanderDefault removeObjectForKey:@"GeRenModel"];
        [kSocketTCP cutOffSocket];
        loginVC.fromUserVC = [NSString stringWithFormat:@"YES"];
        

        [self.navigationController pushViewController:loginVC animated:YES];
    } else if (indexPath.section == 0 && indexPath.row == 4) {
        LocationPickerVC *diZhiVC = [[LocationPickerVC alloc]init];
        diZhiVC.userModel = self.userModel;
        diZhiVC.diZhiModel = self.diZhiModel;
        diZhiVC.delegate = self;
        diZhiVC.navigationItem.title = @"我的地址";
        [self.navigationController pushViewController:diZhiVC animated:YES];
    } else if (indexPath.section == 2) {
        if (indexPath.row == 0) {
            NiChengViewController *niVC = [[NiChengViewController alloc]init];
            niVC.delegate = self;
            [self.navigationController pushViewController:niVC animated:YES];
        } else if (indexPath.row == 1) {
            
            
        } else if (indexPath.row == 2) {
            
        }
    }
}

- (void)sendPickerViewToVC:(UIPickerView *)picker {
    if (self.sexPicker) {
        UserInfoCommonCell *cell = [self tableViewindexPathForRow:2 inSection:0];
        cell.rightLabel.text = [NSString stringWithFormat:@"%@" , self.sexArray[[picker selectedRowInComponent:0]]];
        self.sexPicker = nil;
    }
}

- (UserInfoCommonCell *)tableViewindexPathForRow:(NSInteger)row inSection:(NSInteger)section {
    NSIndexPath *indexpath = [NSIndexPath indexPathForRow:row inSection:section];
    UserInfoCommonCell *cell = (UserInfoCommonCell *)[self.tableView cellForRowAtIndexPath:indexpath];
    return cell;
}

- (void)sendDatePickerViewToVC:(UIDatePicker *)datePicker {
    
    if (self.myDatePicker) {
        NSDate *date = datePicker.date;
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
        [dateFormatter setDateFormat:@"YYYY-MM-dd"];
        NSString *time = [dateFormatter stringFromDate:date];
        UserInfoCommonCell *cell = [self tableViewindexPathForRow:3 inSection:0];
        cell.rightLabel.text= time;
        self.myDatePicker = nil;
    }
    
    
    
}

- (void)sendDiZhiDataToProvienceVC:(NSString *)diZhiStr {
    UserInfoCommonCell *cell = [self tableViewindexPathForRow:4 inSection:0];
    cell.rightLabel.text = diZhiStr;
}

- (void)sendNickOrEmailToPreviousVC:(NSArray *)nickOrEmailArr {
    
    NSString *info = nickOrEmailArr[0];
    NSString *navTitle = nickOrEmailArr[1];
    
    NSIndexPath *indexPath = nil;
    if ([navTitle isEqualToString:@"昵称"]) {
        indexPath = [NSIndexPath indexPathForRow:1 inSection:0];
        self.userModel.nickname = info;
    } else {
        indexPath = [NSIndexPath indexPathForRow:5 inSection:0];
        self.userModel.email = info;
    }
    UserInfoCommonCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
    cell.rightLabel.text = info;
    
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

- (NSArray *)sexArray {
    if (!_sexArray) {
        _sexArray = [NSArray arrayWithObjects:@"男",@"女", nil];
    }
    return _sexArray;
}

@end
