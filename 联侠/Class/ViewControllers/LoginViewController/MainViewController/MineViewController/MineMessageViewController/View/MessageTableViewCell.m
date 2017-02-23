//
//  MessageTableViewCell.m
//  联侠
//
//  Created by 杭州阿尔法特 on 2017/2/5.
//  Copyright © 2017年 张海昌. All rights reserved.
//

#import "MessageTableViewCell.h"

#define kCircleW kScreenW / 50
@interface MessageTableViewCell ()
@property (nonatomic , strong) UIView *tiShiView;
@end

@implementation MessageTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self customUI];
    }
    return self;
}

- (void)customUI {
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenW, kScreenH / 14.2)];
    [self.contentView addSubview:view];
    
    UIImageView *imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:[NSString stringWithFormat:@"iconfont-dingshi"]]];
    [view addSubview:imageView];
    imageView.image = [imageView.image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    imageView.tintColor = [UIColor whiteColor];
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(view.height * 1 / 3, view.height * 1 / 3));
        make.left.mas_equalTo(kScreenW / 18.75);
        make.centerY.mas_equalTo(view.mas_centerY);
    }];
    self.imageViw = imageView;
    
    UILabel *label = [UILabel creatLableWithTitle:@"定时预约" andSuperView:view andFont:k14 andTextAligment:NSTextAlignmentLeft];
    label.textColor  =[UIColor blackColor];
    label.layer.borderWidth = 0;
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kScreenW / 2, view.height * 1 / 3));
        make.left.mas_equalTo(imageView.mas_right).offset(kScreenW / 18.75);
        make.centerY.mas_equalTo(view.mas_centerY);
    }];
    self.lable = label;
    
    UIImageView *jianTouImage = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"iconfont-qianjin"]];
    [view addSubview:jianTouImage];
    jianTouImage.image = [jianTouImage.image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    jianTouImage.tintColor = [UIColor blackColor];
    [jianTouImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(view.height * 1 / 3, view.height * 1 / 3));
        make.right.mas_equalTo(view.mas_right).offset(-20);
        make.centerY.mas_equalTo(view.mas_centerY);
    }];
    
    UIView *promptView = [[UIView alloc]init];
    promptView.backgroundColor = [UIColor redColor];
    [view addSubview:promptView];
    [promptView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kCircleW, kCircleW));
        make.right.mas_equalTo(jianTouImage.mas_left).offset(- kScreenW / 30);
        make.centerY.mas_equalTo(view.mas_centerY);
    }];
    promptView.layer.cornerRadius = kCircleW / 2;
    
    _tiShiView = promptView;
    _tiShiView.hidden = YES;
    
    UIView *bottomView = [[UIView alloc]init];
    [view addSubview:bottomView];
    bottomView.backgroundColor = kCOLOR(244, 244, 244);
    bottomView.tag = 111;
    [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kScreenW, 1));
        make.left.mas_equalTo(0);
        make.bottom.mas_equalTo(view.mas_bottom);
    }];
    UILabel *clearLabel = [UILabel creatLableWithTitle:@"" andSuperView:view andFont:k14 andTextAligment:NSTextAlignmentCenter];
    [clearLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kScreenW / 3, view.height));
        make.centerY.mas_equalTo(view.mas_centerY);
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

@end
