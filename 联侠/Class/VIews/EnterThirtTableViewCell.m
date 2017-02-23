//
//  EnterThirtTableViewCell.m
//  AEFT冷风扇
//
//  Created by 杭州阿尔法特 on 16/3/11.
//  Copyright © 2016年 阿尔法特. All rights reserved.
//

#import "EnterThirtTableViewCell.h"

static NSString *str = nil;

@implementation EnterThirtTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        //cell选中时的颜色
        self.selectionStyle = UITableViewCellSeparatorStyleNone;
        
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getDate555555555:) name:@"4131" object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getDate555555555:) name:@"4132" object:nil];
        
        UILabel *modelChanceLable = [UILabel creatLableWithTitle:@"风速控制" andSuperView:self.contentView andFont:k17 andTextAligment:NSTextAlignmentCenter];
        modelChanceLable.textColor = [UIColor whiteColor];
        modelChanceLable.layer.borderWidth = 0;
        [modelChanceLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(kScreenW / 5.3571, kScreenH / 33.35));
            make.left.mas_equalTo(kScreenW / 20);
            make.top.mas_equalTo(self.contentView.mas_top).offset(10);
        }];
        
        
        //滑块设置
        _slider = [[UISlider alloc] init];
        _slider.continuous = NO;
        _slider.minimumValue = 1;
        _slider.maximumValue = 3;
        _slider.minimumTrackTintColor = [UIColor whiteColor];
        _slider.maximumTrackTintColor = [UIColor whiteColor];
        //设置默认值
        self.slider.userInteractionEnabled = YES;
        [self.contentView addSubview:self.slider];
        [self.slider mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(self.contentView.mas_centerX);
            make.size.mas_equalTo(CGSizeMake(kScreenW / 1.63, 30));
            make.centerY.mas_equalTo(self.contentView.mas_centerY);
        }];
        
        //添加点击手势和滑块滑动事件响应
        [_slider addTarget:self action:@selector(valueChanged:) forControlEvents:UIControlEventValueChanged];
        UITapGestureRecognizer *tap =
        [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction1:)];
        
        [_slider addGestureRecognizer:tap];
        
        NSArray *array = [NSArray arrayWithObjects:@"低", @"中" , @"高" , nil];
        
        for (int i = 0; i < 3; i++) {
            UILabel *stateLable = [UILabel creatLableWithTitle:[NSString stringWithFormat:@"%@" , array[i]] andSuperView:self.contentView andFont:k14 andTextAligment:NSTextAlignmentCenter];
            stateLable.tag = i;
            stateLable.textColor = [UIColor whiteColor];
            stateLable.layer.borderWidth = 0;
            [stateLable mas_makeConstraints:^(MASConstraintMaker *make) {
                make.size.mas_equalTo(CGSizeMake(kScreenW / 15, kScreenW / 20));
                
                if (stateLable.tag == 0) {
                    make.left.mas_equalTo(_slider.mas_left);
                } else if (stateLable.tag == 1) {
                    make.centerX.mas_equalTo(_slider.mas_centerX);
                } else {
                    make.right.mas_equalTo(_slider.mas_right);
                }
                make.top.mas_equalTo(_slider.mas_bottom).offset(kScreenH / 66.7);
            }];
            
        }
        
        [UIView creatBottomFenGeView:self.contentView andBackGroundColor:[UIColor whiteColor] isOrNotAllLenth:@"NO"];
        
        
    }
    return self;
}

- (void)valueChanged:(UISlider *)sender
{
    //只取整数值，固定间距
    NSString *tempStr = [self numberFormat:_slider.value];
    [_slider setValue:tempStr.intValue];
    
    
    if (_slider.value == 1) {

        str = [NSString stringWithFormat:@"HMFF%@%@W1#" , self.serviceModel.devTypeSn, self.serviceModel.devSn];
        
        [kSocketTCP sendDataToHost:str andType:kZhiLing andIsNewOrOld:kOld];
        
    } else if (_slider.value == 2) {
        
        str = [NSString stringWithFormat:@"HMFF%@%@W2#" , self.serviceModel.devTypeSn, self.serviceModel.devSn];
        
        [kSocketTCP sendDataToHost:str andType:kZhiLing andIsNewOrOld:kOld];
        
    } else if (sender.value == 3){
        
        str = [NSString stringWithFormat:@"HMFF%@%@W3#" , self.serviceModel.devTypeSn, self.serviceModel.devSn];
        
        [kSocketTCP sendDataToHost:str andType:kZhiLing andIsNewOrOld:kOld];
        
    }
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getDate555555555:) name:@"4131" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getDate555555555:) name:@"4132" object:nil];
}

#pragma mark - 取得tcp返回的数据
- (void)getDate555555555:(NSNotification *)post {
    
    NSString *str = post.userInfo[@"Message"];
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

- (void)tapAction1:(UITapGestureRecognizer *)sender
{
    //取得点击点
    CGPoint p = [sender locationInView:_slider];
    //计算处于背景图的几分之几，并将之转换为滑块的值（1~7）
    float tempFloat = p.x  / ( _slider.width / 2 ) + 1;
    NSString *tempStr = [self numberFormat:tempFloat];
    
    if (tempStr.intValue == 1) {
        
        [kSocketTCP sendDataToHost:[NSString stringWithFormat:@"HMFF%@%@W1#" , self.serviceModel.devTypeSn, self.serviceModel.devSn] andType:kZhiLing andIsNewOrOld:kOld];
    } else if (tempStr.intValue == 2) {
        
        [kSocketTCP sendDataToHost:[NSString stringWithFormat:@"HMFF%@%@W2#" , self.serviceModel.devTypeSn, self.serviceModel.devSn] andType:kZhiLing andIsNewOrOld:kOld];
    } else {
        [kSocketTCP sendDataToHost:[NSString stringWithFormat:@"HMFF%@%@W3#" , self.serviceModel.devTypeSn, self.serviceModel.devSn] andType:kZhiLing andIsNewOrOld:kOld];
    }
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getDate555555555:) name:@"4131" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getDate555555555:) name:@"4132" object:nil];
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
    //    formatter.numberStyle = kCFNumberFormatterRoundFloor;
    [formatter setPositiveFormat:@"0"];
    return [formatter stringFromNumber:[NSNumber numberWithFloat:num]];
}

- (void)setModel:(StateModel *)model {
    
    if (model == 0) {
        self.slider.value = 1;
    } else {
        if (model.fWind == 1) {
            self.slider.value = 1;
        } else if (model.fWind == 2) {
            self.slider.value = 2;
        } else if (model.fWind == 3) {
            self.slider.value = 3;
        }
    }
}

- (void)setServiceModel:(ServicesModel *)serviceModel {
    _serviceModel = serviceModel;
}

@end
