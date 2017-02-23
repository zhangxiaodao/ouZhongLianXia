//
//  AddSTableViewCell.m
//  AEFT冷风扇
//
//  Created by 杭州阿尔法特 on 16/3/25.
//  Copyright © 2016年 阿尔法特. All rights reserved.
//

#import "AddSTableViewCell.h"

@implementation AddSTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenW, (kScreenH - kScreenH / 16.70588 - kScreenH / 28.4 ) / 3)];
        [self.contentView addSubview:view];
        
        self.lable = [UILabel creatLableWithTitle:@"" andSuperView:view andFont:k20 andTextAligment:NSTextAlignmentCenter];
        self.lable.layer.borderWidth = 0;
        CGFloat R  = (CGFloat) 173/255.0;
        CGFloat G = (CGFloat) 226/255.0;
        CGFloat B = (CGFloat) 254/255.0;
        CGFloat alpha = (CGFloat) 1.0;
        
        self.lable.textColor = [ UIColor colorWithRed: R  green: G  blue: B  alpha: alpha];
        [self.lable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(kScreenW / 2, kScreenW / 13));
            make.centerX.mas_equalTo(view.mas_centerX);
            make.top.mas_equalTo(view.height / 14.33333);
        }];
        
        self.lable2 = [UILabel creatLableWithTitle:@"" andSuperView:view andFont:k15 andTextAligment:NSTextAlignmentCenter];
        self.lable2.layer.borderWidth = 0;
        [self.lable2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(kScreenW * 2 / 3, kScreenW / 13));
            make.centerX.mas_equalTo(view.mas_centerX);
            make.top.mas_equalTo(self.lable.mas_bottom);
        }];
        
        
        self.imageViw = [[UIImageView alloc]init];
        [view addSubview:self.imageViw];
        [self.imageViw mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(self.contentView.mas_centerX);
            make.size.mas_equalTo(CGSizeMake(kScreenH / 6.29059, kScreenH / 7.913978));
//            make.bottom.mas_equalTo(view.mas_bottom).offset(-view.height / 5.333333);
            make.top.mas_equalTo(self.lable2.mas_bottom);
        }];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
