//
//  MessageCell.m
//  联侠
//
//  Created by 杭州阿尔法特 on 2017/4/12.
//  Copyright © 2017年 张海昌. All rights reserved.
//

#import "MessageCell.h"

@implementation MessageCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    return self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
}

- (void)setIndexpath:(NSIndexPath *)indexpath {
    
    [super setIndexpath:indexpath];
  
    
    
    
    if (self.indexpath.row == 0) {
        self.lable.text = @"系统消息";
        self.imageViw.image = [UIImage imageNamed:@"icon_message2"];
        self.fenGeView.hidden = NO;
        [self setTopCorner];
    } else {
        self.lable.text = @"我的消息";
        self.imageViw.image = [UIImage imageNamed:@"icon_message1"];
        [self setBottomCorner];
    }
    
}

@end
