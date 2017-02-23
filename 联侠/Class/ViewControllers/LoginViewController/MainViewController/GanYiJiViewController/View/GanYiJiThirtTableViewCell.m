//
//  GanYiJiThirtTableViewCell.m
//  联侠
//
//  Created by 杭州阿尔法特 on 16/6/27.
//  Copyright © 2016年 张海昌. All rights reserved.
//

#import "GanYiJiThirtTableViewCell.h"
#import "GanYiJiDingShiCollectionViewController.h"
@interface GanYiJiThirtTableViewCell ()<GanYiJiDingShiCollectionViewControllerDelegate>

@property (nonatomic , strong) UIButton *firstBtn;
@property (nonatomic , strong) UIButton *secondBtn;
@property (nonatomic , strong) UIButton *thirtBtn;
@property (nonatomic , strong) UILabel *openLable;
@property (nonatomic , strong) UILabel *offLable;
@property (nonatomic , strong) UILabel *titleLable;
@property (nonatomic , strong) NSArray *dataArray;
@end

@implementation GanYiJiThirtTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self customUI];
    }
    return self;
}

//- (void)getMoShiArray22:(NSNotification *)post {
//    
//    _moShiArray = [NSArray arrayWithArray:post.userInfo[@"moShiArray"]];
//    
//    [self setButtonOfSubViewsGraryColor:_firstBtn];
//    [self setButtonOfSubViewsGraryColor:_secondBtn];
//    [self setButtonOfSubViewsGraryColor:_thirtBtn];
//    
//    if ([_moShiArray[1] isEqualToString:@"NO"]) {
//        
//        
//        [self setButtonOfSubViewsGraryColor:_firstBtn];
//        [self setButtonOfSubViewsGraryColor:_secondBtn];
//        [self setButtonOfSubViewsGraryColor:_thirtBtn];
//        
//    } else {
//        
//        if ([_moShiArray[0] isEqualToString:@"first"]) {
//            
//            [self setButtonOfSubViewsColor:_firstBtn];
//        } else if ([_moShiArray[0] isEqualToString:@"second"]) {
//            [self setButtonOfSubViewsColor:_secondBtn];
//        } else if ([_moShiArray[0] isEqualToString:@"thirt"]) {
//            [self setButtonOfSubViewsColor:_thirtBtn];
//        }
//        
//    }
//    
//}
//
//- (void)getAirTimeTextArray22:(NSNotification *)post {
//    
//    _timeTextArray = post.userInfo[@"AirTimeTextArray"];
//    
//}

- (void)customUI {
    
    
    //cell选中时的颜色
    self.selectionStyle = UITableViewCellSeparatorStyleNone;
    //显示最右边的箭头
    //    self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenW, kScreenH * 3 / 9.57142)];
    view.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:view];
    
    
    for (int i = 0; i < 3; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
        [view addSubview:button];
//        button.frame = CGRectMake(0, kScreenH  * i / 9.57142 - (i - 1) + kScreenH / 13.34, kScreenW, kScreenH  / 9.57142);
        button.frame = CGRectMake(0, kScreenH  * i / 9.57142 - (i - 1) , kScreenW, kScreenH  / 9.57142);
        
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
        imageView.image = [imageView.image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
        imageView.tintColor = [UIColor grayColor];
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
        //        label.backgroundColor = [UIColor redColor];
        
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
        jianTouImage.image = [jianTouImage.image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
        jianTouImage.tintColor = [UIColor lightGrayColor];
        [jianTouImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(button.height * 1 / 3, button.height * 1 / 3));
            make.right.mas_equalTo(button.mas_right).offset(-20);
            make.centerY.mas_equalTo(button.mas_centerY);
        }];
        jianTouImage.tag = 3 * button.tag + 6;
        
        
    }
    
    
    
    for (int i = 0; i < 3; i++) {
        NSArray *textArray = nil;
        textArray = @[@"快放入春秋衣物，让我为您烘干吧" , @"快放入夏季衣物，让我为您烘干吧" , @"快放入洞冬天衣物，让我为您烘干吧" ];
        
        
        NSArray *nameArray = nil;
        nameArray = @[@"春秋模式" , @"夏季模式" , @"冬季模式"];
        
        
        NSArray *btnArray = @[_firstBtn , _secondBtn , _thirtBtn];
        
        [self setLableTextOfBtn:btnArray[i] andText:textArray[i] andTitle:nameArray[i]];
    }
    
    NSArray *array = nil;
    array = [kStanderDefault objectForKey:@"GanYiJiDingShiData"];
    
    _dataArray = array;
    
    NSDate *date = [NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"HH:mm"];
    NSString *time = [formatter stringFromDate:date];
    
    if ([_dataArray[2] compare:time] == -1) {
        [kStanderDefault removeObjectForKey:@"GanYiJiDingShiData"];
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
    
}

- (void)getGanYiJiDelegate:(GanYiJiDingShiCollectionViewController *)ganYiJiVC andDelegate:(NSArray *)dataArray {

    _dataArray = dataArray;
    
    
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
    
    lable2.text = [NSString stringWithFormat:@"开启 : %@" , _dataArray[1]];
    lable3.text = [NSString stringWithFormat:@"关闭 : %@" , _dataArray[2]];
    lable5.text = [NSString stringWithFormat:@"时长 : %@ 分" , _dataArray[3]];
    imageView.tintColor = kKongJingYanSe;
    lable1.textColor = kKongJingYanSe;
    lable2.textColor = kKongJingYanSe;
    lable3.textColor = kKongJingYanSe;
    lable5.textColor = kKongJingYanSe;
    jianTouImageView.tintColor = kKongJingYanSe;
    
    
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
    imageView.tintColor = [UIColor grayColor];
    lable1.textColor = [UIColor grayColor];
    lable2.textColor = [UIColor grayColor];
    lable3.textColor = [UIColor grayColor];
    lable4.textColor = [UIColor grayColor];
    lable5.textColor = [UIColor grayColor];
    jianTouImageView.tintColor = [UIColor grayColor];
    
    
}


- (void)buttonAtcion:(UIButton *)btn {
    GanYiJiDingShiCollectionViewController *ganYiJiVC = [[GanYiJiDingShiCollectionViewController alloc]init];
    ganYiJiVC.delegate = self;
    ganYiJiVC.serviceModel = self.serviceModel;
    NSArray *nameArray = @[@"外出模式" , @"周末模式" , @"智能模式" , @"自定义模式"];
    switch (btn.tag) {
        case 0: {
            ganYiJiVC.titleText = nameArray[0];
            ganYiJiVC.fromWhich = @"first";
            [self.vc.navigationController pushViewController:ganYiJiVC animated:YES];
            break;
        }
        case 1: {
            
            ganYiJiVC.titleText = nameArray[1];
            ganYiJiVC.fromWhich = @"second";
            [self.vc.navigationController pushViewController:ganYiJiVC animated:YES];
            break;
        }
        case 2: {
            
            ganYiJiVC.titleText = nameArray[2];
            ganYiJiVC.fromWhich = @"thirt";
            [self.vc.navigationController pushViewController:ganYiJiVC animated:YES];
            break;
        }
        default:
            break;
    }
}



//- (NSArray *)timeTextArray {
//    if (!_timeTextArray) {
//        _timeTextArray = [NSArray array];
//    }
//    return _timeTextArray;
//}

- (void)setServiceModel:(ServicesModel *)serviceModel {
    _serviceModel = serviceModel;
}

- (void)setLableTextOfBtn:(UIButton *)btn andText:(NSString *)subText andTitle:(NSString *)title{
    
    
    UILabel *lable = [btn viewWithTag:(3 * btn.tag + 2)];
    lable.text = title;
    
    UILabel *lable2 = [btn viewWithTag:(3 * btn.tag + 5)];
    lable2.text = subText;
}

- (NSArray *)dataArray {
    if (!_dataArray) {
        _dataArray = [NSArray array];
    }
    return _dataArray;
}

@end
