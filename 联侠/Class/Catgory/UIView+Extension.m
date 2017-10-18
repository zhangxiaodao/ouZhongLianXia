//
//  UIView+Extension.m
//  01-黑酷
//
//  Created by apple on 14-6-27.
//  Copyright (c) 2014年 heima. All rights reserved.
//

#import "UIView+Extension.h"

@implementation UIView (Extension)

- (void)setX:(CGFloat)x
{
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}

- (CGFloat)x
{
    return self.frame.origin.x;
}

- (void)setY:(CGFloat)y
{
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}

- (CGFloat)y
{
    return self.frame.origin.y;
}

- (void)setCenterX:(CGFloat)centerX
{
    CGPoint center = self.center;
    center.x = centerX;
    self.center = center;
}

- (CGFloat)centerX
{
    return self.center.x;
}

- (void)setCenterY:(CGFloat)centerY
{
    CGPoint center = self.center;
    center.y = centerY;
    self.center = center;
}

- (CGFloat)centerY
{
    return self.center.y;
}

- (void)setWidth:(CGFloat)width
{
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}

- (CGFloat)width
{
    return self.frame.size.width;
}

- (void)setHeight:(CGFloat)height
{
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}

- (CGFloat)height
{
    return self.frame.size.height;
}

- (void)setSize:(CGSize)size
{
//    self.width = size.width;
//    self.height = size.height;
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
}

- (CGSize)size
{
    return self.frame.size;
}

- (CGFloat)left {
    return self.frame.origin.x;
}
- (void)setLeft:(CGFloat)x {
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}
- (void)leftAdd:(CGFloat)add{
    CGRect frame = self.frame;
    frame.origin.x += add;
    self.frame = frame;
}


- (CGFloat)top {
    return self.frame.origin.y;
}
- (void)setTop:(CGFloat)y {
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}
- (void)topAdd:(CGFloat)add{
    CGRect frame = self.frame;
    frame.origin.y += add;
    self.frame = frame;
}


- (CGFloat)right {
    return self.frame.origin.x + self.frame.size.width;
}
- (void)setRight:(CGFloat)right {
    CGRect frame = self.frame;
    frame.origin.x = right - frame.size.width;
    self.frame = frame;
}

- (CGFloat)bottom {
    return self.frame.origin.y + self.frame.size.height;
}
- (void)setBottom:(CGFloat)bottom {
    CGRect frame = self.frame;
    frame.origin.y = bottom - frame.size.height;
    self.frame = frame;
}




//- (CGFloat)width {
//    return self.frame.size.width;
//}
//- (void)setWidth:(CGFloat)width {
//    CGRect frame = self.frame;
//    frame.size.width = width;
//    self.frame = frame;
//}
- (void)widthAdd:(CGFloat)add {
    CGRect frame = self.frame;
    frame.size.width += add;
    self.frame = frame;
}


//- (CGFloat)height {
//    return self.frame.size.height;
//}
//- (void)setHeight:(CGFloat)height {
//    CGRect frame = self.frame;
//    frame.size.height = height;
//    self.frame = frame;
//}
- (void)heightAdd:(CGFloat)add {
    CGRect frame = self.frame;
    frame.size.height += add;
    self.frame = frame;
}


- (CGPoint)origin {
    return self.frame.origin;
}
- (void)setOrigin:(CGPoint)origin {
    CGRect frame = self.frame;
    frame.origin = origin;
    self.frame = frame;
}
//- (CGSize)size {
//    return self.frame.size;
//}
//- (void)setSize:(CGSize)size {
//    CGRect frame = self.frame;
//    frame.size = size;
//    self.frame = frame;
//}

+ (UIView *)creatViewWithFrame:(CGSize)size image:(UIImage *)iamge andSuperView:(UIView *)superView {
    
    UIView *bigView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, size.width, size.height)];
    bigView.backgroundColor = [UIColor clearColor];
    [superView addSubview:bigView];
    bigView.userInteractionEnabled = YES;
    
    
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0,bigView.width / 2, bigView.width / 2)];
    [bigView addSubview:view];
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(bigView.width / 2, bigView.width / 2));
        make.centerY.mas_equalTo(bigView.mas_centerY);
        make.centerX.mas_equalTo(bigView.mas_centerX);
    }];
    view.backgroundColor = [UIColor blackColor];
    view.layer.cornerRadius = view.height / 2;
    view.layer.masksToBounds = YES;
    view.layer.opacity = 0.5;
    
    UIImageView *imageVIew = [[UIImageView alloc]initWithImage:iamge];
    [bigView addSubview:imageVIew];
    [imageVIew mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(view.height * 2 / 3, view.height * 2 / 3));
        make.centerX.mas_equalTo(view.mas_centerX);
        make.centerY.mas_equalTo(view.mas_centerY);
    }];
    [UIImageView setImageViewColor:imageVIew andColor:kWhiteColor];
    return bigView;
}

+ (UIView *)creatViewWithBackViewandTitle:(NSString *)text andSuperView:(UIView *)superView{
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenW / 2, kScreenH / 31.7619)];
    [superView addSubview:view];
    view.backgroundColor = [UIColor blackColor];
    view.layer.cornerRadius = view.height / 2;
    view.layer.masksToBounds = YES;
    view.layer.opacity = 0.5;
    view.userInteractionEnabled = YES;
    UILabel *lable = [UILabel creatLableWithTitle:text andSuperView:superView andFont:k15 andTextAligment:NSTextAlignmentCenter];
    lable.layer.borderWidth = 0;
    lable.textColor = [UIColor whiteColor];
    [lable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(view.mas_centerY);
        make.centerX.mas_equalTo(view.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(view.width, view.height));
    }];
    
    
    return view;
}

+ (UIView *)creatTextFiledWithLableText:(NSString *)lableText andTextFiledPlaceHold:(NSString *)placeHolder andSuperView:(UIView *)superView {
    
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kStandardW, kScreenW / 10)];
    [superView addSubview:view];
    view.backgroundColor = [UIColor clearColor];
    
    UIView *xiaHuaXian2 = [[UIView alloc]init];
    [view addSubview:xiaHuaXian2];
    xiaHuaXian2.backgroundColor = [UIColor lightGrayColor];
    [xiaHuaXian2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kStandardW, 1));
        make.centerX.mas_equalTo(view.mas_centerX);
        make.bottom.mas_equalTo(view.mas_bottom);
    }];
    
    
    UILabel *nameLabel = [UILabel creatLableWithTitle:lableText andSuperView:view andFont:k15 andTextAligment:NSTextAlignmentLeft];
    [nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(xiaHuaXian2.mas_left);
        make.bottom.mas_equalTo(xiaHuaXian2.mas_top);
    }];

    
    UITextField *textFiled = [UITextField creatTextfiledWithPlaceHolder:placeHolder andSuperView:view];
    CGFloat width = kStandardW - [nameLabel contentSize].width - kStandardW / 25;
    [textFiled mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(width, kScreenW / 10));
        make.left.mas_equalTo(nameLabel.mas_right)
        .offset(kStandardW / 25);
        make.centerY.mas_equalTo(nameLabel.mas_centerY);
    }];
    textFiled.clearButtonMode = UITextFieldViewModeWhileEditing;
//    textFiled.hidden = YES;
    
    return view;
}


+ (UIView *)creatNavView:(UIView *)superView WithTarget:(nullable id)delegate action:(nullable SEL)action  andTitle:(NSString *)title{
    
    UIView *navView = [[UIView alloc]init];
    [superView addSubview:navView];
    navView.layer.borderWidth = 0;
    navView.layer.borderColor = [UIColor colorWithRed:224/255.0 green:224/255.0 blue:224/255.0 alpha:1.0].CGColor;
    
    [navView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kScreenW + 2, kScreenH / 14));
        make.left.mas_equalTo(-1);
        make.top.mas_equalTo(kScreenH / 28.4);
    }];
    
    
    UIView *backView = [UIView creatViewWithFrame:CGSizeMake(kNavibarH  * 4 / 5, kNavibarH * 4 / 5) image:[UIImage imageNamed:@"iconfont-fanhui"] andSuperView:navView];
    [backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(kScreenW / 30);
        make.centerY.mas_equalTo(navView.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(kNavHidth * 4 / 5, kNavHidth * 4 / 5));
    }];
    backView.backgroundColor = [UIColor clearColor];
    UITapGestureRecognizer *backTap = [[UITapGestureRecognizer alloc]initWithTarget:delegate action:action];
    [backView addGestureRecognizer:backTap];
    
    UIView *titleView = [UIView creatViewWithBackViewandTitle:title andSuperView:navView];
    titleView.backgroundColor = [UIColor clearColor];
    [titleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(navView.mas_centerX);
        make.centerY.mas_equalTo(backView.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(kNavHidth * 4 / 5, kNavHidth * 4 / 5));
    }];
    
    
    [backView.subviews objectAtIndex:1].tintColor = [UIColor blackColor];
    [backView.subviews objectAtIndex:0].backgroundColor = [UIColor clearColor];
    UILabel *lable11 = [navView.subviews objectAtIndex:2];
    lable11.textColor = [UIColor blackColor];
    
    
    return navView;
}

//+ (void)creatBottomFenGeView:(UIView *)superView {
//    
//    UIView *bottomView = [[UIView alloc]initWithFrame:CGRectMake(kScreenW / 40, superView.height - 1, kScreenW - kScreenW / 20, 1)];
//    [superView addSubview:bottomView];
//    //    bottomView.layer.borderWidth = 1;
//    //    bottomView.layer.borderColor = [UIColor lightGrayColor].CGColor;
//    bottomView.backgroundColor = [UIColor colorWithRed:222/255.0 green:222/255.0 blue:222/255.0 alpha:1.0];
//    
//    bottomView.layer.shadowColor = [UIColor colorWithRed:222/255.0 green:222/255.0 blue:222/255.0 alpha:1.0].CGColor;//shadowColor阴影颜色
//    bottomView.layer.shadowOffset = CGSizeMake(0,1);//shadowOffset阴影偏移,x向右偏移4，y向下偏移4，默认(0, -3),这个跟shadowRadius配合使用
//    bottomView.layer.shadowOpacity = 0.3;//阴影透明度，默认0
//    bottomView.layer.shadowRadius = 1;//阴影半径，默认3
//}

//+ (void)creatBottomView:(UIView *)superView {
//    UIView *bottomView = [[UIView alloc]init];
//    [superView addSubview:bottomView];
//    bottomView.backgroundColor = kFenGeXianYanSe;
//    [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.size.mas_equalTo(CGSizeMake(kScreenW, 5));
//        make.bottom.mas_equalTo(superView.mas_bottom);
//        make.centerX.mas_equalTo(superView.mas_centerX);
//    }];
//}

+ (UIView *)creatBottomFenGeView:(UIView *)superView andBackGroundColor:(UIColor *)backColor isOrNotAllLenth:(NSString *)isOrNotAllLenth{
    UIView *bottomView = [[UIView alloc]init];
    bottomView.backgroundColor = backColor;
    [superView addSubview:bottomView];
    [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        if ([isOrNotAllLenth isEqualToString:@"YES"]) {
            make.size.mas_equalTo(CGSizeMake(kScreenW, 1));
            make.left.mas_equalTo(0);
        } else if ([isOrNotAllLenth isEqualToString:@"NO"]) {
            make.size.mas_equalTo(CGSizeMake(kScreenW - kScreenW / 10, 1));
            make.left.mas_equalTo(kScreenW / 20);
        }
        make.bottom.mas_equalTo(superView.mas_bottom);
    }];
    return bottomView;
}

+ (UIView *)creatMiddleFenGeView:(UIView *)superView andBackGroundColor:(UIColor *)backColor andHeight:(CGFloat)height andWidth:(CGFloat)width andConnectId:(UILabel *)anyLabel {
    
    UIView *middleFenGeView = [[UIView alloc]init];
    middleFenGeView.backgroundColor = backColor;
    [superView addSubview:middleFenGeView];
    [middleFenGeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(width, height));
        make.centerX.mas_equalTo(anyLabel.mas_centerX);
        make.top.mas_equalTo(anyLabel.mas_bottom);
    }];
    return middleFenGeView;
}

+ (UIView *)creatViewWithTextfiledPlaceholder:(NSString *)placeholder andRightOrErrorImageView:(UIImage *)image andSuperView:(UIView *)superView {
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kStandardW, kScreenW / 12)];
    [superView addSubview:view];
    

    UITextField *textfiled = [UITextField creatTextfiledWithPlaceHolder:placeholder andSuperView:view];
    [textfiled mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(view.width - kScreenW / 10, view.height));
        make.left.mas_equalTo(view.mas_left);
        make.bottom.mas_equalTo(view.mas_bottom);
    }];
    
    UIImageView *rightImageView = [[UIImageView alloc]initWithImage:image];
    [view addSubview:rightImageView];
    [rightImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kScreenW / 20, kScreenW / 20));
        make.right.mas_equalTo(view.mas_right);
        make.centerY.mas_equalTo(textfiled.mas_centerY);
    }];
    
    UIView *xiaHuaXian2 = [[UIView alloc]init];
    [view addSubview:xiaHuaXian2];
    xiaHuaXian2.backgroundColor = [UIColor grayColor];
    [xiaHuaXian2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(view.width, 1));
        make.centerX.mas_equalTo(view.mas_centerX);
        make.bottom.mas_equalTo(view.mas_bottom);
    }];
    
    return view;
}

+ (UIView * _Nonnull)creatViewWithVerificationCodeAndPlaceholder:(NSString * _Nonnull)placeholder andSuperView:(UIView * _Nonnull)superView {
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kStandardW, kScreenW / 12)];
    [superView addSubview:view];
    
    
    UITextField *textfiled = [UITextField creatTextfiledWithPlaceHolder:placeholder andSuperView:view];
    [textfiled mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(view.width - kScreenW / 10, view.height));
        make.left.mas_equalTo(view.mas_left);
        make.bottom.mas_equalTo(view.mas_bottom);
    }];
    
    AuthcodeView *authcodeView = [[AuthcodeView alloc]init];
    [view addSubview:authcodeView];
    [authcodeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(view.width / 3, view.height));
        make.centerY.mas_equalTo(textfiled.mas_centerY).offset(-5);
        make.right.mas_equalTo(view.mas_right);
    }];
    
    UIView *xiaHuaXian2 = [[UIView alloc]init];
    [view addSubview:xiaHuaXian2];
    xiaHuaXian2.backgroundColor = [UIColor grayColor];
    [xiaHuaXian2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(view.width, 1));
        make.centerX.mas_equalTo(view.mas_centerX);
        make.bottom.mas_equalTo(view.mas_bottom);
    }];
    
    return view;
}


+ (UIView *)createViewWithOneLabelAndBottomViewWithSuperView:(UIView *)superView withLabelTitle:(NSString *)title{
    
    UIView *view = [[UIView alloc]init];
    [superView addSubview:view];
    
    
    UILabel *timeTitleLabel = [UILabel creatLableWithTitle:title andSuperView:view andFont:k15 andTextAligment:NSTextAlignmentLeft];
    [timeTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kCommonW, kScreenW / 8));
        make.left.mas_equalTo(view.mas_left);
        make.centerY.mas_equalTo(view.mas_centerY);
    }];
    timeTitleLabel.textColor = [UIColor lightGrayColor];
    
    UIView *separatedView = [[UIView alloc]init];
    [view addSubview:separatedView];
    separatedView.backgroundColor = kFenGeXianYanSe;
    [separatedView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kCommonW, 1));
        make.centerX.mas_equalTo(view.mas_centerX);
        make.bottom.mas_equalTo(view.mas_bottom);
    }];
    return view;
}


+ (UIView * _Nonnull)createViewWithTwoLabelAndBottomAndSwitchViewWithSuperView:(UIView * _Nonnull)superView withFirstLabelTitle:(NSString * _Nonnull)firsttitle withFirstLabelTextColor:(UIColor * _Nonnull)firstTextColor withSecondLabelTitle:(NSString * _Nonnull)secondtitle withSecondLabelTextColor:(UIColor * _Nonnull)secondTextColor andSecondLabelAtcion:(nonnull SEL)secondLabelAction andSecondLabelTarget:(nullable id)secondLabeltarget andSwitchAtcion:(nonnull SEL)switchaction andSwitchTarget:(nullable id)switchtarget {
    UIView *view = [[UIView alloc]init];
    [superView addSubview:view];
    
    
    UILabel *titleLabel = [UILabel creatLableWithTitle:firsttitle andSuperView:view andFont:k15 andTextAligment:NSTextAlignmentLeft];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kCommonW / 3, kScreenW / 8));
        make.left.mas_equalTo(view.mas_left);
        make.centerY.mas_equalTo(view.mas_centerY);
    }];
    titleLabel.textColor = firstTextColor;
    
    UILabel *timeTitleLabel = [UILabel creatLableWithTitle:secondtitle andSuperView:view andFont:k15 andTextAligment:NSTextAlignmentCenter];
    [timeTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kCommonW / 3, kScreenW / 8));
        make.centerX.mas_equalTo(view.mas_centerX);
        make.centerY.mas_equalTo(titleLabel.mas_centerY);
    }];
    timeTitleLabel.textColor = secondTextColor;
    timeTitleLabel.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:secondLabeltarget action:secondLabelAction];
    [timeTitleLabel addGestureRecognizer:tap];
    
    UISwitch *rightSwitch = [[UISwitch alloc]init];
    [view addSubview:rightSwitch];
    [rightSwitch mas_makeConstraints:^(MASConstraintMaker *make) {
        //        make.size.mas_equalTo(CGSizeMake(kCommonW / 3, kScreenW / 8));
        make.centerY.mas_equalTo(titleLabel.mas_centerY);
        make.right.mas_equalTo(view.mas_right);
    }];
    [rightSwitch addTarget:switchtarget action:switchaction forControlEvents:UIControlEventValueChanged];
    
    UIView *separatedView = [[UIView alloc]init];
    [view addSubview:separatedView];
    separatedView.backgroundColor = kFenGeXianYanSe;
    [separatedView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kCommonW, 1));
        make.centerX.mas_equalTo(view.mas_centerX);
        make.bottom.mas_equalTo(view.mas_bottom);
    }];
    return view;
}

+ (UIView *_Nonnull)creatViewWithFiledCoradiusOfPlaceholder:(NSString *_Nonnull)placholder andSuperView:(UIView *_Nonnull)superView {
    UIView *view = [[UIView alloc]init];
    [superView addSubview:view];
    view.frame = CGRectMake(10, 0, kScreenW - kScreenW / 15.625, kScreenW / 8.3);
    view.layer.cornerRadius = 5;
    view.backgroundColor = [UIColor whiteColor];
    
    UITextField *filed = [UITextField creatTextfiledWithPlaceHolder:placholder andSuperView:view];
    [filed mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kScreenW - kScreenW * 2 / 15.625, kScreenW / 8.3));
        make.centerX.mas_equalTo(view.mas_centerX);
        make.centerY.mas_equalTo(view.mas_centerY);
    }];
    return view;
    
}

+ (void)setTopCornerWithView:(UIView *)view {
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:view.bounds byRoundingCorners:UIRectCornerTopLeft | UIRectCornerTopRight cornerRadii:CGSizeMake(5, 5)];
    
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = view.bounds;
    maskLayer.path = maskPath.CGPath;
    view.layer.mask = maskLayer;
}

+ (void)setBottomCornerWithView:(UIView *)view {
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:view.bounds byRoundingCorners:UIRectCornerBottomLeft | UIRectCornerBottomRight cornerRadii:CGSizeMake(5, 5)];
    
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = view.bounds;
    maskLayer.path = maskPath.CGPath;
    view.layer.mask = maskLayer;
}

@end
