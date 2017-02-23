//
//  AboutOusTableViewCell.m
//  联侠
//
//  Created by 杭州阿尔法特 on 2017/2/10.
//  Copyright © 2017年 张海昌. All rights reserved.
//

#import "AboutOusTableViewCell.h"

@interface AboutOusTableViewCell ()
@property (nonatomic , strong) UILabel *label;
@end

@implementation AboutOusTableViewCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self customUI];
    }
    return self;
}

- (void)customUI {
    UIView *view = [[UIView alloc]initWithFrame:self.contentView.bounds];
    [self.contentView addSubview:view];
    
    UILabel *label = [UILabel creatLableWithTitle:@"" andSuperView:view andFont:k14 andTextAligment:NSTextAlignmentLeft];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kScreenW / 2, view.height));
        make.centerY.mas_equalTo(view.mas_centerY);
        make.left.mas_equalTo(view.mas_left).offset(kScreenW / 20);
    }];
    self.label = label;

}

- (void)setTitle:(NSString *)title {
    _title = title;
    
    self.label.text = _title;
}

@end
