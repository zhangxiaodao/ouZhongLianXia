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


@interface XinFengThirtTableViewCell ()<HelpFunctionDelegate>{
    UIButton *shuiMianBtn;
    UIButton *ziRanBtn;
    UIButton *gaoXiaoBtn;
    UIButton *shuShiBtn;
}
@property (nonatomic , strong) UIView *markView;
@property (nonatomic , strong) NSArray *array;
@property (nonatomic , strong) UIView *backView;
@property (nonatomic , strong) StateModel *stateModel;
@end

@implementation XinFengThirtTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
       
        [self customUI];
    }
    return self;
}


- (void)getBottomBtnSelectedMarkViewWhearthShowOfModelCell:(NSNotification *)post {
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
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getBottomBtnSelectedMarkViewWhearthShowOfModelCell:) name:@"BottomBtnSelected" object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getXinFengModelBtnAtcion:) name:@"4232" object:nil];
    
    self.backView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenW,  kBtnW * 3 / 2 )];
    self.backView.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:self.backView];
    
    
    NSArray *imageArray = @[@"xinfeng_gaoxiao" , @"xinfeng_ziran" , @"shuiMian" , @"xinfeng_shushi"];
    _array = [NSArray arrayWithObjects:@"高效" , @"节能", @"睡眠",  @"舒适", nil];
    
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
    
    switch (btn.tag) {
        case 0:
        {

            [kSocketTCP sendDataToHost:XinFengKongJing(_serviceModel.devTypeSn, _serviceModel.devSn, @"00", @"02", @"00", @"02" , @"04") andType:kZhiLing andIsNewOrOld:kNew];
            break;
        }
        case 1: {

            [kSocketTCP sendDataToHost:XinFengKongJing(_serviceModel.devTypeSn, _serviceModel.devSn, @"00", @"01", @"02", @"01" , @"02") andType:kZhiLing andIsNewOrOld:kNew];
            break;
        }
        case 2: {

            [kSocketTCP sendDataToHost:XinFengKongJing(_serviceModel.devTypeSn, _serviceModel.devSn, @"00", @"02", @"00", @"02" , @"01") andType:kZhiLing andIsNewOrOld:kNew];
            break;
        }
            
        case 3:{
            [kSocketTCP sendDataToHost:XinFengKongJing(_serviceModel.devTypeSn, _serviceModel.devSn, @"00", @"02", @"00", @"01" , @"02") andType:kZhiLing andIsNewOrOld:kNew];
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
        modelStr = @"节能";
    }
    
    if ([ziDong isEqualToString:@"02"] && [wind isEqualToString:@"01"] && [fuLiZi isEqualToString:@"01"]) {
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

- (void)setStateModel:(StateModel *)stateModel {
    _stateModel = stateModel;
    
    NSLog(@"第三个--%@" , _stateModel);
    
    if (_stateModel) {
        [UIButton setBtnOfImageAndLableWithUnSelected:gaoXiaoBtn andTintColor:kXinFengKongJingYanSe];
        [UIButton setBtnOfImageAndLableWithUnSelected:ziRanBtn andTintColor:kXinFengKongJingYanSe];
        [UIButton setBtnOfImageAndLableWithUnSelected:shuiMianBtn andTintColor:kXinFengKongJingYanSe];
        [UIButton setBtnOfImageAndLableWithUnSelected:shuShiBtn andTintColor:kXinFengKongJingYanSe];
        
        if (_stateModel.fMode == 2 && _stateModel.fWind == 1 && _stateModel.fAnion == 1) {
            [UIButton setBtnOfImageAndLableWithSelected:shuiMianBtn andBackGroundColor:kXinFengKongJingYanSe];
        }
        
        if (_stateModel.fAnion == 1 && _stateModel.fMode == 1 && _stateModel.fWind == 2) {
            [UIButton setBtnOfImageAndLableWithSelected:ziRanBtn andBackGroundColor:kXinFengKongJingYanSe];
        }
        
        if (_stateModel.fMode == 2 && _stateModel.fAnion == 2 && _stateModel.fWind == 4) {
            [UIButton setBtnOfImageAndLableWithSelected:gaoXiaoBtn andBackGroundColor:kXinFengKongJingYanSe];
        }
        
        if (_stateModel.fMode == 2 && _stateModel.fAnion == 1 && _stateModel.fWind == 2) {
            [UIButton setBtnOfImageAndLableWithSelected:shuShiBtn andBackGroundColor:kXinFengKongJingYanSe];
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

@end
