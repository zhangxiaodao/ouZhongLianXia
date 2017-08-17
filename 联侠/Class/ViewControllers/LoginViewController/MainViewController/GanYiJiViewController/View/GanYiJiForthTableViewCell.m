//
//  GanYiJiForthTableViewCell.m
//  联侠
//
//  Created by 杭州阿尔法特 on 16/7/20.
//  Copyright © 2016年 张海昌. All rights reserved.
//

#import "GanYiJiForthTableViewCell.h"
#import "GanYiJiDingShiViewController.h"


@interface GanYiJiForthTableViewCell ()

@property (nonatomic , strong) UIButton *firstBtn;
@property (nonatomic , strong) UIButton *secondBtn;
@property (nonatomic , strong) UIButton *thirtBtn;
@property (nonatomic , strong) UILabel *openLable;
@property (nonatomic , strong) UILabel *offLable;
@property (nonatomic , strong) UILabel *titleLable;
@property (nonatomic , strong) NSArray *dataArray;
@property (nonatomic , strong) NSDictionary *dic;
@end

@implementation GanYiJiForthTableViewCell

- (NSDictionary *)dic {
    if (!_dic) {
        _dic = [NSDictionary dictionary];
    }
    return _dic;
}

- (NSArray *)dataArray {
    if (!_dataArray) {
        _dataArray = [NSArray array];
    }
    return _dataArray;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self customUI];
    }
    return self;
}

- (void)getCommonGanYiJiData:(NSNotification *)post {
    _dataArray = post.userInfo[@"commonGanYiJiData"];

//    NSLog(@"%@" , _dataArray);
    [self setButtonOfSubViewsGraryColor:_firstBtn];
    [self setButtonOfSubViewsGraryColor:_secondBtn];
    [self setButtonOfSubViewsGraryColor:_thirtBtn];

    if ([_dataArray[0] isEqualToString:@"first"]) {
        [self setButtonOfSubViewsColor:_firstBtn];
    } else if ([_dataArray[0] isEqualToString:@"second"]) {
        [self setButtonOfSubViewsColor:_secondBtn];
    } else if ([_dataArray[0] isEqualToString:@"thirt"]) {
        [self setButtonOfSubViewsColor:_thirtBtn];
    }
    
}

- (void)getGanYiJiIsChongZhi:(NSNotification *)post {
    if ([post.userInfo[@"GanYiJiChongZhi"] isEqualToString:@"YES"]) {
        [self setButtonOfSubViewsGraryColor:_firstBtn];
        [self setButtonOfSubViewsGraryColor:_secondBtn];
        [self setButtonOfSubViewsGraryColor:_thirtBtn];
    }
}

- (void)customUI {
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getCommonGanYiJiData:) name:@"commonGanYiJiData" object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getGanYiJiIsChongZhi:) name:@"GanYiJiChongZhi" object:nil];
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenW, kScreenH * 3 / 9.57142)];
    view.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:view];
    
    
    for (int i = 0; i < 3; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
        [view addSubview:button];
      
        button.frame = CGRectMake(0, kScreenH  * i / 9.57142 - (i - 1) , kScreenW, kScreenH  / 9.57142);
        
        button.tag = i;
        [button addTarget:self action:@selector(buttonForthAtcion:) forControlEvents:UIControlEventTouchUpInside];
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
            default:
                break;
        }
        
        UIImageView *imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"gouHao"]];
        [button addSubview:imageView];
        [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(button.height * 1 / 3, button.height * 1 / 3));
            make.centerX.mas_equalTo(button.mas_left).offset(kScreenW / 9.375);
            make.centerY.mas_equalTo(button.mas_centerY);
        }];
        
        [UIImageView setImageViewColor:imageView andColor:[UIColor grayColor]];
        imageView.tag = 3 * button.tag + 1;
        
        
        
        UILabel *label = [UILabel creatLableWithTitle:@"" andSuperView:button andFont:k20 andTextAligment:NSTextAlignmentLeft];
        label.textColor  =[UIColor grayColor];
        label.layer.borderWidth = 0;
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(kScreenW / 3, button.height * 1 / 3));
            make.left.mas_equalTo(imageView.mas_right).offset(kScreenW / 9.375);
            make.bottom.mas_equalTo(button.mas_centerY);
        }];
        label.tag = 3 * button.tag + 2;
        
        UILabel *label5 = [UILabel creatLableWithTitle:@"" andSuperView:button andFont:k14 andTextAligment:NSTextAlignmentLeft];
        label5.textColor  =[UIColor grayColor];
        label5.layer.borderWidth = 0;
        [label5 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(kScreenW / 4, button.height * 1 / 3));
            make.left.mas_equalTo(label.mas_right);
            make.top.mas_equalTo(label.mas_top);
        }];
        label5.tag = 3 * button.tag + 7;
        
        UILabel *label2 = [UILabel creatLableWithTitle:@"" andSuperView:button andFont:k14 andTextAligment:NSTextAlignmentLeft];
        label2.textColor  =[UIColor grayColor];
        label2.layer.borderWidth = 0;
        [label2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(kScreenW / 4, button.height * 1 / 3));
            make.left.mas_equalTo(label.mas_left);
            make.top.mas_equalTo(button.mas_centerY);
        }];
        label2.tag = 3 * button.tag + 3;
        
        
        UILabel *label3 = [UILabel creatLableWithTitle:@"" andSuperView:button andFont:k14 andTextAligment:NSTextAlignmentLeft];
        label3.textColor  =[UIColor grayColor];
        label3.layer.borderWidth = 0;
        [label3 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(kScreenW / 4, button.height * 1 / 3));
            make.left.mas_equalTo(label5.mas_left);
            make.top.mas_equalTo(button.mas_centerY);
        }];
        label3.tag = 3 * button.tag + 4;
        
        
        
        UILabel *label4 = [UILabel creatLableWithTitle:@"" andSuperView:button andFont:k14 andTextAligment:NSTextAlignmentLeft];
        label4.textColor  =[UIColor grayColor];
        label4.layer.borderWidth = 0;
        [label4 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(kScreenW * 2 / 3, button.height * 1 / 3));
            make.left.mas_equalTo(label.mas_left);
            make.top.mas_equalTo(button.mas_centerY);
        }];
        label4.tag = 3 * button.tag + 5;
        
        UIImageView *jianTouImage = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"iconfont-qianjin"]];
        [button addSubview:jianTouImage];
        
        [UIImageView setImageViewColor:jianTouImage andColor:[UIColor lightGrayColor]];
        [jianTouImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(button.height * 1 / 3, button.height * 1 / 3));
            make.right.mas_equalTo(button.mas_right).offset(-20);
            make.centerY.mas_equalTo(button.mas_centerY);
        }];
        jianTouImage.tag = 3 * button.tag + 6;
        
        
    }
    
    [self setButtonOfSubViewsGraryColor:_firstBtn];
    [self setButtonOfSubViewsGraryColor:_secondBtn];
    [self setButtonOfSubViewsGraryColor:_thirtBtn];
    
    for (int i = 0; i < 3; i++) {
        NSArray *textArray = nil;
        textArray = @[@"让孩子感受到您温暖的爱" , @"让您所有的衣服温暖如初" , @"您自己选择烘干的时长" ];
        
        NSArray *nameArray = nil;
        nameArray = @[@"儿童衣物模式" , @"存衣祛湿模式" , @"自定义模式"];
        
        NSArray *btnArray = @[_firstBtn , _secondBtn , _thirtBtn];
        
        [self setLableTextOfBtn:btnArray[i] andText:textArray[i] andTitle:nameArray[i]];
    }
    
    
}


- (void)setLableTextOfBtn:(UIButton *)btn andText:(NSString *)subText andTitle:(NSString *)title{
    
    
    UILabel *lable = [btn viewWithTag:(3 * btn.tag + 2)];
    lable.text = title;
    
    UILabel *lable2 = [btn viewWithTag:(3 * btn.tag + 5)];
    lable2.text = subText;
}

- (void)buttonForthAtcion:(UIButton *)btn {
    
    GanYiJiDingShiViewController *ganYiJiDingShiVC = [[GanYiJiDingShiViewController alloc]init];
    ganYiJiDingShiVC.serviceModel = self.serviceModel;
    
    NSArray *titleArray = @[@"儿童衣物模式" , @"存衣祛湿模式" , @"自定义模式"];
    NSArray *fromWhichArray = @[@"first" , @"second" , @"thirt"];
    
    ganYiJiDingShiVC.fromWhich = fromWhichArray[btn.tag];
    ganYiJiDingShiVC.titleText = titleArray[btn.tag];
    [self.vc.navigationController pushViewController:ganYiJiDingShiVC animated:YES];
    
}


- (void)setButtonOfSubViewsColor:(UIButton *)btn {
    UIImageView *imageView = [btn viewWithTag:(3 * btn.tag + 1)];
    UILabel *lable1 = [btn viewWithTag:(3 * btn.tag + 2)];
    UILabel *lable2 = [btn viewWithTag:(3 * btn.tag + 3)];
    UILabel *lable3 = [btn viewWithTag:(3 * btn.tag + 4)];
    UILabel *lable4 = [btn viewWithTag:(3 * btn.tag + 5)];
    UILabel *lable5 = [btn viewWithTag:(3 * btn.tag + 7)];
    UIImageView *jianTouImageView = [btn viewWithTag:(3 * btn.tag + 6)];
    
    lable2.hidden = NO;
    lable3.hidden = NO;
    lable5.hidden = NO;
    lable4.hidden = YES;
    
    lable2.text = [NSString stringWithFormat:@"%@" , _dataArray[2]];
    lable3.text = [NSString stringWithFormat:@"%@" , _dataArray[3]];
    lable5.text = [NSString stringWithFormat:@"%@" , _dataArray[1]];
    imageView.tintColor = [UIColor whiteColor];
    lable1.textColor = [UIColor whiteColor];
    lable2.textColor = [UIColor whiteColor];
    lable3.textColor = [UIColor whiteColor];
    lable5.textColor = [UIColor whiteColor];
    jianTouImageView.tintColor = [UIColor whiteColor];
    btn.backgroundColor = kKongJingYanSe;
    
}


- (void)setButtonOfSubViewsGraryColor:(UIButton *)btn {
    UIImageView *imageView = [btn viewWithTag:(3 * btn.tag + 1)];
    UILabel *lable1 = [btn viewWithTag:(3 * btn.tag + 2)];
    UILabel *lable2 = [btn viewWithTag:(3 * btn.tag + 3)];
    UILabel *lable3 = [btn viewWithTag:(3 * btn.tag + 4)];
    UILabel *lable4 = [btn viewWithTag:(3 * btn.tag + 5)];
    UILabel *lable5 = [btn viewWithTag:(3 * btn.tag + 7)];
    UIImageView *jianTouImageView = [btn viewWithTag:(3 * btn.tag + 6)];
    
    
    lable2.hidden = YES;
    lable3.hidden = YES;
    lable5.hidden = YES;
    lable4.hidden = NO;
    imageView.tintColor = kKongJingYanSe;
    lable1.textColor = kKongJingYanSe;
    lable2.textColor = kKongJingYanSe;
    lable3.textColor = kKongJingYanSe;
    lable4.textColor = kKongJingYanSe;
    lable5.textColor = kKongJingYanSe;
    jianTouImageView.tintColor = kKongJingYanSe;
    btn.backgroundColor = [UIColor whiteColor];
    
}

- (void)setServiceModel:(ServicesModel *)serviceModel {
    _serviceModel = serviceModel;
    
    if ([kStanderDefault objectForKey:@"GanYiJiData"]) {
        _dic = [kStanderDefault objectForKey:@"GanYiJiData"];
        
        _dataArray = [NSArray arrayWithObjects:[_dic objectForKey:@"formWhich"], [_dic objectForKey:@"time"] , [_dic objectForKey:@"openTime"] , [_dic objectForKey:@"closeTime"] , nil];
        
        NSString *closeTime = [_dataArray[3] substringWithRange:NSMakeRange(3, 5)];
        
        NSDate *date = [NSDate date];
        NSDateFormatter *fm = [[NSDateFormatter alloc]init];
        [fm setDateFormat:@"HH:mm"];
        NSString *locationTime = [fm stringFromDate:date];
        
        //         NSLog(@"%@ , %@ , %@ , %@ , %ld" , _dic , _dataArray , closeTime , locationTime , [locationTime compare:closeTime]);
        
        if ([locationTime compare:closeTime] > 0) {
            [kStanderDefault removeObjectForKey:@"GanYiJiData"];
        } else {
            [self setButtonOfSubViewsGraryColor:_firstBtn];
            [self setButtonOfSubViewsGraryColor:_secondBtn];
            [self setButtonOfSubViewsGraryColor:_thirtBtn];
            
            if ([_dataArray[0] isEqualToString:@"first"]) {
                [self setButtonOfSubViewsColor:_firstBtn];
            } else if ([_dataArray[0] isEqualToString:@"second"]) {
                [self setButtonOfSubViewsColor:_secondBtn];
            } else if ([_dataArray[0] isEqualToString:@"thirt"]) {
                [self setButtonOfSubViewsColor:_thirtBtn];
            }
        }
        
    } else {
        [self.contentView.subviews[0] removeFromSuperview];
        
        [self customUI];
    }

}
- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
@end
