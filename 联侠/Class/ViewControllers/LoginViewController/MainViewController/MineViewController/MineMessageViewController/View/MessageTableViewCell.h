//
//  MessageTableViewCell.h
//  联侠
//
//  Created by 杭州阿尔法特 on 2017/2/5.
//  Copyright © 2017年 张海昌. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MessageTableViewCell : UITableViewCell

@property (nonatomic , strong) UIImageView *imageViw;
@property (nonatomic ,strong) UILabel *lable;
@property (nonatomic , copy) NSString *isShowPromptImageView;
@property (nonatomic , strong) UILabel *clearLabel;

@end
