//
//  SystemMessageAndMineMessageTableViewCell.m
//  联侠
//
//  Created by 杭州阿尔法特 on 2017/2/7.
//  Copyright © 2017年 张海昌. All rights reserved.
//

#import "SystemMessageAndMineMessageTableViewCell.h"
#import "SystemMessageModel.h"

@interface SystemMessageAndMineMessageTableViewCell ()
@property (nonatomic , strong) UILabel *titleLabel;
@property (nonatomic , strong) UILabel *timeLabel;
@property (nonatomic , strong) UILabel *readCountLabel;
@property (nonatomic , strong) UILabel *subtitleLabel;
@end

@implementation SystemMessageAndMineMessageTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self customUI];
    }
    return self;
}

- (void)customUI {
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenW, kScreenW / 4.5)];
    [self.contentView addSubview:view];
    view.backgroundColor = [UIColor whiteColor];
    UILabel *titleLable = [UILabel creatLableWithTitle:@"" andSuperView:view andFont:k15 andTextAligment:NSTextAlignmentLeft];
    [titleLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kScreenW - kScreenW / 10, view.height / 4));
        make.left.mas_equalTo(view.mas_left).offset(kScreenW / 20);
        make.top.mas_equalTo(view.mas_top).offset(view.height / 16);
    }];
    self.titleLabel = titleLable;
    
    UILabel *timeLable = [UILabel creatLableWithTitle:@"" andSuperView:view andFont:k12 andTextAligment:NSTextAlignmentLeft];
    [timeLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake((kScreenW - kScreenW / 10) / 2, view.height / 4));
        make.left.mas_equalTo(titleLable.mas_left);
        make.top.mas_equalTo(titleLable.mas_bottom).offset(view.height / 16);
    }];
    self.timeLabel = timeLable;
    
    UILabel *readCountLable = [UILabel creatLableWithTitle:@"" andSuperView:view andFont:k12 andTextAligment:NSTextAlignmentLeft];
    [readCountLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake((kScreenW - kScreenW / 10) / 2, view.height / 4));
        make.left.mas_equalTo(timeLable.mas_right);
        make.centerY.mas_equalTo(timeLable.mas_centerY);
    }];
    self.readCountLabel = readCountLable;
    
    UILabel *subtitleLable = [UILabel creatLableWithTitle:@"" andSuperView:view andFont:k15 andTextAligment:NSTextAlignmentLeft];
    [subtitleLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kScreenW - kScreenW / 10, view.height / 4));
        make.left.mas_equalTo(titleLable.mas_left);
        make.top.mas_equalTo(timeLable.mas_bottom).offset(view.height / 16);
    }];
    self.subtitleLabel = subtitleLable;
    
    [UIView creatBottomFenGeView:view andBackGroundColor:[UIColor lightGrayColor] isOrNotAllLenth:@"YES"];
    
    titleLable.layer.borderWidth = 0;
    timeLable.layer.borderWidth = 0;
    subtitleLable.layer.borderWidth = 0;
    readCountLable.layer.borderWidth = 0;
    
    timeLable.textColor = [UIColor blackColor];
    timeLable.textColor = kCOLOR(176, 176, 176);
    readCountLable.textColor = kCOLOR(176, 176, 176);
    subtitleLable.textColor = kCOLOR(114, 114, 114);
}

- (void)setSystemMessageModel:(SystemMessageModel *)systemMessageModel {
    _systemMessageModel = systemMessageModel;
    
    if (_systemMessageModel) {
        self.titleLabel.text = _systemMessageModel.title;
        self.timeLabel.text = _systemMessageModel.addTime;
        self.subtitleLabel.text = _systemMessageModel.content;
        self.readCountLabel.text = [NSString stringWithFormat:@"阅读量:%ld" , (long)_systemMessageModel.readCount];
    }
    
}

@end
