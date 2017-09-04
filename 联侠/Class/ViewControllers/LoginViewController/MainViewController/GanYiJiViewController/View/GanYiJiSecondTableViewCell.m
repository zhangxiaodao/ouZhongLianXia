//
//  GanYiJiSecondTableViewCell.m
//  联侠
//
//  Created by 杭州阿尔法特 on 16/6/27.
//  Copyright © 2016年 张海昌. All rights reserved.
//

#import "GanYiJiSecondTableViewCell.h"

#define kArrayCount _array.count
#define kArrayCountJiaYi (_array.count + 1)
#define kBtnW ((kScreenW + 4) / 4)
#define kContentViewHeight kBtnW * 2 + kBtnW * 2 / 3
@interface GanYiJiSecondTableViewCell (){
    UIButton *gaoReBtn;
    UIButton *jieNengBtn;
    UIButton *shaJunBtn;
    UIButton *fuLiZiBtn;
}
@property (nonatomic , strong) NSArray *array;
@end

@implementation GanYiJiSecondTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self customUI];
    }
    return self;
}


- (void)getGanYiJiAnNiuZhuangTai:(NSNotification *)post {
    
    if ([post.userInfo[@"GanYiJiAnNiuZhuangTai"] isEqual:@0]) {
        
        for (UIButton *button in self.subviews) {
            button.userInteractionEnabled = NO;
        }
        
    } else {
        for (UIButton *button in self.subviews) {
            button.userInteractionEnabled = YES;
        }
    }
}


- (void)customUI {
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getGanYiJiData:) name:kServiceOrder object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getGanYiJiAnNiuZhuangTai:) name:@"GanYiJiAnNiuZhuangTai" object:nil];
    
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenW, kBtnW * 2 )];
    view.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:view];
    
    NSArray *imageArray = @[@"gaoRe" , @"jieNeng" , @"shaJun" , @"fuLiZi"];
    _array = [NSArray arrayWithObjects:@"高热" , @"节能", @"UV杀菌", @"负离子", nil];
    
    for (int i = 0; i < kArrayCount; i++) {
        
        UIButton *btn = [UIButton creatBtnWithTitle:_array[i] andImage:[UIImage imageNamed:imageArray[i]] andImageColor:kKongJingYanSe  andWidth:kBtnW andHeight:kBtnW andSuperView:view WithTarget:self andDoneAtcion:@selector(btnDoneAtcion:) andTag:i];
        
        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.size.mas_equalTo(CGSizeMake(kScreenW / 2, kBtnW));
            
            if (i < 2) {
                make.left.mas_equalTo(self.contentView.mas_left).offset( (kScreenW / 2 - 1) * i);
                make.centerY.mas_equalTo(view.mas_top).offset(kBtnW * 2 / 4);
            } else {
                make.left.mas_equalTo(self.contentView.mas_left).offset( (kScreenW / 2 - 1) * (i - 2));
                make.centerY.mas_equalTo(view.mas_top).offset(kBtnW * 2 * 3 / 4 - 1);
            }
        }];
        
        switch (i) {
            case 0:{
                gaoReBtn = btn;
                break;
            }
            case 1:{
                jieNengBtn = btn;
                break;
            }
                
            case 2:{
                shaJunBtn = btn;
                break;
            }
            case 3: {
                fuLiZiBtn = btn;
                break;
            }
            default:
                break;
        }
        
    }
    
    [UIView creatBottomFenGeView:view andBackGroundColor:[UIColor whiteColor] isOrNotAllLenth:@"YES"];
    
}


- (void)btnDoneAtcion:(UIButton *)btn {
    
    switch (btn.tag) {
        case 0:
        {
            [kSocketTCP sendDataToHost:GanYiJiXieYi(_serviceModel.devTypeSn, _serviceModel.devSn, @"00", @"01", @"00", @"00") andType:kZhiLing andIsNewOrOld:kNew];
            
            break;
        }
        case 1:{
            [kSocketTCP sendDataToHost:GanYiJiXieYi(_serviceModel.devTypeSn, _serviceModel.devSn, @"00", @"02", @"00", @"00") andType:kZhiLing andIsNewOrOld:kNew];
            
            break;
        }
            
        case 2: {
            
            [kSocketTCP sendDataToHost:GanYiJiXieYi(_serviceModel.devTypeSn, _serviceModel.devSn, @"00", @"00", @"01", @"00") andType:kZhiLing andIsNewOrOld:kNew];
            [btn removeTarget:self action:@selector(btnDoneAtcion:) forControlEvents:UIControlEventTouchUpInside];
            [btn addTarget:self action:@selector(btnAgainDoneAtcion:) forControlEvents:UIControlEventTouchUpInside];
            break;
        }
        case 3: {
            
            [kSocketTCP sendDataToHost:GanYiJiXieYi(_serviceModel.devTypeSn, _serviceModel.devSn, @"00", @"00", @"00", @"01") andType:kZhiLing andIsNewOrOld:kNew];
            [btn removeTarget:self action:@selector(btnDoneAtcion:) forControlEvents:UIControlEventTouchUpInside];
            [btn addTarget:self action:@selector(btnAgainDoneAtcion:) forControlEvents:UIControlEventTouchUpInside];
            
            break;
        }
            
        default:
            break;
    }
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getGanYiJiData:) name:kServiceOrder object:nil];
    
}

- (void)btnAgainDoneAtcion:(UIButton *)btn {
    
    switch (btn.tag) {
        case 2: {
            
            [kSocketTCP sendDataToHost:GanYiJiXieYi(_serviceModel.devTypeSn, _serviceModel.devSn, @"00", @"00", @"02", @"00") andType:kZhiLing andIsNewOrOld:kNew];
            [btn removeTarget:self action:@selector(btnAgainDoneAtcion:) forControlEvents:UIControlEventTouchUpInside];
            [btn addTarget:self action:@selector(btnDoneAtcion:) forControlEvents:UIControlEventTouchUpInside];
            break;
        }
        case 3: {
            
            [kSocketTCP sendDataToHost:GanYiJiXieYi(_serviceModel.devTypeSn, _serviceModel.devSn, @"00", @"00", @"00", @"02") andType:kZhiLing andIsNewOrOld:kNew];
            [btn removeTarget:self action:@selector(btnAgainDoneAtcion:) forControlEvents:UIControlEventTouchUpInside];
            [btn addTarget:self action:@selector(btnDoneAtcion:) forControlEvents:UIControlEventTouchUpInside];
            break;
        }
        default:
            break;
    }
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getGanYiJiData:) name:kServiceOrder object:nil];
}

- (void)getGanYiJiData:(NSNotification *)post {
    NSString *str = post.userInfo[@"Message"];
    
    if (str.length != 62) {
        return;
    }
    
    NSString *devSn = [str substringWithRange:NSMakeRange(14, 12)];
    NSString *gaoRe = [str substringWithRange:NSMakeRange(30, 2)];
    NSString *shaJun = [str substringWithRange:NSMakeRange(32, 2)];
    NSString *fuLiZi = [str substringWithRange:NSMakeRange(34, 2)];

    
    
    if ([devSn isEqualToString:_serviceModel.devSn]) {
        if ([gaoRe isEqualToString:@"02"]) {
            
            [UIButton setBtnOfImageAndLableWithSelected:jieNengBtn andBackGroundColor:kKongJingYanSe];
            [UIButton setBtnOfImageAndLableWithUnSelected:gaoReBtn andTintColor:kKongJingYanSe];
        } else if ([gaoRe isEqualToString:@"01"]) {
            [UIButton setBtnOfImageAndLableWithSelected:gaoReBtn andBackGroundColor:kKongJingYanSe];
            [UIButton setBtnOfImageAndLableWithUnSelected:jieNengBtn andTintColor:kKongJingYanSe];
        }
        
        if ([shaJun isEqualToString:@"02"]) {
            
            [UIButton setBtnOfImageAndLableWithUnSelected:shaJunBtn andTintColor:kKongJingYanSe];
        } else if ([shaJun isEqualToString:@"01"]) {
            [UIButton setBtnOfImageAndLableWithSelected:shaJunBtn andBackGroundColor:kKongJingYanSe];
        }
        
        if ([fuLiZi isEqualToString:@"02"]) {
            [UIButton setBtnOfImageAndLableWithUnSelected:fuLiZiBtn andTintColor:kKongJingYanSe];
            
        } else if ([fuLiZi isEqualToString:@"01"]) {
            [UIButton setBtnOfImageAndLableWithSelected:fuLiZiBtn andBackGroundColor:kKongJingYanSe];
        }
        
    }
    
}

- (void)btnSureAtcion:(UIButton *)btn {
    [btn removeTarget:self action:nil forControlEvents:UIControlEventTouchUpInside];
    [btn addTarget:self action:@selector(btnDoneAtcion:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)btnCancleAtcion:(UIButton *)btn {
    [btn removeTarget:self action:nil forControlEvents:UIControlEventTouchUpInside];
    [btn addTarget:self action:@selector(btnAgainDoneAtcion:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)setServiceModel:(ServicesModel *)serviceModel {
    _serviceModel = serviceModel;
    
}

- (void)setStateModel:(StateModel *)stateModel {
    _stateModel = stateModel;
    
    
    if (_stateModel.fShift == 1) {
        [UIButton setBtnOfImageAndLableWithSelected:gaoReBtn andBackGroundColor:kKongJingYanSe];
        [UIButton setBtnOfImageAndLableWithUnSelected:jieNengBtn andTintColor:kKongJingYanSe];
        [self btnSureAtcion:gaoReBtn];
        [self btnSureAtcion:jieNengBtn];
    } else if(_stateModel.fShift == 2){
        [UIButton setBtnOfImageAndLableWithSelected:jieNengBtn andBackGroundColor:kKongJingYanSe];
        [UIButton setBtnOfImageAndLableWithUnSelected:gaoReBtn andTintColor:kKongJingYanSe];
        [self btnSureAtcion:gaoReBtn];
        [self btnSureAtcion:jieNengBtn];
    }
    
    if (_stateModel.fUV == 1) {
        [UIButton setBtnOfImageAndLableWithSelected:shaJunBtn andBackGroundColor:kKongJingYanSe];
        [self btnCancleAtcion:shaJunBtn];
    } else {
        [UIButton setBtnOfImageAndLableWithUnSelected:shaJunBtn andTintColor:kKongJingYanSe];
        
        [self btnSureAtcion:shaJunBtn];
    }
    
    if (_stateModel.fAnion == 1) {
        [UIButton setBtnOfImageAndLableWithSelected:fuLiZiBtn andBackGroundColor:kKongJingYanSe];
        [self btnCancleAtcion:fuLiZiBtn];
    } else {
        [UIButton setBtnOfImageAndLableWithUnSelected:fuLiZiBtn andTintColor:kKongJingYanSe];
        
        [self btnSureAtcion:fuLiZiBtn];
    }
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
