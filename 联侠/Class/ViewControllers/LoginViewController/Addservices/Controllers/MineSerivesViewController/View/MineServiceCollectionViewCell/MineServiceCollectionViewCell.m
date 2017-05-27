//
//  MineServiceCollectionViewCell.m
//  AEFT冷风扇
//
//  Created by 杭州阿尔法特 on 16/4/16.
//  Copyright © 2016年 阿尔法特. All rights reserved.
//

#import "MineServiceCollectionViewCell.h"

@interface MineServiceCollectionViewCell ()

@end

@implementation MineServiceCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    
    return self;
}

- (void)setServiceModel:(ServicesModel *)serviceModel {
    
    [super setServiceModel:serviceModel];
    self.pointImageView.hidden = YES;
    
    if (self.serviceModel) {
        [self.backImage sd_setImageWithURL:[NSURL URLWithString:self.serviceModel.imageUrl] placeholderImage:[UIImage new]];
        
        if (self.serviceModel.definedName) {
            self.typeName.text = self.serviceModel.definedName;
        } else {
            self.typeName.text = [NSString stringWithFormat:@"%@%@" , self.serviceModel.brand , self.serviceModel.typeName];
            
            if ([self.serviceModel.brand isKindOfClass:[NSNull class]]) {
                self.typeName.text = [NSString stringWithFormat:@"%@" , self.serviceModel.typeName];
            }
            
        }
        self.numberLabel.text = [NSString stringWithFormat:@"No.%ld" ,((long)self.indexPath.row + 1)];
        
        if (self.serviceModel.ifConn == 1) {
            self.onlieLabel.text = @"在线";
            self.onlieLabel.textColor = kMainColor;
        } else {
            self.onlieLabel.text = @"离线";
            self.onlieLabel.textColor = [UIColor colorWithHexString:@"767676"];
        }
        self.layer.masksToBounds = YES;
    }
    
}

@end
