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
#import "AddServiceModel.h"
#import "MainViewController.h"
#import "ChanPinShuoMingViewController.h"
#import "AllServicesCollectionViewCell.h"

@interface AllServicesViewController ()<UICollectionViewDataSource , UICollectionViewDelegate , UICollectionViewDelegateFlowLayout>
@property (nonatomic , strong) NSMutableArray *array;
@property (nonatomic , strong) NSMutableArray *addModelArray;
@end

@implementation AllServicesViewController

/** 控制器初始化的同时设置布局参数给collectionView */
-(instancetype)init{
    
    /** 创建布局参数 */
    UICollectionViewFlowLayout * flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.itemSize = CGSizeMake((kScreenW - kScreenW * 3 / 25) / 2, kScreenW / 2.6);
    flowLayout.sectionInset = UIEdgeInsetsMake(kScreenW / 25, kScreenW / 25, kScreenW / 25, kScreenW / 25);
    
    self.collectionView = [[UICollectionView alloc] initWithFrame:[UIScreen mainScreen].bounds collectionViewLayout:flowLayout];
    
    /** 注册cell可重用ID */
    [self.collectionView registerClass:[AllServicesCollectionViewCell class] forCellWithReuseIdentifier:@"cellId"];
    self.collectionView.backgroundColor = [UIColor colorWithHexString:@"f2f4fb"];
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    NSDictionary *parames = @{@"typeSn":self.typeSn};
//    [HelpFunction requestDataWithUrlString:kGengDuoChanPin andParames:parames andDelegate:self];
    [kNetWork requestPOSTUrlString:kGengDuoChanPin parameters:parames isSuccess:^(NSDictionary * _Nullable responseObject) {
        NSDictionary *dic = responseObject;
        
        self.array = [NSMutableArray array];
        self.addModelArray = [NSMutableArray array];
        if ([dic[@"data"] isKindOfClass:[NSArray class]]) {
            NSArray *arr = [NSArray arrayWithArray:dic[@"data"]];
            
            for (NSDictionary *dd in arr) {
                
                ServicesModel *model = [[ServicesModel alloc]init];
                [model setValuesForKeysWithDictionary:dd];
                if (![dd[@"slType"] isKindOfClass:[NSNull class]]) {
                    model.slTypeInt = [dd[@"slType"] integerValue];
                }
                AddServiceModel *addModel = [[AddServiceModel alloc]init];
                [addModel setValuesForKeysWithDictionary:dd];
                [self.array addObject:model];
                [self.addModelArray addObject:addModel];
            }
            [self.collectionView reloadData];
        }
    } failure:nil];
    
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
    
    cell.indexPath = indexPath;
    ServicesModel *model = [[ServicesModel alloc]init];
    model = self.array[indexPath.row];
    cell.serviceModel = model;
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    ServicesModel *model = [[ServicesModel alloc]init];
    model = self.array[indexPath.row];
    
    AddServiceModel *addModel = [[AddServiceModel alloc]init];
    addModel = self.addModelArray[indexPath.row];
    if ([self.navigationItem.title isEqualToString:@"添加设备"]) {
        SetServicesViewController *setSerVC = [[SetServicesViewController alloc]init];
        setSerVC.addServiceModel = addModel;
        setSerVC.navigationItem.title = self.navigationItem.title;
        [self.navigationController pushViewController:setSerVC animated:YES];
    } else {
        ChanPinShuoMingViewController *chanPinShuoMingVC = [[ChanPinShuoMingViewController alloc]init];
        chanPinShuoMingVC.addServiceModel = addModel;
        chanPinShuoMingVC.typeSn = self.typeSn;
        
        [self.navigationController pushViewController:chanPinShuoMingVC animated:YES];
    }
    
}

@end
