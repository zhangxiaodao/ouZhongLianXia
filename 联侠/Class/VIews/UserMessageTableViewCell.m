//
//  UserMessageTableViewCell.m
//  AEFT冷风扇
//
//  Created by 杭州阿尔法特 on 16/3/16.
//  Copyright © 2016年 阿尔法特. All rights reserved.
//

#import "UserMessageTableViewCell.h"
#import "GeRenModel.h"

@implementation UserMessageTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        //cell选中时的颜色
        self.selectionStyle = UITableViewCellSeparatorStyleNone;
        
        self.leftLable = [UILabel creatLableWithTitle:@"" andSuperView:self.contentView andFont:k14 andTextAligment:NSTextAlignmentLeft];
        self.leftLable.layer.borderWidth = 0;
        self.leftLable.textColor = [UIColor blackColor];
        [self.leftLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(kScreenW / 15);
            make.size.mas_equalTo(CGSizeMake(kScreenW / 4, kScreenW / 15));
            make.centerY.mas_equalTo(self.contentView.mas_centerY);
        }];
        
        self.rightLable = [UILabel creatLableWithTitle:@"" andSuperView:self.contentView andFont:k14 andTextAligment:NSTextAlignmentRight];
        self.rightLable.layer.borderWidth = 0;
        self.rightLable.textColor = [UIColor blackColor];
        [self.rightLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(self.contentView.mas_right).offset(-kScreenW / 14 - 10);
            make.size.mas_equalTo(CGSizeMake(kScreenW / 2, kScreenW / 15));
            make.centerY.mas_equalTo(self.contentView.mas_centerY);
        }];

        self.rightImage = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"iconfont-qianjin"]];
        [self.contentView addSubview:self.rightImage];
        self.rightImage.image = [self.rightImage.image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
        self.rightImage.tintColor = [UIColor whiteColor];
        [self.rightImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(self.contentView.height * 1 / 3, self.contentView.height * 1 / 3));
            make.left.mas_equalTo(self.rightLable.mas_right).offset(10);
            make.centerY.mas_equalTo(self.contentView.mas_centerY);
        }];
        
        UIView *bottomView = [[UIView alloc]init];
        [self.contentView addSubview:bottomView];
        bottomView.backgroundColor = [UIColor colorWithRed:224/255.0 green:224/255.0 blue:224/255.0 alpha:1.0];
        [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(kScreenW - kScreenW / 10, 1));
            make.left.mas_equalTo(kScreenW / 20);
            make.bottom.mas_equalTo(self.contentView.mas_bottom);
        }];
    }
    return self;
}

- (void)setIndexPath:(NSIndexPath *)indexPath {
    _indexPath = indexPath;
}

- (void)setDizhiModel:(DiZhiModel *)dizhiModel {
    _dizhiModel = dizhiModel;
    
    
    
    if (self.indexPath.section == 1) {
        self.leftLable.text = @"我的地址";

        if (_dizhiModel.addrProvince && _dizhiModel.addrCity && _dizhiModel.addrCounty && _dizhiModel.addrDetail) {
            if ([_dizhiModel.addrProvince isEqualToString:_dizhiModel.addrCity]) {
                self.rightLable.text = [NSString stringWithFormat:@"%@-%@-%@" , _dizhiModel.addrProvince , _dizhiModel.addrCounty , _dizhiModel.addrDetail];
            } else {
                self.rightLable.text = [NSString stringWithFormat:@"%@-%@-%@-%@" , _dizhiModel.addrProvince , _dizhiModel.addrCity , _dizhiModel.addrCounty , _dizhiModel.addrDetail];
            }
        } else {
            self.rightLable.text = @"请输入地址";
            
        }

    }
}

- (void)setUserModel:(UserModel *)userModel {
    
    _userModel = userModel;
    if (self.indexPath.section == 2 && self.indexPath.row == 2) {
        if (![_userModel.email isKindOfClass:[NSNull class]]) {
            self.rightLable.text = _userModel.email;
        } else {
            self.rightLable.text = @"请输入邮箱";
        }
    }  if (self.indexPath.section == 2 && self.indexPath.row == 3) {
        if (![_userModel.birthdate isKindOfClass:[NSNull class]]) {
            self.rightLable.text = _userModel.birthdate;
        } else {
            self.rightLable.text = @"请选择生日";
        }
    }  if (self.indexPath.section == 2 && self.indexPath.row == 0) {
        if (![_userModel.nickname isKindOfClass:[NSNull class]]) {
            self.rightLable.text = _userModel.nickname;
        } else {
            self.rightLable.text = @"昵称";
        }
    }
}

- (void)setGeRenModel:(GeRenModel *)geRenModel {
    _geRenModel = geRenModel;
    
    if (_geRenModel) {
        if (_indexPath.section == 2) {
            if (_indexPath.row == 0) {
                self.rightLable.text = _geRenModel.niCheng;
            } else if (_indexPath.row == 1) {
                NSArray *sexArray = @[@"男" , @"女"];
                self.rightLable.text = sexArray[_geRenModel.sex.integerValue];
            } else if (_indexPath.row == 2) {
                self.rightLable.text = _geRenModel.email;
            } else if (_indexPath.row == 3) {
                self.rightLable.text = _geRenModel.birthday;
            }
        }
    }
    
}

@end
