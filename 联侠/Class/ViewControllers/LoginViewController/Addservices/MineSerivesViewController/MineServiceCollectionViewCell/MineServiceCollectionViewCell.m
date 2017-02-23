//
//  MineServiceCollectionViewCell.m
//  AEFT冷风扇
//
//  Created by 杭州阿尔法特 on 16/4/16.
//  Copyright © 2016年 阿尔法特. All rights reserved.
//

#import "MineServiceCollectionViewCell.h"

@implementation MineServiceCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, (kScreenW - kScreenW / 5) / 3, ((kScreenW - kScreenW / 5) / 3) * 1.25)];
        [self.contentView addSubview:view];
        
        _backImage = [[UIImageView alloc]init];
        [view addSubview:_backImage];
        [_backImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_offset(CGSizeMake(view.width, view.height * 2 / 3));
            make.centerX.mas_equalTo(view.mas_centerX);
            make.top.mas_equalTo(view.mas_top);
        }];
        
        UIView *backImageView = [[UIView alloc]init];
        [view addSubview:backImageView];
        [backImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_offset(CGSizeMake(view.width, view.height * 2 / 3));
            make.centerX.mas_equalTo(view.mas_centerX);
            make.top.mas_equalTo(view.mas_top);
        }];
        backImageView.backgroundColor = [UIColor clearColor];
        backImageView.layer.borderColor = kFenGeXianYanSe.CGColor;
        backImageView.layer.borderWidth = 0;
        backImageView.layer.cornerRadius = 5;
        
        _typeName = [UILabel creatLableWithTitle:@"" andSuperView:view andFont:k14 andTextAligment:NSTextAlignmentCenter];
        [_typeName mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(view.width, view.height / 3));
            make.centerX.mas_equalTo(view.mas_centerX);
            make.top.mas_equalTo(_backImage.mas_bottom);
        }];
        _typeName.layer.borderWidth = 0;
    }
    return self;
}

- (void)setIndexPath:(NSIndexPath *)indexPath{
    _indexPath = indexPath;
}

- (void)setServiceModel:(ServicesModel *)serviceModel {
    
    _serviceModel = serviceModel;
    [self.backImage sd_setImageWithURL:[NSURL URLWithString:_serviceModel.imageUrl] placeholderImage:[UIImage new]];
    self.typeName.text = [NSString stringWithFormat:@"%@%@No%ld" , _serviceModel.brand , _serviceModel.typeName , ((long)_indexPath.row + 1)];
//    self.backView.backgroundColor = [UIColor clearColor];
//    self.backView.layer.borderColor = kACOLOR(224, 224, 224, 1.0).CGColor;
//    self.backView.layer.borderWidth = 0;
//    self.backView.layer.cornerRadius = 5;
    self.layer.masksToBounds = YES;
}

@end
