//
//  UserMessageViewController.m
//  AEFT冷风扇
//
//  Created by 杭州阿尔法特 on 16/3/16.
//  Copyright © 2016年 阿尔法特. All rights reserved.
//

#import "UserMessageViewController.h"
#import "MineYouHuiQuanViewController.h"
#import "ForgetPwdViewController.h"
#import "TabBarViewController.h"
#import "MineViewController.h"
#import "XMGNavigationController.h"

#import "LocationPickerVC.h"
#import "NiChengViewController.h"
#import "LoginViewController.h"
#import "LoginAnfRegisterVC.h"

#import "UserInfoCommonCell.h"
#import "GeRenModel.h"

#import "CustomPickerView.h"

#import <AVFoundation/AVFoundation.h>
@interface UserMessageViewController ()<UITableViewDataSource , UITableViewDelegate , HelpFunctionDelegate , SendDiZhiDataToProvienceVCDelegate , SendNickOrEmailToPreviousVCDelegate, CustomPickerViewDelegate>

@property (strong, nonatomic)  CustomPickerView *myDatePicker;
@property (nonatomic , strong) CustomPickerView *sexPicker;
@property (nonatomic , strong) NSArray *sexArray;
@property (nonatomic , strong) GeRenModel *geRenModel;
@property (nonatomic , strong) DiZhiModel *diZhiModel;
@property (nonatomic , strong) NSIndexPath *selectedIndexPath;

@property (nonatomic , strong) NSMutableArray *infoArray;
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
    
    
    [HelpFunction requestDataWithUrlString:kChaXunYongHuDiZhi andParames:@{@"userSn" : @(self.userModel.sn)} andDelegate:self];
    
    
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
        
        [self.tableView reloadData];
    }
    
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    
    if (self.selectedIndexPath) {
        UserInfoCommonCell *cell = [self.tableView cellForRowAtIndexPath:self.selectedIndexPath];
        cell.selectedImage.hidden = YES;
    }
    
    NSString *nickName = nil;
    NSInteger sex = 0;
    NSString *birthday = nil;
    NSString *address = nil;
    NSString *email = nil;
    
    for (int i = 1; i < 6; i++) {
        UserInfoCommonCell *cell = [self tableViewindexPathForRow:i inSection:0];
        switch (i) {
            case 1:
                nickName = cell.rightLabel.text;
                break;
            case 2:
                sex = [cell.rightLabel.text isEqualToString:@"男"] ? 1 : 2;
                break;
            case 3:
                birthday = cell.rightLabel.text;
                break;
            case 4:
                address = cell.rightLabel.text;
                break;
            case 5:
                email = cell.rightLabel.text;
                break;
            default:
                break;
        }
    }
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:nickName , @"nickName", @(sex) , @"sex" , birthday , @"birthday" , email ,@"email", address , @"address" , nil];
    NSLog(@"%@" , dic);
    [kStanderDefault setValue:dic forKey:@"GeRenInfo"];
    
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
    cell.userModel = self.userModel;
    cell.indexPath = indexPath;
    
    if (indexPath.section != 2) {
        NSArray *array = self.infoArray[indexPath.section];
        if (indexPath.section == 0 && indexPath.row == 0) {
            cell.headPortraitImageView.image = array[0];
            cell.currentVC = self;
        } else if (indexPath.section == 1 && indexPath.row == 0) {
            cell.idLabel.text = array[indexPath.row];
        }
    }
    
    
    return cell;
}


- (BOOL)tableView:(UITableView *)tableView shouldHighlightRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0 && indexPath.row == 0) {
        return NO;
    }
    
    UserInfoCommonCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    cell.selectedImage.hidden = NO;
    self.selectedIndexPath = indexPath;
    return YES;
}

- (void)tableView:(UITableView *)tableView didUnhighlightRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.selectedIndexPath) {
        UserInfoCommonCell *cell = [self.tableView cellForRowAtIndexPath:self.selectedIndexPath];
        cell.selectedImage.hidden = YES;
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) return 6;
    else if (section == 1) return 1;
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
            [self.view addSubview:self.sexPicker];
            self.sexPicker.delegate = self;
        } else if (indexPath.row == 3) {
            self.myDatePicker = [[CustomPickerView alloc]initWithPickerViewType:3 andBackColor:kMainColor];
            [self.view addSubview:self.myDatePicker];
            self.myDatePicker.delegate = self;
        }
        
        
    }  else if (indexPath.section == 0 && indexPath.row == 4) {
        LocationPickerVC *diZhiVC = [[LocationPickerVC alloc]init];
        diZhiVC.userModel = self.userModel;
        diZhiVC.diZhiModel = self.diZhiModel;
        diZhiVC.delegate = self;
        diZhiVC.navigationItem.title = @"我的地址";
        [self.navigationController pushViewController:diZhiVC animated:YES];
    }
//    else if (indexPath.section == 1 && indexPath.row == 0) {
//        if (indexPath.row == 0) {
//            
//            ForgetPwdViewController *forgetPwdVC = [[ForgetPwdViewController alloc]init];
//            forgetPwdVC.navigationItem.title = @"重置密码";
//            forgetPwdVC.phoneNumber = [kStanderDefault objectForKey:@"phone"];
//            [self.navigationController pushViewController:forgetPwdVC animated:YES];
//        }
//    }
    else if (indexPath.section == 2) {
        
        if ([kApplicate.window.rootViewController isKindOfClass:[TabBarViewController class]]) {
            
            [self kStanderDefaultRemoveAllObject];
            
            
            //XMGNavigationController *nav = [[XMGNavigationController alloc]initWithRootViewController:[[LoginViewController alloc]init]];
            XMGNavigationController *nav = [[XMGNavigationController alloc]initWithRootViewController:[[LoginAnfRegisterVC alloc]init]];
            kWindowRoot = nav;
            
        } else {
            
            [self dismissViewControllerAnimated:YES completion:^{
                [self kStanderDefaultRemoveAllObject];
            }];
        }
        
    }
}

- (void)kStanderDefaultRemoveAllObject {
    [kStanderDefault removeObjectForKey:@"Login"];
    [kStanderDefault removeObjectForKey:@"cityName"];
    [kStanderDefault removeObjectForKey:@"password"];
    [kStanderDefault removeObjectForKey:@"phone"];
    [kStanderDefault removeObjectForKey:@"userSn"];
    [kStanderDefault removeObjectForKey:@"userId"];
    
    [kStanderDefault removeObjectForKey:@"zhuYe"];
    
    [kStanderDefault removeObjectForKey:@"offBtn"];
    [kStanderDefault removeObjectForKey:@"GanYiJiData"];
    [kStanderDefault removeObjectForKey:@"ganYiJiHongGanDic"];
    [kStanderDefault removeObjectForKey:@"GanYiJiIsWork"];
    [kStanderDefault removeObjectForKey:@"AirData"];
    [kStanderDefault removeObjectForKey:@"AirDingShiData"];
    [kStanderDefault removeObjectForKey:@"kongZhiTai"];
    
    [kStanderDefault removeObjectForKey:@"data"];
    [kStanderDefault removeObjectForKey:@"requestWeatherTime"];
    [kStanderDefault removeObjectForKey:@"wearthDic"];
    [kStanderDefault removeObjectForKey:@"GeRenInfo"];
    kSocketTCP.isDuanXianChongLian = @"NO";
    [kSocketTCP cutOffSocket];
    
    NSDictionary *dic = [kStanderDefault objectForKey:@"GeRenInfo"];
    NSLog(@"%@" , dic);
}

- (void)sendPickerViewToVC:(UIPickerView *)picker {
    if (self.sexPicker) {
        UserInfoCommonCell *cell = [self tableViewindexPathForRow:2 inSection:0];
        cell.rightLabel.text = [NSString stringWithFormat:@"%@" , self.sexArray[[picker selectedRowInComponent:0]]];
        
        NSString *sexText = cell.rightLabel.text;
        NSInteger sex = 0;
        if ([sexText isEqualToString:@"男"]) {
            sex = 1;
        } else {
            sex = 2;
        }
        
        self.sexPicker = nil;
        NSDictionary *parames = @{@"user.sn" : @(self.userModel.sn) , @"user.sex" : @(sex)};
        NSLog(@"%@" , parames);
        [HelpFunction requestDataWithUrlString:kXiuGaiXinXi andParames:parames andDelegate:self];
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
        
        NSDictionary *parames = @{@"user.sn" : @(self.userModel.sn) , @"user.birthdate" : time};
        NSLog(@"%@" , parames);
        [HelpFunction requestDataWithUrlString:kXiuGaiXinXi andParames:parames andDelegate:self];
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
        
        [[NSNotificationCenter defaultCenter]postNotification:[NSNotification notificationWithName:@"niCheng" object:nil userInfo:[NSDictionary dictionaryWithObject:info forKey:@"niCheng"]]];
        
    } else {
        indexPath = [NSIndexPath indexPathForRow:5 inSection:0];
        self.userModel.email = info;
    }
    UserInfoCommonCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
    cell.rightLabel.text = info;
    
}


- (void)setUserModel:(UserModel *)userModel {
    _userModel = userModel;

    if ([kStanderDefault objectForKey:@"GeRenInfo"] != nil) {
        
        NSDictionary *dic = [kStanderDefault objectForKey:@"GeRenInfo"];
        
        self.geRenModel = [[GeRenModel alloc]init];
        [self.geRenModel setValuesForKeysWithDictionary:dic];
        _userModel.nickname = self.geRenModel.nickName;
        _userModel.sex = self.geRenModel.sex;
        _userModel.birthdate = self.geRenModel.birthday;
        _userModel.email = self.geRenModel.email;
    }
}

- (NSArray *)sexArray {
    if (!_sexArray) {
        _sexArray = [NSArray arrayWithObjects:@"男",@"女", nil];
    }
    return _sexArray;
}

- (NSMutableArray *)infoArray {
    if (!_infoArray) {
        _infoArray = [NSMutableArray array];
        
        NSMutableArray *firstSectionArray = [NSMutableArray array];
        NSMutableArray *secondSectionArray = [NSMutableArray array];
        if (self.headImage) {
            [firstSectionArray addObject:self.headImage];
        } else {
            [firstSectionArray addObject:[UIImage imageNamed:@"iconfont-touxiang"]];
        }
        
        if (self.userModel.nickname == nil || [self.userModel.nickname isKindOfClass:[NSNull class]]) {
            [firstSectionArray addObject:@"昵称"];
        } else {
            [firstSectionArray addObject:self.userModel.nickname];
        }
        
        if (self.userModel.sex == 1){
            [firstSectionArray addObject:@"男"];
        } else {
            [firstSectionArray addObject:@"女"];
        }
        
        if ([self.userModel.birthdate isKindOfClass:[NSNull class]] || self.userModel.birthdate == nil) {
            [firstSectionArray addObject:@"请选择生日"];
        } else {
            [firstSectionArray addObject:self.userModel.birthdate];
        }
        
        if (self.geRenModel.address != nil) {
            [firstSectionArray addObject:[NSString stringWithFormat:@"%@" , self.geRenModel.address]];
        } else {
            [firstSectionArray addObject:@"请输入地址"];
        }
        
        
        if ([self.userModel.email isKindOfClass:[NSNull class]] || self.userModel.email == nil) {
            [firstSectionArray addObject:@"请输入邮箱"];
        } else {
            [firstSectionArray addObject:self.userModel.email];
        }
        [secondSectionArray addObject:[NSString stringWithFormat:@"%ld" , self.userModel.sn]];
        
        [_infoArray addObject:firstSectionArray];
        [_infoArray addObject:secondSectionArray];
        
    }
    return _infoArray;
}
- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
@end
