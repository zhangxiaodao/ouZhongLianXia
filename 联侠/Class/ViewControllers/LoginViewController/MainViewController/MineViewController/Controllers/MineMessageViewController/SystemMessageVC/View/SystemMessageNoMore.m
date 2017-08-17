//
//  SystemMessageNoMore.m
//  联侠
//
//  Created by 杭州阿尔法特 on 2017/8/16.
//  Copyright © 2017年 张海昌. All rights reserved.
//

#import "SystemMessageNoMore.h"

@implementation SystemMessageNoMore

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    
    if (self) {
        self.backgroundColor =  [[UIColor blackColor] colorWithAlphaComponent:0.8];
        self.layer.cornerRadius = 5;
        
        UILabel *label = [UILabel creatLableWithTitle:@"暂无消息" andSuperView:self andFont:k14 andTextAligment:NSTextAlignmentCenter];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(kScreenW / 2, 44));
            make.centerX.mas_equalTo(self.mas_centerX);
            make.centerY.mas_equalTo(self.mas_centerY);
        }];
        label.textColor = [UIColor whiteColor];
        label.layer.borderWidth = 0;
        
        
    }
    
    return self;
    
}

@end
