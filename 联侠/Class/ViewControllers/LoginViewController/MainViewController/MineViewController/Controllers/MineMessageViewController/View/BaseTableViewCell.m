//
//  BaseTableViewCell.m
//  联侠
//
//  Created by 杭州阿尔法特 on 2017/2/5.
//  Copyright © 2017年 张海昌. All rights reserved.
//

#import "BaseTableViewCell.h"

#define kCircleW kScreenW / 50
@interface BaseTableViewCell ()

@end

@implementation BaseTableViewCell

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
    [UIImageView setImageViewColor:jianTouImage andColor:[UIColor colorWithHexString:@"81d0ff"]];
    
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
    
    UIView *fenGeView = [[UIView alloc]init];
    [_view addSubview:fenGeView];
    fenGeView.backgroundColor = kCOLOR(244, 244, 244);
    [fenGeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(_view.width - kScreenW * 2 / 29, 1));
        make.left.mas_equalTo(imageView.mas_left);
        make.bottom.mas_equalTo(_view.mas_bottom);
    }];
    fenGeView.hidden = YES;
    self.fenGeView = fenGeView;
    
    _selectedImage = [[UIImageView alloc]initWithFrame:_view.bounds];
    [_view addSubview:_selectedImage];
    _selectedImage.image = [UIImage imageWithColor:kMainColor];
    _selectedImage.alpha = .3;
    _selectedImage.hidden = YES;
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
