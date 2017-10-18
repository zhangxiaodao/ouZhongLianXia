//
//  DingShiYuYueCell.m
//  AEFT冷风扇
//
//  Created by 杭州阿尔法特 on 16/5/18.
//  Copyright © 2016年 阿尔法特. All rights reserved.
//

#import "DingShiYuYueCell.h"
#import "AFNetworking.h"
#import "CustomPickerView.h"
@interface DingShiYuYueCell ()<UIPickerViewDataSource , UIPickerViewDelegate , HelpFunctionDelegate , CustomPickerViewDelegate>

@property (nonatomic , strong) UIImageView *sureView;
@property (nonatomic , strong) UIImageView *sureImage;

@property (nonatomic , strong) CustomPickerView *firstPickView;
@property (nonatomic , strong) CustomPickerView *secondPickView;
@property (nonatomic , strong) CustomPickerView *thirtPickView;
@property (nonatomic , strong) CustomPickerView *forthPickView;


@property (nonatomic , strong) NSMutableArray *hourArray;
@property (nonatomic , strong) NSMutableArray *minuteArray;
@property (nonatomic , strong) NSArray *modelArray;
@property (nonatomic , strong) NSArray *windArray;

@property (nonatomic , strong) NSMutableDictionary *dic;


@property (nonatomic , strong) UILabel *openTimeLabel;
@property (nonatomic , retain) UILabel *modelLable;
@property (nonatomic , retain) UILabel *windLable;
@property (nonatomic , retain) UILabel *closeTimeLabel;
@property (nonatomic , retain) UILabel *maxopenTimeLabel;
@property (nonatomic , strong) UIButton *openBtn;
@property (nonatomic  ,strong) UIButton *closeBtn;

@property (nonatomic  ,strong) UIView *pickerBgView;
@property (nonatomic , strong) UIPickerView *myPicker;
@property (strong, nonatomic) UIView *maskView;
@property (nonatomic , strong) NSMutableArray *btnArray;
@property (nonatomic , strong) NSArray *keysArray;
@end

@implementation DingShiYuYueCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
//        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenW, kScreenH / 2 + kScreenW / 10 + 30)];
//        view.backgroundColor = [UIColor clearColor];
//        [self.contentView addSubview:view];
//
//        UILabel *offLable = [UILabel creatLableWithTitle:@"开启设定" andSuperView:view andFont:k20 andTextAligment:NSTextAlignmentCenter];
//        offLable.textColor = [UIColor whiteColor];
//        [offLable mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.left.mas_equalTo(kScreenW / 5.8);
//            make.top.mas_equalTo(view.mas_top)
//            .offset(10);
//        }];
//
//        UILabel *openTimeLabel = [UILabel creatLableWithTitle:@"00:00" andSuperView:view andFont:k16 andTextAligment:NSTextAlignmentCenter];
//        openTimeLabel.textColor = [UIColor whiteColor];
//        openTimeLabel.userInteractionEnabled = YES;
//        [openTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.right.mas_equalTo(view.mas_right).offset(-kScreenW / 5.8);
//            make.centerY.mas_equalTo(offLable.mas_centerY);
//        }];
//        UITapGestureRecognizer *timeTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAtcion:)];
//        [openTimeLabel addGestureRecognizer:timeTap];
//        self.openTimeLabel = openTimeLabel;
        
        [self setupUI];
        
//        [self dic];
        
    }
    return self;
}



#pragma mark - 设置UI界面
- (void)setupUI{
  
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenW, kScreenH / 2 )];
    view.backgroundColor = [UIColor clearColor];
    [self.contentView addSubview:view];
    
    UILabel *offLable = [UILabel creatLableWithTitle:@"开启设定" andSuperView:view andFont:k20 andTextAligment:NSTextAlignmentCenter];
    offLable.textColor = [UIColor whiteColor];
    [offLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(kScreenW / 5.8);
        make.top.mas_equalTo(view.mas_top)
        .offset(10);
    }];
    
    UILabel *openTimeLabel = [UILabel creatLableWithTitle:@"00:00" andSuperView:view andFont:k16 andTextAligment:NSTextAlignmentCenter];
    openTimeLabel.textColor = [UIColor whiteColor];
    openTimeLabel.userInteractionEnabled = YES;
    [openTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(view.mas_right).offset(-kScreenW / 5.8);
        make.centerY.mas_equalTo(offLable.mas_centerY);
    }];
    UITapGestureRecognizer *timeTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAtcion:)];
    [openTimeLabel addGestureRecognizer:timeTap];
    self.openTimeLabel = openTimeLabel;
    
    self.openBtn = [UIButton initWithTitle:@"" andColor:[UIColor clearColor] andSuperView:view];
    self.openBtn.layer.borderColor = [UIColor whiteColor].CGColor;
    [self.openBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(view.mas_right)
        .offset(- (kScreenW / 5.8) / 2);
        make.centerY
        .mas_equalTo(self.openTimeLabel.mas_bottom)
        .offset(kScreenH / 66.7 );
        make.size.mas_equalTo(CGSizeMake(kScreenW / 20, kScreenW / 20));
    }];
    self.openBtn.layer.cornerRadius = kScreenW / 40;
    self.openBtn.layer.borderWidth = 1;

    self.modelLable = [UILabel creatLableWithTitle:@"模式未选" andSuperView:view andFont:k16 andTextAligment:NSTextAlignmentCenter];
    self.modelLable.textColor = [UIColor whiteColor];
    self.modelLable.userInteractionEnabled = YES;
    [self.modelLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(offLable.mas_centerX);
        make.top.mas_equalTo(offLable.mas_bottom)
        .offset(kScreenH / 33.35);
    }];
    UITapGestureRecognizer *modelTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAtcion:)];
    [self.modelLable addGestureRecognizer:modelTap];

    self.windLable = [UILabel creatLableWithTitle:@"风速未选" andSuperView:view andFont:k16 andTextAligment:NSTextAlignmentCenter];
    self.windLable.textColor = [UIColor whiteColor];
    self.windLable.userInteractionEnabled = YES;
    [self.windLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX
        .mas_equalTo(self.openTimeLabel.mas_centerX);
        make.centerY.mas_equalTo(self.modelLable.mas_centerY);
    }];
    UITapGestureRecognizer *windTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAtcion:)];
    [self.windLable addGestureRecognizer:windTap];

    UIView *fenGeView = [[UIView alloc]init];
    fenGeView.backgroundColor = [UIColor whiteColor];
    [view addSubview:fenGeView];
    [fenGeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX
        .mas_equalTo(view.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(kScreenW - kScreenW / 5, 1));
        make.top.mas_equalTo(self.windLable.mas_bottom)
        .offset(kScreenH / 33.35);
    }];

    UILabel *onLable = [UILabel creatLableWithTitle:@"关闭设定" andSuperView:view andFont:k20 andTextAligment:NSTextAlignmentCenter];
    onLable.textColor = [UIColor whiteColor];
    [onLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(offLable.mas_centerX);
        make.top.mas_equalTo(fenGeView.mas_top)
        .offset(kScreenH / 33.35);
    }];

    self.closeTimeLabel = [UILabel creatLableWithTitle:@"00:00" andSuperView:view andFont:k16 andTextAligment:NSTextAlignmentCenter];
    self.closeTimeLabel.textColor = [UIColor whiteColor];
    self.closeTimeLabel.userInteractionEnabled = YES;
    [self.closeTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX
        .mas_equalTo(self.openTimeLabel.mas_centerX);
        make.centerY.mas_equalTo(onLable.mas_centerY);
    }];
    UITapGestureRecognizer *time1Tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAtcion:)];
    [self.closeTimeLabel addGestureRecognizer:time1Tap];


    self.closeBtn = [UIButton initWithTitle:@"" andColor:[UIColor clearColor] andSuperView:view];
    self.closeBtn.layer.borderColor = [UIColor whiteColor].CGColor;
    [self.closeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.openBtn.mas_centerX);
        make.centerY
        .mas_equalTo(self.closeTimeLabel.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(kScreenW / 20, kScreenW / 20));
    }];
    self.closeBtn.layer.cornerRadius = kScreenW / 40;
    self.closeBtn.layer.borderWidth = 1;

    UIView *fenGeView1 = [[UIView alloc]init];
    fenGeView1.backgroundColor = [UIColor whiteColor];
    [view addSubview:fenGeView1];
    [fenGeView1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX
        .mas_equalTo(view.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(kScreenW - kScreenW / 5, 1));
        make.top
        .mas_equalTo(self.closeTimeLabel.mas_bottom).offset(kScreenH / 33.35);
    }];

    UILabel *maxOnLable = [UILabel creatLableWithTitle:@"设定最大开启时间" andSuperView:view andFont:k20 andTextAligment:NSTextAlignmentCenter];
    maxOnLable.textColor = [UIColor whiteColor];
    [maxOnLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(onLable.mas_left);
        make.top.mas_equalTo(fenGeView1.mas_top)
        .offset(kScreenH / 33.35);
    }];

    self.maxopenTimeLabel = [UILabel creatLableWithTitle:@"00" andSuperView:view andFont:k16 andTextAligment:NSTextAlignmentCenter];
    self.maxopenTimeLabel.textColor = [UIColor whiteColor];
    self.maxopenTimeLabel.userInteractionEnabled = YES;
    [self.maxopenTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(maxOnLable.mas_right).offset(5);
        make.centerY.mas_equalTo(maxOnLable.mas_centerY);
    }];
    UITapGestureRecognizer *maxTimeTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAtcion:)];
    [self.maxopenTimeLabel addGestureRecognizer:maxTimeTap];

    UILabel *xiaoShiLable = [UILabel creatLableWithTitle:@"小时" andSuperView:view andFont:k20 andTextAligment:NSTextAlignmentCenter];
    xiaoShiLable.textColor = [UIColor whiteColor];
    [xiaoShiLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left
        .mas_equalTo(self.maxopenTimeLabel.mas_right).offset(5);
        make.centerY.mas_equalTo(maxOnLable.mas_centerY);
    }];

    UILabel *wenHaoLable = [UILabel creatLableWithTitle:@"?" andSuperView:view andFont:k15 andTextAligment:NSTextAlignmentCenter];
    wenHaoLable.textColor = [UIColor whiteColor];
    [wenHaoLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kScreenW / 20, kScreenW / 20));
        make.left.mas_equalTo(xiaoShiLable.mas_right)
        .offset(5);
        make.centerY.mas_equalTo(xiaoShiLable.mas_centerY);
    }];
    wenHaoLable.userInteractionEnabled = YES;
    UITapGestureRecognizer *wenHaoTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(wenHaoAtcion:)];
    [wenHaoLable addGestureRecognizer:wenHaoTap];
    wenHaoLable.layer.borderWidth = 1;
    wenHaoLable.layer.borderColor = [UIColor whiteColor].CGColor;
    wenHaoLable.layer.cornerRadius = kScreenW / 40;
    wenHaoLable.layer.masksToBounds = YES;

    UIView *fenGeView2 = [[UIView alloc]init];
    fenGeView2.backgroundColor = [UIColor whiteColor];
    [view addSubview:fenGeView2];
    [fenGeView2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX
        .mas_equalTo(view.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(kScreenW - kScreenW / 5, 1));
        make.top.mas_equalTo(maxOnLable.mas_bottom)
        .offset(kScreenH / 33.35);
    }];

    UIButton *leftBtn = nil;
    UIButton *rightBtn = nil;
    NSArray *array = @[@"一", @"二" , @"三" , @"四" , @"五" , @"六" , @"日"];

    for (int i = 0; i < array.count; i++) {
        UIButton *btn = [UIButton initWithTitle:[NSString stringWithFormat:@"%@" , array[i]] andColor:[UIColor clearColor] andSuperView:view];
        btn.tag = i;
        btn.layer.cornerRadius = 0;
        btn.layer.borderWidth = 1;
        btn.layer.borderColor = [UIColor whiteColor].CGColor;
        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(kScreenW  / 9.375 + i * ((kScreenW - kScreenW * 2 / 9.375) / 7 - 1)) ;
            make.size.mas_equalTo(CGSizeMake((kScreenW - kScreenW * 2 / 9.375) / 7, (kScreenW - kScreenW * 2 / 9.375) / 7));
            make.top.mas_equalTo(fenGeView2.mas_top)
            .offset(kScreenH / 33.35);
        }];

        if (i == 0) {
            leftBtn = btn;
        } else if (i == 6) {
            rightBtn = btn;
        }

        if ([self.dic[self.keysArray[i]] isEqualToString:@"1"]) {
            btn.selected = YES;
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

    UIButton *cancleBtn = [UIButton initWithTitle:@"重置" andColor:kMainColor andSuperView:view];
    [cancleBtn addTarget:self action:@selector(chongZhiAction) forControlEvents:UIControlEventTouchUpInside];
    [cancleBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake((kScreenW / 2 - 40) / 2, kScreenW / 10));
        make.left.mas_equalTo(leftBtn.mas_left);
        make.top.mas_equalTo(leftBtn.mas_bottom)
        .offset(kScreenH / 33.35);
    }];

    UIButton *doneBtn = [UIButton initWithTitle:@"确定" andColor:kMainColor andSuperView:view];
    [doneBtn addTarget:self action:@selector(closeBtnAtcion:) forControlEvents:UIControlEventTouchUpInside];
    [doneBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake((kScreenW / 2 - 40) / 2, kScreenW / 10));
        make.right.mas_equalTo(rightBtn.mas_right);
        make.top.mas_equalTo(rightBtn.mas_bottom)
        .offset(kScreenH / 33.35);
    }];
    doneBtn.tag = 33;

    [cancleBtn setBackgroundImage:[UIImage imageWithColor:[UIColor colorWithRed:218/255.0 green:235/255.0 blue:254/255.0 alpha:1.0]] forState:UIControlStateHighlighted];
    [doneBtn setBackgroundImage:[UIImage imageWithColor:[UIColor colorWithRed:218/255.0 green:235/255.0 blue:254/255.0 alpha:1.0]] forState:UIControlStateHighlighted];

    self.openTimeLabel.tag = 2;
    self.modelLable.tag = 3;
    self.windLable.tag = 4;
    self.closeTimeLabel.tag = 6;
    self.maxopenTimeLabel.tag = 7;

    if (self.openBtn.imageView.image.size.width == 0) {
        self.openBtn.tag = 0;
    } else {
        self.openBtn.tag = 1;
    }

    if (self.closeBtn.imageView.image.size.width == 0) {
        self.closeBtn.tag = 0;
    } else {
        self.closeBtn.tag = 1;
    }
}

#pragma mark - 充值数据
- (void)chongZhiAction {
    
    [self.dic removeAllObjects];
    [kStanderDefault removeObjectForKey:@"data"];
    
    self.openTimeLabel.text = @"00:00";
    self.modelLable.text = @"模式未选";
    self.windLable.text = @"风速未选";
    self.closeTimeLabel.text = @"00:00";
    self.maxopenTimeLabel.text = @"00";
    
    [UIButton btn:self.openBtn removeAtcion:@selector(closeBtnAgainAtcion:) addAtcion:@selector(closeBtnAtcion:) target:self image:[UIImage new]];
    
    [UIButton btn:self.closeBtn removeAtcion:@selector(closeBtnAgainAtcion:) addAtcion:@selector(closeBtnAtcion:) target:self image:[UIImage new]];
    
    
    for (int i = 0; i < 7; i++) {
        UIButton *btn = self.btnArray[i];
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        btn.backgroundColor = [UIColor clearColor];
        [btn addTarget:self action:@selector(btnAtcion:) forControlEvents:UIControlEventTouchUpInside];
    }
    
}


#pragma mark - 设定确认按钮点击事件
- (void)closeBtnAtcion:(UIButton *)btn {
    if (btn.tag != 33) {
        
        [btn setImage:[UIImage imageNamed:@"iconfont-gougou"] forState:UIControlStateNormal];
        [btn setTintColor:[UIColor clearColor]];
    }
    if ([btn isEqual:self.openBtn]) {
        self.openBtn.tag = 1;
    } else if ([btn isEqual:self.closeBtn]){
        self.closeBtn.tag = 1;
    }
    
    [self.dic setObject:@(self.openBtn.tag) forKey:@"openBtn"];
    [self.dic setObject:@(self.closeBtn.tag) forKey:@"closeBtn"];
    NSDictionary *dataDic = [self.dic mutableCopy];
    [kStanderDefault setObject:dataDic forKey:@"data"];
    
    if (btn.tag == 33) {
        [self getData];
    }
    
    NSLog(@"%ld , %ld" , (long)self.openBtn.tag , (long)self.closeBtn.tag);
    [btn removeTarget:nil action:nil forControlEvents:UIControlEventTouchUpInside];
    
    [btn addTarget:self action:@selector(closeBtnAgainAtcion:) forControlEvents:UIControlEventTouchUpInside];
}

#pragma mark - 设定确认按钮再次点击事件
- (void)closeBtnAgainAtcion:(UIButton *)btn {
    //    btn.backgroundColor = [UIColor clearColor];
    [btn setImage:[UIImage new] forState:UIControlStateNormal];
    
    if ([btn isEqual:self.openBtn]) {
        self.openBtn.tag = 0;
    } else if ([btn isEqual:self.closeBtn]) {
        self.closeBtn.tag = 0;
    }
    
    [self.dic setObject:@(self.openBtn.tag) forKey:@"openBtn"];
    [self.dic setObject:@(self.closeBtn.tag) forKey:@"closeBtn"];
    NSDictionary *dataDic = [self.dic mutableCopy];
    [kStanderDefault setObject:dataDic forKey:@"data"];
    NSLog(@"%ld , %ld" , (long)self.openBtn.tag , (long)self.closeBtn.tag);
    
    [btn removeTarget:nil action:nil forControlEvents:UIControlEventTouchUpInside];
    [btn addTarget:self action:@selector(closeBtnAtcion:) forControlEvents:UIControlEventTouchUpInside];
    
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
    
    for (NSString *items in self.windArray) {
        if ([items isEqualToString:self.windLable.text]) {
            windIndex = [self.windArray indexOfObject:items];
        }
    }
    
    NSInteger i = [self.maxopenTimeLabel.text intValue] * 60 * 60 * 1000;
    
    
    NSDictionary *parames = @{@"devSn" : self.serviceModel.devSn ,@"task.fSwitchOn" : @(self.openBtn.tag) , @"task.fSwitchOff" : @(self.closeBtn.tag) , @"task.onJobTime" : self.openTimeLabel.text , @"task.offJobTime" : self.closeTimeLabel.text , @"task.fMode" : @(modelIndex + 1) , @"task.fWind" : @(windIndex + 1) , @"task.durTime" : @(i) , @"task.runWeek" : task};
    
    NSLog(@"%@" , parames);
    
    [kNetWork requestPOSTUrlString:kLengFengShanDingShiYuYue parameters:parames isSuccess:^(NSDictionary * _Nullable responseObject) {
        [UIAlertController creatRightAlertControllerWithHandle:nil andSuperViewController:self.currentVC Title:@"预约成功"];
    } failure:nil];
    
}

#pragma mark - 星期的点击事件
- (void)btnAtcion:(UIButton *)btn {
    btn.backgroundColor = [UIColor clearColor];
    [btn setTitleColor:kMainColor forState:UIControlStateNormal];
    [self.dic setObject:@"1" forKey:self.keysArray[btn.tag]];
    [btn addTarget:self action:@selector(btnAgainAtcion:) forControlEvents:UIControlEventTouchUpInside];
}

#pragma mark - 星期再次点击事件
- (void)btnAgainAtcion:(UIButton *)btn {
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    btn.backgroundColor = [UIColor clearColor];
    [self.dic setObject:@"0" forKey:self.keysArray[btn.tag]];
    [btn addTarget:self action:@selector(btnAtcion:) forControlEvents:UIControlEventTouchUpInside];
}

#pragma mark - 问好的点击事件
- (void)wenHaoAtcion:(UITapGestureRecognizer *)btn {
    
    [UIAlertController creatRightAlertControllerWithHandle:nil andSuperViewController:self.currentVC Title:@"设定您机器的最大开启时间"];
}

#pragma mark - 几个控件的点击事件
- (void)tapAtcion:(UITapGestureRecognizer *)tap {
    self.firstPickView = nil;
    self.secondPickView = nil;
    self.thirtPickView = nil;
    self.forthPickView = nil;
    if (tap.view.tag == 1 || tap.view.tag == 2) {
        self.firstPickView = [[CustomPickerView alloc]initWithPickerViewType:UIPickerViewTypeOfTime andBackColor:kCOLOR(244, 244, 244)];
        self.firstPickView.delegate = self;
        [self.currentVC.view addSubview:self.firstPickView];
    } else if (tap.view.tag == 3 || tap.view.tag == 4) {
        NSDictionary *dataDic = @{@(0):self.modelArray , @(1):self.windArray};
        self.secondPickView = [[CustomPickerView alloc]initWithPickerViewType:UIPickerViewTypeOfCustom data:dataDic andBackColor:kCOLOR(244, 244, 244)];
        self.secondPickView.delegate = self;
        [self.currentVC.view addSubview:self.secondPickView];
    } else if (tap.view.tag == 5 || tap.view.tag == 6) {
        self.thirtPickView = [[CustomPickerView alloc]initWithPickerViewType:UIPickerViewTypeOfTime andBackColor:kCOLOR(244, 244, 244)];
        self.thirtPickView.delegate = self;
        [self.currentVC.view addSubview:self.thirtPickView];
    } else  {
        NSDictionary *dataDic = @{@(0):self.hourArray};
        self.forthPickView = [[CustomPickerView alloc]initWithPickerViewType:UIPickerViewTypeOfCustom data:dataDic andBackColor:kCOLOR(244, 244, 244)];
        self.forthPickView.delegate = self;
        [self.currentVC.view addSubview:self.forthPickView];
    }
}

- (void)sendPickerViewToVC:(UIPickerView *)picker {
    
    if (self.firstPickView) {
        self.openTimeLabel.text = [NSString stringWithFormat:@"%@:%@" , self.hourArray[[picker selectedRowInComponent:0]] , self.minuteArray[[picker selectedRowInComponent:1]]];
    }
    
    if (self.secondPickView) {
        self.modelLable.text = self.modelArray[[picker selectedRowInComponent:0]];
        self.windLable.text = self.windArray[[picker selectedRowInComponent:1]];
    }
    
    if (self.thirtPickView) {
        self.closeTimeLabel.text = [NSString stringWithFormat:@"%@:%@" , self.hourArray[[picker selectedRowInComponent:0]] , self.minuteArray[[picker selectedRowInComponent:1]]];
    }
    
    if (self.forthPickView) {
        self.maxopenTimeLabel.text = self.hourArray[[picker selectedRowInComponent:0]];
    }
    
    [self.dic setObject:self.openTimeLabel.text forKey:@"openTimeLabel"];
    [self.dic setObject:self.modelLable.text forKey:@"model"];
    [self.dic setObject:self.windLable.text forKey:@"wind"];
    [self.dic setObject:self.closeTimeLabel.text forKey:@"closeTimeLabel"];
    [self.dic setObject:self.maxopenTimeLabel.text forKey:@"maxopenTimeLabel"];
}

#pragma mark - 懒加载
- (NSArray *)windArray {
    if (!_windArray) {
        _windArray = @[@"风速未选",@"低速", @"中速" , @"高速"];
    }
    return _windArray;
}

- (NSArray *)modelArray {
    if (!_modelArray) {
        _modelArray = @[@"模式未选" , @"正常" , @"自然" , @"睡眠"];
    }
    return _modelArray;
}

- (NSMutableArray *)minuteArray {
    if (!_minuteArray) {
        _minuteArray = [NSMutableArray array];
        for (int i = 0; i < 60; i++) {
            if (i < 10) {
                [_minuteArray addObject:[NSString stringWithFormat:@"0%d" , i]];
            } else {
                [_minuteArray addObject:[NSString stringWithFormat:@"%d" , i]];
            }
        }
    }
    return _minuteArray;
}

- (NSMutableArray *)hourArray {
    if (!_hourArray) {
        _hourArray = [NSMutableArray array];
        for (int i = 0; i < 24; i++) {
            if (i < 10) {
                [_hourArray addObject:[NSString stringWithFormat:@"0%d" , i]];
            } else {
                [_hourArray addObject:[NSString stringWithFormat:@"%d" , i]];
            }
        }
    }
    return _hourArray;
}

- (NSMutableDictionary *)dic{
    if (!_dic) {
        _dic = [NSMutableDictionary dictionary];
        
        if ([kStanderDefault objectForKey:@"data"]) {
            _dic = [[kStanderDefault objectForKey:@"data"] mutableCopy];
        }
        
        if (_dic[@"openTimeLabel"] == nil || [_dic[@"openTimeLabel"] isKindOfClass:[NSNull class]]) {
            self.openTimeLabel.text = @"00:00";
        } else {
            self.openTimeLabel.text = _dic[@"openTimeLabel"];
        }
        
        if (_dic[@"wind"] == nil || [_dic[@"wind"] isKindOfClass:[NSNull class]]) {
            self.windLable.text = @"风速未选";
        } else {
            self.windLable.text = _dic[@"wind"];
        }
        
        if (_dic[@"model"] == nil || [_dic[@"model"] isKindOfClass:[NSNull class]]) {
            self.modelLable.text = @"模式未选";
        } else {
            self.modelLable.text = _dic[@"model"];
        }
        
        if (_dic[@"closeTimeLabel"] == nil || [_dic[@"closeTimeLabel"] isKindOfClass:[NSNull class]]) {
            self.closeTimeLabel.text = @"00:00";
        } else {
            self.closeTimeLabel.text = _dic[@"closeTimeLabel"];
        }
        
        if (_dic[@"maxopenTimeLabel"] == nil || [_dic[@"maxopenTimeLabel"] isKindOfClass:[NSNull class]]) {
            self.maxopenTimeLabel.text = @"00";
        } else {
            self.maxopenTimeLabel.text = _dic[@"maxopenTimeLabel"];
        }
        
        if ([[self.dic objectForKey:@"openBtn"] integerValue] == 0) {
            [UIButton btn:self.openBtn removeAtcion:@selector(closeBtnAgainAtcion:) addAtcion:@selector(closeBtnAtcion:) target:self image:[UIImage new]];
        } else {
            [UIButton btn:self.openBtn removeAtcion:@selector(closeBtnAtcion:) addAtcion:@selector(closeBtnAgainAtcion:) target:self image:[UIImage imageNamed:@"iconfont-gougou"]];
            [self.openBtn setTintColor:[UIColor clearColor]];
        }
        

        if ([[self.dic objectForKey:@"closeBtn"] integerValue] == 0) {
            [UIButton btn:self.closeBtn removeAtcion:@selector(closeBtnAgainAtcion:) addAtcion:@selector(closeBtnAtcion:) target:self image:[UIImage new]];
        } else {
            [UIButton btn:self.closeBtn removeAtcion:@selector(closeBtnAtcion:) addAtcion:@selector(closeBtnAgainAtcion:) target:self image:[UIImage imageNamed:@"iconfont-gougou"]];
            [self.closeBtn setTintColor:[UIColor clearColor]];
        }
    }
    return _dic;
}

- (NSMutableArray *)btnArray {
    if (!_btnArray) {
        _btnArray = [NSMutableArray array];
    }
    return _btnArray;
}

- (NSArray *)keysArray {
    if (!_keysArray) {
        _keysArray = @[@"yi" , @"er" , @"san" , @"si" , @"wu" , @"liu" , @"qi"];
    }
    return _keysArray;
}

@end
