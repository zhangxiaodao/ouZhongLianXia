//
//  EnterSecondTableViewCell.h
//  AEFT冷风扇
//
//  Created by 杭州阿尔法特 on 16/3/11.
//  Copyright © 2016年 阿尔法特. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol StateTypeDelegate <NSObject>

- (void)sendStateType:(NSArray *)stateTypeArray;

@end

@interface EnterSecondTableViewCell : UITableViewCell
@property (nonatomic , strong) ServicesModel *serviceModel;
@property (nonatomic , assign) NSInteger userSn;
@property (nonatomic , strong) UIButton *zhiLengBtn;
@property (nonatomic , strong) UILabel *zhiLengLable;
@property (nonatomic , strong) UIButton *baiFengBtn;
@property (nonatomic , strong) UIButton *shanJunBtn;
@property (nonatomic , strong) UIButton *tongSuoBtn;
@property (nonatomic , strong) StateModel *model;
//@property (nonatomic , copy) NSString *fModel;
@property (nonatomic , copy) NSString *isAimation;

- (void)setbaiFengBtnWithSelected:(NSInteger) isSelected;
- (void)setshanJunBtnWithSelected:(NSInteger) isSelected;

@property (nonatomic , assign) id<StateTypeDelegate> delegate;
@end
