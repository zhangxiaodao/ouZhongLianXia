//
//  UserInfoCell.m
//  联侠
//
//  Created by 杭州阿尔法特 on 2017/4/13.
//  Copyright © 2017年 张海昌. All rights reserved.
//

#import "UserInfoCell.h"

@interface UserInfoCell ()

@end

@implementation UserInfoCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self customUI];
    }
    return self;
}

- (void)customUI {
    
    self.backgroundColor = [UIColor colorWithHexString:@"f2f4fb"];
    _view = [[UIView alloc] initWithFrame:CGRectMake(10, 0, kScreenW - kScreenW / 15.625, kScreenH / 14.46)];
    [self.contentView addSubview:_view];
    _view.backgroundColor = [UIColor whiteColor];
    
    
    UILabel *label = [UILabel creatLableWithTitle:nil andSuperView:_view andFont:k15 andTextAligment:NSTextAlignmentLeft];
    label.textColor = [UIColor blackColor];
    label.layer.borderWidth = 0;
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kScreenW / 3, _view.height * 1 / 3));
        make.left.mas_equalTo(_view.mas_left).offset(kScreenW / 29);
        make.centerY.mas_equalTo(_view.mas_centerY);
    }];
    self.lable = label;
    
    UIImageView *jianTouImage = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"tab_return"]];
    [_view addSubview:jianTouImage];
    [jianTouImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kScreenW / 50, kScreenW / 30));
        make.right.mas_equalTo(_view.mas_right).offset(-kScreenW / 29);
        make.centerY.mas_equalTo(_view.mas_centerY);
    }];
    jianTouImage.transform = CGAffineTransformRotate(jianTouImage.transform, M_PI);
    jianTouImage.contentMode = UIViewContentModeScaleAspectFit;
    self.jianTouImage = jianTouImage;
    
    UIView *bottomView = [[UIView alloc]init];
    [_view addSubview:bottomView];
    bottomView.backgroundColor = kCOLOR(244, 244, 244);
    [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(_view.width - kScreenW * 2 / 29, 1));
        make.left.mas_equalTo(label.mas_left);
        make.bottom.mas_equalTo(_view.mas_bottom);
    }];
    bottomView.hidden = YES;
    self.fenGeView = bottomView;
    
    UILabel *clearLabel = [UILabel creatLableWithTitle:@"" andSuperView:_view andFont:k12 andTextAligment:NSTextAlignmentRight];
    [clearLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kScreenW / 3, _view.height));
        make.centerY.mas_equalTo(_view.mas_centerY);
        make.right.mas_equalTo(jianTouImage.mas_left).offset(-kScreenW / 29);
    }];
    self.rightLabel = clearLabel;
    clearLabel.layer.borderWidth = 0;
    
    UIImageView *headPortraitImageView = [[UIImageView alloc]init];
    [_view addSubview:headPortraitImageView];
    [headPortraitImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kScreenW / 6, kScreenW / 6));
        make.centerY.mas_equalTo(_view.mas_centerY);
        make.right.mas_equalTo(jianTouImage.mas_left).offset(-kScreenW / 29);
    }];
    _headPortraitImageView = headPortraitImageView;
    headPortraitImageView.hidden = YES;
    headPortraitImageView.layer.cornerRadius = kScreenW / 12;
    headPortraitImageView.layer.masksToBounds = YES;
    headPortraitImageView.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(changHeadPortraitAtcion)];
    [headPortraitImageView addGestureRecognizer:tap];
    
    UILabel *loginOutLabel = [UILabel creatLableWithTitle:@"" andSuperView:_view andFont:k15 andTextAligment:NSTextAlignmentCenter];
    [loginOutLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(_view.width - kScreenW * 2 / 29, _view.height));
        make.centerY.mas_equalTo(_view.mas_centerY);
        make.centerX.mas_equalTo(_view.mas_centerX);
    }];
    loginOutLabel.hidden = YES;
    self.loginOutLabel = loginOutLabel;
    loginOutLabel.layer.borderWidth = 0;
}

- (void)setIndexpath:(NSIndexPath *)indexpath {
    _indexPath = indexpath;
}

- (void)setUserModel:(UserModel *)userModel {
    _userModel = userModel;
}

- (void)setDizhiModel:(DiZhiModel *)dizhiModel {
    _dizhiModel = dizhiModel;
}


- (void)setTopCorner {
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.view.bounds byRoundingCorners:UIRectCornerTopLeft | UIRectCornerTopRight cornerRadii:CGSizeMake(5, 5)];
    
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = self.view.bounds;
    maskLayer.path = maskPath.CGPath;
    self.view.layer.mask = maskLayer;
}

- (void)setBottomCorner {
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.view.bounds byRoundingCorners:UIRectCornerBottomLeft | UIRectCornerBottomRight cornerRadii:CGSizeMake(5, 5)];
    
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = self.view.bounds;
    maskLayer.path = maskPath.CGPath;
    self.view.layer.mask = maskLayer;
}

@end
