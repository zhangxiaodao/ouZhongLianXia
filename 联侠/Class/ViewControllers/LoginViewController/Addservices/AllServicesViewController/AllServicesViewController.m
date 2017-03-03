//
//  AllServicesViewController.m
//  联侠
//
//  Created by 杭州阿尔法特 on 2016/11/8.
//  Copyright © 2016年 张海昌. All rights reserved.
//

#import "AllServicesViewController.h"
#import "SetServicesViewController.h"
#import "ServicesModel.h"
#import "AllServicesCollectionViewCell.h"
#import "MainViewController.h"
#import "ChanPinShuoMingViewController.h"

#import "ErWeiMaSaoMiaoViewController.h"

@interface AllServicesViewController ()<UICollectionViewDataSource , UICollectionViewDelegate , UICollectionViewDelegateFlowLayout,  HelpFunctionDelegate>
//@property (nonatomic , strong) UITableView *tableVIew;
@property (nonatomic , strong) UIView *navView;
@property (nonatomic , strong) NSMutableArray *array;
@property (strong, nonatomic) UICollectionView *collectionView;
@end

@implementation AllServicesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self setUI];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [HelpFunction requestDataWithUrlString:kGengDuoChanPin andParames:nil andDelegate:self];
}
#pragma mark - 返回主界面
- (void)backTap:(UITapGestureRecognizer *)tap {
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - 设置UI
- (void)setUI {

    //1.初始化layout
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.headerReferenceSize = CGSizeMake(self.view.frame.size.width, 0);
    
    //2.初始化collectionView
    self.collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:layout];
    [self.view addSubview:self.collectionView];
    self.collectionView.backgroundColor = [UIColor clearColor];
    
    self.navView = [UIView creatNavView:self.view WithTarget:self action:@selector(backTap:) andTitle:@"所有设备"];
    
    if ([_fromFailVC isEqualToString:@"YES"] || [_isFromBottomVC isEqualToString:@"YES"]) {
        UIView *backView = [[UIView alloc]init];
        backView = [_navView.subviews objectAtIndex:0];
        backView.userInteractionEnabled = NO;
        UIImageView *iiii = [backView.subviews objectAtIndex:1];
        iiii.image = [UIImage new];
    }
    
    if ([_isFromBottomVC isEqualToString:@"YES"]) {
        UILabel *lable = self.navView.subviews[2];
        lable.text = @"添加设备";
    }
    
    
    UIButton *offBtn = [UIButton initWithTitle:@"" andColor:[UIColor whiteColor] andSuperView:self.navView];
    offBtn.titleLabel.font = [UIFont systemFontOfSize:k15];
    [offBtn setImage:[UIImage imageNamed:@"erWeima"] forState:UIControlStateNormal];
    
    [offBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [offBtn addTarget:self action:@selector(erWeiMaAtcion:) forControlEvents:UIControlEventTouchUpInside];
    
    [offBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kNavHidth * 1 / 2, kNavHidth * 1 / 2));
        make.centerY.mas_equalTo(self.navView.mas_centerY);
        make.right.mas_equalTo(self.navView.mas_right).offset(- kScreenW / 30);
    }];
    
    
    self.collectionView.backgroundColor = [UIColor clearColor];
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kScreenW, kScreenH - self.navView.y - self.navView.height));
        make.top.mas_equalTo(self.navView.mas_bottom);
        make.left.mas_equalTo(0);
    }];
    //注意，此处的ReuseIdentifier 必须和 cellForItemAtIndexPath 方法中 一致 均为 cellId
    [self.collectionView registerClass:[AllServicesCollectionViewCell class] forCellWithReuseIdentifier:@"cellId"];
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    
}

- (void)erWeiMaAtcion:(UIButton *)btn {
    
    ErWeiMaSaoMiaoViewController * erWeiMaVC = [[ErWeiMaSaoMiaoViewController alloc]init];
    [self.navigationController pushViewController:erWeiMaVC animated:YES];
    
}


#pragma mark - 代理返回的数据
- (void)requestData:(HelpFunction *)request didFinishLoadingDtaArray:(NSMutableArray *)data {
    NSDictionary *dic = data[0];
//    NSLog(@"%@" , dic);
    
    
    self.array = [NSMutableArray array];
    if ([dic[@"data"] isKindOfClass:[NSArray class]]) {
        NSArray *arr = [NSArray arrayWithArray:dic[@"data"]];
        
        for (NSDictionary *dd in arr) {
            ServicesModel *model = [[ServicesModel alloc]init];
            [model setValuesForKeysWithDictionary:dd];
            
            
            if (![dd[@"slType"] isKindOfClass:[NSNull class]]) {
                model.slTypeInt = [dd[@"slType"] integerValue];
            }
            
            NSString *type = [model.typeSn substringToIndex:2];
            NSString *subType = [self.devType substringToIndex:2];
            
            if ([subType isEqualToString:type]) {
                [self.array addObject:model];
            }
        }
        
        [self.collectionView reloadData];
    }
    
}


#pragma mark - collectionView有多少分区
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

#pragma mark - 每个分区rows的个数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.array.count;
}

#pragma mark - 生成items
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    AllServicesCollectionViewCell *cell = (AllServicesCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"cellId" forIndexPath:indexPath];
    
    ServicesModel *model = [[ServicesModel alloc]init];
    model = self.array[indexPath.row];
    cell.serviceModel = model;
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    ServicesModel *model = [[ServicesModel alloc]init];
    model = self.array[indexPath.row];
    if ([self.fromAboutVC isEqualToString:@"YES"]) {
        ChanPinShuoMingViewController *chanPinShuoMingVC = [[ChanPinShuoMingViewController alloc]init];
        chanPinShuoMingVC.serviceModel = model;
        [self.navigationController pushViewController:chanPinShuoMingVC animated:YES];
    } else {
        
        
//        SetServicesViewController *serVC = [[SetServicesViewController alloc]init];
//        serVC.addServiceModel = [[AddServiceModel alloc]init];
//        serVC.addServiceModel.typeSn = model.typeSn;
//        serVC.addServiceModel.protocol = model.protocol;
//        serVC.addServiceModel.typeName = model.typeName;
//        serVC.addServiceModel.bindUrl = model.bindUrl;
//        serVC.addServiceModel.slType = model.slTypeInt;
        
//        if ([serVC.addServiceModel.typeSn hasPrefix:@"41"] || [serVC.addServiceModel.typeSn hasPrefix:@"42"] || [serVC.addServiceModel.typeSn hasPrefix:@"43"]) {
//            
//            [self.navigationController pushViewController:serVC animated:YES];
//        } else {
//            
//            [UIAlertController creatRightAlertControllerWithHandle:nil andSuperViewController:kWindowRoot Title:@"您当前的版本无法添加此设备，请更新版本"];
//        }
        
    }
}


- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake((kScreenW - kScreenW * 2 / 15) / 3, ((kScreenW - kScreenW * 2 / 15) / 3) * 1.25);
}

//定义每个UICollectionView 的 margin
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(kScreenW / 30, kScreenW / 30, kScreenW / 30, kScreenW / 30);
}


@end
