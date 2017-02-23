//
//  AllTypeServiceTableViewCell.m
//  联侠
//
//  Created by 杭州阿尔法特 on 2016/12/2.
//  Copyright © 2016年 张海昌. All rights reserved.
//

#import "AllTypeServiceTableViewCell.h"

@interface AllTypeServiceTableViewCell ()
@property (nonatomic , strong) UIImageView *imageViw;
@property (nonatomic ,strong) UILabel *lable;
@end

@implementation AllTypeServiceTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self customUI];
    }
    return self;
}

- (void)customUI {
    
    //cell选中时的颜色
    self.selectionStyle = UITableViewCellSeparatorStyleNone;
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenW, kScreenH / 12)];
    [self.contentView addSubview:view];
    
    UIImageView *imageView = [[UIImageView alloc]initWithImage:[UIImage new]];
    [self.contentView addSubview:imageView];
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(view.height * 2 / 3, view.height * 2 / 3));
        make.left.mas_equalTo(kScreenW / 18.75);
        make.centerY.mas_equalTo(self.contentView.mas_centerY);
    }];
    self.imageViw = imageView;
    
    
    UILabel *label = [UILabel creatLableWithTitle:@"定时预约" andSuperView:self.contentView andFont:k14 andTextAligment:NSTextAlignmentLeft];
    label.layer.borderWidth = 0;
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kScreenW / 2, view.height * 2 / 3));
        make.left.mas_equalTo(imageView.mas_right).offset(kScreenW / 18.75);
        make.centerY.mas_equalTo(self.contentView.mas_centerY);
    }];
    self.lable = label;
    
    UIView *bottomView = [[UIView alloc]init];
    [view addSubview:bottomView];
    bottomView.backgroundColor = kFenGeXianYanSe;
    bottomView.tag = 111;
    [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kScreenW, 1));
        make.left.mas_equalTo(0);
        make.bottom.mas_equalTo(view.mas_bottom).offset(-2);
    }];
    
    
    
}

- (void)setImageViw:(UIImageView *)imageViw {
    _imageViw = imageViw;
}


- (void)setAllTypeServiceModel:(AllTypeServiceModel *)allTypeServiceModel {
    _allTypeServiceModel = allTypeServiceModel;
    [_imageViw sd_setImageWithURL:[NSURL URLWithString:_allTypeServiceModel.imageUrl] placeholderImage:[UIImage new]];
    _lable.text = _allTypeServiceModel.typeName;
}

@end
