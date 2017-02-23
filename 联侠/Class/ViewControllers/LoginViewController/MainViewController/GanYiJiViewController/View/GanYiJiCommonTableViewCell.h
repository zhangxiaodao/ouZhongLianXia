//
//  GanYiJiCommonTableViewCell.h
//  联侠
//
//  Created by 杭州阿尔法特 on 16/7/19.
//  Copyright © 2016年 张海昌. All rights reserved.
//

#import <UIKit/UIKit.h>

@class GanYiJiCommonTableViewCell;
@protocol GanYiJiCommonTableViewCellDelegate <NSObject>

- (void)getGaiYiJiCommonClothesData:(GanYiJiCommonTableViewCell *)ganYiJiCommonVC andClothesData:(NSArray *)dataArray;

@end

@interface GanYiJiCommonTableViewCell : UITableViewCell
@property (nonatomic , strong) UIViewController *vc;
@property (nonatomic , copy) NSString *isChongZhi;
@property (nonatomic , copy) NSString *isFromWhich;
@property (nonatomic , assign) id<GanYiJiCommonTableViewCellDelegate> delegate;

@end
