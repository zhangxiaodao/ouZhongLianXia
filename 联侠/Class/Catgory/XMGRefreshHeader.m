//
//  XMGRefreshHeader.m
//  5期-百思不得姐
//
//  Created by xiaomage on 15/11/19.
//  Copyright © 2015年 xiaomage. All rights reserved.
//

#import "XMGRefreshHeader.h"

@interface XMGRefreshHeader()

@end

@implementation XMGRefreshHeader

/**
 *  初始化
 */
- (void)prepare
{
    [super prepare];
    
    self.automaticallyChangeAlpha = YES;
    self.lastUpdatedTimeLabel.textColor = [UIColor lightGrayColor];
    self.stateLabel.textColor = [UIColor lightGrayColor];
    [self setTitle:@"赶紧下拉吧" forState:MJRefreshStateIdle];
    [self setTitle:@"赶紧松开吧" forState:MJRefreshStatePulling];
    [self setTitle:@"正在加载数据..." forState:MJRefreshStateRefreshing];
    //    self.lastUpdatedTimeLabel.hidden = YES;
    //    self.stateLabel.hidden = YES;
    
}

@end
