//
//  UIView+Extension.h
//  01-黑酷
//
//  Created by apple on 14-6-27.
//  Copyright (c) 2014年 heima. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AuthcodeView.h"

@interface UIView (Extension)
@property (nonatomic, assign) CGFloat x;
@property (nonatomic, assign) CGFloat y;
@property (nonatomic, assign) CGFloat centerX;
@property (nonatomic, assign) CGFloat centerY;
@property (nonatomic, assign) CGFloat width;
@property (nonatomic, assign) CGFloat height;
@property (nonatomic, assign) CGSize size;
@property (nonatomic) CGFloat left;
@property (nonatomic) CGFloat top;
@property (nonatomic) CGFloat right;
@property (nonatomic) CGFloat bottom;

- (void)topAdd:(CGFloat)add;
- (void)leftAdd:(CGFloat)add;
- (void)widthAdd:(CGFloat)add;
- (void)heightAdd:(CGFloat)add;

+ (UIView * _Nonnull)creatViewWithBackView:(UIImage * _Nonnull)iamge andSuperView:(UIView * _Nonnull)superView;
+ (UIView * _Nonnull)creatViewWithBackViewandTitle:(NSString * _Nonnull)text andSuperView:(UIView * _Nonnull)superView;

+ (UIView * _Nonnull)creatTextFiledWithLableText:(NSString * _Nonnull)lableText andTextFiledPlaceHold:(NSString * _Nonnull)placeHolder andSuperView:(UIView * _Nonnull)superView;

+ (UIView * _Nonnull)creatNavView:(UIView * _Nonnull)superView WithTarget:(nullable id)delegate action:(nullable SEL)action andTitle:(NSString * _Nonnull)title;

//+ (void)creatBottomFenGeView:(UIView * _Nonnull)superView;

//+ (void)creatBottomView:(UIView * _Nonnull)superView;

+ (UIView * _Nonnull)creatBottomFenGeView:(UIView * _Nonnull)superView andBackGroundColor:(UIColor * _Nonnull)backColor isOrNotAllLenth:(NSString * _Nonnull)isOrNotAllLenth;


+ (UIView  *  _Nonnull )creatMiddleFenGeView:(UIView * _Nonnull)superView andBackGroundColor:(UIColor * _Nonnull)backColor andHeight:(CGFloat)height andWidth:(CGFloat)width andConnectId:(UILabel * _Nonnull)anyLabel;

+ (UIView * _Nonnull)creatViewWithTextfiledPlaceholder:(NSString * _Nonnull)placeholder andRightOrErrorImageView:(UIImage * _Nonnull)image andSuperView:(UIView * _Nonnull)superView;

+ (UIView * _Nonnull)creatViewWithVerificationCodeAndPlaceholder:(NSString * _Nonnull)placeholder andSuperView:(UIView * _Nonnull)superView;

+ (UIView * _Nonnull)createViewWithOneLabelAndBottomViewWithSuperView:(UIView * _Nonnull)superView withLabelTitle:(NSString * _Nonnull)title;

+ (UIView * _Nonnull)createViewWithTwoLabelAndBottomAndSwitchViewWithSuperView:(UIView * _Nonnull)superView withFirstLabelTitle:(NSString * _Nonnull)firsttitle withFirstLabelTextColor:(UIColor * _Nonnull)firstTextColor withSecondLabelTitle:(NSString * _Nonnull)secondtitle withSecondLabelTextColor:(UIColor * _Nonnull)secondTextColor andSecondLabelAtcion:(nonnull SEL)secondLabelAction andSecondLabelTarget:(nullable id)secondLabeltarget andSwitchAtcion:(nonnull SEL)switchaction andSwitchTarget:(nullable id)switchtarget;

+ (UIView *_Nonnull)creatViewWithFiledCoradiusOfPlaceholder:(NSString *_Nonnull)placholder andSuperView:(UIView *_Nonnull)superView;

+ (void)setTopCornerWithView:(UIView *_Nonnull)view;
+ (void)setBottomCornerWithView:(UIView *_Nonnull)view;
@end
