//
//  HeadPortraitView.m
//  联侠
//
//  Created by 杭州阿尔法特 on 2017/4/11.
//  Copyright © 2017年 张海昌. All rights reserved.
//

#import "HeadPortraitView.h"
#import <Accelerate/Accelerate.h>

@interface HeadPortraitView ()
@property (nonatomic , strong) UIImageView *headBackImageView;
@property (nonatomic , strong) UIImageView *headImageView;
@property (nonatomic , strong) UILabel *nameLable;
//@property (nonatomic , strong) UILabel *sexLable;
@end

@implementation HeadPortraitView

- (instancetype)initWithFrame:(CGRect)frame Target:(nullable id)target action:(nullable SEL)action {
    self = [super initWithFrame:frame];
    if (self) {
        [self creatWithTarget:target action:action];
    }
    return self;
}

- (void)creatWithTarget:(nullable id)target action:(nullable SEL)action {
 
    self.backgroundColor = [UIColor colorWithHexString:@"f2f4fb"];
    
    _headBackImageView = [[UIImageView alloc]init];
    [self addSubview:_headBackImageView];
    [_headBackImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(self.width - 5, self.height - 5));
        make.centerY.mas_equalTo(self.mas_centerY);
        make.centerX.mas_equalTo(self.mas_centerX);
    }];
//    _headBackImageView.contentMode = UIViewContentModeScaleAspectFit;
    _headBackImageView.alpha = .25;
    

//    _headBackImageView.hidden = YES;
    
    
    UIImageView *markImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"markImage"]];
    [self addSubview:markImageView];
    [markImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(self.width, self.height));
        make.centerY.mas_equalTo(self.mas_centerY);
        make.centerX.mas_equalTo(self.mas_centerX);
    }];
    markImageView.contentMode = UIViewContentModeScaleAspectFit;

    _headImageView = [[UIImageView alloc]init];
    [self addSubview:_headImageView];
    [_headImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kScreenW / 3.75, kScreenW / 3.75));
        make.top.mas_equalTo(self.mas_top).offset(kScreenW / 13);
        make.centerX.mas_equalTo(self.mas_centerX);
    }];
//    _headImageView.contentMode = UIViewContentModeScaleAspectFit;
    _headImageView.layer.cornerRadius = kScreenW / 3.75 / 2;
    _headImageView.layer.masksToBounds = YES;
    _headImageView.userInteractionEnabled = YES;
    
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:target action:action];
    [_headImageView addGestureRecognizer:tap];
    
    _nameLable = [UILabel creatLableWithTitle:@"" andSuperView:self andFont:k15 andTextAligment:NSTextAlignmentCenter];
    _nameLable.layer.borderWidth = 0;
    [_nameLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kScreenW / 2, kScreenW / 14));
        make.centerX.mas_equalTo(_headImageView.mas_centerX);
        make.top.mas_equalTo(_headImageView.mas_bottom);
    }];

    
//    _sexLable = [UILabel creatLableWithTitle:@"" andSuperView:self andFont:k14 andTextAligment:NSTextAlignmentCenter];
//    _sexLable.textColor = [UIColor colorWithHexString:@"ff40b5"];
//    _sexLable.layer.borderWidth = 0;
//    [_sexLable mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.size.mas_equalTo(CGSizeMake(kScreenW / 20, kScreenW / 14));
//        make.left.mas_equalTo(_nameLable.mas_right);
//        make.centerY.mas_equalTo(_nameLable.mas_centerY);
//    }];
    
}


- (void)setUserModel:(UserModel *)userModel {
    _userModel = userModel;
    
        if ([_userModel.headImageUrl isKindOfClass:[NSNull class]]) {
            _headImageView.image = [UIImage imageNamed:@"iconfont-touxiang"];
            _headBackImageView.image = _headBackImageView.image = [UIImage boxblurImage:[UIImage imageNamed:@"iconfont-touxiang"] withBlurNumber:.3];
        } else {
            [_headImageView sd_setImageWithURL:[NSURL URLWithString:_userModel.headImageUrl] placeholderImage:[UIImage imageNamed:@"iconfont-touxiang"]];
            __weak typeof(self) weakSelf = self;
            [_headBackImageView sd_setImageWithURL:[NSURL URLWithString:_userModel.headImageUrl] placeholderImage:nil completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                _headBackImageView.image = [UIImage boxblurImage:image withBlurNumber:.3];
            }];
            

            
        }
        
        if (![_userModel.nickname isKindOfClass:[NSNull class]]) {
            _nameLable.text = _userModel.nickname;
        } else {
            _nameLable.text = @"用户名";
        }
        
        
//        if (_userModel.sex == 0) {
//            _sexLable.text = @"♂";
//        } else {
//            _sexLable.text = @"♀";
//        }
    
}

@end
