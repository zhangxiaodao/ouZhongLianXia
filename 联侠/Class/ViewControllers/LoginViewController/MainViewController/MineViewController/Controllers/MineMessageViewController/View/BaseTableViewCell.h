//
//  BaseTableViewCell.h
//  联侠
//
//  Created by 杭州阿尔法特 on 2017/2/5.
//  Copyright © 2017年 张海昌. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseTableViewCell : UITableViewCell

@property (nonatomic , strong) UIView *fenGeView;
@property (nonatomic , strong) UIView *tiShiView;
@property (nonatomic , strong) UIImageView *imageViw;
@property (nonatomic ,strong) UILabel *lable;
@property (nonatomic , strong) UIView *view;
@property (nonatomic , copy) NSString *isShowPromptImageView;
@property (nonatomic , strong) NSIndexPath *indexpath;
@property (nonatomic , strong) UIImageView *selectedImage;

- (void)setIndexpath:(NSIndexPath *)indexpath;

- (void)setTopCorner;
- (void)setBottomCorner;
@end
