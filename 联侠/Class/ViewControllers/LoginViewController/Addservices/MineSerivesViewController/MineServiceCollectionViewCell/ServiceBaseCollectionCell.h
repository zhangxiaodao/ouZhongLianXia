//
//  ServiceBaseCollectionCell.h
//  联侠
//
//  Created by 杭州阿尔法特 on 2017/4/12.
//  Copyright © 2017年 张海昌. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ServiceBaseCollectionCell : UICollectionViewCell

@property (nonatomic , strong) UILabel *numberLabel;
@property (strong, nonatomic)  UIImageView *backImage;
@property (nonatomic , strong) UILabel *typeName;
@property (nonatomic , strong) ServicesModel *serviceModel;
@property (nonatomic , strong) NSIndexPath *indexPath;

- (void)setServiceModel:(ServicesModel *)serviceModel;
@end
