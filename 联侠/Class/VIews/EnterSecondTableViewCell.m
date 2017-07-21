//
//  EnterSecondTableViewCell.m
//  AEFT冷风扇
//
//  Created by 杭州阿尔法特 on 16/3/11.
//  Copyright © 2016年 阿尔法特. All rights reserved.
//

#import "EnterSecondTableViewCell.h"

#define kArrayCount _array.count
#define kArrayCountJiaYi (_array.count + 1)
#define kBtnW (((kScreenW - kScreenW / 3) / 4) - 5)
@interface EnterSecondTableViewCell ()
@property (nonatomic , copy) NSString *isSelected;
@property (nonatomic , strong) NSArray *array;
@end

@implementation EnterSecondTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        //cell选中时的颜色
        self.selectionStyle = UITableViewCellSeparatorStyleNone;
        
        [self customFrame];
        
    }
    
    return self;
}

#pragma mark - 通知获取空气净化的状态
- (void)getKongJingBtn:(NSNotification *)post {
    NSLog(@"%@" , post.userInfo[@"isSelect"]);
    self.isSelected = [NSString stringWithString:post.userInfo[@"isSelect"]];
    if ([self.isSelected isEqualToString:@"YES"]) {
        
        [kSocketTCP sendDataToHost:[NSString stringWithFormat:@"HMFF%@%@C0#" , self.serviceModel.devTypeSn, self.serviceModel.devSn] andType:kZhiLing andIsNewOrOld:kOld];
        
        self.zhiLengBtn.userInteractionEnabled = NO;
        [self.zhiLengBtn setTitle:@"关闭" forState:UIControlStateNormal];
        [self.zhiLengBtn setImage:[UIImage new] forState:UIControlStateNormal];
        
    } else {
        self.zhiLengBtn.userInteractionEnabled = YES;
    }
}

- (void)customFrame{
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getData66666765:) name:@"4131" object:nil];
    
    UILabel *modelChanceLable = [UILabel creatLableWithTitle:@"当前功能" andSuperView:self.contentView andFont:k17 andTextAligment:NSTextAlignmentCenter];
    modelChanceLable.textColor = [UIColor whiteColor];
    modelChanceLable.layer.borderWidth = 0;
    [modelChanceLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kScreenW / 5.3571, kScreenH / 33.35));
        make.left.mas_equalTo(kScreenW / 20);
        make.top.mas_equalTo(self.contentView.mas_top).offset(10);
    }];
    
    _array = [NSArray arrayWithObjects:@"制冷加湿" , @"摆风", @"UV杀菌", nil];
    
    for (int i = 0; i < kArrayCount; i++) {
        
        UILabel *downLable = [UILabel creatLableWithTitle:[NSString stringWithFormat:@"%@" , _array[i]] andSuperView:self.contentView andFont:k14 andTextAligment:NSTextAlignmentCenter];
        downLable.textColor = [UIColor whiteColor];
        downLable.layer.borderWidth = 0;
        [downLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(kBtnW , kScreenW / 15));
            make.top.mas_equalTo(self.contentView.mas_centerY).offset(kBtnW / 2);
            make.centerX.mas_equalTo(self.contentView.mas_left).offset(((kScreenW - kArrayCount * kBtnW) / kArrayCountJiaYi + kBtnW / 2) + i * ((kScreenW - kArrayCount * kBtnW) / kArrayCountJiaYi + kBtnW));
        }];
    }
    
    
    [UIView creatBottomFenGeView:self.contentView andBackGroundColor:[UIColor whiteColor] isOrNotAllLenth:@"NO"];
    
}

- (void)setzhiLengBtnWithSelected:(NSInteger) isSelected {
    self.zhiLengBtn = [UIButton initWithTitle:@""  andColor:[UIColor clearColor] andSuperView:self.contentView];
    //    self.zhiLengBtn.titleLabel.font = [UIFont systemFontOfSize:k14];
    [self.zhiLengBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kBtnW, kBtnW));
        make.left.mas_equalTo((kScreenW - kArrayCount * kBtnW) / kArrayCountJiaYi);
        
        make.centerY.mas_equalTo(self.contentView.mas_centerY);
    }];
    self.zhiLengBtn.selected = isSelected;
    self.zhiLengBtn.layer.borderWidth = 2;
    self.zhiLengBtn.layer.borderColor = [UIColor whiteColor].CGColor;
    
    
    self.zhiLengBtn.layer.cornerRadius = kBtnW / 2;
    [self beginAnimation:self.zhiLengBtn];
    
    
    
    if (self.zhiLengBtn.selected == 1) {
        [self.zhiLengBtn setImage:[UIImage imageNamed:@"已开启"] forState:UIControlStateNormal];
        [self.zhiLengBtn addTarget:self action:@selector(btnAtcion3456:) forControlEvents:UIControlEventTouchUpInside];
    } else {
        [self.zhiLengBtn setTitle:@"关闭" forState:UIControlStateNormal];
        [self.zhiLengBtn setImage:[UIImage new] forState:UIControlStateNormal];
        [self.zhiLengBtn addTarget:self action:@selector(btnAtcion2:) forControlEvents:UIControlEventTouchUpInside];
    }
    
}


- (void)setbaiFengBtnWithSelected:(NSInteger) isSelected {
    self.baiFengBtn = [UIButton initWithTitle:@"关闭"  andColor:[UIColor clearColor] andSuperView:self.contentView];
    //    self.baiFengBtn.titleLabel.font = [UIFont systemFontOfSize:k14];
    [self.baiFengBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kBtnW, kBtnW));
        make.left.mas_equalTo(kBtnW * 1 + ((kScreenW - kArrayCount * kBtnW) / kArrayCountJiaYi) * (1 + 1));
        make.centerY.mas_equalTo(self.contentView.mas_centerY);
    }];
    self.baiFengBtn.selected = isSelected;
    self.baiFengBtn.layer.borderWidth = 2;
    self.baiFengBtn.layer.borderColor = [UIColor whiteColor].CGColor;
    
    
    self.baiFengBtn.layer.cornerRadius = kBtnW / 2;
    [self beginAnimation:self.baiFengBtn];
    if (self.baiFengBtn.selected == 1) {
        [self.baiFengBtn setImage:[UIImage imageNamed:@"已开启"] forState:UIControlStateNormal];
        [self.baiFengBtn addTarget:self action:@selector(btnAtcion2:) forControlEvents:UIControlEventTouchUpInside];
    } else {
        [self.baiFengBtn setTitle:@"关闭" forState:UIControlStateNormal];
        [self.baiFengBtn setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
        [self.baiFengBtn addTarget:self action:@selector(btnAtcion3456:) forControlEvents:UIControlEventTouchUpInside];
    }
    
}

- (void)setshanJunBtnWithSelected:(NSInteger)isSelected {
    self.shanJunBtn = [UIButton initWithTitle:@"关闭"  andColor:[UIColor clearColor] andSuperView:self.contentView];
    //    self.shanJunBtn.titleLabel.font = [UIFont systemFontOfSize:k14];
    [self.shanJunBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kBtnW, kBtnW));
        make.left.mas_equalTo(kBtnW * 2 + ((kScreenW - kArrayCount * kBtnW) / kArrayCountJiaYi) * (2 + 1));
        make.centerY.mas_equalTo(self.contentView.mas_centerY);
    }];
    self.shanJunBtn.selected = isSelected;
    self.shanJunBtn.layer.borderWidth = 2;
    self.shanJunBtn.layer.borderColor = [UIColor whiteColor].CGColor;
    
    
    self.shanJunBtn.layer.cornerRadius = kBtnW / 2;
    [self beginAnimation:self.shanJunBtn];
    if (self.shanJunBtn.selected == 1) {
        [self.shanJunBtn setImage:[UIImage imageNamed:@"已开启"] forState:UIControlStateNormal];
        [self.shanJunBtn addTarget:self action:@selector(btnAtcion2:) forControlEvents:UIControlEventTouchUpInside];
    } else {
        [self.shanJunBtn setTitle:@"关闭" forState:UIControlStateNormal];
        [self.shanJunBtn setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
        [self.shanJunBtn addTarget:self action:@selector(btnAtcion3456:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    
    
}


- (void)btnAtcion3456:(UIButton *)btn {
    
    if ([btn isEqual:self.zhiLengBtn]) {
        
        [kSocketTCP sendDataToHost:[NSString stringWithFormat:@"HMFF%@%@C1#" , self.serviceModel.devTypeSn, self.serviceModel.devSn] andType:kZhiLing andIsNewOrOld:kOld];
        
    } else if ([btn isEqual:self.baiFengBtn]) {
        
        [kSocketTCP sendDataToHost:[NSString stringWithFormat:@"HMFF%@%@R1#" , self.serviceModel.devTypeSn, self.serviceModel.devSn] andType:kZhiLing andIsNewOrOld:kOld];
        
    } else if ([btn isEqual:self.shanJunBtn]) {        [kSocketTCP sendDataToHost:[NSString stringWithFormat:@"HMFF%@%@U1#" , self.serviceModel.devTypeSn, self.serviceModel.devSn] andType:kZhiLing andIsNewOrOld:kOld];
        
    }
    
    btn.tag = 1;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getData66666765:) name:@"4131" object:nil];
}

- (void)btnAtcion2:(UIButton *)btn {
     btn.tag = 0;
    if ([btn isEqual:self.zhiLengBtn]) {
        
        [kSocketTCP sendDataToHost:[NSString stringWithFormat:@"HMFF%@%@C0#" , self.serviceModel.devTypeSn, self.serviceModel.devSn] andType:kZhiLing andIsNewOrOld:kOld];
        
    } else if ([btn isEqual:self.baiFengBtn]) {
        
        [kSocketTCP sendDataToHost:[NSString stringWithFormat:@"HMFF%@%@R0#" , self.serviceModel.devTypeSn, self.serviceModel.devSn] andType:kZhiLing andIsNewOrOld:kOld];
    } else if ([btn isEqual:self.shanJunBtn]) {
        
        [kSocketTCP sendDataToHost:[NSString stringWithFormat:@"HMFF%@%@U0#" , self.serviceModel.devTypeSn, self.serviceModel.devSn] andType:kZhiLing andIsNewOrOld:kOld];
    }
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getData66666765:) name:@"4131" object:nil];
}
- (void)beginAnimation:(UIButton *)btn{
    
    
    if ([self.isAimation isEqualToString:@"YES"]) {
        btn.transform = CGAffineTransformMakeScale(0, 0);
        [UIView animateWithDuration:1 animations:^{
            btn.hidden = NO;
            btn.transform = CGAffineTransformMakeScale(1, 1);
        } completion:^(BOOL finished) {
            
        }];
    }
   
}

#pragma mark - 取得tcp返回的数据
- (void)getData66666765:(NSNotification *)post {
    
    
    NSString *str = post.userInfo[@"Message"];
    
    NSString *baiFeng = [str substringWithRange:NSMakeRange(32,2)];
    NSString *shanJun = [str substringWithRange:NSMakeRange(34, 2)];
    NSString *zhiLeng = [str substringWithRange:NSMakeRange(38, 2)];
  
    NSString *devSn = [str substringWithRange:NSMakeRange(12, 12)];
    
    
    NSString *zhiLengState = nil;
    NSString *baiFengState = nil;
    if ([self.serviceModel.devSn isEqualToString:devSn])  {
        if ([zhiLeng isEqualToString:@"01"]) {
            [self.zhiLengBtn setImage:[UIImage imageNamed:@"已开启"] forState:UIControlStateNormal];
            zhiLengState = @"开";
            [self.zhiLengBtn removeTarget:nil action:nil forControlEvents:UIControlEventTouchUpInside];
            [self.zhiLengBtn addTarget:self action:@selector(btnAtcion2:) forControlEvents:UIControlEventTouchUpInside];
            
        } else if ([zhiLeng isEqualToString:@"02"]) {
            [self.zhiLengBtn setTitle:@"关闭" forState:UIControlStateNormal];
            [self.zhiLengBtn setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
            zhiLengState = @"关";
            
            [self.zhiLengBtn removeTarget:nil action:nil forControlEvents:UIControlEventTouchUpInside];
            [self.zhiLengBtn addTarget:self action:@selector(btnAtcion3456:) forControlEvents:UIControlEventTouchUpInside];
        }
        if ([baiFeng isEqualToString:@"01"]) {
            [self.baiFengBtn setImage:[UIImage imageNamed:@"已开启"] forState:UIControlStateNormal];
            baiFengState = @"开";
            [self.baiFengBtn removeTarget:nil action:nil forControlEvents:UIControlEventTouchUpInside];
            [self.baiFengBtn addTarget:self action:@selector(btnAtcion2:) forControlEvents:UIControlEventTouchUpInside];
        } else if ([baiFeng isEqualToString:@"02"]) {
            [self.baiFengBtn setTitle:@"关闭"  forState:UIControlStateNormal];
            baiFengState = @"关";
            [self.baiFengBtn setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
            [self.baiFengBtn removeTarget:nil action:nil forControlEvents:UIControlEventTouchUpInside];
            [self.baiFengBtn addTarget:self action:@selector(btnAtcion3456:) forControlEvents:UIControlEventTouchUpInside];
        }
        if ([shanJun isEqualToString:@"01"]) {
            [self.shanJunBtn setImage:[UIImage imageNamed:@"已开启"] forState:UIControlStateNormal];
            
            [self.shanJunBtn removeTarget:nil action:nil forControlEvents:UIControlEventTouchUpInside];
            [self.shanJunBtn addTarget:self action:@selector(btnAtcion2:) forControlEvents:UIControlEventTouchUpInside];
        } else if ([shanJun isEqualToString:@"02"]) {
            [self.shanJunBtn setTitle:@"关闭"  forState:UIControlStateNormal];
            [self.shanJunBtn setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
            [self.shanJunBtn removeTarget:nil action:nil forControlEvents:UIControlEventTouchUpInside];
            [self.shanJunBtn addTarget:self action:@selector(btnAtcion3456:) forControlEvents:UIControlEventTouchUpInside];
        }
        //    if ([tongSong isEqualToString:@"01"]) {
        //        [self.tongSuoBtn setImage:[UIImage imageNamed:@"已开启"] forState:UIControlStateNormal];
        //        [self.tongSuoBtn removeTarget:nil action:nil forControlEvents:UIControlEventTouchUpInside];
        //        [self.tongSuoBtn addTarget:self action:@selector(btnAtcion2:) forControlEvents:UIControlEventTouchUpInside];
        //    } else if ([tongSong isEqualToString:@"02"]) {
        //        [self.tongSuoBtn setTitle:@"关闭" forState:UIControlStateNormal];
        //        [self.tongSuoBtn setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
        //        [self.tongSuoBtn removeTarget:nil action:nil forControlEvents:UIControlEventTouchUpInside];
        //        [self.tongSuoBtn addTarget:self action:@selector(btnAtcion3456:) forControlEvents:UIControlEventTouchUpInside];
        //    }
        //    
        //    

        NSArray *stateType = @[[NSString stringWithFormat:@"%@" , zhiLengState] , [NSString stringWithFormat:@"%@" , baiFengState]];
        if (_delegate && [_delegate respondsToSelector:@selector(sendStateType:)]) {
            [_delegate sendStateType:stateType];
        }
        
    }
    
}

- (void)setModel:(StateModel *)model {
    
    if (model.fSwing == 1) {
        [self.baiFengBtn removeFromSuperview];
        [self setbaiFengBtnWithSelected:YES];
    } else {
        [self.baiFengBtn removeFromSuperview];
        [self setbaiFengBtnWithSelected:NO];
    }
    
    if (model.fUV == 1) {
        [self.shanJunBtn removeFromSuperview];
        [self setshanJunBtnWithSelected:YES];
    } else {
        [self.shanJunBtn removeFromSuperview];
        [self setshanJunBtnWithSelected:NO];
    }
    
    if (model.fCold == 1) {
        [self.zhiLengBtn removeFromSuperview];
        [self setzhiLengBtnWithSelected:YES];
    } else {
        [self.zhiLengBtn removeFromSuperview];
        [self setzhiLengBtnWithSelected:NO];
    }
    
    
}

- (void)setServiceModel:(ServicesModel *)serviceModel {
    _serviceModel = serviceModel;
}

- (void)setIsAimation:(NSString *)isAimation {
    _isAimation = isAimation;
}

@end
