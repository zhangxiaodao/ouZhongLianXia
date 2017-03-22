//
//  XinFengCaiDengHeaderView.m
//  联侠
//
//  Created by 杭州阿尔法特 on 2017/3/22.
//  Copyright © 2017年 张海昌. All rights reserved.
//

#import "XinFengCaiDengHeaderView.h"

@interface XinFengCaiDengHeaderView ()
@property (nonatomic , strong) UIButton *pauseBtn;
@property (nonatomic , strong) UIButton *autoBtn;
@property (nonatomic , strong) UIButton *closeBtn;
@end

#define kBtnW ((kScreenW - kScreenW / 5) / 3)
#define kMargin (kScreenW / 20)
@implementation XinFengCaiDengHeaderView

- (XinFengCaiDengHeaderView *)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getXinFengCaiDengHeaderViewAtcion:) name:@"4232" object:nil];
        
        NSArray *threeNameArray = @[@"暂停" , @"自动" , @"关闭"];
        for (int i = 0; i < 3; i++) {
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
            [btn setTitle:threeNameArray[i] forState:UIControlStateNormal];
            [self addSubview:btn];
            [btn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.size.mas_equalTo(CGSizeMake(kBtnW, self.height * 2 / 3));
                make.top.mas_equalTo(self.mas_top).offset(self.height / 6);
                if (i == 0) {
                    make.centerX.mas_equalTo(self.mas_centerX).offset(-kBtnW - kMargin);
                } else if (i == 1) {
                    make.centerX.mas_equalTo(self.mas_centerX);
                } else if (i == 2) {
                    make.centerX.mas_equalTo(self.mas_centerX).offset(kBtnW + kMargin);
                }
            }];
            btn.layer.borderColor = kXinFengKongJingYanSe.CGColor;
            btn.layer.borderWidth = 1;
            btn.layer.cornerRadius = 3;
            [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            
            [btn addTarget:self action:@selector(titleBtnAtcion:) forControlEvents:UIControlEventTouchUpInside];
            btn.tag = 50 + i;
            
            if (i == 0) {
                self.pauseBtn = btn;
            } else if (i == 1) {
                self.autoBtn = btn;
            } else if (i == 2) {
                self.closeBtn = btn;
            }
        }
    }
    return self;
}
    
    
- (void)titleBtnAtcion:(UIButton *)btn {
    
    NSInteger index = 0;
    if (btn.tag == 50) {
        index = 16;
    } else if (btn.tag == 51) {
        index = 2;
    } else if (btn.tag == 52) {
        index = 1;
    }
    NSString *toHex = [[NSString ToHex:index] substringFromIndex:2];
    
    NSLog(@"%@" , toHex);
    
    if (_serviceModel) {
        [kSocketTCP sendDataToHost:[NSString stringWithFormat:@"HMFFA%@%@w0000%@0000000000000000000000%@%@0000000000000000#" , _serviceModel.devTypeSn , _serviceModel.devSn ,  toHex, [[NSString sendXinFengNowTime] firstObject] , [[NSString sendXinFengNowTime] lastObject]] andType:kZhiLing andIsNewOrOld:kNew];
        NSLog(@"%@" , [NSString stringWithFormat:@"HMFFA%@%@w0000%@0000000000000000000000%@%@0000000000000000#" , _serviceModel.devTypeSn , _serviceModel.devSn ,  toHex, [[NSString sendXinFengNowTime] firstObject] , [[NSString sendXinFengNowTime] lastObject]]);
        }
}
    
- (void)getXinFengCaiDengHeaderViewAtcion:(NSNotification *)post {
    NSString *mingLing = post.userInfo[@"Message"];
    NSString *caiDeng = [mingLing substringWithRange:NSMakeRange(32, 2)];
    NSString *indexCaiDeng = [NSString turnHexToInt:caiDeng];
    NSLog(@"彩灯回传命令%@ , %@" , caiDeng , indexCaiDeng);
    
    NSInteger index = indexCaiDeng.intValue;
    
    self.pauseBtn.backgroundColor = [UIColor whiteColor];
    self.autoBtn.backgroundColor = [UIColor whiteColor];
    self.closeBtn.backgroundColor = [UIColor whiteColor];

    if (index == 1) {
        self.closeBtn.backgroundColor = kXinFengKongJingYanSe;
    } else if (index == 2) {
        self.autoBtn.backgroundColor = kXinFengKongJingYanSe;
    } else if (index == 16) {
        self.pauseBtn.backgroundColor = kXinFengKongJingYanSe;
    }
}
    
- (void)setServiceModel:(ServicesModel *)serviceModel {
    _serviceModel = serviceModel;
}
    
- (void)setStateModel:(StateModel *)stateModel {
    _stateModel = stateModel;
    self.pauseBtn.backgroundColor = [UIColor whiteColor];
    self.autoBtn.backgroundColor = [UIColor whiteColor];
    self.closeBtn.backgroundColor = [UIColor whiteColor];
    
    if (_stateModel) {
        if (_stateModel.light == 1) {
            self.closeBtn.backgroundColor = kXinFengKongJingYanSe;
        } else if (_stateModel.light == 2) {
            self.autoBtn.backgroundColor = kXinFengKongJingYanSe;
        } else if (_stateModel.light == 16) {
            self.pauseBtn.backgroundColor = kXinFengKongJingYanSe;
        }
    }
}
    
@end
