//
//  TableViewCell.m
//  AEFT冷风扇
//
//  Created by 杭州阿尔法特 on 16/3/31.
//  Copyright © 2016年 阿尔法特. All rights reserved.
//

#import "TableViewCell.h"

@implementation TableViewCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        //cell选中时的颜色
        self.selectionStyle = UITableViewCellSeparatorStyleNone;
    }
    return self;
}

@end
