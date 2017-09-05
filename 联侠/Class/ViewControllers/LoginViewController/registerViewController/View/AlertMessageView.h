//
//  AlertMessageView.h
//  联侠
//
//  Created by 杭州阿尔法特 on 2017/3/14.
//  Copyright © 2017年 张海昌. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AlertMessageView : UIView

@property (nonatomic , copy) NSString * _Nullable phoneNumber;

- (UIView *_Nullable)initWithFrame:(CGRect)frame TitleText:(NSString *_Nullable)titleText andBtnTarget:(nullable id)target andCancleAtcion:(nonnull SEL)cancleAtcion;

- (void)clearNumber;

@end
