//
//  AlertMessageView.h
//  联侠
//
//  Created by 杭州阿尔法特 on 2017/3/14.
//  Copyright © 2017年 张海昌. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AlertMessageView : UIView

@property (nonatomic , copy) NSString *phoneNumber;

- (UIView *)initWithFrame:(CGRect)frame TitleText:(NSString *)titleText andBtnTarget:(nullable id)target andCancleAtcion:(nonnull SEL)cancleAtcion;

@end
