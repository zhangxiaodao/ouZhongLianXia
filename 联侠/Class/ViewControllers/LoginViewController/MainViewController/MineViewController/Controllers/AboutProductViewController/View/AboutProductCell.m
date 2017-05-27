//
//  AboutProductCell.m
//  联侠
//
//  Created by 杭州阿尔法特 on 2017/4/12.
//  Copyright © 2017年 张海昌. All rights reserved.
//

#import "AboutProductCell.h"

@implementation AboutProductCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    return self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
}

- (void)setIndexpath:(NSIndexPath *)indexpath {
    [super setIndexpath:indexpath];
    
    if (self.indexpath.row == 0) {
        self.imageViw.image = [UIImage imageNamed:@"icon_product_explain"];
        self.lable.text = @"产品说明";
        self.fenGeView.hidden = NO;
//        [self setTopCorner];
        self.backImage.image = [UIImage imageNamed:@"topleftandright"];
        
    } else if (self.indexpath.row == 1) {
        self.imageViw.image = [UIImage imageNamed:@"icon_online_help"];
        self.lable.text = @"在线帮助";
        self.fenGeView.hidden = NO;
    } else if (self.indexpath.row == 2) {
        self.imageViw.image = [UIImage imageNamed:@"icon_feedback"];
        self.lable.text = @"建议反馈";
        self.fenGeView.hidden = NO;
    } else {
        self.imageViw.image = [UIImage imageNamed:@"icon_log"];
        self.lable.text = @"更新日志";
//        [self setBottomCorner];
        self.backImage.image = [UIImage imageNamed:@"bottomleftandright"];
    }
    
}



@end
