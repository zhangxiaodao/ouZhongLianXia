//
//  AlertMessageView.m
//  联侠
//
//  Created by 杭州阿尔法特 on 2017/3/14.
//  Copyright © 2017年 张海昌. All rights reserved.
//

#import "AlertMessageView.h"
#import "PZXVerificationCodeView.h"

@interface AlertMessageView ()
@property(nonatomic,strong)PZXVerificationCodeView *pzxView;
@end

@implementation AlertMessageView

- (UIView *)initWithFrame:(CGRect)frame TitleText:(NSString *)titleText andBtnTarget:(nullable id)target andAtcion:(nonnull SEL)atcion {
    self = [super initWithFrame:frame];
    if (self) {
        UILabel *titleLabel = [UILabel creatLableWithTitle:titleText andSuperView:self andFont:k15 andTextAligment:NSTextAlignmentCenter];
        [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(self.width, self.height / 5));
            make.centerX.mas_equalTo(self.centerX);
            make.top.mas_equalTo(self.mas_top);
        }];
        
        UIButton *countdownBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [self addSubview:countdownBtn];
        [countdownBtn setTitle:@"60s" forState:UIControlStateNormal];
        [countdownBtn addTarget:target action:atcion forControlEvents:UIControlEventTouchUpInside];
        [countdownBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(self.width / 3, self.height / 5));
            make.centerX.mas_equalTo(self.mas_centerX);
            make.top.mas_equalTo(titleLabel.mas_bottom).offset(self.height * 2 / 15);
        }];
        countdownBtn.layer.cornerRadius = self.height / 10;
        countdownBtn.layer.masksToBounds = YES;
        
        
        _pzxView = [[PZXVerificationCodeView alloc]init];
        [self addSubview:_pzxView];
        [_pzxView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(self.width, self.height / 5));
            make.centerX.mas_equalTo(self.centerX);
            make.top.mas_equalTo(countdownBtn.mas_bottom).offset(self.height * 2 / 15);
        }];
        
        _pzxView.selectedColor = kMainColor;
        _pzxView.VerificationCodeNum = 6;
        _pzxView.Spacing = 3;//每个格子间距属性
        
    }
    return self;
}

@end
