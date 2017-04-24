//
//  LaunchScreenViewController.m
//  联侠
//
//  Created by 杭州阿尔法特 on 2017/1/11.
//  Copyright © 2017年 张海昌. All rights reserved.
//

#import "LaunchScreenViewController.h"
#import "LoginViewController.h"
#import "XMGNavigationController.h"
@interface LaunchScreenViewController ()<UIScrollViewDelegate>
@property (nonatomic , retain) UIScrollView *scrollerView;
@property (nonatomic , retain) UIPageControl *pageControl;
@end

@implementation LaunchScreenViewController
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
    self.scrollerView.backgroundColor = [UIColor whiteColor];
    self.scrollerView.bounces = NO;
    self.scrollerView.pagingEnabled = YES;
    self.scrollerView.showsVerticalScrollIndicator = NO;
    self.scrollerView.showsHorizontalScrollIndicator = NO;
    self.scrollerView.contentSize = CGSizeMake([UIScreen mainScreen].bounds.size.width * 3, 0);
    self.scrollerView.delegate = self;
    [self.view addSubview:self.scrollerView];
    for (int i = 0 ; i < 3; i++) {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"launchImage%d" , i + 1]];
        UIImageView *imageView = [[UIImageView alloc] init];
        [self.scrollerView addSubview:imageView];
        imageView.image = image;
        [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(self.scrollerView.mas_centerX).offset(kScreenW * i + kScreenW / 100);
            make.centerY.mas_equalTo(self.scrollerView.mas_centerY).offset(-kScreenW / 4);
            make.size.mas_equalTo(CGSizeMake(kScreenW , image.size.height * (kScreenW / kScreenH)));
        }];
        imageView.contentMode = UIViewContentModeScaleAspectFit;
        
        UIImage *titleImage = [UIImage imageNamed:[NSString stringWithFormat:@"launchImage%d_title" , i + 1]];
        UIImageView *titleImageView = [[UIImageView alloc] init];
        [self.scrollerView addSubview:titleImageView];
        titleImageView.image = titleImage;
        [titleImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(self.scrollerView.mas_centerX).offset(kScreenW * i + kScreenW / 100);
            make.top.mas_equalTo(imageView.mas_bottom).offset(-kScreenW / 8);
            make.size.mas_equalTo(CGSizeMake(kScreenW / 2, titleImage.size.height * (kScreenW / kScreenH)));
        }];
        titleImageView.contentMode = UIViewContentModeScaleAspectFit;
        if (kScreenW / kScreenH == 320.0 / 480.0) {
            titleImageView.hidden = YES;
        }
        
    }
    
    self.pageControl = [[UIPageControl alloc]init];
    [self.view addSubview:self.pageControl];
    [self.pageControl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kScreenW, 20));
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.bottom.mas_equalTo(self.view.mas_bottom).offset(-kScreenW / 20);
    }];
    self.pageControl.numberOfPages = 3;
    self.pageControl.currentPage = 0;
    self.pageControl.userInteractionEnabled = NO;
    
    self.pageControl.currentPageIndicatorTintColor = kMainColor;
    self.pageControl.pageIndicatorTintColor = kKongJingHuangSe;
    
    UIButton *enterBtn = [UIButton initWithTitle:@"开启智能生活" andColor:[UIColor clearColor] andSuperView:self.scrollerView];
    [enterBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kScreenW / 2, kScreenH / 13));
        make.centerX.mas_equalTo(kScreenW * 2);
        make.bottom.mas_equalTo(self.view.mas_bottom).offset(-kScreenW / 16);
    }];
    enterBtn.layer.cornerRadius = kScreenH / 26;
    enterBtn.layer.borderColor = kCOLOR(225, 178, 238).CGColor;
    enterBtn.layer.borderWidth = 1;
    [enterBtn setTitleColor:kCOLOR(186, 131, 225) forState:UIControlStateNormal];
    
    [enterBtn addTarget:self action:@selector(enterButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    
}
#pragma mark - enterButton 点击事件
- (void)enterButtonAction:(UIButton *) sender{
    
    [kStanderDefault setObject:@"YES" forKey:@"isRun"];
    
    [kStanderDefault setObject:@"NO" forKey:@"isLaunch"];
    AppDelegate *appdele = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    LoginViewController *loginVC = [[LoginViewController alloc]init];
    XMGNavigationController *nav = [[XMGNavigationController alloc]initWithRootViewController:loginVC];
    
    appdele.window.rootViewController = nav;
}
#pragma mark - scrollerView 的代理方法
- (void) scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    self.pageControl.currentPage = self.scrollerView.contentOffset.x / [UIScreen mainScreen].bounds.size.width;
    
    if (self.pageControl.currentPage == 2) {
        self.pageControl.hidden = YES;
    } else {
        self.pageControl.hidden = NO;
    }
}
@end
