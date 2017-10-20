//
//  AirPurificationFirstTableViewCell.m
//  联侠
//
//  Created by 杭州阿尔法特 on 16/6/6.
//  Copyright © 2016年 张海昌. All rights reserved.
//

#import "AirPurificationFirstTableViewCell.h"
#import "LXCircleAnimationView.h"

@interface AirPurificationFirstTableViewCell ()<HelpFunctionDelegate>{
    UILabel *stateLabel;
    UILabel *tempretureLabel;
}
@property (nonatomic, strong) LXCircleAnimationView *circleProgressView;
@end

@implementation AirPurificationFirstTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self cutomUI];
    }
    return self;
}

- (void)cutomUI {
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getKongJingDataFirst:) name:kServiceOrder object:nil];
    
    UIView *view = [[UIView alloc]init];
    view.backgroundColor = [UIColor whiteColor];
    view.frame = CGRectMake(0, 0, kScreenW, kScreenH / 2.5);
    [self.contentView addSubview:view];
    view.backgroundColor = [UIColor whiteColor];
    
    
    UILabel *titleLabel = [UILabel creatLableWithTitle:@"室内空气质量" andSuperView:view andFont:k15 andTextAligment:NSTextAlignmentCenter];
    titleLabel.textColor = kKongJingYanSe;
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(view.mas_centerX);
        make.top.mas_equalTo(view.mas_top).offset(kScreenW / 20);
    }];
    
    self.circleProgressView = [[LXCircleAnimationView alloc] initWithFrame:CGRectMake(kScreenW / 2 - view.height * 2 / 5, kScreenW / 20 + kScreenW / 14, view.height * 4 / 5, view.height * 4 / 5)];
    [view addSubview:self.circleProgressView];
    self.circleProgressView.userInteractionEnabled = NO;
    
    stateLabel = [UILabel creatLableWithTitle:@"空气:优" andSuperView:view andFont:k15 andTextAligment:NSTextAlignmentCenter];
    [stateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(view.mas_centerX);
        make.top.mas_equalTo(self.circleProgressView.mas_top)
        .offset(kScreenW / 20);
    }];
    stateLabel.textColor = kKongJingYanSe;
    
    UILabel *indoorTempretureLabel = [UILabel creatLableWithTitle:@"室内温度" andSuperView:view andFont:k12 andTextAligment:NSTextAlignmentCenter];
    indoorTempretureLabel.backgroundColor = kKongJingHuangSe;
    indoorTempretureLabel.textColor = [UIColor whiteColor];
    indoorTempretureLabel.layer.cornerRadius = kScreenW / 40;
    [indoorTempretureLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kScreenW / 6, kScreenW / 20));
        make.top.mas_equalTo(view.mas_top).offset(kScreenW / 20);
        make.left.mas_equalTo(view.mas_left).offset(kScreenW / 20);
    }];
    
    tempretureLabel = [UILabel creatLableWithTitle:@"" andSuperView:view andFont:k12 andTextAligment:NSTextAlignmentCenter];
    [tempretureLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top
        .mas_equalTo(indoorTempretureLabel.mas_bottom);
        make.centerX
        .mas_equalTo(indoorTempretureLabel.mas_centerX);
    }];
    
    [NSString setNSMutableAttributedString:30 andSuperLabel:tempretureLabel andDanWei:@"°C" andSize:k25 andTextColor:kKongJingYanSe isNeedTwoXiaoShuo:@"NO"];
    
    [UIView creatBottomFenGeView:view andBackGroundColor:[UIColor whiteColor] isOrNotAllLenth:@"YES"];
    
}

- (void)getKongJingDataFirst:(NSNotification *)post {
    NSString *mingLing = post.userInfo[@"Message"];
    
    if (mingLing.length != 56) {
        return ;
    }
    
    NSString *wuRanChengDu = [mingLing substringWithRange:NSMakeRange(50, 2)];
    
    if ([wuRanChengDu isEqualToString:@"01"]) {
        stateLabel.text = @"空气:优";
    } else if ([wuRanChengDu isEqualToString:@"02"]) {
        stateLabel.text = @"空气:良";
    } else if ([wuRanChengDu isEqualToString:@"03"]) {
        stateLabel.text = @"空气:差";
    }

}

- (void)setStateModel:(StateModel *)stateModel {
    _stateModel = stateModel;
        
    if (_stateModel.sCurrentC) {
        
        [NSString setNSMutableAttributedString:_stateModel.sCurrentC.floatValue andSuperLabel:tempretureLabel andDanWei:@"°C" andSize:k25 andTextColor:kKongJingYanSe isNeedTwoXiaoShuo:@"NO"];
    }
    
    if (_stateModel.sPm25) {
   
        CGFloat kongQiZhiLiang = _stateModel.sPm25.floatValue / 4;
        [self.circleProgressView setText:[NSString stringWithFormat:@"%.f" , kongQiZhiLiang]];
    } else {
        self.circleProgressView.text = [NSString stringWithFormat:@"%d" , 50];
    }
    
    if (_stateModel.fLight == 01) {
        stateLabel.text = @"空气:优";
    } else if (_stateModel.fLight == 02) {
        stateLabel.text = @"空气:良";
    } else if (_stateModel.fLight == 03) {
        stateLabel.text = @"空气:差";
    }
    
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
