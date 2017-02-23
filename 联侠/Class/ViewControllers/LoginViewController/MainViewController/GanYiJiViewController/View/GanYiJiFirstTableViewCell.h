//
//  GanYiJiFirstTableViewCell.h
//  联侠
//
//  Created by 杭州阿尔法特 on 16/6/27.
//  Copyright © 2016年 张海昌. All rights reserved.
//

#import <UIKit/UIKit.h>

@class GanYiJiFirstTableViewCell;
@protocol GanYiJiFirstTableViewCellDelegate <NSObject>

- (void)getGanYiJiIsWorking:(GanYiJiFirstTableViewCell *)ganYiJiFirstTableViewCell andIswork:(NSString *)isWork;

@end

@interface GanYiJiFirstTableViewCell : UITableViewCell

@property (nonatomic , strong) ServicesDataModel *serviceDataModel;
@property (nonatomic , copy) NSString *isWork;
@property (nonatomic , assign) id<GanYiJiFirstTableViewCellDelegate> delegate;
@end
