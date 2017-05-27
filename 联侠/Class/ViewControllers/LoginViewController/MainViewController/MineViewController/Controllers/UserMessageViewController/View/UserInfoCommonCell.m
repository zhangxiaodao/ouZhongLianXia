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
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
    }
    return self;
}

- (void)setIndexPath:(NSIndexPath *)indexPath {
    [super setIndexPath:indexPath];
    
    self.fenGeView.hidden = NO;

    if (self.indexPath.section == 0) {
        if (indexPath.row == 0) {
            self.view.size = CGSizeMake(kScreenW - kScreenW / 15.625, kScreenH / 8.3);
            [self.backImage removeFromSuperview];
            self.backImage = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"topleftandright"]];
            [self.view insertSubview:self.backImage atIndex:0];
            [self.backImage mas_makeConstraints:^(MASConstraintMaker *make) {
                make.size.mas_equalTo(CGSizeMake(self.view.width, self.view.height));
                make.centerX.mas_equalTo(self.view.mas_centerX);
                make.top.mas_equalTo(self.view.mas_top);
            }];
            self.rightLabel.hidden = YES;
            self.headPortraitImageView.hidden = NO;
            self.lable.text = @"头像";
            
        } else if (self.indexPath.row == 1) {
            self.lable.text = @"昵称";
            
        } else if (self.indexPath.row == 2){
            self.lable.text = @"性别";
            
        } else if (self.indexPath.row == 3) {
            self.lable.text = @"生日";
            
        } else if (self.indexPath.row == 4) {
            self.lable.text = @"我的地址";
            
        } else if (self.indexPath.row == 5) {
            self.fenGeView.hidden = YES;
            self.backImage.image = [UIImage imageNamed:@"bottomleftandright"];
            self.lable.text = @"我的邮箱";
            
        }
    }
    else if (self.indexPath.section == 1) {
        if (self.indexPath.row == 0) {
            self.backImage.image = [UIImage imageNamed:@"topleftandright"];
            self.lable.text = @"修改密码";
        }
        else if (self.indexPath.row == 1) {
            self.backImage.image = [UIImage imageNamed:@"bottomleftandright"];
            self.lable.text = @"我的ID";
            self.fenGeView.hidden = YES;
            self.jianTouImage.hidden = YES;
            self.idLabel.hidden = NO;
        }
    }
    else if (self.indexPath.section == 2) {
        if (self.indexPath.row == 0) {
            self.view.backgroundColor = [UIColor whiteColor];
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
