//
//  LocationPickerVC.m
//  YouZhi
//
//  Created by roroge on 15/4/9.
//  Copyright (c) 2015年 com.roroge. All rights reserved.
//

#import "LocationPickerVC.h"
#import "LocationCell.h"
#import "UserMessageViewController.h"

@interface LocationPickerVC () < UITextFieldDelegate , HelpFunctionDelegate>

@end

static NSString *celled = @"celled";

@implementation LocationPickerVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor colorWithHexString:@"f2f4fb"];
    
    [self setUI];
    
}

#pragma mark - 设置UI
- (void)setUI{
    
    
    self.tableView.backgroundColor = [UIColor colorWithHexString:@"f2f4fb"];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.contentInset = UIEdgeInsetsMake(10, 0, 0, 0);
    [self.tableView registerClass:[LocationCell class] forCellReuseIdentifier:celled];
    [self.tableView addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(filedResiginResponde)]];
    self.tableView.scrollEnabled = NO;

    UIButton *sureBtn = [UIButton initWithTitle:@"保存" andColor:kMainColor andSuperView:self.view];
    [sureBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.top.mas_equalTo(self.view.mas_top).offset(kScreenH / 2.22);
        make.size.mas_equalTo(CGSizeMake( kScreenW / 2.8, kScreenW / 9.375));
    }];
    sureBtn.layer.cornerRadius = kScreenW / 9.375 / 2;
    sureBtn.titleLabel.font = [UIFont systemFontOfSize:k15];
    [sureBtn addTarget:self action:@selector(keepBtnAtcion) forControlEvents:UIControlEventTouchUpInside];
    
}

#pragma mark - TableView的代理事件
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    LocationCell *cell = [tableView dequeueReusableCellWithIdentifier:celled];
    cell.currentVC = self;
    cell.dizhiModel = self.diZhiModel;
    cell.userModel = self.userModel;
    cell.indexPath = indexPath;
    
    return cell;
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) return 4;
    else return 1;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 1 && indexPath.row == 0) {
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

#pragma mark - 确定按钮的点击事件

- (void)keepBtnAtcion {
    
    NSString *receiverName = nil;
    NSString *receiverPhone = nil;
    NSString *addrProvince = nil;
    NSString *addrCity = nil;
    NSString *addrCounty = nil;
    NSString *addrDetail = nil;
    NSString *postcode = nil;
    
    
    
    for (int i = 0; i < 4; i++) {
        LocationCell *cell = [self tableViewindexPathForRow:i inSection:0];
        switch (i) {
            case 0:
                receiverName = cell.contentFiled.text;
                break;
            case 1:
                receiverPhone = cell.contentFiled.text;
                break;
            case 2:
                addrProvince = cell.provience;
                addrCity = cell.city;
                addrCounty = cell.town;
                break;
            case 3:
                postcode = cell.contentFiled.text;
                break;
                
            default:
                break;
        }
        
        if (cell.contentFiled.text.length <= 0) {
            [UIAlertController creatRightAlertControllerWithHandle:nil andSuperViewController:self Title:@"信息未填写完全"];
            return ;
        }
    }
    
    LocationCell *cell = [self tableViewindexPathForRow:0 inSection:1];
    addrDetail = cell.detailFiled.text;

    if (cell.detailFiled.text.length <= 0) {
        [UIAlertController creatRightAlertControllerWithHandle:nil andSuperViewController:self Title:@"信息未填写完全"];
        return ;
    }
    
 
    
    NSString *diZhiStr = [NSString stringWithFormat:@"%@-%@" , addrProvince , addrCity];
    
    if (_delegate && [_delegate respondsToSelector:@selector(sendDiZhiDataToProvienceVC:)]) {
        [_delegate sendDiZhiDataToProvienceVC:diZhiStr];
    }
    
    NSDictionary *parames = nil;
    if (self.diZhiModel.idd == 0) {
        parames = @{ @"address.userSn" : @(self.userModel.sn) , @"address.addrProvince" : addrProvince , @"address.addrCity" : addrCity , @"address.addrCounty" : addrCounty , @"address.addrDetail" : addrDetail , @"address.postcode" : postcode , @"address.receiverName" : receiverName , @"address.receiverPhone" : receiverPhone};
        
        
    } else {
        
        parames = @{ @"address.userSn" : @(self.userModel.sn) , @"address.id" : @(self.diZhiModel.idd) , @"address.addrProvince" : addrProvince , @"address.addrCity" : addrCity , @"address.addrCounty" : addrCounty , @"address.addrDetail" : addrDetail , @"address.postcode" : postcode , @"address.receiverName" : receiverName , @"address.receiverPhone" : receiverPhone};
    }
    NSLog(@"%@" , parames);
    [HelpFunction requestDataWithUrlString:kXiuGaiYongHuDiZhi andParames:parames andDelegate:self];
    
}



#pragma mark - 代理返回的数据代理
- (void)requestData:(HelpFunction *)request didSuccess:(NSDictionary *)dddd {
//    NSLog(@"%@" , dddd);
    
    if ([dddd[@"success"] integerValue] == 1) {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (void)requestData:(HelpFunction *)request didFailLoadData:(NSError *)error {
    NSLog(@"%@" , error);
}

- (LocationCell *)tableViewindexPathForRow:(NSInteger)row inSection:(NSInteger)section {
    NSIndexPath *indexpath = [NSIndexPath indexPathForRow:row inSection:section];
    LocationCell *cell = (LocationCell *)[self.tableView cellForRowAtIndexPath:indexpath];
    return cell;
}

#pragma mark - 点击空白处收回键盘
- (void)filedResiginResponde {
    
    for (int i = 0; i < 4; i++) {
        LocationCell *cell = [self tableViewindexPathForRow:i inSection:0];
        [cell.contentFiled resignFirstResponder];
    }
    
    LocationCell *cell = [self tableViewindexPathForRow:0 inSection:1];
    [cell.detailFiled resignFirstResponder];

}

- (void)setUserModel:(UserModel *)userModel {
    _userModel = userModel;
}

- (void)setDiZhiModel:(DiZhiModel *)diZhiModel {
    _diZhiModel = diZhiModel;
}


@end
