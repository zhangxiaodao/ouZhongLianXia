//
//  MalertView.h
//  GsAnimation
//
//  Created by MX007 on 16/7/18.
//  Copyright © 2016年 zhangfaxing. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MalertView;

@protocol MalertItemSelectDelegate <NSObject>

- (void)malertItemSelect:(NSInteger)index;

@end

@interface MalertView : UIView

@property (nonatomic,assign) id<MalertItemSelectDelegate> delegate;

@property (nonatomic,strong) UIVisualEffectView *bgView;
@property (nonatomic,strong) UIView *contentViewLeft;

@property (nonatomic,strong) UIView *bottomView;

@property (nonatomic,strong) UIButton *bottomBtn;
@property (nonatomic,strong) UIImageView *exitImgvi;

- (instancetype)initWithImageArrOfButton:(NSArray *)imgArr;
- (void)showAlert;

@end
