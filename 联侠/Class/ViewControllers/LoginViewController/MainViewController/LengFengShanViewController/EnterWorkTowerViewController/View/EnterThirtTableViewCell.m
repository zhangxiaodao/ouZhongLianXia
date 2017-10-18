//
//  EnterThirtTableViewCell.m
//  AEFT冷风扇
//
//  Created by 杭州阿尔法特 on 16/3/11.
//  Copyright © 2016年 阿尔法特. All rights reserved.
//

#import "EnterThirtTableViewCell.h"

@implementation EnterThirtTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSeparatorStyleNone;
        [self setUI];
    }
    return self;
}

- (void)setUI {
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getLFSInfo:) name:kServiceOrder object:nil];
    
    UILabel *modelChanceLable = [UILabel creatLableWithTitle:@"风速控制" andSuperView:self.contentView andFont:k17 andTextAligment:NSTextAlignmentCenter];
    modelChanceLable.textColor = [UIColor whiteColor];
    [modelChanceLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(kScreenW / 20);
        make.top
        .mas_equalTo(self.contentView.mas_top).offset(10);
    }];
    
    _slider = [[UISlider alloc] init];
    _slider.continuous = NO;
    _slider.minimumValue = 1;
    _slider.maximumValue = 3;
    _slider.minimumTrackTintColor = [UIColor whiteColor];
    _slider.maximumTrackTintColor = [UIColor whiteColor];
    self.slider.userInteractionEnabled = YES;
    [self.contentView addSubview:self.slider];
    [self.slider mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX
        .mas_equalTo(self.contentView.mas_centerX);
        make.size
        .mas_equalTo(CGSizeMake(kScreenW / 1.63, 30));
        make.centerY
        .mas_equalTo(self.contentView.mas_centerY);
    }];
    
    [_slider addTarget:self action:@selector(valueChanged:) forControlEvents:UIControlEventValueChanged];
    UITapGestureRecognizer *tap =
    [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapSliderAction:)];
    
    [_slider addGestureRecognizer:tap];
    
    NSArray *array = [NSArray arrayWithObjects:@"低", @"中" , @"高" , nil];
    
    for (int i = 0; i < 3; i++) {
        UILabel *stateLable = [UILabel creatLableWithTitle:[NSString stringWithFormat:@"%@" , array[i]] andSuperView:self.contentView andFont:k14 andTextAligment:NSTextAlignmentCenter];
        stateLable.textColor = [UIColor whiteColor];
        [stateLable mas_makeConstraints:^(MASConstraintMaker *make) {
            if (i == 0) {
                make.left.mas_equalTo(_slider.mas_left);
            } else if (i == 1) {
                make.centerX
                .mas_equalTo(_slider.mas_centerX);
            } else {
                make.right.mas_equalTo(_slider.mas_right);
            }
            make.top.mas_equalTo(_slider.mas_bottom).offset(kScreenH / 66.7);
        }];
        
    }
    
    [UIView creatBottomFenGeView:self.contentView andBackGroundColor:[UIColor whiteColor] isOrNotAllLenth:@"NO"];
}

- (void)valueChanged:(UISlider *)sender
{
    NSString *tempStr = [self numberFormat:_slider.value];
    [_slider setValue:tempStr.intValue];
    
    NSString *orderStr = nil;
    if (_slider.value == 1) {
        orderStr = [NSString stringWithFormat:@"HMFF%@%@W1#" , self.serviceModel.devTypeSn, self.serviceModel.devSn];
    } else if (_slider.value == 2) {
        orderStr = [NSString stringWithFormat:@"HMFF%@%@W2#" , self.serviceModel.devTypeSn, self.serviceModel.devSn];
    } else if (sender.value == 3){
        orderStr = [NSString stringWithFormat:@"HMFF%@%@W3#" , self.serviceModel.devTypeSn, self.serviceModel.devSn];
    }
    [kSocketTCP sendDataToHost:orderStr andType:kZhiLing andIsNewOrOld:kOld];
}

#pragma mark - 取得tcp返回的数据
- (void)getLFSInfo:(NSNotification *)post {
    
    NSString *str = post.userInfo[@"Message"];
    
    if (str.length != 42) {
        return;
    }
    
    NSString *wind = [str substringWithRange:NSMakeRange(30, 2)];
    NSString *devSn = [str substringWithRange:NSMakeRange(12, 12)];
    NSString *windType = @"中速";
    if ([self.serviceModel.devSn isEqualToString:devSn]) {
        if ([wind isEqualToString:@"01"]) {
            _slider.value = 1;
            windType = @"低速";
        } else if ([wind isEqualToString:@"02"]) {
            _slider.value = 2;
            windType = @"中速";
        } else if ([wind isEqualToString:@"03"]) {
            _slider.value = 3;
            windType = @"高速";
        }
        if (_delegate && [_delegate respondsToSelector:@selector(sendWindType:)]) {
            [_delegate sendWindType:windType];
        }
        
    }
    
}

- (void)tapSliderAction:(UITapGestureRecognizer *)sender
{
    //取得点击点
    CGPoint p = [sender locationInView:_slider];
    float tempFloat = p.x  / ( _slider.width / 2 ) + 1;
    NSString *tempStr = [self numberFormat:tempFloat];

    NSString *orderStr = nil;
    if (tempStr.intValue == 1) {
        orderStr = [NSString stringWithFormat:@"HMFF%@%@W1#" , self.serviceModel.devTypeSn, self.serviceModel.devSn];
    } else if (tempStr.intValue == 2) {
        orderStr = [NSString stringWithFormat:@"HMFF%@%@W2#" , self.serviceModel.devTypeSn, self.serviceModel.devSn];
    } else {
        orderStr = [NSString stringWithFormat:@"HMFF%@%@W3#" , self.serviceModel.devTypeSn, self.serviceModel.devSn];
    }
    [kSocketTCP sendDataToHost:orderStr andType:kZhiLing andIsNewOrOld:kOld];
}

/**
 *  四舍五入
 *
 *  @param num 待转换数字
 *
 *  @return 转换后的数字
 */
- (NSString *)numberFormat:(float)num
{
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    [formatter setPositiveFormat:@"0"];
    return [formatter stringFromNumber:[NSNumber numberWithFloat:num]];
}

- (void)setModel:(StateModel *)model {
    
    if (model == 0) {
        self.slider.value = 1;
    } else {
        self.slider.value = model.fWind;
    }
}

- (void)setServiceModel:(ServicesModel *)serviceModel {
    _serviceModel = serviceModel;
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
