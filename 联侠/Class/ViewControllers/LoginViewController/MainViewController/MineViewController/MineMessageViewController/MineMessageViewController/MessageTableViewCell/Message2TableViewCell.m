//
//  Message2TableViewCell.m
//  AEFT冷风扇
//
//  Created by 杭州阿尔法特 on 16/4/5.
//  Copyright © 2016年 阿尔法特. All rights reserved.
//

#import "Message2TableViewCell.h"

@interface Message2TableViewCell ()
@property (nonatomic , strong) UILabel *contentLable;
@property (nonatomic  ,strong) UILabel *titmeLable;

@end


@implementation Message2TableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.contentLable = [[UILabel alloc]initWithFrame:self.contentView.frame];
        [self.contentView addSubview:self.contentLable];
        self.contentLable.font = [UIFont systemFontOfSize:k14];
    }
    return self;
}

- (void)setModel:(MessageModel *)model{
    NSLog(@"%@" , model.sendTime);
    self.contentLable.text = model.content;
//    self.titmeLable.text = model.sendTime;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
