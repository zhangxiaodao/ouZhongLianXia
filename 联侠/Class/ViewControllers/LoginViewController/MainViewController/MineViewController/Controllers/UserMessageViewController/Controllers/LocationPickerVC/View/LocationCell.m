//
//  LocationCell.m
//  联侠
//
//  Created by 杭州阿尔法特 on 2017/4/14.
//  Copyright © 2017年 张海昌. All rights reserved.
//

#import "LocationCell.h"
#import "CustomPickerView.h"

@interface LocationCell ()<CustomPickerViewDelegate , UITextFieldDelegate>
@property (strong, nonatomic) NSMutableArray *provinceArray;
@property (strong, nonatomic) NSMutableArray *cityArray;
@property (strong, nonatomic) NSMutableArray *townArray;

@property (nonatomic , strong) NSMutableDictionary *pickerDic;
@end
@implementation LocationCell

- (void)getAddressData {
    
    self.provinceArray = [[self.pickerDic allKeys] mutableCopy];
    NSMutableArray *selectedArray = [self.pickerDic objectForKey:[self.provinceArray objectAtIndex:0]];
    
    if (selectedArray.count > 0) {
        self.cityArray = [[[selectedArray objectAtIndex:0] allKeys] mutableCopy];
    }
    
    if (self.cityArray.count > 0) {
        self.townArray = [[selectedArray objectAtIndex:0] objectForKey:[self.cityArray objectAtIndex:0]];
    }
    
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    [self getAddressData];
    return self;
}

- (void)setIndexPath:(NSIndexPath *)indexPath {
    [super setIndexPath:indexPath];
    
    self.rightLabel.hidden = YES;
    self.loginOutLabel.hidden = YES;
    self.chanceBtn.hidden = YES;
    self.headPortraitImageView.hidden = YES;
    self.jianTouImage.hidden = YES;
    self.fenGeView.hidden = NO;
    self.contentFiled.hidden = NO;
    self.contentFiled.delegate = self;
    if (indexPath.section == 0 && indexPath.row == 0) {

        self.backImage.image = [UIImage imageNamed:@"topleftandright"];
        self.lable.text = @"收货人";
        self.contentFiled.keyboardType = UIKeyboardTypeDefault;
        if (self.dizhiModel != nil) {
            self.contentFiled.text = self.dizhiModel.receiverName;
        }
        
    } else if (indexPath.section == 0 && indexPath.row == 1) {
        self.lable.text = @"联系电话";
        if (self.dizhiModel != nil) {
            self.contentFiled.text = self.dizhiModel.receiverPhone;
        }
    } else if (indexPath.section == 0 && indexPath.row == 2) {
        self.lable.text = @"所在地区";
        self.chanceBtn.hidden = NO;
        self.jianTouImage.hidden = NO;
        [self.contentFiled removeFromSuperview];
        [self.view addSubview:self.contentFiled];
        [self.contentFiled mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(self.view.width * 3 / 6, self.view.height));
            make.centerY.mas_equalTo(self.view.mas_centerY);
            make.left.mas_equalTo(self.lable.mas_right);
        }];
        [self.contentFiled resignFirstResponder];
        self.contentFiled.userInteractionEnabled = NO;
        if (self.dizhiModel != nil) {
            
            if ([self.dizhiModel.addrCity isEqualToString:self.dizhiModel.addrCounty]) {
                self.contentFiled.text = [NSString stringWithFormat:@"%@-%@" , self.dizhiModel.addrProvince , self.dizhiModel.addrCity];
            } else {
                self.contentFiled.text = [NSString stringWithFormat:@"%@-%@-%@" , self.dizhiModel.addrProvince , self.dizhiModel.addrCity , self.dizhiModel.addrCounty];
            }
            
        }
        
    } else if (indexPath.section == 0 && indexPath.row == 3) {

        self.backImage.image = [UIImage imageNamed:@"bottomleftandright"];
        self.fenGeView.hidden = YES;
        self.lable.text = @"邮政编码";
        if (self.dizhiModel != nil) {
            self.contentFiled.text = [NSString stringWithFormat:@"%@" , self.dizhiModel.postcode];
        }
    } else {
        self.lable.hidden = YES;
        self.contentFiled.hidden = YES;
        self.detailFiled.hidden = NO;
        self.view.size = CGSizeMake(kScreenW - kScreenW / 15.625, kScreenH / 8.3);
        self.view.layer.cornerRadius = 5;
        self.view.layer.masksToBounds = YES;
        self.view.backgroundColor = [UIColor whiteColor];
        self.detailFiled.keyboardType = UIKeyboardTypeDefault;
        if (self.dizhiModel != nil) {
            self.detailFiled.text = self.dizhiModel.addrDetail;
        }
        
    }
    
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    if (self.indexPath.section == 0 && self.indexPath.row == 1) {
        if (textField.text.length != 11 && textField.text.length != 0) {
            [UIAlertController creatRightAlertControllerWithHandle:^{
                textField.text = nil;
            } andSuperViewController:self.currentVC Title:@"手机号码格式不正确"];
        }
    } else if (self.indexPath.section == 0 && self.indexPath.row == 3) {
        if (textField.text.length != 6 && textField.text.length != 0) {
            [UIAlertController creatRightAlertControllerWithHandle:^{
                textField.text = nil;
            } andSuperViewController:self.currentVC Title:@"邮编格式不正确"];
        }
        
    }
}

- (void)chanceAddressAtcion {
    
    
    
    CustomPickerView *addressPicker = [[CustomPickerView alloc]initWithPickerViewType:4 andBackColor:kMainColor];
    [self.currentVC.view addSubview:addressPicker];
    addressPicker.delegate = self;
    
}

- (void)sendPickerViewToVC:(UIPickerView *)picker {
    if (self.indexPath.section == 0 && self.indexPath.row == 2) {
        
        NSInteger colProvince = [picker selectedRowInComponent:0];
        NSInteger colCity = [picker selectedRowInComponent:1];
        NSInteger colTown = [picker selectedRowInComponent:2];
        
        NSString *province = self.provinceArray[colProvince];
        
        NSDictionary *selectedDict = [self.pickerDic objectForKey:province][0];
        
        if (selectedDict.count > 0) {
            self.cityArray = [[selectedDict allKeys] mutableCopy];
        }
        
        NSString *city = @"";
        
        if (self.cityArray.count > colCity) {
            city = self.cityArray[colCity];
            self.townArray = selectedDict[city];
        }
        
        NSString *town = self.townArray[colTown];
        
        _provience = province;
        _city = city;
        _town = town;
        
        
        if ([_city isEqualToString:_town]) {
            self.contentFiled.text = [NSString stringWithFormat:@"%@-%@" , _provience , _city];
        } else {
            self.contentFiled.text = [NSString stringWithFormat:@"%@-%@-%@" , _provience , _city , _town];
        }
    }
}


- (void)setUserModel:(UserModel *)userModel {
    [super setUserModel:userModel];
}

- (void)setDizhiModel:(DiZhiModel *)dizhiModel {
    [super setDizhiModel:dizhiModel];
    
    _provience = self.dizhiModel.addrProvince;
    _city = self.dizhiModel.addrCity;
    _town = self.dizhiModel.addrCounty;
    
}

- (NSMutableDictionary *)pickerDic {
    if (!_pickerDic) {
        NSString *path = [[NSBundle mainBundle] pathForResource:@"Address" ofType:@"plist"];
        _pickerDic = [[NSMutableDictionary alloc] initWithContentsOfFile:path];
        
    }
    return _pickerDic;
}
@end
