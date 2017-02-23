//
//  MainSecondTableViewCell.m
//  AEFT冷风扇
//
//  Created by 杭州阿尔法特 on 16/3/10.
//  Copyright © 2016年 阿尔法特. All rights reserved.
//

#import "MainSecondTableViewCell.h"

#define kTapViewX tap.view.frame.origin.x
#define kTapViewY tap.view.frame.origin.y


@implementation MainSecondTableViewCell


- (void)awakeFromNib {
    // Initialization code
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        //cell选中时的颜色
        self.selectionStyle = UITableViewCellSeparatorStyleNone;
        UILabel *lable = [UILabel initWithTitle:@"请添加设备" andSuperView:self.contentView andFont:14 andtextAlignment:NSTextAlignmentCenter andMas_Left:0];
        [lable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(self.contentView.mas_right);
            make.top.mas_equalTo(self.contentView.mas_top);
            make.bottom.mas_equalTo(self.contentView.mas_bottom);
        }];
        lable.backgroundColor = [UIColor greenColor];
        
        NSString *isContnect = [kStanderDefault objectForKey:@"isContnect"];
        
        if ([isContnect isEqualToString:@"NO"]) {
            lable.text = @"进入工作台";
        }
        
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
