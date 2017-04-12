//
//  AllTypeServiceTableViewCell.m
//  联侠
//
//  Created by 杭州阿尔法特 on 2016/12/2.
//  Copyright © 2016年 张海昌. All rights reserved.
//

#import "AllTypeServiceTableViewCell.h"

@interface AllTypeServiceTableViewCell ()

@end

@implementation AllTypeServiceTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    self.lable.font = [UIFont systemFontOfSize:13];
    
    return self;
}

- (void)setIndexpath:(NSIndexPath *)indexpath {
    [super setIndexpath:indexpath];
    
    if (indexpath.row == 0) {
        [self setTopCorner];
    }
    
    if (indexpath.row != self.dataArray.count - 1) {
        self.fenGeView.hidden = NO;
    } else {
        self.fenGeView.hidden = YES;
    }
    
    if (indexpath.row == self.dataArray.count - 1) {
        [self setBottomCorner];
    }
}

- (void)setAllTypeServiceModel:(AllTypeServiceModel *)allTypeServiceModel {
    _allTypeServiceModel = allTypeServiceModel;

    [self.imageViw sd_setImageWithURL:[NSURL URLWithString:_allTypeServiceModel.imageUrl] placeholderImage:[UIImage new]];
    self.lable.text = _allTypeServiceModel.typeName;
}

@end
