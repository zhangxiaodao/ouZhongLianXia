//
//  GanYiJiYiWuXuanZeTableViewCell.m
//  联侠
//
//  Created by 杭州阿尔法特 on 16/8/29.
//  Copyright © 2016年 张海昌. All rights reserved.
//

#import "GanYiJiYiWuXuanZeTableViewCell.h"

#define btnWidthAndHeight (minusHeight / 6 )
#define numLabelHeight kScreenW / 15
#define minusHeight (kScreenH / 3.1761 - numLabelHeight)
#define shengXiaHeight kScreenW / 8

#define baoTime 3
#define zhongTime 5
#define houTime 7

@interface GanYiJiYiWuXuanZeTableViewCell ()<HelpFunctionDelegate>{
    UIView *view;
}
@property (nonatomic , assign) NSInteger baoNum;
@property (nonatomic , assign) NSInteger zhongNum;
@property (nonatomic , assign) NSInteger houNum;
@property (nonatomic , assign) NSInteger sumJianShu;
@property (nonatomic , assign) NSInteger sumTime;

@property (nonatomic , strong) UIView *baoView;
@property (nonatomic , strong) UIView *zhongView;
@property (nonatomic , strong) UIView *houView;

@property (nonatomic , strong) UIButton *doneBtn;

@property (nonatomic , strong) NSMutableDictionary *ganYiJiHongGanDic;
@end

@implementation GanYiJiYiWuXuanZeTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self customUI];
    }
    return self;
}

- (void)customUI {
    
    
    view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenW, kScreenH / 3.1761 + shengXiaHeight)];
    [self.contentView addSubview:view];
    view.backgroundColor = [UIColor whiteColor];
    
    _baoNum = 0;
    _zhongNum = 0;
    _houNum = 0;
    
    NSArray *imageAry = @[@"bao" , @"zhong" , @"hou"];
    NSArray *nameAry = @[ @"薄" , @"中" ,  @"厚"];
    for (int i = 0; i < 3; i++) {
       UIView *modelView = [self creatModelViewOfSuperView:view andWidth:kScreenW / 3 andHeight:kScreenH / 3.1761 andImageView:[UIImage imageNamed:imageAry[i]] andTitle:nameAry[i]];
        [view addSubview:modelView];

        [modelView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(kScreenW / 3, kScreenH / 3.1761));
            make.right.mas_equalTo(view.mas_left).offset(kScreenW * (i + 1) / 3);
            make.top.mas_equalTo(view.mas_top);
        }];
        
        if (i == 0) {
            _baoView = modelView;
            
        } else if (i == 1) {
            _zhongView = modelView;
            
        } else if (i == 2) {
            _houView = modelView;
        }
        
        UIImageView *imageView = [modelView.subviews objectAtIndex:1];
        for (int i = 0; i < 3; i++) {
            UIView *fenGeView = [[UIView alloc]init];
            [modelView addSubview:fenGeView];
            fenGeView.backgroundColor = kFenGeXianYanSe;
            [fenGeView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.size.mas_equalTo(CGSizeMake(kScreenW, 1));
                make.left.mas_equalTo(view.mas_left);
                
                if (i == 0) {
                    make.top.mas_equalTo(imageView.mas_top).offset(1);
                } else if (i == 1) {
                    make.top.mas_equalTo(imageView.mas_bottom).offset(-1);
                } else if (i == 2) {
                    make.top.mas_equalTo(modelView.mas_bottom).offset(-1);
                }
            }];
        }
        
        
        
        for (int i = 0; i < 3; i++) {
            UIView *fenGeView2 = [[UIView alloc]init];
            [modelView addSubview:fenGeView2];
            fenGeView2.backgroundColor = kFenGeXianYanSe;
            [fenGeView2 mas_makeConstraints:^(MASConstraintMaker *make) {
                make.size.mas_equalTo(CGSizeMake(1, minusHeight / 4));
                make.top.mas_equalTo(imageView.mas_bottom);
                 make.left.mas_equalTo(imageView.mas_centerX);
            }];
        }
    }
    UILabel *sumLabel = [UILabel creatLableWithTitle:@"共0件" andSuperView:view andFont:k15 andTextAligment:NSTextAlignmentCenter];
    [sumLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kScreenW / 3, shengXiaHeight));
        make.left.mas_equalTo(view.mas_left);
        make.bottom.mas_equalTo(view.mas_bottom);
    }];
    sumLabel.textColor = [UIColor grayColor];
    sumLabel.tag = 123;

    
    
    UILabel *timeLabel = [UILabel creatLableWithTitle:@"预计:00时00分" andSuperView:view andFont:k15 andTextAligment:NSTextAlignmentCenter];
    [timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kScreenW / 3, shengXiaHeight));
        make.left.mas_equalTo(sumLabel.mas_right);
        make.bottom.mas_equalTo(sumLabel.mas_bottom);
    }];
    timeLabel.textColor = [UIColor grayColor];
    timeLabel.tag = 321;
    
    _doneBtn = [UIButton initWithTitle:@"开始烘干" andColor:kKongJingYanSe andSuperView:view];
    _doneBtn.layer.cornerRadius = 0;

    _doneBtn.backgroundColor = kKongJingYanSe;
    [_doneBtn setBackgroundImage:[UIImage imageWithColor:kACOLOR(215, 132, 110, 1.0)] forState:UIControlStateHighlighted];
    
    [_doneBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kScreenW / 3, shengXiaHeight));
        make.left.mas_equalTo(timeLabel.mas_right);
        make.bottom.mas_equalTo(sumLabel.mas_bottom);
    }];
    _doneBtn.titleLabel.font = [UIFont systemFontOfSize:20.0];
    
    [_doneBtn addTarget:self action:@selector(beginBtnAtcion:) forControlEvents:UIControlEventTouchUpInside];
    _doneBtn.selected = NO;
    
}


- (void)initGanYiJiHongGanDic {
    
    
    if ([kStanderDefault objectForKey:@"ganYiJiHongGanDic"]) {
        
        _ganYiJiHongGanDic = [[kStanderDefault objectForKey:@"ganYiJiHongGanDic"] mutableCopy];
        NSString *confirmTimeStr = _ganYiJiHongGanDic[@"confirmTimeStr"];
        
        NSDate *date = [NSDate date];
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
        [dateFormatter setDateFormat:@"YYYY/MM/dd HH:mm"];
        NSString *currentTime = [dateFormatter stringFromDate:date];
        
        if ([confirmTimeStr compare:currentTime] < 0) {
            [kStanderDefault removeObjectForKey:@"ganYiJiHongGanDic"];
            _ganYiJiHongGanDic = [NSMutableDictionary dictionary];
        }
    }
}

- (UIView *)creatModelViewOfSuperView:(UIView *)superView andWidth:(CGFloat)width andHeight:(CGFloat)height andImageView:(UIImage *)image andTitle:(NSString *)title{
    UIView *bottomView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, width, height)];
    
    UILabel *numLable = [UILabel creatLableWithTitle:@"0 件" andSuperView:bottomView andFont:k15 andTextAligment:NSTextAlignmentCenter];
    numLable.textColor = [UIColor grayColor];
    [numLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kScreenW / 4, numLabelHeight));
        make.centerX.mas_equalTo(bottomView.mas_centerX);
        make.top.mas_equalTo(bottomView.mas_top);
    }];
    
    UIImageView *imageView = [[UIImageView alloc]initWithImage:image];
    [bottomView addSubview:imageView];
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(bottomView.width, minusHeight * 3 / 4));
        make.top.mas_equalTo(numLable.mas_bottom);
        make.centerX.mas_equalTo(bottomView.mas_centerX);
    }];
    
    UILabel *typeLabel = [UILabel creatLableWithTitle:title andSuperView:bottomView andFont:k14 andTextAligment:NSTextAlignmentCenter];
    [typeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(bottomView.width / 3, minusHeight / 4));
        make.left.mas_equalTo(imageView.mas_left);
        make.top.mas_equalTo(imageView.mas_top);
    }];
    typeLabel.textColor = [UIColor grayColor];
    typeLabel.layer.borderWidth = 0;
    
    UIView *fenGeView3 = [[UIView alloc]init];
    [imageView addSubview:fenGeView3];
    fenGeView3.backgroundColor = kFenGeXianYanSe;
    [fenGeView3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(1, bottomView.height));
        make.top.mas_equalTo(bottomView.mas_top);
        make.left.mas_equalTo(bottomView.mas_right).offset(-1);
    }];
    
    UIButton *doneBtn = [UIButton initWithTitle:@"+" andColor:kKongJingYanSe andSuperView:bottomView];
    [doneBtn setBackgroundImage:[UIImage imageWithColor:kACOLOR(215, 132, 110, 1.0)] forState:UIControlStateHighlighted];
    [doneBtn addTarget:self action:@selector(addDoneAtcion:) forControlEvents:UIControlEventTouchUpInside];
    
    //注册按钮的约束
    [doneBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(btnWidthAndHeight, btnWidthAndHeight));
        make.centerX.mas_equalTo(bottomView.mas_centerX).offset(bottomView.width / 4);
        make.centerY.mas_equalTo(bottomView.mas_bottom).offset(-bottomView.height/8);
    }];
    doneBtn.layer.cornerRadius = btnWidthAndHeight / 2;
    doneBtn.layer.masksToBounds = YES;
    
    doneBtn.tag = 3;
    
    
    
    UIButton *cancleBtn = [UIButton initWithTitle:@"-" andColor:kKongJingHuangSe andSuperView:bottomView];
    [cancleBtn addTarget:self action:@selector(minusDoneAtcion:) forControlEvents:UIControlEventTouchUpInside];
    [cancleBtn setBackgroundImage:[UIImage imageWithColor:kACOLOR(218, 235, 254, 1.0)] forState:UIControlStateHighlighted];
    
    //注册按钮的约束
    [cancleBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(btnWidthAndHeight, btnWidthAndHeight));
        make.centerX.mas_equalTo(bottomView.mas_centerX).offset(-bottomView.width / 4);
        make.centerY.mas_equalTo(bottomView.mas_bottom).offset(-bottomView.height/8);
    }];
    cancleBtn.layer.cornerRadius = btnWidthAndHeight / 2;
    cancleBtn.layer.masksToBounds = YES;
    cancleBtn.tag = 4;
    
    
    return bottomView;
}

- (void)addDoneAtcion:(UIButton *)btn {

    
    UIView *superView = btn.superview;
    UILabel *numLabel = [superView.subviews objectAtIndex:0];
    UILabel *sumLable = [view viewWithTag:123];
    UILabel *yuJiLabel = [view viewWithTag:321];
    
    if ([superView isEqual:_baoView]) {
        _baoNum++;
        numLabel.text = [NSString stringWithFormat:@"%ld件" , (long)_baoNum];
    } else if ([superView isEqual:_zhongView]) {
        _zhongNum++;
        numLabel.text = [NSString stringWithFormat:@"%ld件" , (long)_zhongNum];
    } else if ([superView isEqual:_houView]) {
        _houNum++;
        numLabel.text = [NSString stringWithFormat:@"%ld件" , (long)_houNum];
    }
    _sumJianShu = _baoNum + _zhongNum + _houNum;
    sumLable.text = [NSString stringWithFormat:@"共%ld件" , (long)_sumJianShu];
    
    _sumTime = _baoNum * baoTime > _zhongNum * zhongTime ? _baoNum * baoTime : _zhongNum * zhongTime;
    _sumTime = _sumTime > _houNum * houTime ? _sumTime : _houNum * houTime;

    
    if ((_sumTime % 60) < 10) {
        yuJiLabel.text = [NSString stringWithFormat:@"预计:%ld时:0%ld分" , _sumTime / 60 , _sumTime % 60];
    } else {
        yuJiLabel.text = [NSString stringWithFormat:@"预计:%ld时:%ld分" , _sumTime / 60 , _sumTime % 60];
    }
    
}

- (void)minusDoneAtcion:(UIButton *)btn {
    UIView *superView = btn.superview;
    UILabel *numLabel = [superView.subviews objectAtIndex:0];
    UILabel *sumLable = [view viewWithTag:123];
    UILabel *yuJiLabel = [view viewWithTag:321];
    
    if ([superView isEqual:_baoView]) {
        _baoNum--;
        if (_baoNum <= 0) {
            _baoNum = 0;
        }
        numLabel.text = [NSString stringWithFormat:@"%ld件" , (long)_baoNum];
        
    } else if ([superView isEqual:_zhongView]) {
        _zhongNum--;
        if (_zhongNum <= 0) {
            _zhongNum = 0;
        }
        numLabel.text = [NSString stringWithFormat:@"%ld件" , (long)_zhongNum];
        
    } else if ([superView isEqual:_houView]) {
        _houNum--;
        if (_houNum <= 0) {
            _houNum = 0;
        }
        numLabel.text = [NSString stringWithFormat:@"%ld件" , (long)_houNum];
    }
    _sumJianShu = _baoNum + _zhongNum + _houNum;
    sumLable.text = [NSString stringWithFormat:@"共%ld件" , (long)_sumJianShu];
    
    _sumTime = _baoNum * baoTime > _zhongNum * zhongTime ? _baoNum * baoTime : _zhongNum * zhongTime;
    _sumTime = _sumTime > _houNum * houTime ? _sumTime : _houNum * houTime;
  
    if ((_sumTime % 60) < 10) {
        yuJiLabel.text = [NSString stringWithFormat:@"预计:%ld时:0%ld分" , _sumTime / 60 , _sumTime % 60];
    } else {
        yuJiLabel.text = [NSString stringWithFormat:@"预计:%ld时:%ld分" , _sumTime / 60 , _sumTime % 60];
    }
}

- (void)beginBtnAtcion:(UIButton *)btn {
    
    btn.selected = YES;
    
    
    NSString *locationDate = [NSString getNowTimeString];
    NSInteger confirmTimeInterval = _sumTime * 60 + [NSString getNowTimeInterval];
    NSString *confirmTimeStr = [NSString turnTimeIntervalToString:confirmTimeInterval];
    
//    NSLog(@"%@ , %@" , locationDate , confirmTimeStr);
    
    NSString *locationDate2 = [locationDate substringWithRange:NSMakeRange(11, 5)];
    NSString *confirmTimeStr2 = [confirmTimeStr substringWithRange:NSMakeRange(11, 5)];
    locationDate = [locationDate substringFromIndex:14];
    confirmTimeStr = [confirmTimeStr substringFromIndex:14];
    
    UILabel *sumLable = [view viewWithTag:123];
    UILabel *yuJiLabel = [view viewWithTag:321];
    
    
    NSDictionary *ganYiJiHongGanDic = @{@"baoNum" : @(_baoNum) , @"zhongNum" : @(_zhongNum) , @"houNum" : @(_houNum) , @"sumLable" : sumLable.text , @"yuJiLabel" : yuJiLabel.text , @"locationDate" : locationDate , @"confirmTimeStr" : confirmTimeStr , @"date2" : @(confirmTimeInterval)};
//    NSLog(@"%@" , ganYiJiHongGanDic);
    
    [kStanderDefault setObject:ganYiJiHongGanDic forKey:@"ganYiJiHongGanDic"];
    
    [kStanderDefault removeObjectForKey:@"GanYiJiData"];
    
    
    if (![locationDate2 isEqualToString:confirmTimeStr2]) {
        
        
        if ([kStanderDefault objectForKey:@"offBtn"]) {
            NSString *isOpen = [kStanderDefault objectForKey:@"offBtn"];
            if ([isOpen isEqualToString:@"NO"]) {
                
                [kSocketTCP sendDataToHost:GanYiJiXieYi(self.serviceModel.devTypeSn, self.serviceModel.devSn, @"01", @"00", @"02", @"02") andType:kZhiLing andIsNewOrOld:kNew];
                [kStanderDefault setObject:@"NO" forKey:@"offBtn"];
            }
        }
        
        if (_serviceModel.devSn) {
            //    需要上传数据到服务器
            NSDictionary *parames = @{@"devSn" : self.serviceModel.devSn , @"task.fSwitchOn" : @(0) , @"task.fSwitchOff" : @(1) , @"task.onJobTime" : locationDate2 , @"task.offJobTime" : confirmTimeStr2};
            [HelpFunction requestDataWithUrlString:kGanYiJiDeDingShiURL andParames:parames andDelegate:self];
            
        }

    } else{
        [UIAlertController creatRightAlertControllerWithHandle:nil andSuperViewController:self.currentVC Title:@"请选择衣物"];
    }

    
    [[NSNotificationCenter defaultCenter] postNotification:[NSNotification notificationWithName:@"GanYiJiBeginWork" object:nil userInfo:@{@"GanYiJiBeginWork" : @"YES"}]];
}

- (void)requestData:(HelpFunction *)request didSuccess:(NSDictionary *)dddd {
    NSLog(@"定时---%@" , dddd);
}

- (void)requestData:(HelpFunction *)request didFailLoadData:(NSError *)error {
    NSLog(@"%@" , error);
}

- (void)setServiceModel:(ServicesModel *)serviceModel {
    _serviceModel = serviceModel;
    
    [self initGanYiJiHongGanDic];
    
    if ([kStanderDefault objectForKey:@"ganYiJiHongGanDic"]) {
        _ganYiJiHongGanDic = [[kStanderDefault objectForKey:@"ganYiJiHongGanDic"] mutableCopy];
        
        for (int i = 0; i < 3; i++) {
            
            NSArray *arrayView = @[_baoView , _zhongView , _houView];
            UIView *vieeee = arrayView[i];
            UILabel *numLabel = [vieeee.subviews objectAtIndex:0];
            
            
            if ([_ganYiJiHongGanDic allValues].count != 0) {
                if (i == 0) {
                    numLabel.text = [NSString stringWithFormat:@"%@件" , _ganYiJiHongGanDic[@"baoNum"]];
                } else if (i == 1) {
                    numLabel.text = [NSString stringWithFormat:@"%@件" , _ganYiJiHongGanDic[@"zhongNum"]];
                } else if (i == 2) {
                    numLabel.text = [NSString stringWithFormat:@"%@件" , _ganYiJiHongGanDic[@"houNum"]];
                }
            }
        }
        
        UILabel *sumLable = [view viewWithTag:123];
        UILabel *yuJiLabel = [view viewWithTag:321];
        if ([_ganYiJiHongGanDic allValues].count != 0) {
            sumLable.text = _ganYiJiHongGanDic[@"sumLable"];
            yuJiLabel.text = _ganYiJiHongGanDic[@"yuJiLabel"];
        }

    } else {
        [self.contentView.subviews[0] removeFromSuperview];
        [self customUI];
    }
    
    
}

@end
