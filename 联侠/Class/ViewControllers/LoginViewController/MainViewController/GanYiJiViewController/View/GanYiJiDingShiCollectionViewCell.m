//
//  GanYiJiDingShiCollectionViewCell.m
//  联侠
//
//  Created by 杭州阿尔法特 on 16/6/30.
//  Copyright © 2016年 张海昌. All rights reserved.
//

#import "GanYiJiDingShiCollectionViewCell.h"

#define kColothesHeight self.contentView.width / 5

@interface GanYiJiDingShiCollectionViewCell (){

    UILabel *dingShiLable;
    UIImageView *imageView;
    UILabel *titleLable;
}

@end

@implementation GanYiJiDingShiCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {

        [self customUI];
    }
    return self;
}

- (void)customUI {
    
    self.contentView.backgroundColor = [UIColor whiteColor];
    
    imageView = [[UIImageView alloc]init];
    [self.contentView addSubview:imageView];
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(self.contentView.width, self.contentView.width));
        make.centerX.mas_equalTo(self.contentView.mas_centerX);
        make.top.mas_equalTo(self.contentView.mas_top);
    }];
    imageView.image = [UIImage imageNamed:@"dingShiTuPian"];
    
    titleLable = [UILabel creatLableWithTitle:@"" andSuperView:self.contentView andFont:k15 andTextAligment:NSTextAlignmentCenter];
    titleLable.layer.borderWidth = 0;
    [titleLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(self.contentView.width, kColothesHeight));
        make.centerX.mas_equalTo(self.contentView.mas_centerX);
        make.top.mas_equalTo(imageView.mas_bottom);
    }];
    

    dingShiLable = [UILabel creatLableWithTitle:@"" andSuperView:self.contentView andFont:k15 andTextAligment:NSTextAlignmentCenter];
    dingShiLable.layer.borderWidth = 0;
    [dingShiLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(self.contentView.width * 1 / 3, kColothesHeight));
        make.centerX.mas_equalTo(self.contentView.mas_centerX);
        make.top.mas_equalTo(titleLable.mas_bottom);
    }];

    if (_model.count != 0) {
         [self setDingShiLableText:_model.count];
    }
    
   
    
    UIButton *addButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [addButton setTitle:@"+" forState:UIControlStateNormal];
    addButton.titleLabel.font = [UIFont systemFontOfSize:k30];
    addButton.backgroundColor = [UIColor whiteColor];
    [addButton addTarget:self action:@selector(addButtonAtcion:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:addButton];
    [addButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(self.contentView.width / 3, kColothesHeight));
        make.left.mas_equalTo(dingShiLable.mas_right);
        make.top.mas_equalTo(dingShiLable.mas_top);
    }];
    
    
    UIButton *minusButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [minusButton setTitle:@"-" forState:UIControlStateNormal];
    minusButton.titleLabel.font = [UIFont systemFontOfSize:k30];
    minusButton.backgroundColor = [UIColor whiteColor];
    [minusButton addTarget:self action:@selector(jianBtnAtcion:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:minusButton];
    [minusButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(self.contentView.width / 3, kColothesHeight));
        make.left.mas_equalTo(self.contentView.mas_left);
        make.top.mas_equalTo(dingShiLable.mas_top);
    }];
    
}

- (void)addButtonAtcion:(UIButton *)btn {
    
    _model.count++;
    [self setDingShiLableText:_model.count];
    
    [_clothesDic setObject:@(_model.count) forKey:_model.name];
    
    NSString *time = [NSString stringWithFormat:@"%ld" , _model.count * _model.time.intValue];
    NSArray *array = @[_clothesDic , time];
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(getClothesTimes:didFinishTime:)]) {
        [self.delegate getClothesTimes:self didFinishTime:array];
    }
    
}

- (void)jianBtnAtcion:(UIButton *)btn {
    _model.count--;
    if ( _model.count < 0) {
        _model.count = 0;
    }
    [self setDingShiLableText:_model.count];
    
    [_clothesDic setObject:@(_model.count) forKey:_model.name];
    NSString *time = [NSString stringWithFormat:@"%ld" , _model.count * _model.time.intValue];
    NSArray *array = @[_clothesDic , time];
    if (self.delegate && [self.delegate respondsToSelector:@selector(getClothesTimes:didFinishTime:)]) {
        [self.delegate getClothesTimes:self didFinishTime:array];
    }
}

- (void)setDingShiLableText:(NSInteger)title {
    
    NSMutableAttributedString *str4 = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%ld 件" , (long)title]];
    [str4 addAttribute:NSForegroundColorAttributeName value:kKongJingYanSe range:NSMakeRange(0,[NSString stringWithFormat:@"%ld", (long)title].length)];
    [str4 addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"Helvetica" size:k20] range:NSMakeRange(0, [NSString stringWithFormat:@"%ld", (long)title].length)];
    dingShiLable.attributedText = str4;
}

- (void)setModel:(GanYiJIClothesModel *)model {
    
    _model = model;
    imageView.image = [UIImage imageNamed:_model.image];
    titleLable.text = _model.name;
    dingShiLable.text = [NSString stringWithFormat:@"%ld" , _model.count];

    if ([kStanderDefault objectForKey:@"GanYiJiDingShiData"]) {
        NSArray *array = [kStanderDefault objectForKey:@"GanYiJiDingShiData"];
        NSLog(@"%@ , %@" , array , _model.name);
        NSMutableDictionary *dic = array[4];
        
        for (NSString *key in [dic allKeys]) {
            if ([_model.name isEqualToString:key]) {
                dingShiLable.text = [NSString stringWithFormat:@"%@" , dic[key]];
            }
        }
        
        
    }

}

@end
