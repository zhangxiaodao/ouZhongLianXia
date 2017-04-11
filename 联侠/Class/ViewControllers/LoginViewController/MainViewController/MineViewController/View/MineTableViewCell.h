//
//  MineTableViewCell.h
//  联侠
//
//  Created by 杭州阿尔法特 on 2017/4/11.
//  Copyright © 2017年 张海昌. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MineTableViewCell : UITableViewCell

@property (nonatomic , copy) NSString *isShowPromptImageView;
@property (nonatomic , strong) UILabel *clearLabel;
@property (nonatomic , strong) NSIndexPath *indexpath;


- (NSString *)getBufferSize;
@end
