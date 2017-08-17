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

@interface EnterFirstTableViewCell ()
@property (nonatomic , strong) StateModel *stateModel;
@property (nonatomic , strong) NSArray *array;

@property (nonatomic , strong) UIButton *zhengChangBtn;
@property (nonatomic , strong) UIButton *jingHuaBtn;
@property (nonatomic , strong) UIButton *ziRanBtn;
@property (nonatomic , strong) UIButton *shuMianBtn;
@property (nonatomic , strong) NSArray *xuanZhongArray;
@property (nonatomic , strong) NSArray *weiXuanZhogArray;

@property (nonatomic , strong) NSMutableArray *imageArray;
@end

@implementation EnterFirstTableViewCell

- (NSMutableArray *)imageArray {
    if (!_imageArray) {
        _imageArray = [NSMutableArray array];
        
        UIImage *jingHuaImage = [UIImage imageNamed:[NSString stringWithFormat:@"%@" , self.xuanZhongArray[1]]];
        UIImage *ziRanImage = [UIImage imageNamed:[NSString stringWithFormat:@"%@" , self.xuanZhongArray[2]]];
        UIImage *shuiMianImage = [UIImage imageNamed:[NSString stringWithFormat:@"%@" , self.xuanZhongArray[3]]];
        UIImage *zhengChangImage = [UIImage imageNamed:[NSString stringWithFormat:@"%@" , self.xuanZhongArray[0]]];
        
        UIImage *jingHuaImage1 = [UIImage imageNamed:[NSString stringWithFormat:@"%@" , self.weiXuanZhogArray[1]]];
        UIImage *ziRanImage1 = [UIImage imageNamed:[NSString stringWithFormat:@"%@" , self.weiXuanZhogArray[2]]];
        UIImage *shuiMianImage1 = [UIImage imageNamed:[NSString stringWithFormat:@"%@" , self.weiXuanZhogArray[3]]];
        UIImage *zhengChangImage1 = [UIImage imageNamed:[NSString stringWithFormat:@"%@" , self.weiXuanZhogArray[0]]];
        NSArray *aaa = @[jingHuaImage , ziRanImage , shuiMianImage , zhengChangImage , jingHuaImage1 , ziRanImage1 , shuiMianImage1 , zhengChangImage1];
        [_imageArray addObjectsFromArray:aaa];
    }
    return _imageArray;
}

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
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getDate444444444:) name:kServiceOrder object:nil];

    
    [UIView creatBottomFenGeView:self.contentView andBackGroundColor:[UIColor whiteColor] isOrNotAllLenth:@"NO"];
    
    
    UILabel *modelChanceLable = [UILabel creatLableWithTitle:@"当前模式" andSuperView:self.contentView andFont:k17 andTextAligment:NSTextAlignmentCenter];
    modelChanceLable.textColor = [UIColor whiteColor];
    modelChanceLable.layer.borderWidth = 0;
    [modelChanceLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kScreenW / 5.3571, kScreenH / 33.35));
        make.left.mas_equalTo(kScreenW / 20);
        make.top.mas_equalTo(self.contentView.mas_top).offset(10);
    }];
    

    self.array = @[@"正常风", @"自然风" , @"睡眠风" ];
    
    for (int i = 0; i < kArrayCount; i++) {
        UILabel *downLable = [UILabel creatLableWithTitle:[NSString stringWithFormat:@"%@" , self.array[i]] andSuperView:self.contentView andFont:k14 andTextAligment:NSTextAlignmentCenter];
        downLable.textColor = [UIColor whiteColor];
        downLable.layer.borderWidth = 0;
        downLable.tag = i;
        
        [downLable mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.size.mas_equalTo(CGSizeMake(kBtnW , kScreenW / 15));
            make.top.mas_equalTo(self.contentView.mas_centerY).offset(kBtnW / 2);
            make.centerX.mas_equalTo(self.contentView.mas_left).offset(((kScreenW - kArrayCount * kBtnW) / kArrayCountJiaYi + kBtnW / 2) + i * ((kScreenW - kArrayCount * kBtnW) / kArrayCountJiaYi + kBtnW));
        }];
    }

}

- (void)stateBtnAtcion:(UIButton *)btn{
   
    if ([btn isEqual:self.jingHuaBtn]) {
        [UIAlertController creatRightAlertControllerWithHandle:^{
        [[NSNotificationCenter defaultCenter] postNotification:[NSNotification notificationWithName:@"KongJing" object:self userInfo:@{@"isSelect" : @"YES"}]];
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [kSocketTCP sendDataToHost:[NSString stringWithFormat:@"HMFF%@%@M4#" , self.serviceModel.devTypeSn, self.serviceModel.devSn] andType:kZhiLing andIsNewOrOld:kOld];
        });
        
    } andSuperViewController:self.currentVC Title:@"请确认您已经更换空气净化滤网"];
        
    }
    
    if ([btn isEqual:self.ziRanBtn]) {
        
        [kSocketTCP sendDataToHost:[NSString stringWithFormat:@"HMFF%@%@M2#" , self.serviceModel.devTypeSn, self.serviceModel.devSn] andType:kZhiLing andIsNewOrOld:kOld];
        
    } else if ([btn isEqual:self.shuMianBtn]) {
        [kSocketTCP sendDataToHost:[NSString stringWithFormat:@"HMFF%@%@M3#" , self.serviceModel.devTypeSn, self.serviceModel.devSn] andType:kZhiLing andIsNewOrOld:kOld];
        
    } else if ([btn isEqual:self.zhengChangBtn]) {
        [kSocketTCP sendDataToHost:[NSString stringWithFormat:@"HMFF%@%@M1#" , self.serviceModel.devTypeSn, self.serviceModel.devSn] andType:kZhiLing andIsNewOrOld:kOld];
    }
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getDate444444444:) name:kServiceOrder object:nil];
}

#pragma mark - 取得tcp返回的数据
- (void)getDate444444444:(NSNotification *)post {

    NSString *str = post.userInfo[@"Message"];
    NSString *model = [str substringWithRange:NSMakeRange(28 , 2)];
    
    NSString *devSn = [str substringWithRange:NSMakeRange(12, 12)];
    
    NSString *modelType = @"==";
    if ([self.serviceModel.devSn isEqualToString:devSn])  {
        
        UIImage *jingHuaImage = self.imageArray[0];
        UIImage *ziRanImage = self.imageArray[1];
        UIImage *shuiMianImage = self.imageArray[2];
        UIImage *zhengChangImage = self.imageArray[3];
        
        UIImage *jingHuaImage1 = self.imageArray[4];
        UIImage *ziRanImage1 = self.imageArray[5];
        UIImage *shuiMianImage1 = self.imageArray[6];
        UIImage *zhengChangImage1 = self.imageArray[7];
        
        
        
        if ([model isEqualToString:@"04"]) {
            [self setFourBtnImageWithJingHuaBtnImage:jingHuaImage withZiRanBtn:ziRanImage1 withShuMianBtn:shuiMianImage1 withZhengChangBtn:zhengChangImage1];
            
            modelType = @"空净";
        } else if ([model isEqualToString:@"02"]) {
       
            [self setFourBtnImageWithJingHuaBtnImage:jingHuaImage1 withZiRanBtn:ziRanImage withShuMianBtn:shuiMianImage1 withZhengChangBtn:zhengChangImage1];
            modelType = @"自然风";
        } else if ([model isEqualToString:@"03"]) {
            [self setFourBtnImageWithJingHuaBtnImage:jingHuaImage1 withZiRanBtn:ziRanImage1 withShuMianBtn:shuiMianImage withZhengChangBtn:zhengChangImage1];
            modelType = @"睡眠风";
            
        } else if ([model isEqualToString:@"01"]) {
            [self setFourBtnImageWithJingHuaBtnImage:jingHuaImage1 withZiRanBtn:ziRanImage1 withShuMianBtn:shuiMianImage1 withZhengChangBtn:zhengChangImage];
            modelType = @"正常风";
            
        }

        if (_delegate && [_delegate respondsToSelector:@selector(sendTheModelType:)]) {
            [_delegate sendTheModelType:modelType];
        }
        
        
    }
   
    
}

- (void)setFourBtnImageWithJingHuaBtnImage:(UIImage *)jingHuaBtnImage withZiRanBtn:(UIImage *)ziRanBtnImage withShuMianBtn:(UIImage *)shuMianBtnImage withZhengChangBtn:(UIImage *)zhengChangBtnImage {
    [self.jingHuaBtn setImage:jingHuaBtnImage forState:UIControlStateNormal];
    [self.ziRanBtn setImage:ziRanBtnImage forState:UIControlStateNormal];
    [self.shuMianBtn setImage:shuMianBtnImage forState:UIControlStateNormal];
    [self.zhengChangBtn setImage:zhengChangBtnImage forState:UIControlStateNormal];
}

- (void)setZhengChangBtnWithSelected:(NSInteger)aaa {
    self.xuanZhongArray = [NSArray arrayWithObjects: @"正常风" ,@"空气净化", @"自然风" , @"睡眠风" , nil];
    self.weiXuanZhogArray = [NSArray arrayWithObjects:@"正常风1",@"空气净化1", @"自然风1" , @"睡眠风1" ,  nil];
    
    
    self.zhengChangBtn = [UIButton initWithTitle:@"" andColor:[UIColor clearColor] andSuperView:self.contentView];
    self.zhengChangBtn.layer.borderWidth = 2;
    self.zhengChangBtn.layer.cornerRadius = 10;
    self.zhengChangBtn.layer.borderColor = [UIColor whiteColor].CGColor;
    self.zhengChangBtn.tag = 1;
    self.zhengChangBtn.selected = aaa;
    
    if (self.zhengChangBtn.selected == 1) {
        UIImage *jingHuaImage = [UIImage imageNamed:[NSString stringWithFormat:@"%@" , self.xuanZhongArray[0]]];
        
        [self.zhengChangBtn setImage:jingHuaImage forState:UIControlStateNormal];
    } else {
        [self.zhengChangBtn setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@" , self.weiXuanZhogArray[0]]] forState:UIControlStateNormal];
    }
    [self.zhengChangBtn addTarget:self action:@selector(stateBtnAtcion:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.zhengChangBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kBtnW, kBtnW));
        make.centerY.mas_equalTo(self.contentView.mas_centerY);
        make.centerX.mas_equalTo(self.contentView.mas_left).offset(((kScreenW - kArrayCount * kBtnW) / kArrayCountJiaYi + kBtnW / 2) + 0 * ((kScreenW - kArrayCount * kBtnW) / kArrayCountJiaYi + kBtnW));
    }];
    
    [self beginAnimation:self.zhengChangBtn];
   

}

- (void)setZiRanBtnWithSelected:(NSInteger)aaa {
    self.xuanZhongArray = [NSArray arrayWithObjects: @"正常风" ,@"空气净化", @"自然风" , @"睡眠风" , nil];
    self.weiXuanZhogArray = [NSArray arrayWithObjects:@"正常风1",@"空气净化1", @"自然风1" , @"睡眠风1" ,  nil];
    
    
    self.ziRanBtn = [UIButton initWithTitle:@"" andColor:[UIColor clearColor] andSuperView:self.contentView];
    self.ziRanBtn.layer.borderWidth = 2;
    self.ziRanBtn.layer.cornerRadius = 10;
    self.ziRanBtn.layer.borderColor = [UIColor whiteColor].CGColor;
    self.ziRanBtn.tag = 1;
    self.ziRanBtn.selected = aaa;

    if (self.ziRanBtn.selected == 1) {
        UIImage *jingHuaImage = [UIImage imageNamed:[NSString stringWithFormat:@"%@" , self.xuanZhongArray[2]]];
        
        [self.ziRanBtn setImage:jingHuaImage forState:UIControlStateNormal];
    } else {
        [self.ziRanBtn setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@" , self.weiXuanZhogArray[2]]] forState:UIControlStateNormal];
    }
    [self.ziRanBtn addTarget:self action:@selector(stateBtnAtcion:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.ziRanBtn mas_makeConstraints:^(MASConstraintMaker *make) {

        make.centerX.mas_equalTo(self.contentView.mas_left).offset(((kScreenW - kArrayCount * kBtnW) / kArrayCountJiaYi + kBtnW / 2) + 1 * ((kScreenW - kArrayCount * kBtnW) / kArrayCountJiaYi + kBtnW));
        
        make.size.mas_equalTo(CGSizeMake(kBtnW, kBtnW));
        make.centerY.mas_equalTo(self.contentView.mas_centerY);
        
    }];
    
    
    
    [self beginAnimation:self.ziRanBtn];
    
    
}

- (void)setShuiMianBtnWithSelected:(NSInteger)aaa {
    
    self.xuanZhongArray = [NSArray arrayWithObjects: @"正常风" ,@"空气净化", @"自然风" , @"睡眠风" , nil];
    self.weiXuanZhogArray = [NSArray arrayWithObjects:@"正常风1",@"空气净化1", @"自然风1" , @"睡眠风1" ,  nil];
    
    
    self.shuMianBtn = [UIButton initWithTitle:@"" andColor:[UIColor clearColor] andSuperView:self.contentView];
    self.shuMianBtn.layer.borderWidth = 2;
    self.shuMianBtn.layer.cornerRadius = 10;
    self.shuMianBtn.layer.borderColor = [UIColor whiteColor].CGColor;
    self.shuMianBtn.tag = 2;
    self.shuMianBtn.selected = aaa;

    if (self.shuMianBtn.selected == 1) {
        UIImage *jingHuaImage = [UIImage imageNamed:[NSString stringWithFormat:@"%@" , self.xuanZhongArray[3]]];
        
        [self.shuMianBtn setImage:jingHuaImage forState:UIControlStateNormal];
    } else {
        [self.shuMianBtn setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@" , self.weiXuanZhogArray[3]]] forState:UIControlStateNormal];
    }
    [self.shuMianBtn addTarget:self action:@selector(stateBtnAtcion:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.shuMianBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.size.mas_equalTo(CGSizeMake(kBtnW, kBtnW));
        make.centerY.mas_equalTo(self.contentView.mas_centerY);
        make.centerX.mas_equalTo(self.contentView.mas_left).offset(((kScreenW - kArrayCount * kBtnW) / kArrayCountJiaYi + kBtnW / 2) + 2 * ((kScreenW - kArrayCount * kBtnW) / kArrayCountJiaYi + kBtnW));
        
    }];
    
    [self beginAnimation:self.shuMianBtn];
    
}

- (void)beginAnimation:(UIButton *)btn{
    
    
    if ([self.isAnimation isEqualToString:@"YES"]) {
        btn.transform = CGAffineTransformMakeScale(0, 0);
        [UIView animateWithDuration:1 animations:^{
            btn.hidden = NO;
            btn.transform = CGAffineTransformMakeScale(1, 1);
        } completion:^(BOOL finished) {
            
        }];
    }
    
}

- (void)setModel:(StateModel *)model {
    
    if (model.fMode == 2) {
        [self.ziRanBtn removeFromSuperview];
        [self setZiRanBtnWithSelected:YES];
    } else {
        [self.ziRanBtn removeFromSuperview];
        [self setZiRanBtnWithSelected:NO];
    }
    
    if (model.fMode == 3) {
        [self.shuMianBtn removeFromSuperview];
        [self setShuiMianBtnWithSelected:YES];
    } else {
        [self.shuMianBtn removeFromSuperview];
        [self setShuiMianBtnWithSelected:NO];
    }
    
    if (model.fMode == 1) {
        [self.zhengChangBtn removeFromSuperview];
        [self setZhengChangBtnWithSelected:YES];
    } else {
        [self.zhengChangBtn removeFromSuperview];
        [self setZhengChangBtnWithSelected:NO];
    }
    
}

- (void)setServiceModel:(ServicesModel *)serviceModel {
    _serviceModel = serviceModel;
}

- (void)setIsAnimation:(NSString *)isAnimation {
    _isAnimation = isAnimation;
    NSLog(@"%@" , _isAnimation);
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
