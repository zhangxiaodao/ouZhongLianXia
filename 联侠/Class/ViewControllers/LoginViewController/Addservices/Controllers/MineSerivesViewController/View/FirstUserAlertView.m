//
//  FirstUserAlertView.m
//  联侠
//
//  Created by 杭州阿尔法特 on 2017/6/23.
//  Copyright © 2017年 张海昌. All rights reserved.
//

#import "FirstUserAlertView.h"

@interface FirstUserAlertView ()
@property (nonatomic , strong) NSString *deleteObj;
@end

@implementation FirstUserAlertView

- (instancetype)initWithFrame:(CGRect)frame withImage:imageStr deleteFirstObj:(NSString *)deleteObj{
    self = [super initWithFrame:frame];
    
    if (self) {
        self.deleteObj = deleteObj;
        
        UIImageView *imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:imageStr]];
        [self addSubview:imageView];
        imageView.frame = self.bounds;
        
        UIButton *btn = [UIButton initWithTitle:@"" andColor:[UIColor clearColor] andSuperView:self];
        
        if ([deleteObj isEqualToString:@"move"]) {
            [btn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.size.mas_equalTo(CGSizeMake(kScreenW / 1.78571, kScreenH  /11.11666666));
                make.top.mas_equalTo(self.mas_top).offset(kScreenH / 1.2472);
                make.centerX.mas_equalTo(self.mas_centerX);
            }];
        } else {
            [btn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.size.mas_equalTo(CGSizeMake(kScreenW / 2.35, kScreenW / 8.3));
                make.bottom.mas_equalTo(self.mas_bottom).offset(-kScreenW / 8.2);
                make.centerX.mas_equalTo(self.mas_centerX);
            }];
        }
        
        [btn addTarget:self action:@selector(zhiDaoLeAtcion) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}

- (void)creatAlertViewwithImage:(NSString *)imageStr deleteFirstObj:(NSString *)deleteObj{

    NSLog(@"%@" , [kStanderDefault objectForKey:@"first"]);
    
    if (![kStanderDefault objectForKey:@"first"]) {
        return ;
    }
    
    FirstUserAlertView *firstUserView = [[FirstUserAlertView alloc]initWithFrame:kScreenFrame withImage:imageStr deleteFirstObj:deleteObj];

   
    [[self getPresentedViewController].view addSubview:firstUserView];
}

- (void)zhiDaoLeAtcion {
    
    if ([self.deleteObj isEqualToString:@"YES"]) {
        [kStanderDefault removeObjectForKey:@"first"];
    }

    self.hidden = YES;
    [self removeFromSuperview];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    NSSet *allTouches = [event allTouches];
    UITouch *touch = [allTouches anyObject];
    CGPoint point = [touch locationInView:[touch view]];
    int x = point.x;
    int y = point.y;
    NSLog(@"touch (x, y) is (%d, %d)", x, y);
    
    if (x < 40.0 &&  y < 60) {
        [self zhiDaoLeAtcion];
    }
    
}

- (UIViewController *)getPresentedViewController
{
    UIViewController *appRootVC = [UIApplication sharedApplication].keyWindow.rootViewController;
    UIViewController *topVC = appRootVC;
    if (topVC.presentedViewController) {
        topVC = topVC.presentedViewController;
    }
    
    return topVC;
}


//获取当前屏幕显示的viewcontroller
- (UIViewController *)getCurrentVC
{
    UIViewController *result = nil;
    
    UIWindow * window = [[UIApplication sharedApplication] keyWindow];
    if (window.windowLevel != UIWindowLevelNormal)
    {
        NSArray *windows = [[UIApplication sharedApplication] windows];
        for(UIWindow * tmpWin in windows)
        {
            if (tmpWin.windowLevel == UIWindowLevelNormal)
            {
                window = tmpWin;
                break;
            }
        }
    }
    
    UIView *frontView = [[window subviews] objectAtIndex:0];
    id nextResponder = [frontView nextResponder];
    
    if ([nextResponder isKindOfClass:[UIViewController class]])
        result = nextResponder;
    else
        result = window.rootViewController;
    
    return result;
}

@end
