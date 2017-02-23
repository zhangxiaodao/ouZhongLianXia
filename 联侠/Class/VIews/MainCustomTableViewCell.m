//
//  MainCustomTableViewCell.m
//  AEFT冷风扇
//
//  Created by 杭州阿尔法特 on 16/3/10.
//  Copyright © 2016年 阿尔法特. All rights reserved.
//

#import "MainCustomTableViewCell.h"

@implementation MainCustomTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        //cell选中时的颜色
        self.selectionStyle = UITableViewCellSeparatorStyleNone;
        UIColor * bgColor = [UIColor colorWithRed:0.7
                                            green:1.0 blue:0.7 alpha:1.0];
        // 设置该使用淡绿色背景
        self.contentView.backgroundColor = bgColor;
        UIImageView *imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"iconfont-fangzi"]];
        [self.contentView addSubview:imageView];
        [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(kCGSizeMake);
            make.left.mas_equalTo(kScreenW / 2 - 20);
            make.right.mas_equalTo(- kScreenW / 2 + 20);
            make.top.mas_equalTo(self.contentView.mas_top).offset(10);
        }];
        
        UILabel *caseLable = [UILabel initWithTitle:@"优美的句子" andSuperView:self.contentView andFont:14 andtextAlignment:NSTextAlignmentLeft andMas_Left:20];
        [caseLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(kCGSizeMake);
            make.right.mas_equalTo(20);
            make.top.mas_equalTo(imageView.mas_top).offset(15);
        }];
        
        UILabel *temperatureLable = [UILabel initWithTitle:@"1000度" andSuperView:self.contentView andFont:14 andtextAlignment:NSTextAlignmentCenter andMas_Left:20];
        [temperatureLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(kCGSizeMake);
            make.right.mas_equalTo(- kScreenW / 2 - 20);
            make.top.mas_equalTo(caseLable.mas_bottom);
        }];
        
        UILabel *fenGeXianLable = [UILabel initWithTitle:@"----------------" andSuperView:self.contentView andFont:5 andtextAlignment:NSTextAlignmentCenter andMas_Left:20];
        [fenGeXianLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(0, kScreenW / 50));
            make.right.mas_equalTo(temperatureLable.mas_right);
            make.top.mas_equalTo(temperatureLable.mas_bottom);
        }];
        
        UILabel *sumLable = [UILabel initWithTitle:@"累计降低温度" andSuperView:self.contentView andFont:14 andtextAlignment:NSTextAlignmentCenter andMas_Left:20];
        [sumLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(kCGSizeMake);
            make.right.mas_equalTo(- kScreenW / 2 - 20);
            make.top.mas_equalTo(fenGeXianLable.mas_bottom);
        }];
        
        UILabel *timeLable = [UILabel initWithTitle:@"365小时" andSuperView:self.contentView andFont:14 andtextAlignment:NSTextAlignmentCenter andMas_Left:kScreenW / 2 + 20];
        [timeLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(kCGSizeMake);
            make.right.mas_equalTo(- 20);
            make.top.mas_equalTo(caseLable.mas_bottom);
        }];
        
        UILabel *fenGeXianLable2 = [UILabel initWithTitle:@"----------------" andSuperView:self.contentView andFont:5 andtextAlignment:NSTextAlignmentCenter andMas_Left:kScreenW / 2 + 20];
        [fenGeXianLable2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(0, kScreenW / 50));
            make.right.mas_equalTo(timeLable.mas_right);
            make.top.mas_equalTo(timeLable.mas_bottom);
        }];
        
        UILabel *sumTimeLable = [UILabel initWithTitle:@"累计运行时间" andSuperView:self.contentView andFont:14 andtextAlignment:NSTextAlignmentCenter andMas_Left:kScreenW / 2 + 20];
        [sumTimeLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(kCGSizeMake);
            make.right.mas_equalTo( - 20);
            make.top.mas_equalTo(fenGeXianLable2.mas_bottom);
        }];
        
        
    }
    return self;
}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
