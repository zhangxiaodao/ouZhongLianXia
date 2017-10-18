//
//  EnterForthTableViewCell.m
//  AEFT冷风扇
//
//  Created by 杭州阿尔法特 on 16/3/11.
//  Copyright © 2016年 阿尔法特. All rights reserved.
//

#import "EnterForthTableViewCell.h"

@implementation EnterForthTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        //cell选中时的颜色
        self.selectionStyle = UITableViewCellSeparatorStyleNone;

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
        label.textColor  =[UIColor whiteColor];
        label.layer.borderWidth = 0;
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(kScreenW / 2, view.height * 1 / 3));
            make.left.mas_equalTo(imageView.mas_right).offset(kScreenW / 18.75);
             make.centerY.mas_equalTo(view.mas_centerY);
        }];
        self.lable = label;
        
        self.jianTouImage = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"iconfont-qianjin"]];
        [view addSubview:self.jianTouImage];
        self.jianTouImage.image = [self.jianTouImage.image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
        self.jianTouImage.tintColor = [UIColor whiteColor];
        [self.jianTouImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(view.height * 1 / 3, view.height * 1 / 3));
            make.right.mas_equalTo(view.mas_right).offset(-20);
            make.centerY.mas_equalTo(view.mas_centerY);
        }];
        
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
            make.right.mas_equalTo(_jianTouImage.mas_left);
        }];
        self.clearLabel = clearLabel;
        clearLabel.layer.borderWidth = 0;
        
    }
    return self;
}

@end
