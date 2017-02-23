//
//  AddServiesTableViewCell.m
//  AEFT冷风扇
//
//  Created by 杭州阿尔法特 on 16/3/23.
//  Copyright © 2016年 阿尔法特. All rights reserved.
//

#import "AddServiesTableViewCell.h"

@implementation AddServiesTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSeparatorStyleNone;
       self.lable = [UILabel creatLableWithTitle:@"" andSuperView:self.contentView andFont:14 andTextAligment:NSTextAlignmentCenter];
        [self.lable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(kScreenW / 4, kScreenW / 10));
            make.left.mas_equalTo(kScreenW / 15);
            make.centerY.mas_equalTo(self.contentView.mas_centerY);
        }];
        
//        self.textFiled = [UITextField initWithText:@"WIFI名字" andSuperView:self.contentView andMas_Size:CGSizeMake(kScreenW / 2, kScreenW / 10) andMas_Left:(kScreenW * 2 / 12 + kScreenW / 5) andMas_Right:- kScreenW / 15];
//        self.textFiled.layer.borderWidth = 1;
        self.textFiled = [UITextField creatTextfiledWithPlaceHolder:@"WIFI名字" andSuperView:self.contentView];
        [self.textFiled mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(self.contentView.mas_centerY);
            make.size.mas_equalTo(CGSizeMake(kScreenW / 2, kScreenW / 10));
            make.centerX.mas_equalTo(self.contentView.mas_centerX);
        }];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
