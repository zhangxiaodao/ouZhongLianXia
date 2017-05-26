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
@property (nonatomic , strong) UILabel *lable;
@property (nonatomic , strong) UILabel *loginOutLabel;
@property (nonatomic , strong) UIImageView *jianTouImage;

@property (nonatomic , strong) UIView *view;
@property (nonatomic , strong) UIView *fenGeView;
@property (nonatomic , strong) UIImageView *backImage;
@end

@implementation UserInfoCommonCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self customUI];
    }
    return self;
}

- (void)customUI {
    
    self.backgroundColor = [UIColor colorWithHexString:@"f2f4fb"];
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(10, 0, kScreenW - kScreenW / 15.625, kScreenH / 14.46)];
    [self.contentView addSubview:view];
    view.backgroundColor = [UIColor clearColor];
    self.view = view;
    
    UIImageView *backImage = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"normalback"]];
    [view addSubview:backImage];
    [backImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(view.width, view.height));
        make.centerX.mas_equalTo(view.mas_centerX);
        make.centerY.mas_equalTo(view.mas_centerY);
    }];
    backImage.contentMode = UIViewContentModeScaleToFill;
    self.backImage = backImage;
    
    UILabel *label = [UILabel creatLableWithTitle:nil andSuperView:view andFont:k15 andTextAligment:NSTextAlignmentLeft];
    label.textColor = [UIColor blackColor];
    label.layer.borderWidth = 0;
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(view.width / 5, view.height));
        make.left.mas_equalTo(view.mas_left).offset(kScreenW / 29);
        make.centerY.mas_equalTo(view.mas_centerY);
    }];
    self.lable = label;
    
    UIImageView *jianTouImage = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"tab_return"]];
    [view addSubview:jianTouImage];
    [jianTouImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kScreenW / 50, kScreenW / 30));
        make.right.mas_equalTo(view.mas_right).offset(-kScreenW / 29);
        make.centerY.mas_equalTo(view.mas_centerY);
    }];
    jianTouImage.transform = CGAffineTransformRotate(jianTouImage.transform, M_PI);
    jianTouImage.contentMode = UIViewContentModeScaleAspectFit;
    self.jianTouImage = jianTouImage;
    [UIImageView setImageViewColor:jianTouImage andColor:[UIColor colorWithHexString:@"81d0ff"]];
    
    UIView *bottomView = [[UIView alloc]init];
    [view addSubview:bottomView];
    bottomView.backgroundColor = kCOLOR(244, 244, 244);
    [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(view.width - kScreenW * 2 / 29, 1));
        make.left.mas_equalTo(label.mas_left);
        make.bottom.mas_equalTo(view.mas_bottom);
    }];
    bottomView.hidden = YES;
    self.fenGeView = bottomView;
    
    UILabel *rightLabel = [UILabel creatLableWithTitle:@"" andSuperView:view andFont:k12 andTextAligment:NSTextAlignmentRight];
    [rightLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kScreenW / 3, view.height));
        make.centerY.mas_equalTo(view.mas_centerY);
        make.right.mas_equalTo(jianTouImage.mas_left).offset(-kScreenW / 29);
    }];
    self.rightLabel = rightLabel;
    rightLabel.layer.borderWidth = 0;
    rightLabel.textColor = [UIColor colorWithHexString:@"858585"];
    
    UILabel *idLabel = [UILabel creatLableWithTitle:@"" andSuperView:view andFont:k12 andTextAligment:NSTextAlignmentRight];
    [idLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kScreenW / 3, view.height));
        make.centerY.mas_equalTo(view.mas_centerY);
        make.right.mas_equalTo(view.mas_right).offset(-kScreenW / 29);
    }];
    self.idLabel = idLabel;
    self.idLabel.hidden = YES;
    idLabel.layer.borderWidth = 0;
    idLabel.textColor = [UIColor colorWithHexString:@"858585"];
    
    
    UIImageView *headPortraitImageView = [[UIImageView alloc]init];
    [view addSubview:headPortraitImageView];
    [headPortraitImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kScreenW / 6, kScreenW / 6));
        make.centerY.mas_equalTo(view.mas_centerY);
        make.right.mas_equalTo(jianTouImage.mas_left).offset(-kScreenW / 29);
    }];
    _headPortraitImageView = headPortraitImageView;
    headPortraitImageView.hidden = YES;
    headPortraitImageView.layer.cornerRadius = kScreenW / 12;
    headPortraitImageView.layer.masksToBounds = YES;
    headPortraitImageView.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(changHeadPortraitAtcion)];
    [headPortraitImageView addGestureRecognizer:tap];
    
    UILabel *loginOutLabel = [UILabel creatLableWithTitle:@"" andSuperView:view andFont:k15 andTextAligment:NSTextAlignmentCenter];
    [loginOutLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(view.width - kScreenW * 2 / 29, view.height));
        make.centerY.mas_equalTo(view.mas_centerY);
        make.centerX.mas_equalTo(view.mas_centerX);
    }];
    loginOutLabel.hidden = YES;
    self.loginOutLabel = loginOutLabel;
    loginOutLabel.layer.borderWidth = 0;
    
    _selectedImage = [[UIImageView alloc]initWithFrame:view.bounds];
    [view addSubview:_selectedImage];
    _selectedImage.image = [UIImage imageWithColor:kMainColor];
    _selectedImage.alpha = .3;
    _selectedImage.hidden = YES;
}

- (void)setIndexPath:(NSIndexPath *)indexPath {
    _indexPath = indexPath;
    
    self.fenGeView.hidden = NO;

    if (_indexPath.section == 0) {
        if (_indexPath.row == 0) {
            self.view.size = CGSizeMake(kScreenW - kScreenW / 15.625, kScreenH / 8.3);
            [self.backImage mas_makeConstraints:^(MASConstraintMaker *make) {
                make.size.mas_equalTo(CGSizeMake(self.view.width, self.view.height));
                make.centerX.mas_equalTo(self.view.mas_centerX);
                make.top.mas_equalTo(self.view.mas_top);
            }];
            self.backImage.image = [UIImage imageNamed:@"topleftandright"];
            self.rightLabel.hidden = YES;
            self.headPortraitImageView.hidden = NO;
            self.lable.text = @"头像";
            
        } else if (_indexPath.row == 1) {
            self.lable.text = @"昵称";
            
        } else if (_indexPath.row == 2) {
            self.lable.text = @"性别";
            
        } else if (_indexPath.row == 3) {
            self.lable.text = @"生日";
            
        } else if (_indexPath.row == 4) {
            self.lable.text = @"我的地址";
            
        } else if (_indexPath.row == 5) {
            self.fenGeView.hidden = YES;
            self.backImage.image = [UIImage imageNamed:@"bottomleftandright"];
            self.lable.text = @"我的邮箱";
            
        }
    }
    else if (_indexPath.section == 1) {
        if (_indexPath.row == 0) {
            self.backImage.image = [UIImage imageNamed:@"topleftandright"];
            self.lable.text = @"修改密码";
        }
        else if (_indexPath.row == 1) {
            self.backImage.image = [UIImage imageNamed:@"bottomleftandright"];
            self.lable.text = @"我的ID";
            self.fenGeView.hidden = YES;
            self.jianTouImage.hidden = YES;
            self.idLabel.hidden = NO;
        }
    }
    else if (_indexPath.section == 2) {
        if (_indexPath.row == 0) {
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
    _userModel = userModel;
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
