//
//  BingJingShouMingTableViewCell.m
//  AEFT冷风扇
//
//  Created by 杭州阿尔法特 on 16/4/4.
//  Copyright © 2016年 阿尔法特. All rights reserved.
//

#import "BingJingShouMingTableViewCell.h"

@interface BingJingShouMingTableViewCell ()<HelpFunctionDelegate>
@end

@implementation BingJingShouMingTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSeparatorStyleNone;
        
    }
    return self;
}

@end
