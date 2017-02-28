//
//  EnterWorkTowerFirsetView.h
//  AEFT冷风扇
//
//  Created by 杭州阿尔法特 on 16/3/11.
//  Copyright © 2016年 阿尔法特. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EnterWorkTowerFirsetView : UIView

+ (EnterWorkTowerFirsetView *)creatViewWithColor:(UIColor *)color withSuperView:(UIView *)superView;

@property (nonatomic , strong) NSArray *stateArray;
- (void)setStateArray:(NSArray *)stateArray;
@end
