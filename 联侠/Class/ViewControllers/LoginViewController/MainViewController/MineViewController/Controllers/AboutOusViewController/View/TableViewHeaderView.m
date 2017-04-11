//
//  TableViewHeaderView.m
//  联侠
//
//  Created by 杭州阿尔法特 on 2017/2/10.
//  Copyright © 2017年 张海昌. All rights reserved.
//

#import "TableViewHeaderView.h"

@implementation TableViewHeaderView

- (instancetype)init {
    
    if (self = [super init]) {
        
        UIImageView *imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"logo"]];
        [self addSubview:imageView];
        [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(kScreenW / 5, kScreenW / 5));
            make.centerX.mas_equalTo(self.centerX);
            make.centerY.mas_equalTo(self.centerY).offset(-kScreenW / 20);
        }];
        imageView.layer.cornerRadius = 5;
        
        UILabel *versionLabel = [UILabel creatLableWithTitle:nil andSuperView:self andFont:k12 andTextAligment:NSTextAlignmentCenter];
        [versionLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(kScreenW / 5, kScreenW / 20));
            make.top.mas_equalTo(imageView.mas_bottom);
            make.centerX.mas_equalTo(imageView.mas_centerX);
        }];
        versionLabel.layer.borderWidth = 0;
    }
    
    return self;

}

- (void)setVersion:(NSString *)version {
    _version = version;
    
    UILabel *label = [self.subviews lastObject];
    label.text = [NSString stringWithFormat:@"V %@" , _version];
}

@end
