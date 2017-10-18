//
//  LvWangJieDuTableViewCell.m
//  AEFT冷风扇
//
//  Created by 杭州阿尔法特 on 16/3/31.
//  Copyright © 2016年 阿尔法特. All rights reserved.
//

#import "LvWangJieDuTableViewCell.h"

@interface LvWangJieDuTableViewCell ()

@end

@implementation LvWangJieDuTableViewCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.selectionStyle = UITableViewCellSeparatorStyleNone;
    }
    return self;
}
@end
