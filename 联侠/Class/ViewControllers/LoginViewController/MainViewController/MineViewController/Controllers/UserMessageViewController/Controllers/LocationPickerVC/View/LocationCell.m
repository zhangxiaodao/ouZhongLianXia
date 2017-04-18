//
//  LocationCell.m
//  联侠
//
//  Created by 杭州阿尔法特 on 2017/4/14.
//  Copyright © 2017年 张海昌. All rights reserved.
//

#import "LocationCell.h"
#import "CustomPickerView.h"

@interface LocationCell ()<CustomPickerViewDelegate>
@property (strong, nonatomic) NSMutableArray *provinceArray;
@property (strong, nonatomic) NSMutableArray *cityArray;
@property (strong, nonatomic) NSMutableArray *townArray;
@end
@implementation LocationCell

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
    if (indexPath.section == 0 && indexPath.row == 0) {
        [self setTopCorner];
        self.lable.text = @"收货人";
        
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
        
        if (self.dizhiModel != nil) {
            
            if ([self.dizhiModel.addrCity isEqualToString:self.dizhiModel.addrCounty]) {
                self.contentFiled.text = [NSString stringWithFormat:@"%@-%@" , self.dizhiModel.addrProvince , self.dizhiModel.addrCity];
            } else {
                self.contentFiled.text = [NSString stringWithFormat:@"%@-%@-%@" , self.dizhiModel.addrProvince , self.dizhiModel.addrCity , self.dizhiModel.addrCounty];
            }
            
        }
        
    } else if (indexPath.section == 0 && indexPath.row == 3) {
        [self setBottomCorner];
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
        if (self.dizhiModel != nil) {
            self.detailFiled.text = self.dizhiModel.addrDetail;
        }
        
    }
    
}

- (void)chanceAddressAtcion {
   CustomPickerView *addressPicker = [[CustomPickerView alloc]initWithPickerViewType:4 andBackColor:kMainColor];
    [kWindowRoot.view addSubview:addressPicker];
    addressPicker.delegate = self;
    
}

- (void)sendPickerViewToVC:(UIPickerView *)picker {
    if (self.indexPath.section == 0 && self.indexPath.row == 2) {
        _provience = self.provinceArray[[picker selectedRowInComponent:0]];
        _city = self.cityArray[[picker selectedRowInComponent:1]];
        _town = self.townArray[[picker selectedRowInComponent:2]];
        
        
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


- (void)getAddressData {
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"Address" ofType:@"plist"];
    NSMutableDictionary *pickerDic = [[NSMutableDictionary alloc] initWithContentsOfFile:path];
    self.provinceArray = [[pickerDic allKeys] mutableCopy];
    NSMutableArray *selectedArray = [pickerDic objectForKey:[[pickerDic allKeys] objectAtIndex:0]];
    
    if (selectedArray.count > 0) {
        self.cityArray = [[[selectedArray objectAtIndex:0] allKeys] mutableCopy];
    }
    
    if (self.cityArray.count > 0) {
        self.townArray = [[selectedArray objectAtIndex:0] objectForKey:[self.cityArray objectAtIndex:0]];
    }
    
}

@end
