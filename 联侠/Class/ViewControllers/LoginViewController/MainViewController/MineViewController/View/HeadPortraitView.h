//
//  HeadPortraitView.h
//  联侠
//
//  Created by 杭州阿尔法特 on 2017/4/11.
//  Copyright © 2017年 张海昌. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HeadPortraitView : UIView
- (instancetype _Nullable )initWithFrame:(CGRect)frame Target:(nullable id)target action:(nullable SEL)action;

@property (nonatomic , strong) UserModel * _Nullable userModel;
@end
