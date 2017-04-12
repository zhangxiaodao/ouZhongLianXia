//
//  MineTableViewCell.m
//  联侠
//
//  Created by 杭州阿尔法特 on 2017/4/11.
//  Copyright © 2017年 张海昌. All rights reserved.
//

#import "MineTableViewCell.h"

#define kCircleW kScreenW / 50

@interface MineTableViewCell ()

@property (nonatomic , strong) UIView *tiShiView;
@property (nonatomic , strong) UIImageView *imageViw;
@property (nonatomic ,strong) UILabel *lable;
@property (nonatomic , strong) UIView *view;
@end
@implementation MineTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self customUI];
    }
    return self;
}

- (void)customUI {

    
    _view = [[UIView alloc] initWithFrame:CGRectMake(10, 0, kScreenW - kScreenW / 15.625, kScreenH / 14.46)];
    [self.contentView addSubview:_view];
    _view.backgroundColor = [UIColor whiteColor];
    
    UIImageView *imageView = [[UIImageView alloc]initWithImage:nil];
    [_view addSubview:imageView];
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kScreenW / 22, kScreenW / 22));
        make.left.mas_equalTo(_view.mas_left).offset(kScreenW / 29);
        make.centerY.mas_equalTo(_view.mas_centerY);
    }];
    self.imageViw = imageView;
    
    UILabel *label = [UILabel creatLableWithTitle:nil andSuperView:_view andFont:k15 andTextAligment:NSTextAlignmentLeft];
    label.textColor = [UIColor blackColor];
    label.layer.borderWidth = 0;
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kScreenW / 2, _view.height * 1 / 3));
        make.left.mas_equalTo(imageView.mas_right).offset(kScreenW / 29);
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
    
    UIView *promptView = [[UIView alloc]init];
    promptView.backgroundColor = [UIColor redColor];
    [_view addSubview:promptView];
    [promptView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kCircleW, kCircleW));
        make.right.mas_equalTo(jianTouImage.mas_left).offset(- kScreenW / 30);
        make.centerY.mas_equalTo(_view.mas_centerY);
    }];
    promptView.layer.cornerRadius = kCircleW / 2;
    
    _tiShiView = promptView;
    _tiShiView.hidden = YES;
    
    UIView *bottomView = [[UIView alloc]init];
    [_view addSubview:bottomView];
    bottomView.backgroundColor = kCOLOR(244, 244, 244);
    bottomView.tag = 111;
    [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(_view.width - kScreenW * 2 / 29, 1));
        make.left.mas_equalTo(imageView.mas_left);
        make.bottom.mas_equalTo(_view.mas_bottom);
    }];
    bottomView.hidden = YES;
    
    UILabel *clearLabel = [UILabel creatLableWithTitle:@"" andSuperView:_view andFont:k12 andTextAligment:NSTextAlignmentCenter];
    [clearLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kScreenW / 3, _view.height));
        make.centerY.mas_equalTo(_view.mas_centerY);
        make.right.mas_equalTo(jianTouImage.mas_left);
    }];
    self.clearLabel = clearLabel;
    clearLabel.layer.borderWidth = 0;
    
}

- (void)setIsShowPromptImageView:(NSString *)isShowPromptImageView {
    _isShowPromptImageView = isShowPromptImageView;
    
    if ([_isShowPromptImageView isEqualToString:@"YES"]) {
        _tiShiView.hidden = NO;
    } else if ([_isShowPromptImageView isEqualToString:@"NO"]){
        _tiShiView.hidden = YES;
    }
    
}

- (void)setIndexpath:(NSIndexPath *)indexpath {
    _indexpath = indexpath;
    UIView *fenGeView = [self.contentView viewWithTag:111];
    if ((_indexpath.section == 0 && _indexpath.row == 0) || (_indexpath.section == 1 && _indexpath.row == 0)) {
        fenGeView.hidden = NO;
    }
    
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:_view.bounds byRoundingCorners:UIRectCornerTopLeft | UIRectCornerBottomRight cornerRadii:CGSizeMake(5, 5)];
    
    
    if (_indexpath.section == 0) {
        if (_indexpath.row == 0) {
            self.imageViw.image = [UIImage imageNamed:@"icon_own"];
            self.lable.text = @"用户信息";
            maskPath = [UIBezierPath bezierPathWithRoundedRect:_view.bounds byRoundingCorners:UIRectCornerTopLeft | UIRectCornerTopRight cornerRadii:CGSizeMake(5, 5)];
        } else {
            self.imageViw.image = [UIImage imageNamed:@"icon_message"];
            self.lable.text = @"消息通知";
            maskPath = [UIBezierPath bezierPathWithRoundedRect:_view.bounds byRoundingCorners:UIRectCornerBottomLeft | UIRectCornerBottomRight cornerRadii:CGSizeMake(5, 5)];
        }
    } else if (_indexpath.section == 1) {
        if (_indexpath.row == 0) {
            self.imageViw.image = [UIImage imageNamed:@"icon_about_product"];
            self.lable.text = @"关于产品";
            maskPath = [UIBezierPath bezierPathWithRoundedRect:_view.bounds byRoundingCorners:UIRectCornerTopLeft | UIRectCornerTopRight cornerRadii:CGSizeMake(5, 5)];
        } else {
            self.imageViw.image = [UIImage imageNamed:@"icon_personal_center"];
            self.lable.text = @"关于我们";
            maskPath = [UIBezierPath bezierPathWithRoundedRect:_view.bounds byRoundingCorners:UIRectCornerBottomLeft | UIRectCornerBottomRight cornerRadii:CGSizeMake(5, 5)];
        }
    } else {
        self.imageViw.image = [UIImage imageNamed:@"icon_clear"];
        self.clearLabel.text = [NSString stringWithFormat:@"当前缓存 : %@" , [self getBufferSize]];
        self.lable.text = @"清除缓存";
        maskPath = [UIBezierPath bezierPathWithRoundedRect:_view.bounds byRoundingCorners:UIRectCornerTopLeft | UIRectCornerTopRight |UIRectCornerBottomLeft | UIRectCornerBottomRight cornerRadii:CGSizeMake(5, 5)];
    }
    
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = _view.bounds;
    maskLayer.path = maskPath.CGPath;
    _view.layer.mask = maskLayer;
}

//清除缓存按钮的点击事件
- (NSString *)getBufferSize{
    CGFloat size = [SDImageCache sharedImageCache].getSize;
    
    NSString *message = nil;
    
    if (size >= pow(10, 9)) {
        message = [NSString stringWithFormat:@"%.2fGB", size / pow(10, 9)];
    }else if (size >= pow(10, 6) && size < pow(10, 9)) {
        message = [NSString stringWithFormat:@"%.2fMB", size / pow(10, 6)];
    }else if (size >= pow(10, 3) && size < pow(10, 6)) {
        message = [NSString stringWithFormat:@"%.2fKB", size / pow(10, 3)];
    }else {
        message = [NSString stringWithFormat:@"%.0fB", size];
    }
    
    return message;
    
}

@end
