//
//  UserInfoCommonCell.m
//  联侠
//
//  Created by 杭州阿尔法特 on 2017/4/13.
//  Copyright © 2017年 张海昌. All rights reserved.
//

#import "UserInfoCommonCell.h"
#import "BDImagePicker.h"

@interface UserInfoCommonCell ()<HelpFunctionDelegate>

@end

@implementation UserInfoCommonCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    return self;
}

- (void)setIndexPath:(NSIndexPath *)indexPath {
    [super setIndexPath:indexPath];
    
    self.fenGeView.hidden = NO;

    if (self.indexPath.section == 0) {
        if (self.indexPath.row == 0) {
            self.view.frame = CGRectMake(10, 0, kScreenW - kScreenW / 15.625, kScreenH / 8.3);
            [self setTopCorner];
            self.rightLabel.hidden = YES;
            self.headPortraitImageView.hidden = NO;
            self.lable.text = @"头像";
            
            if (self.headImage) {
                self.headPortraitImageView.image = self.headImage;
            } else {
                if (![self.userModel.headImageUrl isKindOfClass:[NSNull class]]) {
                    [self.headPortraitImageView sd_setImageWithURL:[NSURL URLWithString:self.userModel.headImageUrl] placeholderImage:[UIImage imageNamed:@"iconfont-touxiang"]];
                } else {
                    self.headPortraitImageView.image = [UIImage imageNamed:@"iconfont-touxiang"];
                }
            }
            
        } else if (self.indexPath.row == 1) {
            self.lable.text = @"昵称";
            if (self.userModel.nickname == nil || [self.userModel.nickname isKindOfClass:[NSNull class]]) {
                self.rightLabel.text = @"昵称";
            } else {
                self.rightLabel.text = self.userModel.nickname;
            }
        } else if (self.indexPath.row == 2) {
            self.lable.text = @"性别";
            self.rightLabel.text = @"男";
            if (self.userModel.sex == 2) self.rightLabel.text = @"女";
        } else if (self.indexPath.row == 3) {
            self.lable.text = @"生日";
            if (![self.userModel.birthdate isKindOfClass:[NSNull class]]) {
                self.rightLabel.text = self.userModel.birthdate;
            } else {
                self.rightLabel.text = @"请选择生日";
            }
        } else if (self.indexPath.row == 4) {
            self.lable.text = @"我的地址";
            
            if (self.dizhiModel != nil) {
                self.rightLabel.text = [NSString stringWithFormat:@"%@-%@" , self.dizhiModel.addrProvince , self.dizhiModel.addrCity];
            } else {
                self.rightLabel.text = @"请输入地址";
            }
        } else if (self.indexPath.row == 5) {
            
            self.fenGeView.hidden = YES;
            [self setBottomCorner];
            self.lable.text = @"我的邮箱";
            if (![self.userModel.email isKindOfClass:[NSNull class]]) {
                self.rightLabel.text = self.userModel.email;
            } else {
                self.rightLabel.text = @"请输入邮箱";
            }
        }
    }
    else if (self.indexPath.section == 1) {
        if (self.indexPath.row == 0) {
            [self setTopCorner];
            self.lable.text = @"修改密码";
        }
        else if (self.indexPath.row == 1) {
            [self setBottomCorner];
            self.lable.text = @"我的ID";
            
            self.fenGeView.hidden = YES;
            self.jianTouImage.hidden = YES;
            self.idLabel.hidden = NO;
            self.idLabel.text = [NSString stringWithFormat:@"%ld" , self.userModel.sn];
        }
    }
    else if (self.indexPath.section == 2) {
        if (self.indexPath.row == 0) {
            self.view.layer.cornerRadius = 5;
            self.fenGeView.hidden = YES;
            self.lable.hidden = YES;
            self.jianTouImage.hidden = YES;
            self.rightLabel.hidden = YES;
            self.loginOutLabel.hidden = NO;
            self.loginOutLabel.text = @"退出登录";
            self.loginOutLabel.textColor = [UIColor redColor];
            
        }
    }
    
}

- (void)setUserModel:(UserModel *)userModel {
    [super setUserModel:userModel];
}

- (void)setDizhiModel:(DiZhiModel *)dizhiModel {
    [super setDizhiModel:dizhiModel];

}

- (void)changHeadPortraitAtcion {
    [BDImagePicker showImagePickerFromViewController:self.currentVC allowsEditing:YES finishAtcion:^(UIImage *image) {
        if (image) {
            self.headPortraitImageView.image = image;
            NSData *data = [NSData data];
            if (UIImagePNGRepresentation(image) == nil) {
                data = UIImageJPEGRepresentation(image, 1);
            } else {
                data = UIImagePNGRepresentation(image);
            }
            
            NSDictionary *parems = @{@"userSn" : @(self.userModel.sn) , @"files" : data};
            
            [HelpFunction requestDataWithUrlString:kShangChuanTouXiang andParames:parems andImage:self.headPortraitImageView.image andDelegate:self];
        }
    }];

}

- (void)requestData:(HelpFunction *)request didSuccess:(NSDictionary *)dddd {
    NSLog(@"%@" , dddd);
    
    if (self.headPortraitImageView.image) {
        [[NSNotificationCenter defaultCenter] postNotification:[NSNotification notificationWithName:@"headImage" object:self userInfo:[NSDictionary dictionaryWithObject:self.headPortraitImageView.image forKey:@"headImage"]]];
    }
    
}

- (void)requestData:(HelpFunction *)request didFailLoadData:(NSError *)error {
    NSLog(@"%@" , error);
}

@end
