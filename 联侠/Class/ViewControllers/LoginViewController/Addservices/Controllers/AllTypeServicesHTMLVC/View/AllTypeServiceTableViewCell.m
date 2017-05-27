//
//  AllTypeServiceTableViewCell.m
//  联侠
//
//  Created by 杭州阿尔法特 on 2016/12/2.
//  Copyright © 2016年 张海昌. All rights reserved.
//

#import "AllTypeServiceTableViewCell.h"

@interface AllTypeServiceTableViewCell ()
@property (nonatomic , strong) UIImageView *backImage;
@property (nonatomic ,strong) UILabel *lable;
@property (nonatomic , strong) UIView *view;
@property (nonatomic , strong) UIImageView *imageViw;
@property (nonatomic , strong) UIView *fenGeView;
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
    
    self.backgroundColor = [UIColor colorWithHexString:@"f2f4fb"];
    _view = [[UIView alloc] initWithFrame:CGRectMake(10, 0, kScreenW - kScreenW / 15.625, kScreenH / 13)];
    [self.contentView addSubview:_view];
    _view.backgroundColor = [UIColor clearColor];
    
    self.backImage = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"normalback"]];
    [self.view addSubview:self.backImage];
    [self.backImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(self.view.width, self.view.height));
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.centerY.mas_equalTo(self.view.mas_centerY);
    }];
    
    self.imageViw  = [[UIImageView alloc]initWithImage:nil];
    [self.view addSubview:self.imageViw];
    [self.imageViw mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kScreenW / 15, kScreenW / 15));
        make.left.mas_equalTo(self.view.mas_left).offset(kScreenW / 29);
        make.centerY.mas_equalTo(self.view.mas_centerY);
    }];
    
    self.lable = [UILabel creatLableWithTitle:nil andSuperView:self.view andFont:k15 andTextAligment:NSTextAlignmentLeft];
    self.lable.textColor = [UIColor blackColor];
    self.lable.layer.borderWidth = 0;
    [self.lable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kScreenW / 2, self.view.height * 1 / 3));
        make.left.mas_equalTo(self.imageViw.mas_right).offset(kScreenW / 29);
        make.centerY.mas_equalTo(self.view.mas_centerY);
    }];
    
    UIImageView *jianTouImage = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"tab_return"]];
    [_view addSubview:jianTouImage];
    [jianTouImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kScreenW / 50, kScreenW / 30));
        make.right.mas_equalTo(_view.mas_right).offset(-kScreenW / 29);
        make.centerY.mas_equalTo(_view.mas_centerY);
    }];
    jianTouImage.transform = CGAffineTransformRotate(jianTouImage.transform, M_PI);
    jianTouImage.contentMode = UIViewContentModeScaleAspectFit;
    [UIImageView setImageViewColor:jianTouImage andColor:[UIColor colorWithHexString:@"81d0ff"]];
    
    UIView *fenGeView = [[UIView alloc]init];
    [_view addSubview:fenGeView];
    fenGeView.backgroundColor = kCOLOR(244, 244, 244);
    [fenGeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(_view.width - kScreenW * 2 / 29, 1));
        make.left.mas_equalTo(_imageViw.mas_left);
        make.bottom.mas_equalTo(_view.mas_bottom);
    }];
    fenGeView.hidden = YES;
    self.fenGeView = fenGeView;
    
    _selectedImage = [[UIImageView alloc]initWithFrame:_view.bounds];
    [_view addSubview:_selectedImage];
    _selectedImage.image = [UIImage imageWithColor:kMainColor];
    _selectedImage.alpha = .3;
    _selectedImage.hidden = YES;
    
    self.lable.font = [UIFont systemFontOfSize:k13];
}

- (void)setIndePath:(NSIndexPath *)indePath {
    _indePath = indePath;
    self.fenGeView.hidden = NO;
    if (_indePath.row == 0) {
        self.backImage.image = [UIImage imageNamed:@"topleftandright"];
    }
    
    if (_indePath.row == self.count - 1) {
        self.backImage.image = [UIImage imageNamed:@"bottomleftandright"];
        self.fenGeView.hidden = YES;
    }
}

- (void)setAllTypeServiceModel:(AllTypeServiceModel *)allTypeServiceModel {
    _allTypeServiceModel = allTypeServiceModel;

    [self.imageViw sd_setImageWithURL:[NSURL URLWithString:_allTypeServiceModel.imageUrl] placeholderImage:[UIImage new]];
    self.lable.text = _allTypeServiceModel.typeName;
}

@end
