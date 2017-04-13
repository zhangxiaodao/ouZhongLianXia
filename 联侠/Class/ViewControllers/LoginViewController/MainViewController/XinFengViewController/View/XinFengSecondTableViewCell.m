//
//  XinFengSecondTableViewCell.m
//  联侠
//
//  Created by 杭州阿尔法特 on 16/10/11.
//  Copyright © 2016年 张海昌. All rights reserved.
//

#import "XinFengSecondTableViewCell.h"
#import "XinFengCaiDengViewController.h"
#define kArrayCount _array.count
#define kArrayCountJiaYi (_array.count + 1)
#define kBtnW ((kScreenW + 4) / 4)
#define kContentViewHeight kBtnW * 2 + kBtnW * 2 / 3
@interface XinFengSecondTableViewCell ()<HelpFunctionDelegate>
{
    UIButton *ziDongBtn;
    UIButton *windBtn;
    UIButton *fuLiZiBtn;
    UIButton *modelBtn;
    UIButton *shouDongBtn;
    UIButton *caiDengBtn;
}
@property (nonatomic , strong) UIView *markView;
@property (nonatomic , strong) NSArray *array;
@property (nonatomic , strong) UIView *backView;
@property (nonatomic , strong) StateModel *stateModel;
@end

@implementation XinFengSecondTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        [self customUI];
    }
    return self;
}


- (void)getBottomBtnSelectedMarkViewWhearthShow:(NSNotification *)post {
    NSString *selected = post.userInfo[@"BottomBtnSelected"];
//    NSLog(@"selected--%@ , %ld" , selected , selected.integerValue);
    if (selected.integerValue == 1){
        [UIView animateWithDuration:.3 animations:^{
            self.markView.alpha = 0;
        }];
        
    } else {
        [UIView animateWithDuration:.3 animations:^{
            self.markView.alpha = .3;
        }];
    }
    
    
}

- (void)customUI {
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getBottomBtnSelectedMarkViewWhearthShow:) name:@"BottomBtnSelected" object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getXinFengFunctionBtnAtcion:) name:@"4232" object:nil];
    
    self.backView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenW,  kBtnW * 9 / 4 + 1)];
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
    
    self.markView = [[UIView alloc]init];
    [self.backView addSubview:self.markView];
    self.markView.frame = self.backView.bounds;
    self.markView.backgroundColor = [UIColor blackColor];
    self.markView.alpha = .3;
    if ([kStanderDefault objectForKey:@"offBtn"]) {
        NSNumber *bottomSelected = [kStanderDefault objectForKey:@"offBtn"];
        
        if (bottomSelected.integerValue == 0) {
            [UIView animateWithDuration:.3 animations:^{
                self.markView.alpha = .3;
            }];
        } else {
            [UIView animateWithDuration:.3 animations:^{
                self.markView.alpha = 0;
            }];
        }
    }
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
           
            break;
        }
        case 3: {
            [kSocketTCP sendDataToHost:XinFengKongJing(_serviceModel.devTypeSn, _serviceModel.devSn, @"00", @"02", @"00", @"00" , @"00") andType:kZhiLing andIsNewOrOld:kNew];
            
            break;
        }
        case 4: {
            
            XinFengCaiDengViewController *xinFengCaiDengVC = [[XinFengCaiDengViewController alloc]init];
            xinFengCaiDengVC.serviceModel = self.serviceModel;
            UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:xinFengCaiDengVC];
            
            [kWindowRoot presentViewController:nav animated:YES completion:nil];
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
        [self btnRemoveAtcion:@selector(xinFengBtnDoneAtcion:) andAddSelector:@selector(xinFengBtnAgainDoneAtcion:) withWhichBtn:btn];
        
    } else if (btn.tag == 1){
//        [self btnAfterRemoveAddWhichAtcion:@selector(windZhongDangWei:) andAddNSNotificationSelector:@selector(getXinFengFunctionBtnAtcion:) withWhichBtn:btn];
        [self btnRemoveAtcion:@selector(xinFengBtnDoneAtcion:) andAddSelector:@selector(windZhongDangWei:) withWhichBtn:btn];
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
    [self btnRemoveAtcion:@selector(xinFengBtnAgainDoneAtcion:) andAddSelector:@selector(xinFengBtnDoneAtcion:) withWhichBtn:btn];
}

#pragma mark - 风速中档位
- (void)windZhongDangWei:(UIButton *)btn {
    [kSocketTCP sendDataToHost:XinFengKongJing(_serviceModel.devTypeSn, _serviceModel.devSn, @"00", @"00", @"00", @"00" , @"02") andType:kZhiLing andIsNewOrOld:kNew];
    btn.tag = 2;

    [self btnRemoveAtcion:@selector(windZhongDangWei:) andAddSelector:@selector(windGaoDangWei:) withWhichBtn:btn];
}

#pragma mark - 风速高档位
- (void)windGaoDangWei:(UIButton *)btn {
    [kSocketTCP sendDataToHost:XinFengKongJing(_serviceModel.devTypeSn, _serviceModel.devSn, @"00", @"00", @"00", @"00" , @"03") andType:kZhiLing andIsNewOrOld:kNew];
    btn.tag = 3;
    [self btnRemoveAtcion:@selector(windGaoDangWei:) andAddSelector:@selector(windMaxGaoDangWei:) withWhichBtn:btn];
}

#pragma mark - 风速最高档位
- (void)windMaxGaoDangWei:(UIButton *)btn {
    [kSocketTCP sendDataToHost:XinFengKongJing(_serviceModel.devTypeSn, _serviceModel.devSn, @"00", @"00", @"00", @"00" , @"04") andType:kZhiLing andIsNewOrOld:kNew];
   
    [self btnRemoveAtcion:@selector(windMaxGaoDangWei:) andAddSelector:@selector(xinFengBtnDoneAtcion:) withWhichBtn:btn];
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
    
    if (_serviceModel) {
        NSDictionary *parames = @{@"devSn" : _serviceModel.devSn , @"devTypeSn" : _serviceModel.devTypeSn};
        [HelpFunction requestDataWithUrlString:kChaXunKongJingDangQianZhuangTai andParames:parames andDelegate:self];
    }
}


#pragma mark - 获取设备的状态
- (void)requestData:(HelpFunction *)request didSuccess:(NSDictionary *)dddd{
    //    NSLog(@"%@" , dddd);
    if ([dddd[@"data"] isKindOfClass:[NSDictionary class]]) {
        NSDictionary *dataDic = dddd[@"data"];
        
        StateModel *stateModel = [[StateModel alloc]init];
        
        for (NSString *key in [dataDic allKeys]) {
            [stateModel setValue:dataDic[key] forKey:key];
        }
        
        [self setStateModel:stateModel];
    }
    
}

- (void)requestData:(HelpFunction *)request didFailLoadData:(NSError *)error {
    NSLog(@"%@" , error);
}

- (void)setStateModel:(StateModel *)stateModel {
    _stateModel = stateModel;
    
    NSLog(@"第二个--%@ " , _stateModel);
  
    if (_stateModel) {
        [UIButton setBtnOfImageAndLableWithUnSelected:fuLiZiBtn andTintColor:kXinFengKongJingYanSe];
        [UIButton setBtnOfImageAndLableWithUnSelected:windBtn andTintColor:kXinFengKongJingYanSe];
        [UIButton setBtnOfImageAndLableWithUnSelected:ziDongBtn andTintColor:kXinFengKongJingYanSe];
        [UIButton setBtnOfImageAndLableWithUnSelected:shouDongBtn andTintColor:kXinFengKongJingYanSe];
        
        if (_stateModel.fMode == 1) {
            [UIButton setBtnOfImageAndLableWithSelected:ziDongBtn andBackGroundColor:kXinFengKongJingYanSe];
            //        [self btnCancleAtcion:ziDongBtn];
            
        } else if (_stateModel.fMode == 2) {
            [UIButton setBtnOfImageAndLableWithSelected:shouDongBtn andBackGroundColor:kXinFengKongJingYanSe];
            //        [self btnSureAtcion:ziDongBtn];
        }
        
        if (_stateModel.fWind == 1 || _stateModel.fWind == 2 || _stateModel.fWind == 3 || _stateModel.fWind == 4) {
            [UIButton setBtnOfImageAndLableWithSelected:windBtn andBackGroundColor:kXinFengKongJingYanSe];
            if (_stateModel.fWind == 1) {
                [windBtn removeTarget:self action:nil forControlEvents:UIControlEventTouchUpInside];
                [windBtn addTarget:self action:@selector(windZhongDangWei:) forControlEvents:UIControlEventTouchUpInside];
                //                [self btnRemoveAtcion:NULL andAddSelector:@selector(windZhongDangWei:) withWhichBtn:windBtn];
                [self setBtnSubViewsOfLable:@"一档" withWhichBtn:windBtn];
            } else if (_stateModel.fWind == 2) {
                
                [windBtn removeTarget:self action:nil forControlEvents:UIControlEventTouchUpInside];
                [windBtn addTarget:self action:@selector(windGaoDangWei:) forControlEvents:UIControlEventTouchUpInside];
                //                [self btnRemoveAtcion:nil andAddSelector:@selector(windGaoDangWei:) withWhichBtn:windBtn];
                [self setBtnSubViewsOfLable:@"二档" withWhichBtn:windBtn];
            } else if (_stateModel.fWind == 3) {
                
                [windBtn removeTarget:self action:nil forControlEvents:UIControlEventTouchUpInside];
                [windBtn addTarget:self action:@selector(windMaxGaoDangWei:) forControlEvents:UIControlEventTouchUpInside];
                //                [self btnRemoveAtcion:nil andAddSelector:@selector(windMaxGaoDangWei:) withWhichBtn:windBtn];
                [self setBtnSubViewsOfLable:@"三档" withWhichBtn:windBtn];
            } else if (_stateModel.fWind == 4) {
                
                [windBtn removeTarget:self action:nil forControlEvents:UIControlEventTouchUpInside];
                [windBtn addTarget:self action:@selector(xinFengBtnDoneAtcion:) forControlEvents:UIControlEventTouchUpInside];
                //                [self btnRemoveAtcion:nil andAddSelector:@selector(xinFengBtnDoneAtcion:) withWhichBtn:windBtn];
                [self setBtnSubViewsOfLable:@"四档" withWhichBtn:windBtn];
            }
        } else {
            [UIButton setBtnOfImageAndLableWithUnSelected:windBtn andTintColor:kXinFengKongJingYanSe];
            [self setBtnSubViewsOfLable:@"无" withWhichBtn:windBtn];
        }
        
        
        
        if (_stateModel.fAnion == 1) {
            [UIButton setBtnOfImageAndLableWithSelected:fuLiZiBtn andBackGroundColor:kXinFengKongJingYanSe];
            [self btnRemoveAtcion:@selector(xinFengBtnDoneAtcion:) andAddSelector:@selector(xinFengBtnAgainDoneAtcion:) withWhichBtn:windBtn];
        } else {
            [UIButton setBtnOfImageAndLableWithUnSelected:fuLiZiBtn andTintColor:kXinFengKongJingYanSe];
            [self btnRemoveAtcion:@selector(xinFengBtnAgainDoneAtcion:) andAddSelector:@selector(xinFengBtnDoneAtcion:) withWhichBtn:windBtn];
            
        }
        
        if (_stateModel.fSwitch == 1){
            
            [UIView animateWithDuration:.3 animations:^{
                self.markView.alpha = 0;
            }];
            
        } else if (_stateModel.fSwitch == 0) {
            
            [UIView animateWithDuration:.3 animations:^{
                self.markView.alpha = .3;
            }];
        }
        
    }
    
    
}


//- (void)btnSureAtcion:(UIButton *)btn {
//    [btn removeTarget:self action:nil forControlEvents:UIControlEventTouchUpInside];
//    [btn addTarget:self action:@selector(xinFengBtnDoneAtcion:) forControlEvents:UIControlEventTouchUpInside];
//}
//
//- (void)btnCancleAtcion:(UIButton *)btn {
//    [btn removeTarget:self action:nil forControlEvents:UIControlEventTouchUpInside];
//    [btn addTarget:self action:@selector(xinFengBtnAgainDoneAtcion:) forControlEvents:UIControlEventTouchUpInside];
//}


- (void)btnRemoveAtcion:(nonnull SEL)atcion  andAddSelector:(nonnull SEL)selector withWhichBtn:(UIButton *)btn {
    [btn removeTarget:self action:atcion forControlEvents:UIControlEventTouchUpInside];
    [btn addTarget:self action:selector forControlEvents:UIControlEventTouchUpInside];
    
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:selector name:@"4232" object:nil];
}

- (void)setBtnSubViewsOfLable:(NSString *)title withWhichBtn:(UIButton *)btn {
    UILabel *label = btn.subviews[0];
    label.text = title;
}

@end
