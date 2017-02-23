//
//  Launch1ViewController.m
//  AEFT冷风扇
//
//  Created by 杭州阿尔法特 on 16/4/4.
//  Copyright © 2016年 阿尔法特. All rights reserved.
//

#import "Launch1ViewController.h"
#import "LoginViewController.h"
@interface Launch1ViewController () <UIScrollViewDelegate>
@property (nonatomic , retain) UIScrollView *scrollerView;
@property (nonatomic , retain) UIPageControl *pageControl;
//@property (nonatomic , retain) UIButton *enterButton;
@property (nonatomic , retain) UIAlertController *aappp;
@end

@implementation Launch1ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [self setLayoutUI];
}

/**
 *  隐藏当前页面状态栏
 *
 */
- (BOOL)prefersStatusBarHidden {
    return YES;
}

#pragma mark - 界面布局
- (void) setLayoutUI{
    self.scrollerView = [[UIScrollView alloc] initWithFrame:kScreenFrame];
    self.scrollerView.backgroundColor = kMainColor;
    // 修改弹簧效果是NO
    self.scrollerView.bounces = NO;
    // 控制整页滑动
    self.scrollerView.pagingEnabled = YES;
    // 控制显示哪个指示条
    self.scrollerView.showsVerticalScrollIndicator = NO;
    self.scrollerView.showsHorizontalScrollIndicator = NO;
    // 设置内容视图大小
    self.scrollerView.contentSize = CGSizeMake([UIScreen mainScreen].bounds.size.width * 3, 0);
    // 给scrollerView 添加代理
    self.scrollerView.delegate = self;
    // 添加到View
    [self.view addSubview:self.scrollerView];
    // 添加5个imageView
    for (int i = 0 ; i < 3; i++) {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"启动切换图%d" , i + 1]];
        UIImageView *imageView = [[UIImageView alloc] init];
        [self.scrollerView addSubview:imageView];
        imageView.image = image;
        [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(self.scrollerView.mas_centerX).offset(kScreenW * i + kScreenW / 100);
            make.centerY.mas_equalTo(self.scrollerView.mas_centerY);
            make.size.mas_equalTo(CGSizeMake(kScreenW , image.size.height));
        }];
        
        
        imageView.contentMode = UIViewContentModeScaleAspectFit;
    }
    // 创建pageControl
    self.pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake((([UIScreen mainScreen].bounds.size.width - 100) / 2.0) , [UIScreen mainScreen].bounds.size.height - 50 ,  100 , 30)];
    // 设置pageControl 的页数
    self.pageControl.numberOfPages = 3;
    // 设置默认显示的点
    self.pageControl.currentPage = 0;
    // 关闭交互
    self.pageControl.userInteractionEnabled = NO;
    // 添加到View
    [self.view addSubview:self.pageControl];
    // 添加进入程序按钮
    
    UIButton *enterBtn = [UIButton initWithTitle:@"" andColor:[UIColor clearColor] andSuperView:self.scrollerView];
    [enterBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kScreenW / 2, kScreenH / 13));
        make.centerX.mas_equalTo(kScreenW * 2);
        make.top.mas_equalTo(self.view.mas_top).offset(-20 + kScreenH / 1.195789);
    }];
    enterBtn.layer.cornerRadius = kScreenH / 26;
    

    [enterBtn addTarget:self action:@selector(enterButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    
}
#pragma mark - enterButton 点击事件
- (void) enterButtonAction:(UIButton *) sender{

    [kStanderDefault setObject:@"YES" forKey:@"isRun"];

    [kStanderDefault setObject:@"NO" forKey:@"isLaunch"];
    AppDelegate *appdele = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    LoginViewController *loginVC = [[LoginViewController alloc]init];
    UINavigationController *loginNav = [[UINavigationController alloc]initWithRootViewController:loginVC];
    appdele.window.rootViewController = loginNav;
}
#pragma mark - scrollerView 的代理方法
- (void) scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    self.pageControl.currentPage = self.scrollerView.contentOffset.x / [UIScreen mainScreen].bounds.size.width;
}

@end
