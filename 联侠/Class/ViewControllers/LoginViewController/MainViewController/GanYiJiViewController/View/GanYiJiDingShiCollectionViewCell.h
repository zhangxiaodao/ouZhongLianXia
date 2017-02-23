//
//  GanYiJiDingShiCollectionViewCell.h
//  联侠
//
//  Created by 杭州阿尔法特 on 16/6/30.
//  Copyright © 2016年 张海昌. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GanYiJIClothesModel.h"

@class GanYiJiDingShiCollectionViewCell;
@protocol GanYiJiDingShiCollectionViewCellDelegate <NSObject>

- (void)getClothesTimes:(GanYiJiDingShiCollectionViewCell *)cell didFinishTime:(NSArray *)clothesData;

@end

@interface GanYiJiDingShiCollectionViewCell : UICollectionViewCell
@property (nonatomic , strong) GanYiJIClothesModel *model;
@property (nonatomic , assign) id<GanYiJiDingShiCollectionViewCellDelegate> delegate;
@property (nonatomic , strong) NSMutableDictionary *clothesDic;
@end
