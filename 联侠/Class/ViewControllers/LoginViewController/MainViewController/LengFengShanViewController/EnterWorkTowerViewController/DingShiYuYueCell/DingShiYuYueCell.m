//
//  DingShiYuYueCell.m
//  AEFT冷风扇
//
//  Created by 杭州阿尔法特 on 16/5/18.
//  Copyright © 2016年 阿尔法特. All rights reserved.
//

#import "DingShiYuYueCell.h"
#import "AFNetworking.h"
@interface DingShiYuYueCell ()<UIPickerViewDataSource , UIPickerViewDelegate , HelpFunctionDelegate>

@property (nonatomic , strong) UIImageView *sureView;
@property (nonatomic , strong) UIImageView *sureImage;

@property (nonatomic , strong) UIView *firstPickView;
@property (nonatomic , strong) UIView *secondPickView;
@property (nonatomic , strong) UIView *thirtPickView;
@property (nonatomic , strong) UIView *forthPickView;


@property (nonatomic , strong) NSMutableArray *hourArray;
@property (nonatomic , strong) NSMutableArray *minuteArray;
@property (nonatomic , strong) NSArray *modelArray;
@property (nonatomic , strong) NSArray *windArray;

@property (nonatomic , strong) NSMutableDictionary *dic;


@property (nonatomic , strong) UILabel *timeLable;
@property (nonatomic , retain) UILabel *modelLable;
@property (nonatomic , retain) UILabel *windLable;
@property (nonatomic , retain) UILabel *time1Lable;
@property (nonatomic , retain) UILabel *maxTimeLable;
@property (nonatomic , strong) UIButton *queDingBtn;
@property (nonatomic  ,strong) UIButton *queDingBtn1;

@property (nonatomic  ,strong) UIView *pickerBgView;
@property (nonatomic , strong) UIPickerView *myPicker;
@property (strong, nonatomic) UIView *maskView;
@property (nonatomic , strong) NSMutableArray *btnArray;
@end

@implementation DingShiYuYueCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self creatPickViewData];
        
        [self setUI];
        
    }
    return self;
}



#pragma mark - 设置UI界面
- (void)setUI{
    self.dic =  [[kStanderDefault objectForKey:@"data"] mutableCopy];
    NSLog(@"%@" , self.dic);
    
    UILabel *offLable = [UILabel creatLableWithTitle:[NSString stringWithFormat:@"开启设定"] andSuperView:self.contentView andFont:k20 andTextAligment:NSTextAlignmentCenter];
    offLable.backgroundColor = [UIColor clearColor];
    offLable.layer.borderWidth = 0;
    offLable.textColor = [UIColor whiteColor];
    [offLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kScreenW / 4.6875, kScreenH / 22.23333));
        make.left.mas_equalTo(kScreenW / 5.76923);
        make.top.mas_equalTo(self.contentView.mas_top).offset(10);
    }];
    
    self.timeLable = [UILabel creatLableWithTitle:[NSString  stringWithFormat:@"%@" , self.dic[@"timeLable"] ] andSuperView:self.contentView andFont:k16 andTextAligment:NSTextAlignmentCenter];
    self.timeLable.textColor = [UIColor whiteColor];
    self.timeLable.backgroundColor = [UIColor clearColor];
    self.timeLable.tag = 2;
    self.timeLable.userInteractionEnabled = YES;
    [self.timeLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kScreenW / 4.6875, kScreenH / 22.23333));
        make.left.mas_equalTo(offLable.mas_right).offset(kScreenW / 4.16666);
        make.centerY.mas_equalTo(offLable.mas_centerY);
    }];
    UITapGestureRecognizer *timeTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAtcion:)];
    [self.timeLable addGestureRecognizer:timeTap];
    
    self.queDingBtn = [UIButton initWithTitle:@"" andColor:[UIColor clearColor] andSuperView:self.contentView];
    self.queDingBtn.layer.borderColor = [UIColor whiteColor].CGColor;
    //    self.queDingBtn.tag = 1;
    [self.queDingBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.contentView.mas_right).offset(- (kScreenW / 5.76923) / 2);
        make.centerY.mas_equalTo(self.timeLable.mas_bottom).offset(kScreenH / 66.7 );
        make.size.mas_equalTo(CGSizeMake(kScreenW / 20, kScreenW / 20));
    }];
    self.queDingBtn.layer.cornerRadius = kScreenW / 40;
    self.queDingBtn.layer.borderWidth = 1;
    if ([[self.dic objectForKey:@"queDingBtn"] integerValue] == 0) {
        [self.queDingBtn setImage:[UIImage new] forState:UIControlStateNormal];
        [self.queDingBtn removeTarget:nil action:nil forControlEvents:UIControlEventTouchUpInside];
        [self.queDingBtn addTarget:self action:@selector(queDingBtn1Atcion:) forControlEvents:UIControlEventTouchUpInside];
    } else {
        [self.queDingBtn setImage:[UIImage imageNamed:@"iconfont-gougou"] forState:UIControlStateNormal];
        [self.queDingBtn setTintColor:[UIColor clearColor]];
        [self.queDingBtn removeTarget:nil action:nil forControlEvents:UIControlEventTouchUpInside];
        [self.queDingBtn addTarget:self action:@selector(queDingBtn1AgainAtcion:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    
    self.modelLable = [UILabel creatLableWithTitle:[NSString stringWithFormat:@"%@" , self.dic[@"model"]] andSuperView:self.contentView andFont:k16 andTextAligment:NSTextAlignmentCenter];
    self.modelLable.textColor = [UIColor whiteColor];
    self.modelLable.tag = 3;
    self.modelLable.userInteractionEnabled = YES;
    self.modelLable.backgroundColor = [UIColor clearColor];
    [self.modelLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kScreenW / 4.6875, kScreenH / 22.23333));
        make.left.mas_equalTo(kScreenW / 5.76923);
        make.top.mas_equalTo(offLable.mas_bottom).offset(kScreenH / 33.35);
    }];
    UITapGestureRecognizer *modelTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAtcion:)];
    [self.modelLable addGestureRecognizer:modelTap];
    
    
    self.windLable = [UILabel creatLableWithTitle:[NSString stringWithFormat:@"%@" , self.dic[@"wind"]] andSuperView:self.contentView andFont:k16 andTextAligment:NSTextAlignmentCenter];
    self.windLable.textColor = [UIColor whiteColor];
    self.windLable.backgroundColor = [UIColor clearColor];
    self.windLable.tag = 4;
    self.windLable.userInteractionEnabled = YES;
    [self.windLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kScreenW / 4.6875, kScreenH / 22.23333));
        make.left.mas_equalTo(self.modelLable.mas_right).offset(kScreenW / 4.16666);
        make.centerY.mas_equalTo(self.modelLable.mas_centerY);
    }];
    UITapGestureRecognizer *windTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAtcion:)];
    [self.windLable addGestureRecognizer:windTap];
    
    
    
    
    UIView *fenGeView = [[UIView alloc]init];
    fenGeView.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:fenGeView];
    [fenGeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(kScreenW / 10.7142);
        make.size.mas_equalTo(CGSizeMake(kScreenW - kScreenW * 2 / 10.7142, 1));
        make.top.mas_equalTo(self.windLable.mas_bottom).offset(kScreenH / 33.35);
    }];
    
    UILabel *onLable = [UILabel creatLableWithTitle:@"关闭设定" andSuperView:self.contentView andFont:k20 andTextAligment:NSTextAlignmentCenter];
    onLable.layer.borderWidth = 0;
    onLable.textColor = [UIColor whiteColor];
    onLable.backgroundColor = [UIColor clearColor];
    
    [onLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kScreenW / 4.6875, kScreenH / 22.23333));
        make.left.mas_equalTo(kScreenW / 5.76923);
        make.top.mas_equalTo(fenGeView.mas_top).offset(kScreenH / 33.35);
    }];
    
    self.time1Lable = [UILabel creatLableWithTitle:[NSString stringWithFormat:@"%@" ,  self.dic[@"time1Lable"]] andSuperView:self.contentView andFont:k16 andTextAligment:NSTextAlignmentCenter];
    self.time1Lable.textColor = [UIColor whiteColor];
    self.time1Lable.backgroundColor = [UIColor clearColor];
    self.time1Lable.tag = 6;
    self.time1Lable.userInteractionEnabled = YES;
    [self.time1Lable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kScreenW / 4.6875, kScreenW / 12));
        make.left.mas_equalTo(onLable.mas_right).offset(kScreenW / 4.16666);
        make.centerY.mas_equalTo(onLable.mas_centerY);
    }];
    UITapGestureRecognizer *time1Tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAtcion:)];
    [self.time1Lable addGestureRecognizer:time1Tap];
    
    
    self.queDingBtn1 = [UIButton initWithTitle:@"" andColor:[UIColor clearColor] andSuperView:self.contentView];
    self.queDingBtn1.layer.borderColor = [UIColor whiteColor].CGColor;
    //    self.queDingBtn1.tag = 2;
    [self.queDingBtn1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.queDingBtn.mas_centerX);
        make.centerY.mas_equalTo(self.time1Lable.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(kScreenW / 20, kScreenW / 20));
    }];
    self.queDingBtn1.layer.cornerRadius = kScreenW / 40;
    self.queDingBtn1.layer.borderWidth = 1;
    if ([[self.dic objectForKey:@"queDingBtn1"] integerValue] == 0) {
        [self.queDingBtn1 setImage:[UIImage new] forState:UIControlStateNormal];
        [self.queDingBtn1 removeTarget:nil action:nil forControlEvents:UIControlEventTouchUpInside];
        [self.queDingBtn1 addTarget:self action:@selector(queDingBtn1Atcion:) forControlEvents:UIControlEventTouchUpInside];
    } else {
        [self.queDingBtn1 setImage:[UIImage imageNamed:@"iconfont-gougou"] forState:UIControlStateNormal];
        [self.queDingBtn1 setTintColor:[UIColor clearColor]];
        [self.queDingBtn1 removeTarget:nil action:nil forControlEvents:UIControlEventTouchUpInside];
        [self.queDingBtn1 addTarget:self action:@selector(queDingBtn1AgainAtcion:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    
    UIView *fenGeView1 = [[UIView alloc]init];
    fenGeView1.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:fenGeView1];
    [fenGeView1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(kScreenW / 10.7142);
        make.size.mas_equalTo(CGSizeMake(kScreenW - kScreenW * 2 / 10.7142, 1));
        make.top.mas_equalTo(self.time1Lable.mas_bottom).offset(kScreenH / 33.35);
    }];
    
    
    UILabel *maxOnLable = [UILabel creatLableWithTitle:@"设定最大开启时间" andSuperView:self.contentView andFont:k20 andTextAligment:NSTextAlignmentCenter];
    maxOnLable.layer.borderWidth = 0;
    maxOnLable.textColor = [UIColor whiteColor];
    maxOnLable.backgroundColor = [UIColor clearColor];
    [maxOnLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kScreenW / 2.34375, kScreenW / 12));
        make.left.mas_equalTo(kScreenW / 5.76923);
        make.top.mas_equalTo(fenGeView1.mas_top).offset(kScreenH / 33.35);
    }];
    
    
    self.maxTimeLable = [UILabel creatLableWithTitle:[NSString stringWithFormat:@"%@" , self.dic[@"maxTimeLable"]] andSuperView:self.contentView andFont:k16 andTextAligment:NSTextAlignmentCenter];
    self.maxTimeLable.textColor = [UIColor whiteColor];
    self.maxTimeLable.backgroundColor = [UIColor clearColor];
    self.maxTimeLable.tag = 8;
    self.maxTimeLable.userInteractionEnabled = YES;
    [self.maxTimeLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kScreenW / 13.5, kScreenW / 12));
        make.left.mas_equalTo(maxOnLable.mas_right).offset(5);
        make.centerY.mas_equalTo(maxOnLable.mas_centerY);
    }];
    UITapGestureRecognizer *maxTimeTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAtcion:)];
    [self.maxTimeLable addGestureRecognizer:maxTimeTap];
    
    UILabel *xiaoShiLable = [UILabel creatLableWithTitle:@"小时" andSuperView:self.contentView andFont:k20 andTextAligment:NSTextAlignmentCenter];
    xiaoShiLable.layer.borderWidth = 0;
    xiaoShiLable.textColor = [UIColor whiteColor];
    [xiaoShiLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.maxTimeLable.mas_right).offset(5);
        make.size.mas_equalTo(CGSizeMake(kScreenW / 8, kScreenW / 12));
        make.centerY.mas_equalTo(maxOnLable.mas_centerY);
    }];
    
    UILabel *wenHaoLable = [UILabel creatLableWithTitle:@"?" andSuperView:self.contentView andFont:k15 andTextAligment:NSTextAlignmentCenter];
    wenHaoLable.layer.borderWidth = 1;
    wenHaoLable.layer.borderColor = [UIColor whiteColor].CGColor;
    wenHaoLable.textColor = [UIColor whiteColor];
    wenHaoLable.backgroundColor = [UIColor clearColor];
    wenHaoLable.userInteractionEnabled = YES;
    wenHaoLable.layer.cornerRadius = kScreenW / 40;
    wenHaoLable.layer.masksToBounds = YES;
    
    [wenHaoLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kScreenW / 20, kScreenW / 20));
        make.left.mas_equalTo(xiaoShiLable.mas_right).offset(5);
        make.centerY.mas_equalTo(xiaoShiLable.mas_centerY);
    }];
    
    UITapGestureRecognizer *wenHaoTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(wenHaoAtcion:)];
    [wenHaoLable addGestureRecognizer:wenHaoTap];
    
    
    UIView *fenGeView2 = [[UIView alloc]init];
    fenGeView2.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:fenGeView2];
    [fenGeView2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(kScreenW / 10.7142);
        make.size.mas_equalTo(CGSizeMake(kScreenW - kScreenW * 2 / 10.7142, 1));
        make.top.mas_equalTo(maxOnLable.mas_bottom).offset(kScreenH / 33.35);
    }];
    
    UIButton *leftBtn = nil;
    UIButton *rightBtn = nil;
    NSArray *array = [NSArray arrayWithObjects:@"一", @"二" , @"三" , @"四" , @"五" , @"六" , @"日", nil];
    for (int i = 0; i < 7; i++) {
        UIButton *btn = [UIButton initWithTitle:[NSString stringWithFormat:@"%@" , array[i]] andColor:[UIColor clearColor] andSuperView:self.contentView];
        btn.tag = i;
        btn.layer.cornerRadius = 0;
        btn.layer.borderWidth = 1;
        
        btn.layer.borderColor = [UIColor whiteColor].CGColor;
        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(kScreenW  / 9.375 + i * ((kScreenW - kScreenW * 2 / 9.375) / 7 - 1)) ;
            make.size.mas_equalTo(CGSizeMake((kScreenW - kScreenW * 2 / 9.375) / 7, (kScreenW - kScreenW * 2 / 9.375) / 7));
            make.top.mas_equalTo(fenGeView2.mas_top).offset(kScreenH / 33.35);
        }];
        
        if (btn.tag == 0) {
            if ([[self.dic objectForKey:@"yi"] isEqualToString:@"1"]) {
                btn.selected = YES;
            }
            leftBtn = btn;
        } else if (btn.tag == 1) {
            if ([[self.dic objectForKey:@"er"] isEqualToString:@"1"]) {
                btn.selected = YES;
            }
        } else if (btn.tag == 2) {
            if ([[self.dic objectForKey:@"san"] isEqualToString:@"1"]) {
                btn.selected = YES;
            }
        } else if (btn.tag == 3) {
            if ([[self.dic objectForKey:@"si"] isEqualToString:@"1"]) {
                btn.selected = YES;
            }
        } else if (btn.tag == 4) {
            if ([[self.dic objectForKey:@"wu"] isEqualToString:@"1"]) {
                btn.selected = YES;
            }
        } else if (btn.tag == 5) {
            if ([[self.dic objectForKey:@"liu"] isEqualToString:@"1"]) {
                btn.selected = YES;
            }
        } else if (btn.tag == 6) {
            if ([[self.dic objectForKey:@"qi"] isEqualToString:@"1"]) {
                btn.selected = YES;
            }
            rightBtn = btn;
        }
        
        if (btn.selected == YES) {
            btn.backgroundColor = [UIColor clearColor];
            [btn setTitleColor:kMainColor forState:UIControlStateNormal];
            [btn addTarget:self action:@selector(btnAgainAtcion:) forControlEvents:UIControlEventTouchUpInside];
        } else {
            [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            btn.backgroundColor = [UIColor clearColor];
            [btn addTarget:self action:@selector(btnAtcion:) forControlEvents:UIControlEventTouchUpInside];
        }
        
        [self.btnArray addObject:btn];
    }
    
    UIButton *cancleBtn = [UIButton initWithTitle:@"重置" andColor:kMainColor andSuperView:self.contentView];
    [cancleBtn addTarget:self action:@selector(chongZhiAction:) forControlEvents:UIControlEventTouchUpInside];
    [cancleBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake((kScreenW / 2 - 40) / 2, kScreenW / 10));
        make.left.mas_equalTo(leftBtn.mas_left);
        make.top.mas_equalTo(leftBtn.mas_bottom).offset(10);
    }];
    
    
    UIButton *doneBtn = [UIButton initWithTitle:@"确定" andColor:kMainColor andSuperView:self.contentView];
    doneBtn.tag = 33;
    [doneBtn addTarget:self action:@selector(queDingBtn1Atcion:) forControlEvents:UIControlEventTouchUpInside];
    [doneBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake((kScreenW / 2 - 40) / 2, kScreenW / 10));
        make.right.mas_equalTo(rightBtn.mas_right);
        make.top.mas_equalTo(rightBtn.mas_bottom).offset(10);
    }];
    
    [cancleBtn setBackgroundImage:[self imageWithColor:[UIColor colorWithRed:218/255.0 green:235/255.0 blue:254/255.0 alpha:1.0]] forState:UIControlStateHighlighted];
    [doneBtn setBackgroundImage:[self imageWithColor:[UIColor colorWithRed:218/255.0 green:235/255.0 blue:254/255.0 alpha:1.0]] forState:UIControlStateHighlighted];
    
    if ([self.dic objectForKey:@"timeLable"] == nil) {
        self.timeLable.text = @"00:00";
    }  if ([self.dic objectForKey:@"model"] == nil) {
        self.modelLable.text = @"模式未选";
    }  if ([self.dic objectForKey:@"wind"] == nil) {
        self.windLable.text = @"风速未选";
    }  if ([self.dic objectForKey:@"time1Lable"] == nil) {
        self.time1Lable.text = @"00:00";
    }  if ([self.dic objectForKey:@"maxTimeLable"] == nil) {
        self.maxTimeLable.text = @"00";
    }
    
    
    if (self.queDingBtn.imageView.image.size.width == 0) {
        self.queDingBtn.tag = 0;
    } else {
        self.queDingBtn.tag = 1;
    }
    
    if (self.queDingBtn1.imageView.image.size.width == 0) {
        self.queDingBtn1.tag = 0;
    } else {
        self.queDingBtn1.tag = 1;
    }
}


/**
 *  颜色转换为图片
 *
 *
 */
- (UIImage *)imageWithColor:(UIColor *)color {
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

#pragma mark - 充值数据
- (void)chongZhiAction:(UIButton *)btn {
    
    [self.dic removeAllObjects];
    [kStanderDefault removeObjectForKey:@"data"];
    //    NSArray *array = [NSArray arrayWithArray:self.contentView.subviews];
    //    for (int i = 0; i < array.count; i++) {
    //        [array[i] removeFromSuperview];
    //    }
    //
    //    [self setUI];
    
    self.timeLable.text = @"00:00";
    self.modelLable.text = @"模式未选";
    self.windLable.text = @"风速未选";
    self.time1Lable.text = @"00:00";
    self.maxTimeLable.text = @"00";
    
    
    [self.queDingBtn setImage:[UIImage new] forState:UIControlStateNormal];
    [self.queDingBtn removeTarget:nil action:nil forControlEvents:UIControlEventTouchUpInside];
    [self.queDingBtn addTarget:self action:@selector(queDingBtn1Atcion:) forControlEvents:UIControlEventTouchUpInside];
    
    
    [self.queDingBtn1 setImage:[UIImage new] forState:UIControlStateNormal];
    [self.queDingBtn1 removeTarget:nil action:nil forControlEvents:UIControlEventTouchUpInside];
    [self.queDingBtn1 addTarget:self action:@selector(queDingBtn1Atcion:) forControlEvents:UIControlEventTouchUpInside];
    
    for (int i = 0; i < 7; i++) {
        UIButton *btn = self.btnArray[i];
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        btn.backgroundColor = [UIColor clearColor];
        [btn addTarget:self action:@selector(btnAtcion:) forControlEvents:UIControlEventTouchUpInside];
    }
    
}


#pragma mark - 设定确认按钮点击事件
- (void)queDingBtn1Atcion:(UIButton *)btn {
    //    btn.backgroundColor = [UIColor clearColor];
    
    if (btn.tag != 33) {
        
        [btn setImage:[UIImage imageNamed:@"iconfont-gougou"] forState:UIControlStateNormal];
        [btn setTintColor:[UIColor clearColor]];
    }
    if ([btn isEqual:self.queDingBtn]) {
        self.queDingBtn.tag = 1;
    } else if ([btn isEqual:self.queDingBtn1]){
        self.queDingBtn1.tag = 1;
    }
    
    [self.dic setObject:@(self.queDingBtn.tag) forKey:@"queDingBtn"];
    [self.dic setObject:@(self.queDingBtn1.tag) forKey:@"queDingBtn1"];
    NSDictionary *dataDic = [self.dic mutableCopy];
    [kStanderDefault setObject:dataDic forKey:@"data"];
    
    if (btn.tag == 33) {
        [self getData];
    }
    
    NSLog(@"%ld , %ld" , (long)self.queDingBtn.tag , (long)self.queDingBtn1.tag);
    [btn removeTarget:nil action:nil forControlEvents:UIControlEventTouchUpInside];
    
    [btn addTarget:self action:@selector(queDingBtn1AgainAtcion:) forControlEvents:UIControlEventTouchUpInside];
}

#pragma mark - 设定确认按钮再次点击事件
- (void)queDingBtn1AgainAtcion:(UIButton *)btn {
    //    btn.backgroundColor = [UIColor clearColor];
    [btn setImage:[UIImage new] forState:UIControlStateNormal];
    
    if ([btn isEqual:self.queDingBtn]) {
        self.queDingBtn.tag = 0;
    } else if ([btn isEqual:self.queDingBtn1]) {
        self.queDingBtn1.tag = 0;
    }
    
    [self.dic setObject:@(self.queDingBtn.tag) forKey:@"queDingBtn"];
    [self.dic setObject:@(self.queDingBtn1.tag) forKey:@"queDingBtn1"];
    NSDictionary *dataDic = [self.dic mutableCopy];
    [kStanderDefault setObject:dataDic forKey:@"data"];
    NSLog(@"%ld , %ld" , (long)self.queDingBtn.tag , (long)self.queDingBtn1.tag);
    
    [btn removeTarget:nil action:nil forControlEvents:UIControlEventTouchUpInside];
    [btn addTarget:self action:@selector(queDingBtn1Atcion:) forControlEvents:UIControlEventTouchUpInside];
    
}

#pragma mark - 提交数据
- (void)getData {
    
    NSString *task = [NSString stringWithFormat:@"%d%d%d%d%d%d%d" , [[self.dic objectForKey:@"yi"] intValue], [[self.dic objectForKey:@"er"] intValue] , [[self.dic objectForKey:@"san"] intValue], [[self.dic objectForKey:@"si"] intValue], [[self.dic objectForKey:@"wu"] intValue], [[self.dic objectForKey:@"liu"] intValue], [[self.dic objectForKey:@"qi"] intValue]];
    
    
    NSUInteger modelIndex = 0;
    NSUInteger windIndex = 0;
    for (NSString *items in self.modelArray) {
        if ([items isEqualToString:self.modelLable.text]) {
            modelIndex = [self.modelArray indexOfObject:items];
        }
    }
    
    for (NSString *itemss in self.windArray) {
        if ([itemss isEqualToString:self.windLable.text]) {
            windIndex = [self.windArray indexOfObject:itemss];
        }
    }
    
    NSInteger i = [self.maxTimeLable.text intValue] * 60 * 60 * 1000;
    
    
    NSDictionary *parames = @{@"devSn" : self.serviceModel.devSn ,@"task.fSwitchOn" : @(self.queDingBtn.tag) , @"task.fSwitchOff" : @(self.queDingBtn1.tag) , @"task.onJobTime" : self.timeLable.text , @"task.offJobTime" : self.time1Lable.text , @"task.fMode" : @(modelIndex + 1) , @"task.fWind" : @(windIndex + 1) , @"task.durTime" : @(i) , @"task.runWeek" : task};
    
    NSLog(@"%@" , parames);
    
    
    [HelpFunction requestDataWithUrlString:kLengFengShanDingShiYuYue andParames:parames andDelegate:self];
    
    [UIAlertController creatRightAlertControllerWithHandle:nil andSuperViewController:kWindowRoot Title:@"预约成功"];
    
}


- (void)requestData:(HelpFunction *)request didSuccess:(NSDictionary *)dddd {
    NSLog(@"%@" , dddd);
    
    
}


#pragma mark - 星期的点击事件
- (void)btnAtcion:(UIButton *)btn {
    btn.backgroundColor = [UIColor whiteColor];
    [btn setTitleColor:[UIColor colorWithRed:46 / 255.0 green:190 / 255.0 blue:105 / 255.0 alpha:1.0] forState:UIControlStateNormal];
    
    if (btn.tag == 0) {
        [self.dic setObject:@"1" forKey:@"yi"];
    } else if (btn.tag == 1) {
        [self.dic setObject:@"1" forKey:@"er"];
    } else if (btn.tag == 2) {
        [self.dic setObject:@"1" forKey:@"san"];
    } else if (btn.tag == 3) {
        [self.dic setObject:@"1" forKey:@"si"];
    } else if (btn.tag == 4) {
        [self.dic setObject:@"1" forKey:@"wu"];
    }else if (btn.tag == 5) {
        [self.dic setObject:@"1" forKey:@"liu"];
    }else if (btn.tag == 6) {
        [self.dic setObject:@"1" forKey:@"qi"];
    }
    
    [btn addTarget:self action:@selector(btnAgainAtcion:) forControlEvents:UIControlEventTouchUpInside];
    
}

#pragma mark - 星期再次点击事件
- (void)btnAgainAtcion:(UIButton *)btn {
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    btn.backgroundColor = [UIColor clearColor];
    
    if (btn.tag == 0) {
        [self.dic setObject:@"0" forKey:@"yi"];
    } else if (btn.tag == 1) {
        [self.dic setObject:@"0" forKey:@"er"];
    } else if (btn.tag == 2) {
        [self.dic setObject:@"0" forKey:@"san"];
    } else if (btn.tag == 3) {
        [self.dic setObject:@"0" forKey:@"si"];
    } else if (btn.tag == 4) {
        [self.dic setObject:@"0" forKey:@"wu"];
    }else if (btn.tag == 5) {
        [self.dic setObject:@"0" forKey:@"liu"];
    }else if (btn.tag == 6) {
        [self.dic setObject:@"0" forKey:@"qi"];
    }
    
    [btn addTarget:self action:@selector(btnAtcion:) forControlEvents:UIControlEventTouchUpInside];
}

#pragma mark - 问好的点击事件
- (void)wenHaoAtcion:(UITapGestureRecognizer *)btn {
    
    [UIAlertController creatRightAlertControllerWithHandle:nil andSuperViewController:kWindowRoot Title:@"设定您机器的最大开启时间"];
}


#pragma mark - 几个控件的点击事件
- (void)tapAtcion:(UITapGestureRecognizer *)tap {
    if (tap.view.tag == 1 || tap.view.tag == 2) {
        self.firstPickView = [self creatPickView];
    } else if (tap.view.tag == 3 || tap.view.tag == 4) {
        self.secondPickView = [self creatPickView];
    } else if (tap.view.tag == 5 || tap.view.tag == 6) {
        self.thirtPickView = [self creatPickView];
    } else  {
        self.forthPickView = [self creatPickView];
    }
}


#pragma mark - 创建UIPickView
- (UIView *)creatPickView{
    
    self.maskView = [[UIView alloc] initWithFrame:kScreenFrame];
    self.maskView.backgroundColor = [UIColor clearColor];
    //    self.maskView.alpha = 0;
    self.maskView.userInteractionEnabled = YES;
    //    [self.view addSubview:self.maskView];
    [self.maskView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideMyPicker)]];
    
    
    self.pickerBgView = [[UIView alloc]initWithFrame:CGRectMake(0, kScreenH - kScreenH / 2.61568, kScreenW, kScreenH / 2.61568)];
    
    self.pickerBgView.backgroundColor = [UIColor whiteColor];
    
    self.myPicker = [[UIPickerView alloc]init];
    [self.pickerBgView addSubview:self.myPicker];
    [self.myPicker mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kScreenW, kScreenH / 3.08796));
        make.left.mas_equalTo(0);
        make.top.mas_equalTo(kScreenH / 17.1025);
    }];
    self.myPicker.delegate = self;
    self.myPicker.dataSource = self;
    
    [UIView animateWithDuration:0.3 animations:^{
        self.pickerBgView.alpha = 1.0;
    }];
    
    
    UIView *view  =[[UIView alloc]init];
    view.backgroundColor = [UIColor colorWithRed:224/255.0 green:224/255.0 blue:224/255.0 alpha:1.0];
    [self.pickerBgView addSubview:view];
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kScreenW, kScreenH / 17.1025));
        make.left.mas_equalTo(0);
        make.top.mas_equalTo(0);
    }];
    
    UIButton *cancleBtn = [UIButton initWithTitle:@"取消" andColor:[UIColor clearColor] andSuperView:view]
    ;
    [cancleBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [cancleBtn addTarget:self action:@selector(cancel:) forControlEvents:UIControlEventTouchUpInside];
    [cancleBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.size.mas_equalTo(CGSizeMake(kScreenW / 4, kScreenH / 17.1025));
        make.top.mas_equalTo(0);
    }];
    
    UIButton *sureBtn = [UIButton initWithTitle:@"确定" andColor:[UIColor clearColor] andSuperView:view]
    ;
    [sureBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [sureBtn addTarget:self action:@selector(ensure:) forControlEvents:UIControlEventTouchUpInside];
    [sureBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(0);
        make.size.mas_equalTo(CGSizeMake(kScreenW / 4, kScreenH / 17.1025));
        make.top.mas_equalTo(0);
    }];
    
    [self.contentView addSubview:self.maskView];
    [self.contentView addSubview:self.pickerBgView];
    
    self.pickerBgView.top = self.contentView.height;
    
    [UIView animateWithDuration:0.3 animations:^{
        
        self.myPicker.alpha = 1.0;
        self.pickerBgView.bottom = self.contentView.height;
    }];
    
    return self.pickerBgView;
    
}

#pragma mark - 确定  取消  的点击事件
- (void)cancel:(UIButton *)btn {
    [self hideMyPicker];
}

- (void)ensure:(UIButton *)btn {
    
    UIPickerView *firstPickerView = self.firstPickView.subviews[0];
    UIPickerView *secondPickerView = self.secondPickView.subviews[0];
    UIPickerView *thirtPickerView = self.thirtPickView.subviews[0];
    UIPickerView *forthPickerView = self.forthPickView.subviews[0];
    
    
    self.timeLable.text = [NSString stringWithFormat:@"%@:%@" , self.hourArray[[firstPickerView selectedRowInComponent:0]] , self.minuteArray[[firstPickerView selectedRowInComponent:1]]];
    self.modelLable.text = [NSString stringWithFormat:@"%@" , self.modelArray[[secondPickerView selectedRowInComponent:0]]];
    self.windLable.text = [NSString stringWithFormat:@"%@" , self.windArray[[secondPickerView selectedRowInComponent:1]]];
    
    self.time1Lable.text = [NSString stringWithFormat:@"%@:%@" , self.hourArray[[thirtPickerView selectedRowInComponent:0]] , self.minuteArray[[thirtPickerView selectedRowInComponent:1]]];
    
    self.maxTimeLable.text = [NSString stringWithFormat:@"%@" , self.hourArray[[forthPickerView selectedRowInComponent:0]]];
    
    [self.dic setObject:self.timeLable.text forKey:@"timeLable"];
    [self.dic setObject:self.modelLable.text forKey:@"model"];
    [self.dic setObject:self.windLable.text forKey:@"wind"];
    [self.dic setObject:self.time1Lable.text forKey:@"time1Lable"];
    [self.dic setObject:self.maxTimeLable.text forKey:@"maxTimeLable"];
    
    [self hideMyPicker];
}


#pragma mark - 隐藏UIPickView
- (void)hideMyPicker {
    [UIView animateWithDuration:0.3 animations:^{
        self.maskView.alpha = 0;
        self.pickerBgView.top = self.contentView.height;
    } completion:^(BOOL finished) {
        [self.maskView removeFromSuperview];
        [self.pickerBgView removeFromSuperview];
    }];
}

#pragma mark - UIPickView的代理
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    
    if ([pickerView isEqual:self.forthPickView.subviews[0]]) {
        return 1;
    }
    return 2;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    
    if ([pickerView isEqual:self.secondPickView.subviews[0]]) {
        if (component == 0) {
            return self.modelArray.count;
        } else {
            return self.windArray.count;
        }
    } else if ([pickerView isEqual:self.forthPickView.subviews[0]]) {
        return self.hourArray.count;
    } else {
        if (component == 0) {
            return self.hourArray.count;
        } else {
            return self.minuteArray.count;
        }
    }
}
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    if ([pickerView isEqual:self.secondPickView.subviews[0]]) {
        if (component == 0) {
            return [self.modelArray objectAtIndex:row];
        } else {
            return [self.windArray objectAtIndex:row];
        }
    } else if ([pickerView isEqual:self.forthPickView.subviews[0]]) {
        return [self.hourArray objectAtIndex:row];
    } else {
        if (component == 0) {
            return [self.hourArray objectAtIndex:row];
        } else {
            return [self.minuteArray objectAtIndex:row];
        }
    }
}

#pragma mark - PickView的点击事件
//- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
//
//
//    if ([pickerView isEqual:self.forthPickView.subviews[0]]) {
//        NSInteger i =  [pickerView selectedRowInComponent:0];
//        self.maxTimeLable.text = [NSString stringWithFormat:@"%@" , self.hourArray[i]];
//    } else {
//        NSInteger i =  [pickerView selectedRowInComponent:0];
//        NSInteger j =  [pickerView selectedRowInComponent:1];
//        if ([pickerView isEqual:self.firstPickView.subviews[0]]) {
//            self.timeLable.text = [NSString stringWithFormat:@"%@:%@" , self.hourArray[[pickerView selectedRowInComponent:0]] , self.minuteArray[[pickerView selectedRowInComponent:1]]];
//        } else if ([pickerView isEqual:self.secondPickView.subviews[0]]) {
//            self.modelLable.text = [NSString stringWithFormat:@"%@" , self.modelArray[[pickerView selectedRowInComponent:0]]];
//            self.windLable.text = [NSString stringWithFormat:@"%@" , self.windArray[[pickerView selectedRowInComponent:1]]];
//        } else if ([pickerView isEqual:self.thirtPickView.subviews[0]]) {
//            self.time1Lable.text = [NSString stringWithFormat:@"%@:%@" , self.hourArray[[pickerView selectedRowInComponent:0]] , self.minuteArray[[pickerView selectedRowInComponent:1]]];
//        }
//    }
//}

- (void)creatPickViewData{
    self.windArray = [NSArray arrayWithObjects: @"未选",@"低速", @"中速" , @"高速" ,  nil];
    self.modelArray = [NSArray arrayWithObjects:@"未选" , @"正常" , @"自然" , @"睡眠" ,  nil];
    self.minuteArray = [NSMutableArray array];
    for (int i = 0; i < 60; i++) {
        if (i < 10) {
            [self.minuteArray addObject:[NSString stringWithFormat:@"0%d" , i]];
        } else {
            [self.minuteArray addObject:[NSString stringWithFormat:@"%d" , i]];
        }
        
    }
    
    self.hourArray = [NSMutableArray array];
    for (int i = 0; i < 24; i++) {
        if (i < 10) {
            [self.hourArray addObject:[NSString stringWithFormat:@"0%d" , i]];
        } else {
            [self.hourArray addObject:[NSString stringWithFormat:@"%d" , i]];
        }
        
    }
}

- (NSMutableDictionary *)dic{
    if (!_dic) {
        self.dic = [NSMutableDictionary dictionary];
    }
    return _dic;
}

- (NSMutableArray *)btnArray {
    if (!_btnArray) {
        _btnArray = [NSMutableArray array];
    }
    return _btnArray;
}

@end
