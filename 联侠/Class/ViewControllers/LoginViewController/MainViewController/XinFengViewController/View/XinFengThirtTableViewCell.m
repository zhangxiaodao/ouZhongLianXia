//
//  XinFengThirtTableViewCell.m
//  联侠
//
//  Created by 杭州阿尔法特 on 16/10/25.
//  Copyright © 2016年 张海昌. All rights reserved.
//

#import "XinFengThirtTableViewCell.h"


#define kArrayCount _array.count
#define kArrayCountJiaYi (_array.count + 1)
#define kBtnW ((kScreenW + 4) / 4)
#define kContentViewHeight kBtnW * 2 + kBtnW * 2 / 3


@interface XinFengThirtTableViewCell (){
    UIButton *shuiMianBtn;
    UIButton *ziRanBtn;
    UIButton *gaoXiaoBtn;
    UIButton *shuShiBtn;
}

@property (nonatomic , strong) NSArray *array;
@property (nonatomic , strong) UIView *backView;

@end

@implementation XinFengThirtTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self customUI];
    }
    return self;
}


- (void)customUI {
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getXinFengModelBtnAtcion:) name:@"4232" object:nil];
    
    self.backView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenW,  kBtnW * 3 / 2 )];
    self.backView.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:self.backView];
    
    
    NSArray *imageArray = @[@"xinfeng_gaoxiao" , @"xinfeng_ziran" , @"shuiMian" , @"xinfeng_shushi"];
    _array = [NSArray arrayWithObjects:@"高效" , @"自然", @"睡眠",  @"舒适", nil];
    
    for (int i = 0; i < kArrayCount; i++) {
        
        UIButton *btn = [UIButton creatBtnWithTitle:_array[i] andImage:[UIImage imageNamed:imageArray[i]] andImageColor:kXinFengKongJingYanSe andWidth:kBtnW andHeight:kBtnW andSuperView:self.backView WithTarget:self andDoneAtcion:@selector(modelBtnDoneAtcion:) andTag:i];
        
        [UIButton setBtnOfImageAndLableWithUnSelected:btn andTintColor:kXinFengKongJingYanSe];
        
        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.size.mas_equalTo(CGSizeMake(kScreenW / 2 , kBtnW * 3 / 4));
            if (i < 2) {
                make.left.mas_equalTo(self.contentView.mas_left).offset(-1 + (kScreenW / 2 - 1) * i);
                make.top.mas_equalTo(self.contentView.mas_top);
            } else {
                
                make.top.mas_equalTo(self.contentView.mas_top).offset(-1 + kBtnW * 3 / 4);
                make.left.mas_equalTo(self.contentView.mas_left).offset(-1 + (kScreenW / 2 - 1) * (i - 2));
            }
        }];
        
        switch (i) {
            case 0:{
                gaoXiaoBtn = btn;
                break;
            }
                
            case 1:{
                ziRanBtn = btn;
                break;
            }
                
            case 2:{
                shuiMianBtn = btn;
                break;
            }
                
            case 3:{
                shuShiBtn = btn;
                break;
            }
            default:
                break;
        }
        
    }
    
    if ([kStanderDefault objectForKey:@"offBtn"]) {
        NSNumber *bottomSelected = [kStanderDefault objectForKey:@"offBtn"];
        if (bottomSelected.integerValue == 0) {
            for (int i = 0; i < self.backView.subviews.count; i++) {
                UIButton *btn = self.backView.subviews[i];
                btn.userInteractionEnabled = NO;
            }
        } else if (bottomSelected.integerValue == 1) {
            for (int i = 0; i < self.backView.subviews.count; i++) {
                UIButton *btn = self.backView.subviews[i];
                btn.userInteractionEnabled = YES;
            }
        }
    }
    
    UIView *bottomView = [[UIView alloc]init];
    bottomView.backgroundColor = kFenGeXianYanSe;
    [self.backView addSubview:bottomView];
    [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.backView.mas_bottom);
        make.centerX.mas_equalTo(self.backView.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(kScreenW, 5));
    }];
}

- (void)modelBtnDoneAtcion:(UIButton *)btn {
    
    [UIButton setBtnOfImageAndLableWithUnSelected:shuiMianBtn andTintColor:kXinFengKongJingYanSe];
    [UIButton setBtnOfImageAndLableWithUnSelected:ziRanBtn andTintColor:kXinFengKongJingYanSe];
    [UIButton setBtnOfImageAndLableWithUnSelected:gaoXiaoBtn andTintColor:kXinFengKongJingYanSe];
    [UIButton setBtnOfImageAndLableWithUnSelected:shuShiBtn andTintColor:kXinFengKongJingYanSe];
  
//    NSString *model = nil;
    switch (btn.tag) {
        case 0:
        {
//            model = @"高效";
            [kSocketTCP sendDataToHost:XinFengKongJing(_serviceModel.devTypeSn, _serviceModel.devSn, @"00", @"02", @"00", @"00" , @"04") andType:kZhiLing andIsNewOrOld:kNew];
//            [UIButton setBtnOfImageAndLableWithSelected:gaoXiaoBtn andBackGroundColor:kXinFengKongJingYanSe];
            break;
        }
        case 1: {
//            model = @"自然";
            [kSocketTCP sendDataToHost:XinFengKongJing(_serviceModel.devTypeSn, _serviceModel.devSn, @"00", @"01", @"00", @"01" , @"00") andType:kZhiLing andIsNewOrOld:kNew];
//            [UIButton setBtnOfImageAndLableWithSelected:ziRanBtn andBackGroundColor:kXinFengKongJingYanSe];
            break;
        }
        case 2: {
//            model = @"睡眠";
            [kSocketTCP sendDataToHost:XinFengKongJing(_serviceModel.devTypeSn, _serviceModel.devSn, @"00", @"02", @"00", @"02" , @"01") andType:kZhiLing andIsNewOrOld:kNew];
//            [UIButton setBtnOfImageAndLableWithSelected:shuiMianBtn andBackGroundColor:kXinFengKongJingYanSe];
            break;
        }
            
        case 3:{
//            model = @"舒适";
            [kSocketTCP sendDataToHost:XinFengKongJing(_serviceModel.devTypeSn, _serviceModel.devSn, @"00", @"02", @"00", @"01" , @"02") andType:kZhiLing andIsNewOrOld:kNew];
//            [UIButton setBtnOfImageAndLableWithSelected:shuShiBtn andBackGroundColor:kXinFengKongJingYanSe];
            break;
        }
            
        default:
            break;
    }
    
}

- (void)getXinFengModelBtnAtcion:(NSNotification *)post {
    
    [UIButton setBtnOfImageAndLableWithUnSelected:shuiMianBtn andTintColor:kXinFengKongJingYanSe];
    [UIButton setBtnOfImageAndLableWithUnSelected:ziRanBtn andTintColor:kXinFengKongJingYanSe];
    [UIButton setBtnOfImageAndLableWithUnSelected:gaoXiaoBtn andTintColor:kXinFengKongJingYanSe];
    [UIButton setBtnOfImageAndLableWithUnSelected:shuShiBtn andTintColor:kXinFengKongJingYanSe];
    
    NSString *mingLing = post.userInfo[@"Message"];
    NSString *ziDong = [mingLing substringWithRange:NSMakeRange(30, 2)];
    NSString *wind = [mingLing substringWithRange:NSMakeRange(40, 2)];
    NSString *fuLiZi = [mingLing substringWithRange:NSMakeRange(34, 2)];
    
    
    
    NSString *modelStr = nil;
    
    if ([ziDong isEqualToString:@"02"] && [wind isEqualToString:@"04"] && [fuLiZi isEqualToString:@"02"]) {
        [UIButton setBtnOfImageAndLableWithSelected:gaoXiaoBtn andBackGroundColor:kXinFengKongJingYanSe];
        modelStr = @"高效";
    }
   
    if ([ziDong isEqualToString:@"01"] && [fuLiZi isEqualToString:@"01"]) {
        [UIButton setBtnOfImageAndLableWithSelected:ziRanBtn andBackGroundColor:kXinFengKongJingYanSe];
        modelStr = @"自然";
    }
    
    if ([ziDong isEqualToString:@"02"] && [wind isEqualToString:@"01"] && [fuLiZi isEqualToString:@"02"]) {
        [UIButton setBtnOfImageAndLableWithSelected:shuiMianBtn andBackGroundColor:kXinFengKongJingYanSe];
        modelStr = @"睡眠";
    }
    
    if ([ziDong isEqualToString:@"02"] && [fuLiZi isEqualToString:@"01"] && [wind isEqualToString:@"02"]) {
        [UIButton setBtnOfImageAndLableWithSelected:shuShiBtn andBackGroundColor:kXinFengKongJingYanSe];
        modelStr = @"舒适";
    }
    
    if (modelStr) {
        [[NSNotificationCenter defaultCenter] postNotification:[NSNotification notificationWithName:@"XinFengModelState" object:self userInfo:@{@"XinFengModelState" : modelStr}]];
    }
    
    
    
}

- (void)setBtnSubViewsOfLable:(NSString *)title withWhichBtn:(UIButton *)btn {
    UILabel *label = btn.subviews[0];
    label.text = title;
}

- (void)setServiceModel:(ServicesModel *)serviceModel {
    _serviceModel = serviceModel;
}

@end
