//
//  AirPurificationFifthTableViewCell.m
//  联侠
//
//  Created by 杭州阿尔法特 on 16/6/7.
//  Copyright © 2016年 张海昌. All rights reserved.
//

#import "AirPurificationFifthTableViewCell.h"
#import "AirDingShiJieMianViewController.h"

@interface AirPurificationFifthTableViewCell ()
@property (nonatomic , strong) UIButton *firstBtn;
@property (nonatomic , strong) UIButton *secondBtn;
@property (nonatomic , strong) UIButton *thirtBtn;
@property (nonatomic , strong) UIButton *forthBtn;

@property (nonatomic , strong) UILabel *openLable;
@property (nonatomic , strong) UILabel *offLable;
@property (nonatomic , strong) UILabel *titleLable;
@property (nonatomic , strong) NSArray *moShiArray;
@property (nonatomic , strong) NSMutableArray *timeTextArray;

//@property (nonatomic , copy) NSString *clothesType;
@end
@implementation AirPurificationFifthTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self addNotification];
        [self customUI];
    }
    return self;
}

- (void)addNotification {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getAirTimeTextArray:) name:@"AirTimeText" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getMoShiArray:) name:@"KongJingIsWork" object:nil];
}

- (void)getMoShiArray:(NSNotification *)post {
    
    [self dangBaoCunYouKongJingGongZuoZhuangTai];
}

- (void)dangBaoCunYouKongJingGongZuoZhuangTai {
    NSArray *array = nil;
    
    if ([kStanderDefault objectForKey:@"AirDingShiData"]) {
        array = [kStanderDefault objectForKey:@"AirDingShiData"];
        
        _timeTextArray = array[1];
        _moShiArray = array[0];
        
//        NSLog(@"%@ , %@" , _timeTextArray , _moShiArray);
        
        if ([_moShiArray[1] isEqualToString:@"NO"]) {
            
            
            [self setButtonOfSubViewsGraryColor:_firstBtn];
            [self setButtonOfSubViewsGraryColor:_secondBtn];
            [self setButtonOfSubViewsGraryColor:_thirtBtn];
            [self setButtonOfSubViewsGraryColor:_forthBtn];
            
        } else {
            
            [self setButtonOfSubViewsGraryColor:_firstBtn];
            [self setButtonOfSubViewsGraryColor:_secondBtn];
            [self setButtonOfSubViewsGraryColor:_thirtBtn];
            [self setButtonOfSubViewsGraryColor:_forthBtn];
            
            if ([_moShiArray[0] isEqualToString:@"first"]) {
                
                [self setButtonOfSubViewsColor:_firstBtn];
                
            } else if ([_moShiArray[0] isEqualToString:@"second"]) {
                [self setButtonOfSubViewsColor:_secondBtn];
                
                
            } else if ([_moShiArray[0] isEqualToString:@"thirt"]) {
                [self setButtonOfSubViewsColor:_thirtBtn];
                
            } else if ([_moShiArray[0] isEqualToString:@"forth"]) {
                
                [self setButtonOfSubViewsColor:_forthBtn];
                
            }
        }
        
    }
}

- (void)getAirTimeTextArray:(NSNotification *)post {
    NSMutableDictionary *dic = post.userInfo[@"AirTimeText"];

    _timeTextArray = [NSMutableArray array];
    [_timeTextArray addObject:dic[@"openTime"]];
    [_timeTextArray addObject:dic[@"offTime"]];
    [_timeTextArray addObject:dic[@"fromWhich"]];

}

- (void)customUI {
    
    [self timeTextArray];
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenW, kScreenH * 4 / 9.57142 + kScreenH / 13.34)];
    view.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:view];
    
    _titleLable = [UILabel creatLableWithTitle:@"定时模式" andSuperView:view andFont:k20 andTextAligment:NSTextAlignmentCenter];
    [_titleLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kScreenW, kScreenH / 13.34));
        make.centerX.mas_equalTo(view.mas_centerX);
        make.top.mas_equalTo(view.mas_top).offset(2);
    }];
    _titleLable.layer.borderWidth = 1;
    _titleLable.textColor = kKongJingYanSe;
    _titleLable.layer.borderColor = kFenGeXianYanSe.CGColor;
    _titleLable.layer.cornerRadius = 0;
    
    for (int i = 0; i < 4; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
        [view addSubview:button];
        button.frame = CGRectMake(0, kScreenH  * i / 9.57142 - (i - 1) + kScreenH / 13.34, kScreenW, kScreenH  / 9.57142);
        
        button.tag = i;
        [button addTarget:self action:@selector(buttonAtcion:) forControlEvents:UIControlEventTouchUpInside];
        button.layer.borderWidth = 1;
        button.layer.borderColor = kFenGeXianYanSe.CGColor;
        
        switch (i) {
            case 0:
                _firstBtn = button;
                break;
            case 1:
                _secondBtn = button;
                break;
            case 2:
                _thirtBtn = button;
                break;
            case 3:
                _forthBtn = button;
                break;
            default:
                break;
        }
        
        UIImageView *imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"gouHao"]];
        [button addSubview:imageView];
        [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(button.height * 1 / 3, button.height * 1 / 3));
            make.centerX.mas_equalTo(button.mas_left)
            .offset(kScreenW / 9.375);
            make.centerY.mas_equalTo(button.mas_centerY);
        }];
        
        [UIImageView setImageViewColor:imageView andColor:[UIColor grayColor]];
        imageView.tag = 3 * button.tag + 1;
        
        UILabel *label = [UILabel creatLableWithTitle:@"" andSuperView:button andFont:k20 andTextAligment:NSTextAlignmentLeft];
        label.textColor  =[UIColor grayColor];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(imageView.mas_right)
            .offset(kScreenW / 9.375);
            make.bottom.mas_equalTo(button.mas_centerY);
        }];
        label.tag = 3 * button.tag + 2;
        
        UILabel *label2 = [UILabel creatLableWithTitle:@"" andSuperView:button andFont:k14 andTextAligment:NSTextAlignmentLeft];
        label2.textColor  =[UIColor grayColor];
        [label2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(label.mas_left);
            make.top.mas_equalTo(button.mas_centerY);
        }];
        label2.tag = 3 * button.tag + 3;
        
        UILabel *label3 = [UILabel creatLableWithTitle:@"" andSuperView:button andFont:k14 andTextAligment:NSTextAlignmentLeft];
        label3.textColor = [UIColor grayColor];
        [label3 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(label2.mas_right);
            make.top.mas_equalTo(button.mas_centerY);
        }];
        label3.tag = 3 * button.tag + 4;
       
        UILabel *label4 = [UILabel creatLableWithTitle:@"" andSuperView:button andFont:k14 andTextAligment:NSTextAlignmentLeft];
        label4.textColor  =[UIColor grayColor];
        [label4 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(label.mas_left);
            make.top.mas_equalTo(button.mas_centerY);
        }];
        label4.tag = 3 * button.tag + 5;
        
        UIImageView *jianTouImage = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"iconfont-qianjin"]];
        [button addSubview:jianTouImage];
        [UIImageView setImageViewColor:jianTouImage andColor:[UIColor lightGrayColor]];
        [jianTouImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(button.height * 1 / 3, button.height * 1 / 3));
            make.right.mas_equalTo(button.mas_right)
            .offset(-20);
            make.centerY.mas_equalTo(button.mas_centerY);
        }];
        jianTouImage.tag = 3 * button.tag + 6;
    }
    
    for (int i = 0; i < 4; i++) {
        NSArray *textArray = nil;
        textArray = @[@"主人外出了，但我仍要好好工作的" , @"周末静静开启，好空气好心情" , @"由空气质量开或关，真正的智能模式" , @"完全定制专属于你的个性化模式"];
        
        NSArray *nameArray = nil;
        nameArray = @[@"外出模式" , @"周末模式" , @"智能模式" , @"自定义模式"];
        
        NSArray *btnArray = @[_firstBtn , _secondBtn , _thirtBtn , _forthBtn];
        [self setLableTextOfBtn:btnArray[i] andText:textArray[i] andTitle:nameArray[i]];
    }
    
    [self dangBaoCunYouKongJingGongZuoZhuangTai];
}

- (void)setButtonOfSubViewsColor:(UIButton *)btn {
    UIImageView *imageView = [btn viewWithTag:(3 * btn.tag + 1)];
    UILabel *lable1 = [btn viewWithTag:(3 * btn.tag + 2)];
    UILabel *lable2 = [btn viewWithTag:(3 * btn.tag + 3)];
    UILabel *lable3 = [btn viewWithTag:(3 * btn.tag + 4)];
    UILabel *lable4 = [btn viewWithTag:(3 * btn.tag + 5)];
    UIImageView *jianTouImageView = [btn viewWithTag:(3 * btn.tag + 6)];
    
    lable2.hidden = NO;
    lable3.hidden = NO;
    lable4.hidden = YES;
    
    
    
    if (_timeTextArray.count > 0) {
        lable2.text = [NSString stringWithFormat:@"开启 : %@" , _timeTextArray[0]];
        lable3.text = [NSString stringWithFormat:@"关闭 : %@" , _timeTextArray[1]];
    }
    
    imageView.tintColor = kKongJingYanSe;
    lable1.textColor = kKongJingYanSe;
    lable2.textColor = kKongJingYanSe;
    lable3.textColor = kKongJingYanSe;
    jianTouImageView.tintColor = kKongJingYanSe;
    
    
    if ([btn isEqual:_thirtBtn]) {
        lable2.hidden = YES;
        lable3.hidden = YES;
    }
    
}


- (void)setButtonOfSubViewsGraryColor:(UIButton *)btn {
    UIImageView *imageView = [btn viewWithTag:(3 * btn.tag + 1)];
    UILabel *lable1 = [btn viewWithTag:(3 * btn.tag + 2)];
    UILabel *lable2 = [btn viewWithTag:(3 * btn.tag + 3)];
    UILabel *lable3 = [btn viewWithTag:(3 * btn.tag + 4)];
    UILabel *lable4 = [btn viewWithTag:(3 * btn.tag + 5)];
    UIImageView *jianTouImageView = [btn viewWithTag:(3 * btn.tag + 6)];
    
    
    lable2.hidden = YES;
    lable3.hidden = YES;
    lable4.hidden = NO;
    imageView.tintColor = [UIColor grayColor];
    lable1.textColor = [UIColor grayColor];
    lable2.textColor = [UIColor grayColor];
    lable3.textColor = [UIColor grayColor];
    lable4.textColor = [UIColor grayColor];
    jianTouImageView.tintColor = [UIColor grayColor];
    
    
}


- (void)buttonAtcion:(UIButton *)btn {
    AirDingShiJieMianViewController *airDingShiVC = [[AirDingShiJieMianViewController alloc]init];
    airDingShiVC.serviceModel = self.serviceModel;
    
    NSArray *nameArray = @[@"外出模式" , @"周末模式" , @"智能模式" , @"自定义模式"];
        switch (btn.tag) {
            case 0: {
                airDingShiVC.navigationItem.title = nameArray[0];
                airDingShiVC.fromWhich = @"first";
                [self.vc.navigationController pushViewController:airDingShiVC animated:YES];
                break;
            }
            case 1: {
                
                airDingShiVC.navigationItem.title = nameArray[1];
                airDingShiVC.fromWhich = @"second";
                [self.vc.navigationController pushViewController:airDingShiVC animated:YES];
                break;
            }
            case 2: {
                
                airDingShiVC.navigationItem.title = nameArray[2];
                airDingShiVC.fromWhich = @"thirt";
                airDingShiVC.buttonSelected = self.buttonSelected;
                [self.vc.navigationController pushViewController:airDingShiVC animated:YES];
                break;
            }
            case 3: {
                
                airDingShiVC.navigationItem.title = nameArray[3];
                airDingShiVC.fromWhich = @"forth";
                [self.vc.navigationController pushViewController:airDingShiVC animated:YES];
                break;
            }
                
            default:
                break;
        }
}

- (NSMutableArray *)timeTextArray {
    if (!_timeTextArray) {
        _timeTextArray = [NSMutableArray array];
    }
    return _timeTextArray;
}

- (void)setServiceModel:(ServicesModel *)serviceModel {
    _serviceModel = serviceModel;
    
    NSLog(@"%@" , self.contentView.subviews);
    if (self.contentView.subviews.count > 0) {
        [self.contentView.subviews[0] removeFromSuperview];
        [self customUI];
    } else {
        [self customUI];
    }
}

- (void)setLableTextOfBtn:(UIButton *)btn andText:(NSString *)subText andTitle:(NSString *)title{
    
    
    UILabel *lable = [btn viewWithTag:(3 * btn.tag + 2)];
    lable.text = title;
    
    UILabel *lable2 = [btn viewWithTag:(3 * btn.tag + 5)];
    lable2.text = subText;
}


- (void)setButtonSelected:(NSNumber *)buttonSelected {
    _buttonSelected = buttonSelected;
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
