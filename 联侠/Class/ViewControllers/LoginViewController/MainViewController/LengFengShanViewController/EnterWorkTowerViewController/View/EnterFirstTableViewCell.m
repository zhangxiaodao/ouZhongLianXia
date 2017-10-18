//
//  EnterFirstTableViewCell.m
//  AEFT冷风扇
//
//  Created by 杭州阿尔法特 on 16/3/11.
//  Copyright © 2016年 阿尔法特. All rights reserved.
//

#import "EnterFirstTableViewCell.h"

#define kBtnW (((kScreenW - kScreenW / 3) / 4) - 5)
#define kJainGe kScreenW / 7.5
#define kArrayCount self.array.count
#define kArrayCountJiaYi (self.array.count + 1)
#define kBtnMargin ((kScreenW - kArrayCount * kBtnW) / kArrayCountJiaYi)
@interface EnterFirstTableViewCell ()

@property (nonatomic , strong) NSArray *array;

@property (nonatomic , strong) UIButton *zhengChangBtn;
@property (nonatomic , strong) UIButton *ziRanBtn;
@property (nonatomic , strong) UIButton *shuMianBtn;
@property (nonatomic , strong) NSArray *xuanZhongArray;
@property (nonatomic , strong) NSArray *weiXuanZhogArray;

@property (nonatomic , strong) UIImage *normalSelectedImage;
@property (nonatomic , strong) UIImage *normalUnSelectedImage;
@property (nonatomic , strong) UIImage *ziranSelectedImage;
@property (nonatomic , strong) UIImage *ziranUnSelectedImage;
@property (nonatomic , strong) UIImage *sleepSelectedImage;
@property (nonatomic , strong) UIImage *sleepUnSelectedImage;

@end

@implementation EnterFirstTableViewCell



- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        //cell选中时的颜色
        self.selectionStyle = UITableViewCellSeparatorStyleNone;
        [self customFrame];
    }
    return self;
}

- (void)customFrame{
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getLFSInfo:) name:kServiceOrder object:nil];

    
    [UIView creatBottomFenGeView:self.contentView andBackGroundColor:[UIColor whiteColor] isOrNotAllLenth:@"NO"];
    
    
    UILabel *modelChanceLable = [UILabel creatLableWithTitle:@"当前模式" andSuperView:self.contentView andFont:k17 andTextAligment:NSTextAlignmentCenter];
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
                self.zhengChangBtn = btn;
                break;
            case 1:
                self.ziRanBtn = btn;
                break;
            case 2:
                self.shuMianBtn = btn;
                break;
            default:
                break;
        }
        
        UILabel *downLable = [UILabel creatLableWithTitle:self.array[i] andSuperView:self.contentView andFont:k14 andTextAligment:NSTextAlignmentCenter];
        downLable.textColor = [UIColor whiteColor];
        [downLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.contentView.mas_centerY)
            .offset(kBtnW / 2);
            make.centerX.mas_equalTo(btn.mas_centerX);
        }];
    }

}

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
    btn.layer.cornerRadius = 10;
    btn.layer.borderColor = [UIColor whiteColor].CGColor;
    
    NSString *imageStr = self.weiXuanZhogArray[index];
    [btn setImage:[UIImage imageNamed:imageStr] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(stateBtnAtcion:) forControlEvents:UIControlEventTouchUpInside];
    [self beginAnimation:btn];
    
    return btn;
}

- (void)stateBtnAtcion:(UIButton *)btn{
    NSString *orderStr = nil;
    if ([btn isEqual:self.ziRanBtn]) {
        orderStr = [NSString stringWithFormat:@"HMFF%@%@M2#" , self.serviceModel.devTypeSn, self.serviceModel.devSn];
    } else if ([btn isEqual:self.shuMianBtn]) {
        orderStr = [NSString stringWithFormat:@"HMFF%@%@M3#" , self.serviceModel.devTypeSn, self.serviceModel.devSn];
    } else if ([btn isEqual:self.zhengChangBtn]) {
        orderStr = [NSString stringWithFormat:@"HMFF%@%@M1#" , self.serviceModel.devTypeSn, self.serviceModel.devSn];
        
    }
    [kSocketTCP sendDataToHost:orderStr andType:kZhiLing andIsNewOrOld:kOld];
}
#pragma mark - 设置按钮未选中图片
- (void)setAllBtnUnSlected {
    [self.ziRanBtn setImage:self.ziranUnSelectedImage forState:UIControlStateNormal];
    [self.shuMianBtn setImage:self.sleepUnSelectedImage forState:UIControlStateNormal];
    [self.zhengChangBtn setImage:self.normalUnSelectedImage forState:UIControlStateNormal];
}
#pragma mark - 设置btn 图片
- (void)btn:(UIButton *)btn selectedImage:(UIImage *)image {
    [btn setImage:image forState:UIControlStateNormal];
}

#pragma mark - 取得tcp返回的数据
- (void)getLFSInfo:(NSNotification *)post {

    NSString *str = post.userInfo[@"Message"];
    if (str.length != 42) {
        return ;
    }
    NSString *model = [str substringWithRange:NSMakeRange(28 , 2)];
    NSString *devSn = [str substringWithRange:NSMakeRange(12, 12)];
    
    NSString *modelType = @"==";
    if ([self.serviceModel.devSn isEqualToString:devSn])  {
        
        [self setAllBtnUnSlected];
        
         if ([model isEqualToString:@"02"]) {
             [self btn:self.ziRanBtn selectedImage:self.ziranSelectedImage];
            modelType = @"自然风";
        } else if ([model isEqualToString:@"03"]) {
            [self btn:self.shuMianBtn selectedImage:self.sleepSelectedImage];
            modelType = @"睡眠风";
            
        } else if ([model isEqualToString:@"01"]) {
            [self btn:self.zhengChangBtn selectedImage:self.normalSelectedImage];
            modelType = @"正常风";
        }

        if (_delegate && [_delegate respondsToSelector:@selector(sendTheModelType:)]) {
            [_delegate sendTheModelType:modelType];
        }
    }
}

- (void)beginAnimation:(UIButton *)btn{
    if ([self.isAnimation isEqualToString:@"YES"]) {
        btn.transform = CGAffineTransformMakeScale(0, 0);
        [UIView animateWithDuration:1 animations:^{
            btn.hidden = NO;
            btn.transform = CGAffineTransformMakeScale(1, 1);
        } completion:nil];
    }
}


- (void)setModel:(StateModel *)model {
    _model = model;
    [self setAllBtnUnSlected];
    if (_model.fMode == 1) {
        [self btn:self.zhengChangBtn selectedImage:self.normalSelectedImage];
    } else if (_model.fMode == 2) {
        [self btn:self.ziRanBtn selectedImage:self.ziranSelectedImage];
    } else if (_model.fMode == 3) {
        [self btn:self.shuMianBtn selectedImage:self.sleepSelectedImage];
    }
}

- (void)setServiceModel:(ServicesModel *)serviceModel {
    _serviceModel = serviceModel;
}

- (void)setIsAnimation:(NSString *)isAnimation {
    _isAnimation = isAnimation;
}

- (UIImage *)normalSelectedImage {
    if (!_normalSelectedImage) {
        _normalSelectedImage = [UIImage imageNamed:self.xuanZhongArray[0]];
    }
    return _normalSelectedImage;
}
- (UIImage *)normalUnSelectedImage {
    if (!_normalUnSelectedImage) {
        _normalUnSelectedImage = [UIImage imageNamed:self.weiXuanZhogArray[0]];
    }
    return _normalUnSelectedImage;
}

- (UIImage *)ziranSelectedImage {
    if (!_ziranSelectedImage) {
        _ziranSelectedImage = [UIImage imageNamed:self.xuanZhongArray[1]];
    }
    return _ziranSelectedImage;
}
- (UIImage *)ziranUnSelectedImage {
    if (!_ziranUnSelectedImage) {
        _ziranUnSelectedImage = [UIImage imageNamed:self.weiXuanZhogArray[1]];
    }
    return _ziranUnSelectedImage;
}
- (UIImage *)sleepSelectedImage {
    if (!_sleepSelectedImage) {
        _sleepSelectedImage = [UIImage imageNamed:self.xuanZhongArray[2]];
    }
    return _sleepSelectedImage;
}
- (UIImage *)sleepUnSelectedImage {
    if (!_sleepUnSelectedImage) {
        _sleepUnSelectedImage = [UIImage imageNamed:self.weiXuanZhogArray[2]];
    }
    return _sleepUnSelectedImage;
}

- (NSArray *)xuanZhongArray {
    if (!_xuanZhongArray) {
        _xuanZhongArray = [NSArray arrayWithObjects:@"normalSelected", @"ziranSelected" , @"sleepSelected" ,  nil];
    }
    return _xuanZhongArray;
}

- (NSArray *)weiXuanZhogArray {
    if (!_weiXuanZhogArray) {
        _weiXuanZhogArray = [NSArray arrayWithObjects:@"normal", @"ziranNormal" , @"sleepNormal", nil];
    }
    return _weiXuanZhogArray;
}

- (NSArray *)array {
    if (!_array) {
        _array = @[@"正常风", @"自然风" , @"睡眠风"];
    }
    return _array;
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
