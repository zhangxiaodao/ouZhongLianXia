//
//  ExchangeCollectionViewController.m
//  AEFT冷风扇
//
//  Created by 杭州阿尔法特 on 16/4/6.
//  Copyright © 2016年 阿尔法特. All rights reserved.
//

#import "ExchangeCollectionViewController.h"
#import "ExchangeImageCollectionReusableView.h"
#import "ExchangeImageCollectionViewCell.h"
@interface ExchangeCollectionViewController ()<UICollectionViewDelegate , UICollectionViewDataSource , UICollectionViewDelegateFlowLayout >
@property (strong, nonatomic) IBOutlet UICollectionView *collecionViw;
@property (nonatomic,strong) NSMutableArray *zhuYeArray;
@property (nonatomic , strong) NSMutableArray *kongZhiTaiArray;
@property (nonatomic , strong) NSIndexPath *indexpAth;
@property (nonatomic  ,strong) UIView *backView;

@end

@implementation ExchangeCollectionViewController

static CGRect oldframe;
static NSString * const reuseIdentifier = @"Cell";

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    self.view.backgroundColor = [UIColor whiteColor];

    [self setUI];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBar.hidden = NO;
}

#pragma mark - 设置UI
- (void)setUI{
    self.collecionViw.backgroundColor = [UIColor clearColor];
    
}

#pragma mark - collectionView的头部  和  尾部 view
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    UICollectionReusableView *reusableView = nil;
    if (kind == UICollectionElementKindSectionHeader) {
        ExchangeImageCollectionReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header" forIndexPath:indexPath];
        reusableView = headerView;
        
        
    }
    
    if (kind == UICollectionElementKindSectionFooter) {
        UICollectionReusableView *footView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"footer" forIndexPath:indexPath];
        reusableView = footView;
    }
    return reusableView;
}

#pragma mark - collectionView有多少分区
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

#pragma mark - 每个分区rows的个数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    if ([self.fromMainVC isEqualToString:@"1"]) {
        return self.zhuYeArray.count;
    } else {
        return self.kongZhiTaiArray.count;
    }
    
}

#pragma mark - 生成items
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *celled = @"xxx";
    ExchangeImageCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:celled forIndexPath:indexPath];
    
    if ([self.fromMainVC isEqualToString:@"1"]) {
        cell.backImage.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@" , self.zhuYeArray[indexPath.row]]];
    } else {
        cell.backImage.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@" , self.kongZhiTaiArray[indexPath.row]]];
    }
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    UIImageView *imageView = [[UIImageView alloc]init];
    if ([self.fromMainVC isEqualToString:@"1"]) {
        imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@" , self.zhuYeArray[indexPath.row]]];
        
        [self showImage:imageView andIndexPath:indexPath];
        
    } else {
        imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@" , self.kongZhiTaiArray[indexPath.row]]];
        
        [self showImage:imageView andIndexPath:indexPath];
    }
    
    //   self.ii =  [self showImage:imageView];
    
}

- (UIImageView *)showImage:(UIImageView *)avatarImageView andIndexPath:(NSIndexPath *)indexpAth{
    
    
    self.indexpAth = indexpAth;
    
    UIImage *image=avatarImageView.image;
    UIWindow *window=[UIApplication sharedApplication].keyWindow;
    self.backView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
    oldframe=[avatarImageView convertRect:avatarImageView.bounds toView:window];
    self.backView.backgroundColor=[UIColor blackColor];
    self.backView.alpha=0;
    
    UIImageView *imageView=[[UIImageView alloc]initWithFrame:oldframe];
    imageView.image=avatarImageView.image;
    //    imageView.tag = avatarImageView.tag;
    [self.backView addSubview:imageView];
    [window addSubview:self.backView];
    
    NSLog(@"%ld" , (long)imageView.tag);
    
    
    UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hideImage)];
    [self.backView addGestureRecognizer: tap];
    
    
    
    [UIView animateWithDuration:0.3 animations:^{
        imageView.frame=CGRectMake(0,([UIScreen mainScreen].bounds.size.height-image.size.height*[UIScreen mainScreen].bounds.size.width/image.size.width)/2, [UIScreen mainScreen].bounds.size.width, image.size.height*[UIScreen mainScreen].bounds.size.width/image.size.width);
        self.backView.alpha=1;
    } completion:^(BOOL finished) {
        UIButton *btn = [UIButton initWithTitle:@"设置为背景" andColor:[ UIColor colorWithRed: 34/255.0  green: 191/255.0  blue: 100/255.0  alpha: 1.0] andSuperView:self.backView];
        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(kScreenW / 3, kScreenW / 8));
            make.centerX.mas_equalTo(self.backView.mas_centerX);
            make.bottom.mas_equalTo(self.backView.mas_bottom).offset(-kScreenW / 10);
        }];
        btn.layer.cornerRadius = kScreenW / 16;
        btn.layer.masksToBounds = YES;
        
        [btn addTarget:self action:@selector(btnAtcion:) forControlEvents:UIControlEventTouchUpInside];
        
    }];
    
    return imageView;
    
}


- (void)hideImage{
    
    UIImageView *imageView=(UIImageView*)[self.backView.subviews objectAtIndex:0];
    NSLog(@"%ld" , (long)imageView.tag);
    
    [UIView animateWithDuration:0.3 animations:^{
        imageView.frame=oldframe;
        self.backView.alpha=0;
    } completion:^(BOOL finished) {
        [self.backView removeFromSuperview];
    }];
}

- (void)btnAtcion:(UIButton *)btn {
    if ([self.fromMainVC isEqualToString:@"1"]) {
        [kStanderDefault setObject:@(self.indexpAth.row) forKey:@"zhuYe"];
    } else {
        [kStanderDefault setObject:@(self.indexpAth.row) forKey:@"kongZhiTai"];
    }
    [self hideImage];
}

#pragma mark - collectionView的头部高度
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section{
    return CGSizeMake(kScreenW, kScreenW / 100);
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    return CGSizeMake(kScreenW, kScreenW / 10);
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake((kScreenW - kScreenW / 5) / 3, kScreenW / 5);
}

//定义每个UICollectionView 的 margin
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(kScreenW / 20, kScreenW / 20, kScreenW / 20, kScreenW / 20);
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSMutableArray *)zhuYeArray {
    if (!_zhuYeArray) {
        self.zhuYeArray = [NSMutableArray arrayWithObjects:@"主页背景图1.jpg", @"主页背景图2.jpg" , @"主页背景图5.jpg" , @"主页背景图6.jpg" , @"主页背景图4" , @"主页背景图7.jpg" ,nil];
        
    }
    return _zhuYeArray;
}

- (NSMutableArray *)kongZhiTaiArray{
    if (!_kongZhiTaiArray) {
        self.kongZhiTaiArray = [NSMutableArray arrayWithObjects:@"控制台1.jpg", @"控制台2.jpg" , @"控制台3.jpg", @"工作台背景1.jpg" , @"壁纸1.jpg" , @"壁纸2.jpg" , @"壁纸3.jpg" , @"壁纸4.jpg" , @"壁纸5.jpg" , @"壁纸6.jpg" , nil];
    }
    return _kongZhiTaiArray;
}
@end
