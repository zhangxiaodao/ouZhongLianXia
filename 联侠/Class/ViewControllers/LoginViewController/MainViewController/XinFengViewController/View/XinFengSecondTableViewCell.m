//
//  XinFengSecondTableViewCell.m
//  联侠
//
//  Created by 杭州阿尔法特 on 16/10/11.
//  Copyright © 2016年 张海昌. All rights reserved.
//

#import "XinFengSecondTableViewCell.h"
#import "MalertView.h"
#define kArrayCount _array.count
#define kArrayCountJiaYi (_array.count + 1)
#define kBtnW ((kScreenW + 4) / 4)
#define kContentViewHeight kBtnW * 2 + kBtnW * 2 / 3
@interface XinFengSecondTableViewCell ()<MalertItemSelectDelegate , MalertItemSelectDelegate>
{
    UIButton *ziDongBtn;
    UIButton *windBtn;
    UIButton *fuLiZiBtn;
    UIButton *modelBtn;
    UIButton *shouDongBtn;
    UIButton *caiDengBtn;
    MalertView *_alert;
}

@property (nonatomic , strong) NSArray *array;
@property (nonatomic , strong) UIView *backView;

@end

@implementation XinFengSecondTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self customUI];
    }
    return self;
}

- (void)customUI {
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getXinFengFunctionBtnAtcion:) name:@"4232" object:nil];
    
    self.backView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenW,  kBtnW * 9 / 4)];
    self.backView.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:self.backView];
    
    
    NSArray *imageArray = @[@"xinfeng_fulizi" , @"xinfeng_fengsu" ,  @"xinfeng_zidong" ,  @"xingfeng_shoudong" , @"xinfeng_caideng" , @"xinfeng_moshi" ,];
    _array = [NSArray arrayWithObjects:@"负离子" , @"风速", @"智能运行",  @"手动模式" , @"智能彩灯" , @"模式",nil];
    
    for (int i = 0; i < kArrayCount; i++) {
        
        UIButton *btn = [UIButton creatBtnWithTitle:_array[i] andImage:[UIImage imageNamed:imageArray[i]] andImageColor:kXinFengKongJingYanSe andWidth:kBtnW andHeight:kBtnW andSuperView:self.backView WithTarget:self andDoneAtcion:@selector(xinFengBtnDoneAtcion:) andTag:i];
        
        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.size.mas_equalTo(CGSizeMake(kScreenW / 2 , kBtnW * 3 / 4));
            if (i < 2) {
                make.left.mas_equalTo(self.contentView.mas_left).offset(-1 + (kScreenW / 2 - 1) * i);
                make.top.mas_equalTo(self.contentView.mas_top);
            } else if (i >= 2 && i < 4) {
                make.top.mas_equalTo(self.contentView.mas_top).offset(-1 + kBtnW * 3 / 4);
                make.left.mas_equalTo(self.contentView.mas_left).offset(-1 + (kScreenW / 2 - 1) * (i - 2));
            } else {
                make.top.mas_equalTo(self.contentView.mas_top).offset(-2 + kBtnW * 3 / 2);
                make.left.mas_equalTo(self.contentView.mas_left).offset(-1 + (kScreenW / 2 - 1) * (i - 4));
            }
        }];
        
        switch (i) {
            case 0:{
                fuLiZiBtn = btn;
                break;
            }
                
            case 1:{
                windBtn = btn;
                break;
            }
                
            case 2:{
                ziDongBtn = btn;
                break;
            }
                
            case 3:{
                shouDongBtn = btn;
                break;
            }
                
            case 4:{
                caiDengBtn = btn;
                break;
            }
                
            case 5:{
                modelBtn = btn;
                break;
            }
            default:
                break;
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

- (void)malertItemSelect:(NSInteger)index {
    NSLog(@"%ld" , index);
    
    [NSString stringWithFormat:@"HMFFA%@%@w0000%ld000000000000000000000000000000000000000000#" , _serviceModel.devTypeSn , _serviceModel.devSn ,  index - 100];
}

- (void)xinFengBtnDoneAtcion:(UIButton *)btn {
    
    switch (btn.tag) {
        case 0:
        {
            [kSocketTCP sendDataToHost:XinFengKongJing(_serviceModel.devTypeSn, _serviceModel.devSn, @"00", @"00", @"00", @"01" , @"00") andType:kZhiLing andIsNewOrOld:kNew];
            NSLog(@"负离子开");
            break;
        }
        case 1: {
            [kSocketTCP sendDataToHost:XinFengKongJing(_serviceModel.devTypeSn, _serviceModel.devSn, @"00", @"00", @"00", @"00" , @"01") andType:kZhiLing andIsNewOrOld:kNew];
            btn.tag = 1;
            NSLog(@"风速");
            break;
        }
            
        case 2: {
            [kSocketTCP sendDataToHost:XinFengKongJing(_serviceModel.devTypeSn, _serviceModel.devSn, @"00", @"01", @"00", @"00" , @"00") andType:kZhiLing andIsNewOrOld:kNew];
            NSLog(@"自动");
            break;
        }
        case 3: {
            [kSocketTCP sendDataToHost:XinFengKongJing(_serviceModel.devTypeSn, _serviceModel.devSn, @"00", @"02", @"00", @"00" , @"00") andType:kZhiLing andIsNewOrOld:kNew];
            NSLog(@"手动");
            break;
        }
        case 4: {
            _alert = [[MalertView alloc] initWithImageArrOfButton:@[@"红" , @"绿", @"蓝",  @"红绿" , @"红蓝" , @"绿蓝", @"红绿蓝" , @"自动" , @"关闭"]];
            _alert.delegate = self;
            [kWindowRoot.view addSubview:_alert];
            
            [_alert showAlert];
            
//            CaiDengView *view = [[CaiDengView alloc]init];
//            [kWindowRoot.view addSubview:view];
//            view.backgroundColor = [UIColor whiteColor];
//            [UIView animateWithDuration:.5 animations:^{
//                view.frame = CGRectMake(0, 0, kScreenW, kScreenH / 2);
//            }];
            
            
            break;
        }
        case 5:{
            [[NSNotificationCenter defaultCenter] postNotificationName:@"XinFengModelOpen" object:self];
            
            break;
        }
            
        default:
            break;
    }
    
    if (btn.tag == 0 || btn.tag == 5) {
        [self btnAfterRemoveAddWhichAtcion:@selector(xinFengBtnAgainDoneAtcion:) andAddNSNotificationSelector:@selector(getXinFengFunctionBtnAtcion:) withWhichBtn:btn];
    } else if (btn.tag == 1){
        [self btnAfterRemoveAddWhichAtcion:@selector(windZhongDangWei:) andAddNSNotificationSelector:@selector(getXinFengFunctionBtnAtcion:) withWhichBtn:btn];
    }
    
}

- (void)xinFengBtnAgainDoneAtcion:(UIButton *)btn {
    
    switch (btn.tag) {
            
        case 0: {
            [kSocketTCP sendDataToHost:XinFengKongJing(_serviceModel.devTypeSn, _serviceModel.devSn, @"00", @"00", @"00", @"02" , @"00") andType:kZhiLing andIsNewOrOld:kNew];
            NSLog(@"负离子关闭");
            
            break;
        }
            
        case 5:{
            
            [[NSNotificationCenter defaultCenter] postNotificationName:@"XinFengModelOpen" object:self];
            break;
        }
            
        default:
            break;
    }
    
   
    [self btnAfterRemoveAddWhichAtcion:@selector(xinFengBtnDoneAtcion:) andAddNSNotificationSelector:@selector(getXinFengFunctionBtnAtcion:) withWhichBtn:btn];
   
    
}

#pragma mark - 风速中档位
- (void)windZhongDangWei:(UIButton *)btn {
    [kSocketTCP sendDataToHost:XinFengKongJing(_serviceModel.devTypeSn, _serviceModel.devSn, @"00", @"00", @"00", @"00" , @"02") andType:kZhiLing andIsNewOrOld:kNew];
    btn.tag = 2;
    [self btnAfterRemoveAddWhichAtcion:@selector(windGaoDangWei:) andAddNSNotificationSelector:@selector(getXinFengFunctionBtnAtcion:) withWhichBtn:btn];
}

#pragma mark - 风速高档位
- (void)windGaoDangWei:(UIButton *)btn {
    [kSocketTCP sendDataToHost:XinFengKongJing(_serviceModel.devTypeSn, _serviceModel.devSn, @"00", @"00", @"00", @"00" , @"03") andType:kZhiLing andIsNewOrOld:kNew];
    btn.tag = 3;
    [self btnAfterRemoveAddWhichAtcion:@selector(windMaxGaoDangWei:) andAddNSNotificationSelector:@selector(getXinFengFunctionBtnAtcion:) withWhichBtn:btn];
}

#pragma mark - 风速最高档位
- (void)windMaxGaoDangWei:(UIButton *)btn {
    [kSocketTCP sendDataToHost:XinFengKongJing(_serviceModel.devTypeSn, _serviceModel.devSn, @"00", @"00", @"00", @"00" , @"04") andType:kZhiLing andIsNewOrOld:kNew];
    btn.tag = 4;
    [self btnAfterRemoveAddWhichAtcion:@selector(xinFengBtnDoneAtcion:) andAddNSNotificationSelector:@selector(getXinFengFunctionBtnAtcion:) withWhichBtn:btn];
    btn.tag = 1;
}

/**
 *  通知获取TCP协议命令
 *
 */
#pragma mark 通知获取TCP协议命令
- (void)getXinFengFunctionBtnAtcion:(NSNotification *)post {
    NSString *mingLing = post.userInfo[@"Message"];
    NSString *ziDong = [mingLing substringWithRange:NSMakeRange(30, 2)];
    NSString *wind = [mingLing substringWithRange:NSMakeRange(40, 2)];
    NSString *fuLiZi = [mingLing substringWithRange:NSMakeRange(34, 2)];
    
//    NSLog(@"%@ , %@ , %@ , %@" , mingLing , ziDong , wind , fuLiZi);
    if ([ziDong isEqualToString:@"01"]) {
        [UIButton setBtnOfImageAndLableWithSelected:ziDongBtn andBackGroundColor:kXinFengKongJingYanSe];
        [UIButton setBtnOfImageAndLableWithUnSelected:shouDongBtn andTintColor:kXinFengKongJingYanSe];
    } else if ([ziDong isEqualToString:@"02"]) {
        [UIButton setBtnOfImageAndLableWithSelected:shouDongBtn andBackGroundColor:kXinFengKongJingYanSe];
        [UIButton setBtnOfImageAndLableWithUnSelected:ziDongBtn andTintColor:kXinFengKongJingYanSe];
    }
    
    if ([wind isEqualToString:@"01"] || [wind isEqualToString:@"02"] || [wind isEqualToString:@"03"] || [wind isEqualToString:@"04"]) {
        
        [UIButton setBtnOfImageAndLableWithSelected:windBtn andBackGroundColor:kXinFengKongJingYanSe];
        
        if ([wind isEqualToString:@"01"]) {
            [self setBtnSubViewsOfLable:@"一档" withWhichBtn:windBtn];
        } else if ([wind isEqualToString:@"02"]) {
            [self setBtnSubViewsOfLable:@"二档" withWhichBtn:windBtn];
        } else if ([wind isEqualToString:@"03"]) {
            [self setBtnSubViewsOfLable:@"三档" withWhichBtn:windBtn];
        } else if ([wind isEqualToString:@"04"]) {
            [self setBtnSubViewsOfLable:@"四档" withWhichBtn:windBtn];
        }
    } else {
        [UIButton setBtnOfImageAndLableWithUnSelected:windBtn andTintColor:kXinFengKongJingYanSe];
    }
    
    if ([fuLiZi isEqualToString:@"01"]) {
        [UIButton setBtnOfImageAndLableWithSelected:fuLiZiBtn andBackGroundColor:kXinFengKongJingYanSe];
    } else {
        [UIButton setBtnOfImageAndLableWithUnSelected:fuLiZiBtn andTintColor:kXinFengKongJingYanSe];
    }
}

- (void)setServiceModel:(ServicesModel *)serviceModel{
    _serviceModel = serviceModel;
}


- (void)setStateModel:(StateModel *)stateModel {
    _stateModel = stateModel;
    
    
    if (_stateModel.fMode == 1) {
        [UIButton setBtnOfImageAndLableWithSelected:ziDongBtn andBackGroundColor:kXinFengKongJingYanSe];
        [self btnCancleAtcion:ziDongBtn];
        [self setBtnSubViewsOfLable:@"自动" withWhichBtn:ziDongBtn];
    } else if (_stateModel.fMode == 2) {
        [UIButton setBtnOfImageAndLableWithSelected:ziDongBtn andBackGroundColor:kXinFengKongJingYanSe];
        [self btnSureAtcion:ziDongBtn];
        [self setBtnSubViewsOfLable:@"手动" withWhichBtn:ziDongBtn];
    } else {
        [UIButton setBtnOfImageAndLableWithUnSelected:ziDongBtn andTintColor:kXinFengKongJingYanSe];
        [self btnSureAtcion:ziDongBtn];
    }
    
    if (_stateModel.fWind == 1) {
        [UIButton setBtnOfImageAndLableWithSelected:windBtn andBackGroundColor:kXinFengKongJingYanSe];
        [self btnAfterRemoveAddWhichAtcion:@selector(windZhongDangWei:) andAddNSNotificationSelector:@selector(getXinFengFunctionBtnAtcion:) withWhichBtn:windBtn];
        [self setBtnSubViewsOfLable:@"一档" withWhichBtn:windBtn];
    } else if (_stateModel.fWind == 2) {
        [UIButton setBtnOfImageAndLableWithSelected:windBtn andBackGroundColor:kXinFengKongJingYanSe];
        [self btnAfterRemoveAddWhichAtcion:@selector(windGaoDangWei:) andAddNSNotificationSelector:@selector(getXinFengFunctionBtnAtcion:) withWhichBtn:windBtn];
        [self setBtnSubViewsOfLable:@"二档" withWhichBtn:windBtn];
    } else if (_stateModel.fWind == 3) {
        [UIButton setBtnOfImageAndLableWithSelected:windBtn andBackGroundColor:kXinFengKongJingYanSe];
        [self btnAfterRemoveAddWhichAtcion:@selector(windMaxGaoDangWei:) andAddNSNotificationSelector:@selector(getXinFengFunctionBtnAtcion:) withWhichBtn:windBtn];
        [self setBtnSubViewsOfLable:@"三档" withWhichBtn:windBtn];
    } else if (_stateModel.fWind == 4) {
        [UIButton setBtnOfImageAndLableWithSelected:windBtn andBackGroundColor:kXinFengKongJingYanSe];
        [self btnAfterRemoveAddWhichAtcion:@selector(xinFengBtnDoneAtcion:) andAddNSNotificationSelector:@selector(getXinFengFunctionBtnAtcion:) withWhichBtn:windBtn];
        [self setBtnSubViewsOfLable:@"四档" withWhichBtn:windBtn];
    } else {
        [UIButton setBtnOfImageAndLableWithUnSelected:windBtn andTintColor:kXinFengKongJingYanSe];
        [self btnSureAtcion:windBtn];
    }
    
    if (_stateModel.fAnion == 1) {
        [UIButton setBtnOfImageAndLableWithSelected:fuLiZiBtn andBackGroundColor:kXinFengKongJingYanSe];
        [self btnCancleAtcion:fuLiZiBtn];
    } else {
        [UIButton setBtnOfImageAndLableWithUnSelected:fuLiZiBtn andTintColor:kXinFengKongJingYanSe];
        
        [self btnSureAtcion:fuLiZiBtn];
    }
    
    [UIButton setBtnOfImageAndLableWithUnSelected:modelBtn andTintColor:kXinFengKongJingYanSe];
    
}


- (void)btnSureAtcion:(UIButton *)btn {
    [btn removeTarget:self action:nil forControlEvents:UIControlEventTouchUpInside];
    [btn addTarget:self action:@selector(xinFengBtnDoneAtcion:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)btnCancleAtcion:(UIButton *)btn {
    [btn removeTarget:self action:nil forControlEvents:UIControlEventTouchUpInside];
    [btn addTarget:self action:@selector(xinFengBtnAgainDoneAtcion:) forControlEvents:UIControlEventTouchUpInside];
}


- (void)btnAfterRemoveAddWhichAtcion:(nonnull SEL)atcion andAddNSNotificationSelector:(nonnull SEL)selector withWhichBtn:(UIButton *)btn {
    [btn removeTarget:nil action:nil forControlEvents:UIControlEventTouchUpInside];
    [btn addTarget:self action:atcion forControlEvents:UIControlEventTouchUpInside];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:selector name:@"4232" object:nil];
}

- (void)setBtnSubViewsOfLable:(NSString *)title withWhichBtn:(UIButton *)btn {
    UILabel *label = btn.subviews[0];
    label.text = title;
}

@end
