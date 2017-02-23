//
//  AirFirstTableViewCell.m
//  联侠
//
//  Created by 杭州阿尔法特 on 16/5/30.
//  Copyright © 2016年 张海昌. All rights reserved.
//

#import "AirFirstTableViewCell.h"
#import "CustomView.h"
#define kBtnW (((kScreenW - kScreenW / 8) / 4) - 5)

#define kContentViewHeight kBtnW * 2 + kBtnW * 2 / 3
@interface AirFirstTableViewCell ()
@property (nonatomic , strong) UIView *shiNeiView;
@end


@implementation AirFirstTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self customUI];
    }
    return self;
}

- (void)customUI {
    
    
    
    
    UIView *view = [[UIView alloc]init];
    view.backgroundColor = [UIColor whiteColor];
    view.frame = CGRectMake(0, 0, kScreenW, kBtnW * 2 + kBtnW * 3 / 4);
    [self.contentView addSubview:view];
      
    UIImageView *woDeJiaImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"woDeJia"]];
    [view addSubview:woDeJiaImageView];
    [woDeJiaImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kScreenW / 10, kScreenW / 10));
        make.centerX.mas_equalTo(view.mas_centerX);
        make.top.mas_equalTo(view.mas_top).offset(20);
    }];
    
    
    UILabel *leiJiJiangWenLable = [UILabel creatLableWithTitle:@"当前室内空气" andSuperView:view andFont:k12 andTextAligment:NSTextAlignmentCenter];
    leiJiJiangWenLable.layer.borderWidth = 0;
    leiJiJiangWenLable.backgroundColor = [UIColor blackColor];
    leiJiJiangWenLable.textColor = [UIColor whiteColor];
    leiJiJiangWenLable.layer.cornerRadius = kScreenW / 36;
    [leiJiJiangWenLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kScreenW / 3, kScreenW / 18));
        make.centerX.mas_equalTo(view.mas_centerX);
        make.top.mas_equalTo(woDeJiaImageView.mas_bottom).offset(10);
    }];
    
    UILabel *wuRanLable = [UILabel creatLableWithTitle:@"" andSuperView:view andFont:k12 andTextAligment:NSTextAlignmentCenter];
    wuRanLable.textColor = [UIColor grayColor];
    wuRanLable.layer.borderWidth = 0;
    
    
    CGFloat temperature1 = 100;
    NSMutableAttributedString *str3 = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%.1f mg/m³" , temperature1]];
    [str3 addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:46/255.0 green:191/255.0 blue:103/255.0 alpha:1.0] range:NSMakeRange(0,[NSString stringWithFormat:@"%.1f", temperature1].length)];
    [str3 addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"Helvetica" size:k60] range:NSMakeRange(0, [NSString stringWithFormat:@"%.1f", temperature1].length)];
    wuRanLable.attributedText = str3;
    [wuRanLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kScreenW * 2 / 3, kScreenW / 7));
        make.centerX.mas_equalTo(view.mas_centerX);
        make.top.mas_equalTo(woDeJiaImageView.mas_bottom).offset(kScreenW / 12.5);
    }];
    
    
     NSArray *colorArray = [NSArray arrayWithObjects:[UIColor colorWithRed:55/255.0 green:228/255.0 blue:186/255.0 alpha:1.0] , [UIColor colorWithRed:245/255.0 green:222/255.0 blue:63/255.0 alpha:1.0] , [UIColor colorWithRed:230/255.0 green:119/255.0 blue:39/255.0 alpha:1.0] , [UIColor colorWithRed:217/255.0 green:51/255.0 blue:69/255.0 alpha:1.0] , [UIColor colorWithRed:181/255.0 green:37/255.0 blue:151/255.0 alpha:1.0] , [UIColor colorWithRed:111/255.0 green:44/255.0 blue:119/255.0 alpha:1.0], nil];
    
    UILabel *shiNeiLable = [UILabel creatLableWithTitle:@"室内:空气优" andSuperView:view andFont:k12 andTextAligment:NSTextAlignmentCenter];
    [shiNeiLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kScreenW / 3, 15));
        make.centerX.mas_equalTo(self.contentView.mas_centerX);
        make.top.mas_equalTo(wuRanLable.mas_bottom);
    }];
//    shiNeiLable.layer.cornerRadius = 5;
//    shiNeiLable.layer.masksToBounds = YES;
    shiNeiLable.backgroundColor = colorArray[5];
    shiNeiLable.textColor = [UIColor whiteColor];
    shiNeiLable.layer.borderWidth = 0;
    
   
 
    
    
    for (int i = 0; i < 6; i++) {
        UIView *seCaiView = [[UIView alloc]init];
        [view addSubview:seCaiView];
        [seCaiView mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.mas_equalTo(shiNeiLable.mas_left).offset(i * kScreenW / 18);
            make.size.mas_equalTo(CGSizeMake(kScreenW / 18 , 5));
            make.top.mas_equalTo(shiNeiLable.mas_bottom).offset(10);
        }];
        seCaiView.backgroundColor = colorArray[i];
        self.shiNeiView = seCaiView;
        
        
    }
    CustomView *customView = [[CustomView alloc]initWithFrame:CGRectMake(0, 0, kScreenW / 18, 10)];
    [view addSubview:customView];
    customView.color = self.shiNeiView.backgroundColor;
    [customView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kScreenW / 18, 10));
        make.centerX.mas_equalTo(self.shiNeiView.mas_centerX);
        make.top.mas_equalTo(shiNeiLable.mas_bottom).offset(-2);
    }];
    
    
    UILabel *fenChenLable = [UILabel creatLableWithTitle:@"" andSuperView:view andFont:k15 andTextAligment:NSTextAlignmentCenter];
    fenChenLable.textColor = [UIColor blackColor];
    fenChenLable.layer.borderWidth = 0;
    
    
    CGFloat text1 = 59;
    
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%.0f%%" , text1]];
    [str addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"Helvetica" size:k20] range:NSMakeRange(0, [NSString stringWithFormat:@"%.0f", text1].length)];
    fenChenLable.attributedText = str;
    
    
    [fenChenLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kScreenW / 3, kScreenW / 14));
        make.centerX.mas_equalTo(view.mas_centerX).offset(- kScreenW / 3.4090909);
        make.top.mas_equalTo(customView.mas_bottom).offset(10);
    }];
    
    UIView *fenGeXianView = [[UIView alloc]init];
    [view addSubview:fenGeXianView];
    fenGeXianView.backgroundColor = [UIColor colorWithRed:46/255.0 green:191/255.0 blue:103/255.0 alpha:1.0];
    [fenGeXianView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kScreenW / 4, 1));
        make.centerX.mas_equalTo(fenChenLable.mas_centerX);
        make.top.mas_equalTo(fenChenLable.mas_bottom);
    }];
    
    UILabel *yiGuoLvFenChenLable = [UILabel creatLableWithTitle:@"优于室外空气" andSuperView:view andFont:k12 andTextAligment:NSTextAlignmentCenter];
    yiGuoLvFenChenLable.layer.borderWidth = 0;
    yiGuoLvFenChenLable.textColor = [UIColor grayColor];
    [yiGuoLvFenChenLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kScreenW / 3, kScreenW / 14));
        make.centerX.mas_equalTo(fenChenLable.mas_centerX);
        make.top.mas_equalTo(fenGeXianView.mas_bottom);
    }];
    
    UILabel *timeLable1 = [UILabel creatLableWithTitle:@"" andSuperView:view andFont:k14 andTextAligment:NSTextAlignmentCenter];
    timeLable1.layer.borderWidth = 0;
    timeLable1.textColor = [UIColor blackColor];
    
    CGFloat time1 = 100;
    NSMutableAttributedString *str2 = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%.0f小时" , time1]];
    [str2 addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"Helvetica" size:k20] range:NSMakeRange(0, [NSString stringWithFormat:@"%.0f", time1].length)];
    timeLable1.attributedText = str2;
    
    [timeLable1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kScreenW / 3, kScreenW / 14));
        make.centerX.mas_equalTo(view.mas_centerX).offset( kScreenW / 3.4090909);
        make.top.mas_equalTo(customView.mas_bottom).offset(10);
    }];
    
    UIView *fenGeXianView2 = [[UIView alloc]init];
    [view addSubview:fenGeXianView2];
    fenGeXianView2.backgroundColor = [UIColor colorWithRed:46/255.0 green:191/255.0 blue:103/255.0 alpha:1.0];
    
    [fenGeXianView2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kScreenW / 4, 1));
        make.centerX.mas_equalTo(timeLable1.mas_centerX);
        make.top.mas_equalTo(timeLable1.mas_bottom);
    }];
    
    UILabel *sumTimeLable = [UILabel creatLableWithTitle:@"累计运行时间" andSuperView:view andFont:k12 andTextAligment:NSTextAlignmentCenter];
    sumTimeLable.textColor = [UIColor grayColor];
    sumTimeLable.layer.borderWidth = 0;
    [sumTimeLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kScreenW / 3, kScreenW / 14));
        make.centerX.mas_equalTo(timeLable1.mas_centerX);
        make.top.mas_equalTo(fenGeXianView2.mas_bottom);
        
    }];
   
   
    
    
}

@end
