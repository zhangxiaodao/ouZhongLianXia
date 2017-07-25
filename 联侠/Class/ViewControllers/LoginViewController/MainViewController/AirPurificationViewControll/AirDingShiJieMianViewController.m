//
//  AirDingShiJieMianViewController.m
//  联侠
//
//  Created by 杭州阿尔法特 on 16/6/8.
//  Copyright © 2016年 张海昌. All rights reserved.
//

#import "AirDingShiJieMianViewController.h"
#import "AirDingShiTableViewCell.h"

@interface AirDingShiJieMianViewController ()< UITableViewDataSource , UITableViewDelegate , HelpFunctionDelegate , AirDingShiTableViewCellDelegate>{
    NSArray *moShiArray;
}

@property (nonatomic , strong) UITableView *tableView;
@property (nonatomic , strong) UIButton *doneBtn;
@property (nonatomic , strong) UIButton *cancleBtn;
@property (nonatomic , strong) NSMutableArray *timeTextArray;
//@property (nonatomic , copy) NSString *clothesType;
@end

@implementation AirDingShiJieMianViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    [self setUI];
    
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = NO;
    
    UIImageView *backImage = [[UIImageView alloc]initWithImage:[UIImage new]];
    UIImage *image = nil;
    if ([_fromWhich isEqualToString:@"first"]) {
        image = [UIImage imageNamed:@"dingShiTuPian"];
    } else if ([_fromWhich isEqualToString:@"second"]) {
        image = [UIImage imageNamed:@"zhouMoMoShi"];
    } else if ([_fromWhich isEqualToString:@"thirt"]) {
        image = [UIImage imageNamed:@"zhiNengMoShi"];
    } else if ([_fromWhich isEqualToString:@"forth"]) {
        image = [UIImage imageNamed:@"ziDingYiMoShi"];
    }
    backImage.image = image;
    backImage.frame = CGRectMake(0, 0, kScreenW, kScreenW * (image.size.height / image.size.width));
    
    backImage.contentMode = UIViewContentModeScaleToFill;

    [self.view insertSubview:backImage atIndex:0];
    

}

-(void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    [self.view.subviews[0] removeFromSuperview];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.tableView reloadData];
}

- (void)requestServicesData:(HelpFunction *)request didOK:(NSDictionary *)dic {
    
    if ([dic[@"state"] isKindOfClass:[NSNull class]]) {
        return ;
    }
    
    if ([dic[@"state"] integerValue] == 0) {
        [UIAlertController creatRightAlertControllerWithHandle:nil andSuperViewController:self Title:@"预约完成"];
    }
    
}

- (void)requestData:(HelpFunction *)request didFailLoadData:(NSError *)error {
    NSLog(@"%@" , error);
}

- (void)setUI {
    [self timeTextArray];
    self.tableView = [[UITableView alloc]initWithFrame:kScreenFrame style:UITableViewStylePlain];
    [self.view addSubview:self.tableView];
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.scrollEnabled = NO;
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.tableHeaderView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 0, 1)];
    
    self.tableView.contentInset = UIEdgeInsetsMake(BackGroupHeight, 0, 0, 0);
    
    
    
    self.doneBtn = [UIButton initWithTitle:@"开启模式" andColor:kKongJingYanSe andSuperView:self.view];
    [self.doneBtn setBackgroundImage:[UIImage imageWithColor:kACOLOR(215, 132, 110, 1.0)] forState:UIControlStateHighlighted];
    [self.doneBtn addTarget:self action:@selector(doneBtnAtcionQQQ:) forControlEvents:UIControlEventTouchUpInside];
    
    if (![_fromWhich isEqualToString:@"thirt"]) {
        
        //注册按钮的约束
        [self.doneBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake((kScreenW - kScreenW * 3 / 20) / 2, kScreenW / 9));
            make.bottom.mas_equalTo(self.view.mas_bottom).offset(-kScreenW / 20);
            make.right.mas_equalTo(self.view.mas_right).offset(-kScreenW / 20);
        }];

    }
    self.doneBtn.tag = 0;
    
    
    self.cancleBtn = [UIButton initWithTitle:@"关闭模式" andColor:kKongJingHuangSe andSuperView:self.view];
    [self.cancleBtn addTarget:self action:@selector(cancleBtnAtcionQQQ:) forControlEvents:UIControlEventTouchUpInside];
    [self.cancleBtn setBackgroundImage:[UIImage imageWithColor:kACOLOR(218, 235, 254, 1.0)] forState:UIControlStateHighlighted];
    
    //注册按钮的约束
    if (![_fromWhich isEqualToString:@"thirt"]) {
        [self.cancleBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake((kScreenW - kScreenW * 3 / 20) / 2, kScreenW / 9));
            make.bottom.mas_equalTo(self.view.mas_bottom).offset(-kScreenW / 20);
            make.left.mas_equalTo(kScreenW / 20);
        }];
    }
    
    self.cancleBtn.tag = 0;
    
    
    if ([_fromWhich isEqualToString:@"thirt"]) {
        
        [self.doneBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake((kScreenW - kScreenW * 3 / 20) / 2, kScreenW / 9));
            make.right.mas_equalTo(self.view.mas_right).offset(-kScreenW / 20);
            make.top.mas_equalTo(self.view.mas_top).offset(kScreenH / 1.588);
        }];
        [self.cancleBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake((kScreenW - kScreenW * 3 / 20) / 2, kScreenW / 9));
            make.top.mas_equalTo(self.view.mas_top).offset(kScreenH / 1.588);
            make.left.mas_equalTo(kScreenW / 20);
        }];
        
        if ([_buttonSelected isEqual:@0]) {
            self.doneBtn.userInteractionEnabled = NO;
            self.cancleBtn.userInteractionEnabled = NO;
        } else {
            self.doneBtn.userInteractionEnabled = YES;
            self.cancleBtn.userInteractionEnabled = YES;
        }
    }
    
}

- (void)doneBtnAtcionQQQ:(UIButton *)btn {
    moShiArray = [NSArray arrayWithObjects:self.fromWhich, @"YES", nil];
    self.doneBtn.tag = 1;
    self.cancleBtn.tag = 0;
    
    if ([self.fromWhich isEqualToString:@"thirt"]) {
        [kSocketTCP sendDataToHost:[NSString stringWithFormat:@"HMFF%@%@A1#", self.serviceModel.devTypeSn,self.serviceModel.devSn] andType:kZhiLing andIsNewOrOld:kOld];
        [btn removeTarget:self action:nil forControlEvents:UIControlEventTouchUpInside];
        [btn addTarget:self action:@selector(cancleBtnAtcionQQQ:) forControlEvents:UIControlEventTouchUpInside];
        
    } else {
        if (self.serviceModel.devSn) {
            
            if (![_fromWhich isEqualToString:@"thirt"]) {
                NSDictionary *parames = nil;
                if ([_timeTextArray[3] integerValue] == 0) {
                    parames = @{@"devSn" : self.serviceModel.devSn, @"devTypSn" : self.serviceModel.devTypeSn, @"task.fSwitchOn" : @(1), @"task.fSwitchOff" : @(1) , @"task.onJobTime" : _timeTextArray[0] , @"task.offJobTime" : _timeTextArray[1]};
                } else if([_timeTextArray[3] integerValue] == 1){
                    parames = @{@"devSn" : self.serviceModel.devSn, @"devTypSn" : self.serviceModel.devTypeSn, @"task.fSwitchOn" : @(1), @"task.fSwitchOff" : @(1) , @"task.onJobTime" : _timeTextArray[0] , @"task.offJobTime" : _timeTextArray[1] , @"task.runWeek" : @"1111111"};
                }
                NSLog(@"%@" , parames);
                [HelpFunction requestDataWithUrlString:kKongJingDingShiYuYue andParames:parames andDelegate:self];
            }
            
        }
    }
    
    if (moShiArray) {
        
//        NSLog(@"%@ , %@" , moShiArray , _timeTextArray);
        [kStanderDefault removeObjectForKey:@"AirDingShiData"];
        [kStanderDefault setObject:@[moShiArray , _timeTextArray] forKey:@"AirDingShiData"];
        [[NSNotificationCenter defaultCenter] postNotification:[NSNotification notificationWithName:@"KongJingIsWork" object:self userInfo:@{@"KongJingIsWork" : @"YES"}]];
        
    }
    
    
    

    
}

- (void)cancleBtnAtcionQQQ:(UIButton *)btn {
    
    
    moShiArray = [NSArray arrayWithObjects:self.fromWhich, @"NO", nil];
   
    [kStanderDefault removeObjectForKey:@"AirData"];
    [kStanderDefault removeObjectForKey:@"AirDingShiData"];
    
    [self.tableView reloadData];
    
    self.doneBtn.tag = 0;
    self.cancleBtn.tag = 1;
    
    if ([_fromWhich isEqualToString:@"thirt"]) {
        [kSocketTCP sendDataToHost:[NSString stringWithFormat:@"HMFF%@%@A2#", self.serviceModel.devTypeSn,self.serviceModel.devSn] andType:kZhiLing andIsNewOrOld:kOld];
        [btn removeTarget:self action:nil forControlEvents:UIControlEventTouchUpInside];
        [btn addTarget:self action:@selector(doneBtnAtcionQQQ:) forControlEvents:UIControlEventTouchUpInside];
       
    }
    [[NSNotificationCenter defaultCenter] postNotification:[NSNotification notificationWithName:@"KongJingIsChongZhi" object:nil userInfo:@{@"KongJingIsChongZhi" : @"YES"}]];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenW, kScreenH / 6.67)];
    
    UIView *fenGeView = [[UIView alloc]init];
    fenGeView.backgroundColor = kFenGeXianYanSe;
    [view addSubview:fenGeView];
    [fenGeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kScreenW, 1));
        make.left.mas_equalTo(0);
        make.bottom.mas_equalTo(view.mas_bottom);
    }];
    
    if ([_fromWhich isEqualToString:@"thirt"]) {
        fenGeView.backgroundColor = [UIColor whiteColor];
    }
    
    
    UILabel *lable = [UILabel creatLableWithTitle:@"" andSuperView:view andFont:k15 andTextAligment:NSTextAlignmentLeft];
    [lable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kScreenW - kScreenW / 15, view.height));
        make.centerX.mas_equalTo(view.mas_centerX);
        make.centerY.mas_equalTo(view.mas_centerY);
    }];
    lable.layer.borderWidth = 0;
    lable.textColor = [UIColor lightGrayColor];
    
    NSArray *array = nil;
    array = @[@"当您需要外出时，可以使用外出模式的默认值，也可以以自己安排开启和关闭的时间，在您外出的时候，空气净化器为您营造出良好的生活环境。" , @"在周末的时候，使用周末模式的默认模式，愉快和好心情伴随着呼吸，享受一个清新的周末。" , @"开启智能模式，空气净化器会根据室内空气质量情况自动调节工作时间，让空气长久保持健康状态。我很机智，您很健康！" , @"自定义模式下，您可以自由地安排开启和关闭空气净化器，针对您个人的作息做出合理的安排，享受每一个呼吸。"];
    
    
    if ([_fromWhich isEqualToString:@"first"]) {
        lable.text = array[0];
    } else if ([_fromWhich isEqualToString:@"second"]) {
        lable.text = array[1];
    } else if ([_fromWhich isEqualToString:@"thirt"]) {
        lable.text = array[2];
    } else {
        lable.text = array[3];
    }
    view.backgroundColor = [UIColor whiteColor];
    return view;
    
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenW, kScreenH / 6.67)];
    view.backgroundColor = [UIColor whiteColor];
    
    UIView *fenGeView = [[UIView alloc]init];
    fenGeView.backgroundColor = kFenGeXianYanSe;
    [view addSubview:fenGeView];
    [fenGeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kScreenW, 1));
        make.left.mas_equalTo(0);
        make.top.mas_equalTo(view.mas_top);
    }];

        if ([_fromWhich isEqualToString:@"thirt"]) {
            fenGeView.backgroundColor = [UIColor whiteColor];
        }
    
   
    
    return view;
}

#pragma mark - 生成cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if ([_fromWhich isEqualToString:@"thirt"]) {
        static NSString *celled = @"bbbbbb";
        
        UITableViewCell *cell
        =[tableView dequeueReusableCellWithIdentifier:celled];
        if (!cell) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:celled];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    } else {
        static NSString *celled = @"aaaaaa";
        AirDingShiTableViewCell *cell
        =[tableView dequeueReusableCellWithIdentifier:celled];
        if (!cell) {
            cell = [[AirDingShiTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:celled];
        }
        
        cell.fromWhich = self.fromWhich;
        
        cell.delegate = self;
        cell.currentVC = self;
        
        if (_timeTextArray.count == 0) {
            [_timeTextArray addObject:cell.openTime.text];
            [_timeTextArray addObject:cell.offTime.text];
            [_timeTextArray addObject:self.fromWhich];
            [_timeTextArray addObject:@(cell.isSelectedBtn.selected)];
        }
        
        return cell;
    }
    
    
}

- (void)getKongJingDingShiData:(AirDingShiTableViewCell *)AirDingShiTableViewCell andData:(id)data {
    NSMutableDictionary *dic = [data mutableCopy];
    
    [self timeTextArray];
    [_timeTextArray removeAllObjects];
    [_timeTextArray addObject:dic[@"openTime"]];
    [_timeTextArray addObject:dic[@"offTime"]];
    [_timeTextArray addObject:dic[@"fromWhich"]];
    [_timeTextArray addObject:dic[@"isSelectedBtn"]];
}

#pragma mark - cell的高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return kScreenH / 4.16875;
}
#pragma mark - cell的个数
- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

#pragma mark - 取消cell的选中状态
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];// 取消选中
    //其他代码
}


#pragma mark - 尾部的高度
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return kScreenH / 6.67;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return kScreenH / 6.67;
}


- (NSMutableArray *)timeTextArray {
    if (!_timeTextArray) {
        _timeTextArray = [NSMutableArray array];
        
        if ([kStanderDefault objectForKey:@"AirData"]) {
            NSDictionary *dic = [kStanderDefault objectForKey:@"AirData"];
            [_timeTextArray addObject:dic[@"openTime"]];
            [_timeTextArray addObject:dic[@"offTime"]];
            [_timeTextArray addObject:dic[@"fromWhich"]];
            [_timeTextArray addObject:dic[@"isSelectedBtn"]];
        }
        
    }
    return _timeTextArray;
}

- (void)setServiceModel:(ServicesModel *)serviceModel {
    _serviceModel = serviceModel;
}

- (void)setButtonSelected:(NSNumber *)buttonSelected {
    _buttonSelected = buttonSelected;
    
    if ([_buttonSelected isEqual:@0]) {
        self.doneBtn.userInteractionEnabled = NO;
        self.cancleBtn.userInteractionEnabled = NO;
        
    } else {
        self.doneBtn.userInteractionEnabled = YES;
        self.cancleBtn.userInteractionEnabled = YES;
    }

    
}

@end
