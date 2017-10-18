//
//  EnterSecondTableViewCell.m
//  AEFT冷风扇
//
//  Created by 杭州阿尔法特 on 16/3/11.
//  Copyright © 2016年 阿尔法特. All rights reserved.
//

#import "EnterSecondTableViewCell.h"

#define kArrayCount self.array.count
#define kArrayCountJiaYi (self.array.count + 1)
#define kBtnW (((kScreenW - kScreenW / 3) / 4) - 5)
#define kBtnMargin ((kScreenW - kArrayCount * kBtnW) / kArrayCountJiaYi)
@interface EnterSecondTableViewCell ()
@property (nonatomic , strong) NSArray *array;
@property (nonatomic , strong) UIButton *zhiLengBtn;
@property (nonatomic , strong) UIButton *baiFengBtn;
@property (nonatomic , strong) UIButton *shanJunBtn;
@end

@implementation EnterSecondTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSeparatorStyleNone;
        [self customFrame];
    }
    return self;
}

- (void)customFrame{
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getLFSInfo:) name:kServiceOrder object:nil];
    
    UILabel *modelChanceLable = [UILabel creatLableWithTitle:@"当前功能" andSuperView:self.contentView andFont:k17 andTextAligment:NSTextAlignmentCenter];
    modelChanceLable.textColor = [UIColor whiteColor];
    [modelChanceLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(kScreenW / 20);
        make.top.mas_equalTo(self.contentView.mas_top)
        .offset(10);
    }];
    
    for (int i = 0; i < kArrayCount; i++) {
        
        UIButton *btn = [self setBtnWithIndex:i];
        switch (i) {
            case 0:
                self.zhiLengBtn = btn;
                break;
            case 1:
                self.baiFengBtn = btn;
                break;
            case 2:
                self.shanJunBtn = btn;
                break;
            default:
                break;
        }
        
        UILabel *downLable = [UILabel creatLableWithTitle:[NSString stringWithFormat:@"%@" , self.array[i]] andSuperView:self.contentView andFont:k14 andTextAligment:NSTextAlignmentCenter];
        downLable.textColor = [UIColor whiteColor];
        [downLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top
            .mas_equalTo(self.contentView.mas_centerY).offset(kBtnW / 2);
            make.centerX
            .mas_equalTo(self.contentView.mas_left)
            .offset((kBtnMargin + kBtnW / 2) + i * (kBtnMargin + kBtnW));
        }];
    }
    
    
    [UIView creatBottomFenGeView:self.contentView andBackGroundColor:[UIColor whiteColor] isOrNotAllLenth:@"NO"];
    
}

#pragma mark - 设置按钮
- (UIButton *)setBtnWithIndex:(NSInteger)index {
    
    UIButton *btn = [UIButton initWithTitle:@"" andColor:[UIColor clearColor] andSuperView:self.contentView];
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kBtnW, kBtnW));
        make.centerY
        .mas_equalTo(self.contentView.mas_centerY);
        make.centerX
        .mas_equalTo(self.contentView.mas_left).offset((kBtnMargin + kBtnW / 2) + index * (kBtnMargin + kBtnW));
    }];
    
    btn.layer.borderWidth = 2;
    btn.layer.cornerRadius = kBtnW / 2;
    btn.layer.borderColor = [UIColor whiteColor].CGColor;
    [self setBtnUnSelected:btn];
    
    [self beginAnimation:btn];
    
    return btn;
}
#pragma mark - 设置按钮未选中状态
- (void)setBtnUnSelected:(UIButton *)btn {
    [btn setTitle:@"关闭" forState:UIControlStateNormal];
    [btn setImage:[UIImage new] forState:UIControlStateNormal];
    [btn removeTarget:self action:@selector(closeAtcion:) forControlEvents:UIControlEventTouchUpInside];
    [btn addTarget:self action:@selector(openAtcion:) forControlEvents:UIControlEventTouchUpInside];
}
#pragma mark - 设置按钮选中状态
- (void)setBtnSelected:(UIButton *)btn {
    [btn setImage:[UIImage imageNamed:@"已开启"] forState:UIControlStateNormal];
    [btn removeTarget:self action:@selector(openAtcion:) forControlEvents:UIControlEventTouchUpInside];
    [btn addTarget:self action:@selector(closeAtcion:) forControlEvents:UIControlEventTouchUpInside];
}
#pragma mark - 设置所有按钮未选中状态
- (void)setAllBtnUnSelected {
    [self setBtnUnSelected:self.zhiLengBtn];
    [self setBtnUnSelected:self.baiFengBtn];
    [self setBtnUnSelected:self.shanJunBtn];
}
#pragma mark - 按钮开启事件
- (void)openAtcion:(UIButton *)btn {
    
    NSString *orderStr = nil;
    if ([btn isEqual:self.zhiLengBtn]) {
        
        orderStr = [NSString stringWithFormat:@"HMFF%@%@C1#" , self.serviceModel.devTypeSn, self.serviceModel.devSn];
        
    } else if ([btn isEqual:self.baiFengBtn]) {
        
        orderStr = [NSString stringWithFormat:@"HMFF%@%@R1#" , self.serviceModel.devTypeSn, self.serviceModel.devSn];
        
    } else if ([btn isEqual:self.shanJunBtn]) {
        orderStr = [NSString stringWithFormat:@"HMFF%@%@U1#" , self.serviceModel.devTypeSn, self.serviceModel.devSn];
        
    }
    btn.tag = 1;
    [kSocketTCP sendDataToHost:orderStr andType:kZhiLing andIsNewOrOld:kOld];
}
#pragma mark - 按钮关闭事件
- (void)closeAtcion:(UIButton *)btn {
     btn.tag = 0;
    NSString *orderStr = nil;
    if ([btn isEqual:self.zhiLengBtn]) {
        orderStr = [NSString stringWithFormat:@"HMFF%@%@C0#" , self.serviceModel.devTypeSn, self.serviceModel.devSn];
    } else if ([btn isEqual:self.baiFengBtn]) {
        orderStr = [NSString stringWithFormat:@"HMFF%@%@R0#" , self.serviceModel.devTypeSn, self.serviceModel.devSn];
    } else if ([btn isEqual:self.shanJunBtn]) {
        orderStr = [NSString stringWithFormat:@"HMFF%@%@U0#" , self.serviceModel.devTypeSn, self.serviceModel.devSn];
    }
    [kSocketTCP sendDataToHost:orderStr andType:kZhiLing andIsNewOrOld:kOld];
}
#pragma mark - 动画
- (void)beginAnimation:(UIButton *)btn{
    if ([self.isAimation isEqualToString:@"YES"]) {
        btn.transform = CGAffineTransformMakeScale(0, 0);
        [UIView animateWithDuration:1 animations:^{
            btn.hidden = NO;
            btn.transform = CGAffineTransformMakeScale(1, 1);
        } completion:nil];
    }
}

#pragma mark - 取得tcp返回的数据
- (void)getLFSInfo:(NSNotification *)post {
    
    NSString *str = post.userInfo[@"Message"];
    
    if (str.length != 42) {
        return ;
    }
    
    [self setAllBtnUnSelected];
    
    NSString *baiFeng = [str substringWithRange:NSMakeRange(32,2)];
    NSString *shanJun = [str substringWithRange:NSMakeRange(34, 2)];
    NSString *zhiLeng = [str substringWithRange:NSMakeRange(38, 2)];
    NSString *devSn = [str substringWithRange:NSMakeRange(12, 12)];
    
    NSString *zhiLengState = @"==";
    NSString *baiFengState = @"==";
    if ([self.serviceModel.devSn isEqualToString:devSn])  {
        
        if ([zhiLeng isEqualToString:@"01"]) {
            zhiLengState = @"开";
            [self setBtnSelected:self.zhiLengBtn];
        } else if ([zhiLeng isEqualToString:@"02"]) {
            zhiLengState = @"关";
        }
        
        if ([baiFeng isEqualToString:@"01"]) {
            baiFengState = @"开";
            [self setBtnSelected:self.baiFengBtn];
        } else if ([baiFeng isEqualToString:@"02"]) {
            baiFengState = @"关";
        }
        
        if ([shanJun isEqualToString:@"01"]) {
            [self setBtnSelected:self.shanJunBtn];
        }
       
        NSArray *stateType = @[zhiLengState , baiFengState];
        if (_delegate && [_delegate respondsToSelector:@selector(sendStateType:)]) {
            [_delegate sendStateType:stateType];
        }
    }
}
#pragma mark - 根据服务器返回值设置按钮状态
- (void)setModel:(StateModel *)model {
    _model = model;
    
    [self setAllBtnUnSelected];
    
    if (_model.fSwing == 1) {
        [self setBtnSelected:self.baiFengBtn];
    }
    
    if (_model.fUV == 1) {
        [self setBtnSelected:self.shanJunBtn];
    }
    
    if (_model.fCold == 1) {
        [self setBtnSelected:self.zhiLengBtn];
    }
}

- (void)setServiceModel:(ServicesModel *)serviceModel {
    _serviceModel = serviceModel;
}

- (void)setIsAimation:(NSString *)isAimation {
    _isAimation = isAimation;
}

- (NSArray *)array {
    if (!_array) {
        _array = @[@"制冷加湿" , @"摆风", @"UV杀菌"];
    }
    return _array;
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
