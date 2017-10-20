//
//  AirPuritionTableViewCell.m
//  联侠
//
//  Created by 杭州阿尔法特 on 16/5/28.
//  Copyright © 2016年 张海昌. All rights reserved.
//

#import "AirPurificationForthTableViewCell.h"


#define kArrayCount _array.count
#define kArrayCountJiaYi (_array.count + 1)
#define kBtnW ((kScreenW + 4) / 4)
@interface AirPurificationForthTableViewCell (){
    UIButton *ziDongBtn;
    UIButton *shuiMianBtn;
    UIButton *shaJunBtn;
    UIButton *fuLiZiBtn;
}

@property (nonatomic , strong) UISlider *slider;
@property (nonatomic , strong) NSArray *array;
@property (nonatomic , strong) UIView *backView;
@end


@implementation AirPurificationForthTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self customUI];
    }
    return self;
}

- (void)getAnNiuZhuangTai:(NSNotification *)post {
    
    if ([post.userInfo[@"AnNiuZhuangTai"] isEqual:@0]) {
        
        for (UIButton *button in self.subviews) {
            button.userInteractionEnabled = NO;
        }
        
        self.subviews.lastObject.userInteractionEnabled = NO;
        
    } else {
        for (UIButton *button in self.subviews) {
            button.userInteractionEnabled = YES;
        }
        
        self.subviews.lastObject.userInteractionEnabled = YES;
    }
}

- (void)customUI {
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getKongJingData:) name:kServiceOrder object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getAnNiuZhuangTai:) name:@"AnNiuZhuangTai" object:nil];
    
    self.backView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenW, kScreenH / 3)];
    self.backView.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:self.backView];
    
    
    NSArray *imageArray = @[@"ziDong" , @"shuiMian" , @"shaJun" , @"fuLiZi"];
    _array = [NSArray arrayWithObjects:@"自动" , @"睡眠", @"UV杀菌",  @"负离子", nil];
    
    for (int i = 0; i < kArrayCount; i++) {
        
        UIButton *btn = [UIButton creatBtnWithTitle:_array[i] andImage:[UIImage imageNamed:imageArray[i]] andImageColor:kKongJingYanSe  andWidth:kScreenW / 2 andHeight:kBtnW andSuperView:self.backView WithTarget:self andDoneAtcion:@selector(doneAtcion:) andTag:i];
        
        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.size.mas_equalTo(CGSizeMake(kScreenW / 2 , kBtnW * 3 / 4));
            if (i < 2) {
                make.left.mas_equalTo(self.backView.mas_left)
                .offset(-1 + (kScreenW / 2 - 1) * i);
                make.top.mas_equalTo(self.backView.mas_top);
            } else {
                make.top.mas_equalTo(self.backView.mas_top)
                .offset(-1 + kBtnW * 3 / 4);
                make.left.mas_equalTo(self.backView.mas_left)
                .offset(-1 + (kScreenW / 2 - 1) * (i - 2));
            }
        }];
        
        switch (i) {
            case 0:{
                ziDongBtn = btn;
                break;
            }
            case 1:{
                shuiMianBtn = btn;
                break;
            }
                
            case 2:{
                shaJunBtn = btn;
                break;
            }
                
            case 3:{
                fuLiZiBtn = btn;
                break;
            }
            default:
                break;
        }
        
    }
    
    
    
    //滑块设置
    _slider = [[UISlider alloc] init];
    _slider.continuous = NO;
    _slider.minimumValue = 1;
    _slider.maximumValue = 3;
    _slider.minimumTrackTintColor = kKongJingHuangSe;
    _slider.maximumTrackTintColor = kKongJingYanSe;
    
    //设置默认值
    self.slider.userInteractionEnabled = YES;
    [self.backView addSubview:self.slider];
    [self.slider mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.backView.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(kScreenW / 1.63, 30));
        make.top.mas_equalTo(fuLiZiBtn.mas_bottom)
        .offset(kScreenW / 20);
    }];
    
    //添加点击手势和滑块滑动事件响应
    [_slider addTarget:self action:@selector(fengSuValueChanged:)
      forControlEvents:UIControlEventValueChanged];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapActionFengSu:)];
    _slider.userInteractionEnabled = YES;
    [_slider addGestureRecognizer:tap];
    
    NSArray *array = [NSArray arrayWithObjects:@"节能", @"舒适" , @"高效" , nil];
    
    for (int i = 0; i < 3; i++) {
        UILabel *stateLable = [UILabel creatLableWithTitle:[NSString stringWithFormat:@"%@" , array[i]] andSuperView:self.backView andFont:k14 andTextAligment:NSTextAlignmentCenter];
        stateLable.textColor = [UIColor lightGrayColor];
        [stateLable mas_makeConstraints:^(MASConstraintMaker *make) {
            if (i == 0) {
                make.left.mas_equalTo(_slider.mas_left);
            } else if (i == 1) {
                make.centerX.mas_equalTo(_slider.mas_centerX);
            } else {
                make.right.mas_equalTo(_slider.mas_right);
            }
            make.top.mas_equalTo(_slider.mas_bottom)
            .offset(kScreenH / 66.7);
        }];
    }
}

- (void)doneAtcion:(UIButton *)btn {
    
    NSString *orderStr = nil;
    switch (btn.tag) {
        case 0:
        {
            orderStr = [NSString stringWithFormat:@"HMFF%@%@A1#", self.serviceModel.devTypeSn,self.serviceModel.devSn];
            break;
        }
        case 1:{
            orderStr = [NSString stringWithFormat:@"HMFF%@%@L1#", self.serviceModel.devTypeSn,self.serviceModel.devSn];
            break;
        }
            
        case 2: {
            orderStr = [NSString stringWithFormat:@"HMFF%@%@U1#", self.serviceModel.devTypeSn,self.serviceModel.devSn];
            break;
        }
            
        case 3:{
            orderStr = [NSString stringWithFormat:@"HMFF%@%@N1#", self.serviceModel.devTypeSn,self.serviceModel.devSn];
            break;
        }
       
        default:
            break;
    }
    [kSocketTCP sendDataToHost:orderStr andType:kZhiLing andIsNewOrOld:kOld];
    
    [btn removeTarget:self action:nil forControlEvents:UIControlEventTouchUpInside];
    [btn addTarget:self action:@selector(againDoneAtcion:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)againDoneAtcion:(UIButton *)btn {
    //    NSLog(@"%ld" , btn.tag);
    
    NSString *orderStr = nil;
    switch (btn.tag) {
        case 0:
        {
            orderStr = [NSString stringWithFormat:@"HMFF%@%@A2#", self.serviceModel.devTypeSn,self.serviceModel.devSn];
            break;
        }
        case 1:{
            orderStr = [NSString stringWithFormat:@"HMFF%@%@L2#", self.serviceModel.devTypeSn,self.serviceModel.devSn];
            break;
        }
        case 2: {
            orderStr = [NSString stringWithFormat:@"HMFF%@%@U2#", self.serviceModel.devTypeSn,self.serviceModel.devSn];
            break;
        }
        case 3:{
            orderStr = [NSString stringWithFormat:@"HMFF%@%@N2#", self.serviceModel.devTypeSn,self.serviceModel.devSn];
            break;
        }
            
        default:
            break;
    }
    [kSocketTCP sendDataToHost:orderStr andType:kZhiLing andIsNewOrOld:kOld];
    
    [btn removeTarget:self action:nil forControlEvents:UIControlEventTouchUpInside];
    [btn addTarget:self action:@selector(doneAtcion:) forControlEvents:UIControlEventTouchUpInside];
}


- (void)fengSuValueChanged:(UISlider *)sender
{
    //只取整数值，固定间距
    NSString *tempStr = [self numberFormat:_slider.value];
    [_slider setValue:tempStr.intValue];
    
    NSString *str = nil;
    if (_slider.value == 1) {
        str = [NSString stringWithFormat:@"HMFF%@%@W1#" , self.serviceModel.devTypeSn, self.serviceModel.devSn];
    } else if (_slider.value == 2) {
        str = [NSString stringWithFormat:@"HMFF%@%@W2#" , self.serviceModel.devTypeSn, self.serviceModel.devSn];
    } else if (sender.value == 3){
        str = [NSString stringWithFormat:@"HMFF%@%@W3#" , self.serviceModel.devTypeSn, self.serviceModel.devSn];
    }
    
    [kSocketTCP sendDataToHost:str andType:kZhiLing andIsNewOrOld:kOld];
}

- (void)tapActionFengSu:(UITapGestureRecognizer *)sender
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
    //    formatter.numberStyle = kCFNumberFormatterRoundFloor;
    [formatter setPositiveFormat:@"0"];
    return [formatter stringFromNumber:[NSNumber numberWithFloat:num]];
}


- (void)getKongJingData:(NSNotification *)post {
    NSString *mingLing = post.userInfo[@"Message"];
    
    if (mingLing.length != 56) {
        return ;
    }
    
    NSString *ziDong = [mingLing substringWithRange:NSMakeRange(28, 2)];
    NSString *shaJun = [mingLing substringWithRange:NSMakeRange(30, 2)];
    NSString *shuiMian = [mingLing substringWithRange:NSMakeRange(32, 2)];
    NSString *fuLiZi = [mingLing substringWithRange:NSMakeRange(34, 2)];
    NSString *fengSu = [mingLing substringWithRange:NSMakeRange(36, 2)];
    
    
    if ([ziDong isEqualToString:@"01"]) {
        [UIButton setBtnOfImageAndLableWithSelected:ziDongBtn andBackGroundColor:kKongJingYanSe];
    } else {
       
        [UIButton setBtnOfImageAndLableWithUnSelected:ziDongBtn andTintColor:kKongJingYanSe];
    }
    
    if ([shaJun isEqualToString:@"01"]) {
       [UIButton setBtnOfImageAndLableWithSelected:shaJunBtn andBackGroundColor:kKongJingYanSe];
    } else {
        [UIButton setBtnOfImageAndLableWithUnSelected:shaJunBtn andTintColor:kKongJingYanSe];
    }
    
    if ([shuiMian isEqualToString:@"01"]) {
        [UIButton setBtnOfImageAndLableWithSelected:shuiMianBtn andBackGroundColor:kKongJingYanSe];
    } else {
        [UIButton setBtnOfImageAndLableWithUnSelected:shuiMianBtn andTintColor:kKongJingYanSe];
    }
    
    if ([fuLiZi isEqualToString:@"01"]) {
        [UIButton setBtnOfImageAndLableWithSelected:fuLiZiBtn andBackGroundColor:kKongJingYanSe];
    } else {
        [UIButton setBtnOfImageAndLableWithUnSelected:fuLiZiBtn andTintColor:kKongJingYanSe];
    }
    
    if ([fengSu isEqualToString:@"01"]) {
        _slider.value = 1;
    }
    
    if ([fengSu isEqualToString:@"02"]) {
        _slider.value = 2;
    }
    
    if ([fengSu isEqualToString:@"03"]) {
        _slider.value = 3;
    }
}


- (void)setServiceModel:(ServicesModel *)serviceModel {
    _serviceModel = serviceModel;
}

- (void)setStateModel:(StateModel *)stateModel {
    _stateModel = stateModel;
    
    
    if (_stateModel.fAuto == 1) {
        [UIButton setBtnOfImageAndLableWithSelected:ziDongBtn andBackGroundColor:kKongJingYanSe];
        [self btnCancleAtcion:ziDongBtn];
    } else {
        [UIButton setBtnOfImageAndLableWithUnSelected:ziDongBtn andTintColor:kKongJingYanSe];
        [self btnSureAtcion:ziDongBtn];
    }
    
    if (_stateModel.fUV == 1) {
        [UIButton setBtnOfImageAndLableWithSelected:shaJunBtn andBackGroundColor:kKongJingYanSe];
        [self btnCancleAtcion:shaJunBtn];
    } else {
        [UIButton setBtnOfImageAndLableWithUnSelected:shaJunBtn andTintColor:kKongJingYanSe];
        
        [self btnSureAtcion:shaJunBtn];
    }
    
    if (_stateModel.fSleep == 1) {
         [UIButton setBtnOfImageAndLableWithSelected:shuiMianBtn andBackGroundColor:kKongJingYanSe];
        [self btnCancleAtcion:shuiMianBtn];
    } else {
        [UIButton setBtnOfImageAndLableWithUnSelected:shuiMianBtn andTintColor:kKongJingYanSe];
        
        [self btnSureAtcion:shuiMianBtn];
    }
    
    if (_stateModel.fAnion == 1) {
        [UIButton setBtnOfImageAndLableWithSelected:fuLiZiBtn andBackGroundColor:kKongJingYanSe];
        [self btnCancleAtcion:fuLiZiBtn];
    } else {
       [UIButton setBtnOfImageAndLableWithUnSelected:fuLiZiBtn andTintColor:kKongJingYanSe];
        
        [self btnSureAtcion:fuLiZiBtn];
    }
    
    if (_stateModel.fWind == 1) {
        _slider.value = 1;
    }
    
    if (_stateModel.fWind == 2) {
        _slider.value = 2;
    }
    
    if (_stateModel.fWind == 3) {
        _slider.value = 3;
    }
    
    
}

- (void)btnSureAtcion:(UIButton *)btn {
    [btn removeTarget:self action:nil forControlEvents:UIControlEventTouchUpInside];
    [btn addTarget:self action:@selector(doneAtcion:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)btnCancleAtcion:(UIButton *)btn {
    [btn removeTarget:self action:nil forControlEvents:UIControlEventTouchUpInside];
    [btn addTarget:self action:@selector(againDoneAtcion:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)setButtonSelected:(NSNumber *)buttonSelected {
    _buttonSelected = buttonSelected;
    if ([_buttonSelected isEqual:@0]) {
        
        for (UIButton *button in self.subviews) {
            button.userInteractionEnabled = NO;
        }
        
        self.subviews.lastObject.userInteractionEnabled = NO;
        
    } else {
        for (UIButton *button in self.subviews) {
            button.userInteractionEnabled = YES;
        }
        
        self.subviews.lastObject.userInteractionEnabled = YES;
    }
    
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
