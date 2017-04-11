//
//  MineServiceCollectionViewCell.h
//  AEFT冷风扇
//
//  Created by 杭州阿尔法特 on 16/4/16.
//  Copyright © 2016年 阿尔法特. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MineServiceCollectionViewCell : UICollectionViewCell

@property (nonatomic , strong) ServicesModel *serviceModel;
@property (nonatomic , strong) NSIndexPath *indexPath;

@end
