//
//  AllServicesCollectionViewCell.m
//  联侠
//
//  Created by 杭州阿尔法特 on 2016/11/8.
//  Copyright © 2016年 张海昌. All rights reserved.
//

#import "AllServicesCollectionViewCell.h"

@implementation AllServicesCollectionViewCell
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    
    return self;
}

- (void)setServiceModel:(ServicesModel *)serviceModel {
    
    [super setServiceModel:serviceModel];
    
    
    if (self.serviceModel) {
        [self.backImage sd_setImageWithURL:[NSURL URLWithString:self.serviceModel.imageUrl] placeholderImage:[UIImage new]];
        
        if (self.serviceModel.definedName) {
            self.typeName.text = self.serviceModel.definedName;
        } else {

            if (self.serviceModel.brand == nil) {
                self.typeName.text = [NSString stringWithFormat:@"%@" , self.serviceModel.typeName];
            } else {
                self.typeName.text = [NSString stringWithFormat:@"%@%@" , self.serviceModel.brand , self.serviceModel.typeName];
            }
            
        }
        self.numberLabel.text = [NSString stringWithFormat:@"No.%ld" ,((long)self.indexPath.row + 1)];
        self.layer.masksToBounds = YES;
    }
    
}

@end
