//
//  XinFengKongJingViewController.m
//  联侠
//
//  Created by 杭州阿尔法特 on 16/10/10.
//  Copyright © 2016年 张海昌. All rights reserved.
//

#import "XinFengViewController.h"
#import "XinFengFirstTableViewCell.h"
#import "XinFengSecondTableViewCell.h"
#import "XinFengThirtTableViewCell.h"
#import "XinFengForthTableViewCell.h"
#import "XinFengFifthTableViewCell.h"
#import "SetServicesViewController.h"
#import "AllTypeServiceViewController.h"
#import "ConnectWeViewController.h"
#import "MineSerivesViewController.h"
#import "XinFengTimeViewController.h"
#import "ChanPinShuoMingViewController.h"

#define kBtnW ((kScreenW + 4) / 4)
@interface XinFengViewController ()<UITableViewDelegate , UITableViewDataSource , HelpFunctionDelegate , XinFengTimeVCSendTimeToParentVCDelegate , UIGestureRecognizerDelegate , UINavigationControllerDelegate>
@property (nonatomic , strong) UITableView *tableView;
@property (nonatomic , strong) UIButton *bottomBtn;
@property (nonatomic , strong) UIView *markView;

@property (nonatomic , strong) StateModel *stateModel;
@property (nonatomic , strong) ServicesDataModel *serviceDataModel;
@property (nonatomic , strong) UserModel *userModel;
@property (nonatomic , strong) NSMutableDictionary *dic;

@property (nonatomic , copy) NSString *deviceName;
@end

@implementation XinFengViewController

- (NSMutableDictionary *)dic {
    if (!_dic) {
        _dic = [NSMutableDictionary dictionary];
    }
    return _dic;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];

    [kStanderDefault setObject:@"YES" forKey:@"Login"];
    
    NSDictionary *parameters = nil;
    if ([kStanderDefault objectForKey:@"GeTuiClientId"]) {
        parameters = @{@"loginName" : [kStanderDefault objectForKey:@"phone"] , @"password" : [kStanderDefault objectForKey:@"password"] , @"ua.clientId" : [kStanderDefault objectForKey:@"GeTuiClientId"], @"ua.phoneType" : @(2) , @"ua.phoneBrand":@"iPhone" , @"ua.phoneModel":[NSString getDeviceName] , @"ua.phoneSystem":[NSString getDeviceSystemVersion]};
    } else {
        parameters = @{@"loginName" : [kStanderDefault objectForKey:@"phone"] , @"password" : [kStanderDefault objectForKey:@"password"] , @"ua.phoneType" : @(2), @"ua.phoneBrand":@"iPhone" , @"ua.phoneModel":[NSString getDeviceName] , @"ua.phoneSystem":[NSString getDeviceSystemVersion]};
    }
    
    [HelpFunction requestDataWithUrlString:kLogin andParames:parameters andDelegate:self];
    [self setupNav];
    [self setUI];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    if (self.serviceModel && self.userModel) {
        
        [kSocketTCP sendDataToHost:[NSString stringWithFormat:@"HM%ld%@%@N#" , (long)self.userModel.sn , self.serviceModel.devTypeSn , self.serviceModel.devSn] andType:kAddService andIsNewOrOld:nil];
    }
    
}

- (void)setupNav {
    self.navigationController.delegate = self;
    
//    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithTarget:self action:@selector(gengDuoTapAtcion) image:@"gengDuo" highImage:nil];
    
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithTarget:self action:@selector(gengDuoTapAtcion) title:@"产品说明" highTitle:@"产品说明"];
    
}

#pragma mark - 右上角点击事件
- (void)gengDuoTapAtcion {
    
    [UIAlertController creatSheetControllerWithFirstHandle:^{
        
        [UIAlertController creatAlertControllerWithFirstTextfiledPlaceholder:nil andFirstTextfiledText:[NSString stringWithFormat:@"%@%@" , self.serviceModel.brand , self.serviceModel.typeName] andFirstAtcion:nil andWhetherEdite:NO WithSecondTextfiledPlaceholder:@"请输入修改名称" andSecondTextfiledText:nil andSecondAtcion:@selector(secondTextFieldsValueDidChange:) andAlertTitle:@"修改设备名称" andAlertMessage:@"你可以再次修改设备名称，便于区分。" andTextfiledAtcionTarget:self andSureHandle:^{
            if (self.deviceName) {
                NSDictionary *parames = @{@"ud.devTypeSn" :  self.serviceModel.devTypeSn, @"ud.devSn" :  self.serviceModel.devSn, @"ud.definedName" : self.deviceName};
                NSLog(@"修改设备名称---%@" , parames);
                [HelpFunction requestDataWithUrlString:kChangeServiceName andParames:parames andDelegate:self];
            }
        } andSuperViewController:self];
        
    } andFirstTitle:@"修改名称" andSecondHandle:^{
        
        [UIAlertController creatCancleAndRightAlertControllerWithHandle:^{
            NSDictionary *parames = @{@"id" : @(self.serviceModel.userDeviceID)};
            [HelpFunction requestDataWithUrlString:kDeleteServiceURL andParames:parames andDelegate:self];
        } andSuperViewController:self Title:@"是否移除设备"];
        
    } andSecondTitle:@"移除设备" andThirtHandle:^{
     
        ChanPinShuoMingViewController *chanPinDesVC = [[ChanPinShuoMingViewController alloc]init];
        chanPinDesVC.serviceModel = self.serviceModel;
        chanPinDesVC.typeSn = @"4200";
        chanPinDesVC.isFromMainVC = YES;
        [self.navigationController pushViewController:chanPinDesVC animated:YES];
        
    } andThirtTitle:@"产品说明" andForthHandle:^{
        NSMutableString * str=[[NSMutableString alloc] initWithFormat:@"telprompt://%@",@"4009909918"];
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
    } andForthTitle:@"联系我们(4009909918)" andSuperViewController:self];
}

- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    
    
    if ([viewController isKindOfClass:[MineSerivesViewController class]]) {
        XinFengFirstTableViewCell *cell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
        [cell.myTimer invalidate];
        cell.myTimer = nil;
        
        if (self.serviceModel) {
            if (_sendServiceModelToParentVCDelegate && [_sendServiceModelToParentVCDelegate respondsToSelector:@selector(sendServiceModelToParentVC:)]) {
                [_sendServiceModelToParentVCDelegate sendServiceModelToParentVC:self.serviceModel];
            }
        }
    }
    
}

#pragma mark - 获取代理的数据
- (void)requestData:(HelpFunction *)request didFinishLoadingDtaArray:(NSMutableArray *)data {
    NSDictionary *dic = data[0];
//    NSLog(@"%@" , dic);
    if ([dic[@"state"] integerValue] == 0) {
        
        NSDictionary *user = dic[@"data"];
        
        [kStanderDefault setObject:user[@"sn"] forKey:@"userSn"];
        [kStanderDefault setObject:user[@"id"] forKey:@"userId"];
        
        _userModel = [[UserModel alloc]init];
        for (NSString *key in [user allKeys]) {
            [_userModel setValue:user[key] forKey:key];
        }
        
        [kApplicate initLastXinFengViewController:self];
        [kApplicate initUserModel:_userModel];
    }
}


- (void)setServiceModel:(ServicesModel *)serviceModel {
    _serviceModel = serviceModel;
    
    if (_serviceModel) {
        [self sendXinFengNowTime];
        
        [kApplicate initServiceModel:self.serviceModel];
        if ([self.serviceModel.devTypeSn isEqualToString:@"4232"]) {
            [self requestXinFengServiceData];
            [self requestXinFengServiceState];
        }
    }
}

- (void)requestXinFengServiceState {
    NSDictionary *parames = @{@"devSn" : self.serviceModel.devSn , @"devTypeSn" : self.serviceModel.devTypeSn};
    [HelpFunction requestDataWithUrlString:kChaXunKongJingDangQianZhuangTai andParames:parames andDelegate:self];
}

- (void)requestXinFengServiceData {
    NSDictionary *parames = @{@"devSn" : self.serviceModel.devSn , @"devTypeSn" : self.serviceModel.devTypeSn};
    [HelpFunction requestDataWithUrlString:kChaXunKongJingDangQianShuJu andParames:parames andDelegate:self];
}

- (void)sendXinFengNowTime {
    
    NSString *nowTime = [NSString getNowTimeString];
    nowTime = [nowTime substringWithRange:NSMakeRange(11, 5)];
    
    NSString *hourTime = [nowTime substringWithRange:NSMakeRange(0, 2)];
    NSString *minuteTime = [nowTime substringWithRange:NSMakeRange(3, 2)];
    
    NSString *hourHex = [[NSString ToHex:hourTime.integerValue] substringFromIndex:2];
    NSString *minuteHex = [[NSString ToHex:minuteTime.integerValue] substringFromIndex:2];
    
    [kSocketTCP sendDataToHost:XinFengKongJingSetTime(self.serviceModel.devTypeSn, self.serviceModel.devSn , hourHex , minuteHex) andType:kZhiLing andIsNewOrOld:kNew];
}

#pragma mark - 获取设备的数据
- (void)requestServicesData:(HelpFunction *)request didOK:(NSDictionary *)dic{
//    NSLog(@"%@" , dic);
    if ([dic[@"data"] isKindOfClass:[NSDictionary class]]) {
        self.serviceDataModel = [[ServicesDataModel alloc]init];
        [self.serviceDataModel setValuesForKeysWithDictionary:dic[@"data"]];
        [self.tableView reloadData];
    }
}

#pragma mark - 获取设备的状态
- (void)requestData:(HelpFunction *)request didSuccess:(NSDictionary *)dddd{
//    NSLog(@"%@" , dddd);
    if ([dddd[@"data"] isKindOfClass:[NSDictionary class]]) {
        NSDictionary *dataDic = dddd[@"data"];
        
        self.stateModel = [[StateModel alloc]init];
        
        for (NSString *key in [dataDic allKeys]) {
            [self.stateModel setValue:dataDic[key] forKey:key];
        }
        
        if ([self.serviceModel.devTypeSn isEqualToString:@"4232"]) {
            if (self.stateModel.fSwitch == 2  || self.stateModel.fSwitch == 0) {
                self.bottomBtn.backgroundColor = [UIColor grayColor];
                self.bottomBtn.selected = 0;
                [self btn:self.bottomBtn removeAtcion:@"xinFengCloseAtcion" addAtcion:@"xinFengOpenAtcion"];
                [kStanderDefault setObject:@(0) forKey:@"offBtn"];
            } else if (self.stateModel.fSwitch == 1){
                
                [UIView animateWithDuration:0.3 animations:^{
                    _markView.alpha = 0;
                }];
                self.bottomBtn.backgroundColor = kXinFengKongJingYanSe;
                self.bottomBtn.selected = 1;
                [self btn:self.bottomBtn removeAtcion:@"xinFengOpenAtcion" addAtcion:@"xinFengCloseAtcion"];
                [kStanderDefault setObject:@(1) forKey:@"offBtn"];
            }
            
        }
        
        [self.tableView reloadData];
        
    } else {
        
        if ([self.serviceModel.devTypeSn isEqualToString:@"4232"]) {
            [kStanderDefault setObject:@(0) forKey:@"offBtn"];
            self.bottomBtn.backgroundColor = [UIColor grayColor];

            [self btn:self.bottomBtn removeAtcion:@"xinFengCloseAtcion" addAtcion:@"xinFengOpenAtcion"];
        }
    }
    
}

- (void)btn:(UIButton *)btn removeAtcion:(NSString *)removetcion addAtcion:(NSString *)addAtcion {
    
    [btn removeTarget:self action:NSSelectorFromString(removetcion) forControlEvents:UIControlEventTouchUpInside];
    [btn addTarget:self action:NSSelectorFromString(addAtcion) forControlEvents:UIControlEventTouchUpInside];
}

- (void)requestData:(HelpFunction *)request didFailLoadData:(NSError *)error {
    NSLog(@"%@" , error);
}

#pragma mark - 按钮开点击事件
- (void)xinFengOpenAtcion {
    
    [kSocketTCP sendDataToHost:XinFengKongJing(self.serviceModel.devTypeSn, self.serviceModel.devSn, @"01", @"00", @"00", @"00" , @"00") andType:kZhiLing andIsNewOrOld:kNew];
}

#pragma mark - 按钮关点击事件
- (void)xinFengCloseAtcion {
    
    [kSocketTCP sendDataToHost:XinFengKongJing(self.serviceModel.devTypeSn, self.serviceModel.devSn, @"02", @"00", @"00", @"00" , @"00") andType:kZhiLing andIsNewOrOld:kNew];
}

#pragma mark - 获取TCP命令
- (void)getXinFengKongJing:(NSNotification *)post {
    NSString *str = post.userInfo[@"Message"];
    
    
    NSString *kaiGuan = [str substringWithRange:NSMakeRange(28, 2)];
    NSString *devSn = [str substringWithRange:NSMakeRange(14, 12)];
    
    if ([self.serviceModel.devSn isEqualToString:devSn]) {
        if ([kaiGuan isEqualToString:@"02"]) {
            
            self.bottomBtn.selected = 0;
            [kStanderDefault setObject:@(0) forKey:@"offBtn"];
            [UIView animateWithDuration:0.3 animations:^{
                _markView.alpha = 0.3;
            }];
            self.bottomBtn.backgroundColor = [UIColor grayColor];
            [self btn:self.bottomBtn removeAtcion:@"xinFengCloseAtcion" addAtcion:@"xinFengOpenAtcion"];
        } else if ([kaiGuan isEqualToString:@"01"]) {
            
            self.bottomBtn.selected = 1;
            [kStanderDefault setObject:@(1) forKey:@"offBtn"];
            [UIView animateWithDuration:0.3 animations:^{
                _markView.alpha = 0;
            }];
            self.bottomBtn.backgroundColor = kXinFengKongJingYanSe;

            [self btn:self.bottomBtn removeAtcion:@"xinFengOpenAtcion" addAtcion:@"xinFengCloseAtcion"];
        }
        
        [[NSNotificationCenter defaultCenter] postNotification:[NSNotification notificationWithName:@"BottomBtnSelected" object:nil userInfo:@{@"BottomBtnSelected" : @(self.bottomBtn.selected)}]];
        
    }
}

- (void)getXinFengModelIsOpen:(NSNotification *)post {

    NSString *section = [NSString stringWithFormat:@"%d" , 1];
    
    if ([self.dic[section] integerValue] == 0) {
        [self.dic setValue:@(1) forKey:section];
    } else{
        [self.dic setValue:@(0) forKey:section];
    }
    NSIndexSet *set = [NSIndexSet indexSetWithIndex:1];
    [self.tableView reloadSections:set withRowAnimation:UITableViewRowAnimationFade];
    
    
    if ([self.dic[section] isEqual:@(1)]) {
        NSIndexPath *scrollIndexpath = [NSIndexPath indexPathForRow:0 inSection:1];
        [self.tableView scrollToRowAtIndexPath:scrollIndexpath atScrollPosition:UITableViewScrollPositionTop animated:YES];
    }

}

#pragma mark - 布局
- (void)setUI {
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getXinFengKongJing:) name:@"4232" object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getXinFengModelIsOpen:) name:@"XinFengModelOpen" object:nil];
    
    self.automaticallyAdjustsScrollViewInsets = false;
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenW, kScreenH - kHeight - kScreenH / 12.3518518) style:UITableViewStylePlain];
    [self.view insertSubview:self.tableView belowSubview:self.navigationController.navigationBar];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.backgroundColor = kACOLOR(28, 157, 247, 1.0);
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    
    
    for (int i = 1; i < 5; i++) {
        [self.dic setValue:@(0) forKey:[NSString stringWithFormat:@"%d" , i]];
    }
    
    UIView *bottomView = [[UIView alloc]init];
    [self.view addSubview:bottomView];
    [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.view.mas_bottom);
        make.size.mas_equalTo(CGSizeMake(kScreenW, kScreenH / 12.3518518));
        make.right.mas_equalTo(self.view.mas_right);
    }];
    bottomView.backgroundColor = [UIColor whiteColor];
    
    self.bottomBtn = [UIButton initWithTitle:@"" andColor:[UIColor grayColor] andSuperView:self.view];
    self.bottomBtn.layer.cornerRadius = kScreenW / 18;
    //注册按钮的约束
    [self.bottomBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kScreenW - kScreenW * 2 / 15, kScreenW / 9));
        make.left.mas_equalTo(kScreenW / 15);
        make.bottom.mas_equalTo(self.view.mas_bottom).offset(-5);
    }];
    [self.bottomBtn addTarget:self action:@selector(xinFengOpenAtcion) forControlEvents:UIControlEventTouchUpInside];
    
    UILabel *bottomLable = [UILabel creatLableWithTitle:@"开启" andSuperView:self.bottomBtn andFont:k17 andTextAligment:NSTextAlignmentLeft];
    bottomLable.textColor = [UIColor whiteColor];
    bottomLable.layer.borderWidth = 0;
    [bottomLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(self.bottomBtn.height / 2, self.bottomBtn.height / 2));
        make.left.mas_equalTo(self.bottomBtn.mas_centerX).offset(3);
        make.centerY.mas_equalTo(self.bottomBtn.mas_centerY);
    }];
    
    UIImageView *offImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"iconfont-kaiguan222"]];
    offImageView.image = [offImageView.image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    offImageView.tintColor = [UIColor whiteColor];
    [self.bottomBtn addSubview:offImageView];
    [offImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(self.bottomBtn.height / 4, self.bottomBtn.height / 4));
        make.right.mas_equalTo(self.bottomBtn.mas_centerX).offset(-3);
        make.centerY.mas_equalTo(self.bottomBtn.mas_centerY);
    }];
    
}

#pragma mark - 移除设备
- (void)requestRemoveService:(HelpFunction *)request didDone:(NSDictionary *)dic{
//    NSLog(@"%@" , dic);
    
    if ([dic[@"state"] integerValue] == 0) {
        
        
        [UIAlertController creatRightAlertControllerWithHandle:^{
            [self.navigationController popViewControllerAnimated:YES];
        } andSuperViewController:self Title:@"设备删除成功"];
    }
}



- (void)secondTextFieldsValueDidChange:(UITextField *)textfiled {
    self.deviceName = textfiled.text;
}

- (void)requestData:(HelpFunction *)request changeServiceName:(NSDictionary *)dic {
//    NSLog(@"%@" , dic);
    
    if ([dic[@"state"] isKindOfClass:[NSNull class]]) {
        return ;
    }
    
    NSInteger index = [dic[@"state"] integerValue];
    if (index == 0) {
        if (self.deviceName) {
            self.navigationItem.title = [NSString stringWithFormat:@"%@%@" , self.deviceName , self.serviceModel.typeName];
        } else {
            self.navigationItem.title = [NSString stringWithFormat:@"%@%@" , self.serviceModel.brand , self.serviceModel.typeName];
        }
    }
    
    
    
}

#pragma mark - 左上角返回点击事件
- (void)xinFengBackAtcion:(UITapGestureRecognizer *)tap{
    
    XinFengFirstTableViewCell *cell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    [cell.myTimer invalidate];
    cell.myTimer = nil;
    
    if (self.serviceModel) {
        if (_sendServiceModelToParentVCDelegate && [_sendServiceModelToParentVCDelegate respondsToSelector:@selector(sendServiceModelToParentVC:)]) {
            [_sendServiceModelToParentVCDelegate sendServiceModelToParentVC:self.serviceModel];
        }
    }
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - tableView的代理
#pragma mark - 分区的个数

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (section == 0) {
        return 2;
    } else if (section == 1){
        NSString *key = [NSString stringWithFormat:@"%ld" , (long)section];
        if ([self.dic[key] integerValue] == 1) {
            return 1;
        }
        return 0;
        
    } else {
        return 2;
    }

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            static NSString *celled = @"first";
            XinFengFirstTableViewCell *cell
            =[tableView dequeueReusableCellWithIdentifier:celled];
            if (!cell) {
                cell = [[XinFengFirstTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:celled];
            }
            cell.serviceModel = self.serviceModel;
            cell.serviceDataModel = self.serviceDataModel;
            
            return cell;
        } else {
            static NSString *celled = @"second";
            XinFengSecondTableViewCell *cell
            =[tableView dequeueReusableCellWithIdentifier:celled];
            if (!cell) {
                cell = [[XinFengSecondTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:celled];
            }
            cell.serviceModel = self.serviceModel;
            cell.vc = self;
            return cell;
        }
    } else if (indexPath.section == 1) {
        static NSString *celled = @"Thirt";
        XinFengThirtTableViewCell *cell
        =[tableView dequeueReusableCellWithIdentifier:celled];
        if (!cell) {
            cell = [[XinFengThirtTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:celled];
        }
        
        cell.serviceModel = self.serviceModel;
        
        return cell;
    } else {
        
        if (indexPath.row == 0) {
            static NSString *celled = @"fifth";
            XinFengFifthTableViewCell *cell
            =[tableView dequeueReusableCellWithIdentifier:celled];
            if (!cell) {
                cell = [[XinFengFifthTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:celled];
            }
            
            cell.servicModel = self.serviceModel;
            return cell;
        } else  {
            static NSString *celled = @"forth";
            XinFengForthTableViewCell *cell
            =[tableView dequeueReusableCellWithIdentifier:celled];
            if (!cell) {
                cell = [[XinFengForthTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:celled];
            }
            
            cell.liearColor = kXinFengKongJingYanSe;
            cell.chaXunLishiJiLu = kKongJingLiShiJiLu;
            cell.serviceModel = self.serviceModel;
            return cell;
        }
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            return kScreenH / 1.56 + kScreenW / 10 - kScreenW / 25 + 5;
        } else {
            return kBtnW * 9 / 4;
        }
        
    } else if (indexPath.section == 1) {
        return kBtnW * 3 / 2;
    } else {
        if(indexPath.row == 0){
            return kScreenH / 7;
        } else {
            return kScreenH / 2.9 ;
        }
    }
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    if (indexPath.row == 0 && indexPath.section == 2) {
        XinFengTimeViewController *xinFengTimeVC = [[XinFengTimeViewController alloc]init];
        xinFengTimeVC.serviceModel = self.serviceModel;
        xinFengTimeVC.delegate = self;
        [self.navigationController pushViewController:xinFengTimeVC animated:YES];
    }
    
}

- (void)xinFengTimeVCSendTimeToParentVCDelegate:(NSArray *)array {
//    NSLog(@"%@" , array);
    
    NSString *time = nil;
    NSString *repeatStr = nil;
    NSString *openTime = array[0];
    NSString *closeTime = array[1];
    NSInteger openOn = [array[2] integerValue];
    NSInteger closeOn = [array[3] integerValue];
    NSInteger repeatOn = [array[4] integerValue];
    
    if (openOn == 0 && closeOn == 0) {
        time = [NSString stringWithFormat:@"暂无定时预约"];
    }
    if (openOn == 1 && closeOn == 0) {
        time = [NSString stringWithFormat:@"%@开启" , openTime];
    }
    if (openOn == 0 && closeOn == 1) {
       time = [NSString stringWithFormat:@"%@关闭" , closeTime];
    }
    if (openOn == 1 && closeOn == 1) {
        time = [NSString stringWithFormat:@"%@开启 , %@关闭" , openTime , closeTime];
    }
    
    if (repeatOn == 1) {
        repeatStr = @"每天";
    } else {
        repeatStr = @"无重复";
    }
    
    XinFengFifthTableViewCell *cell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:2]];
    if (time) {
        cell.shuoMingLabel.text = time;
        cell.openOrOffLable.text = repeatStr;
    }
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:nil object:nil];
}


@end
