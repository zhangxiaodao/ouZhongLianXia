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

@interface AllServicesViewController ()<UICollectionViewDataSource , UICollectionViewDelegate , UICollectionViewDelegateFlowLayout,  HelpFunctionDelegate>
@property (nonatomic , strong) NSMutableArray *array;
@property (nonatomic , strong) NSMutableArray *addModelArray;
@end

@implementation AllServicesViewController

/** 控制器初始化的同时设置布局参数给collectionView */
-(instancetype)init{
    
    /** 创建布局参数 */
    UICollectionViewFlowLayout * flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.itemSize = CGSizeMake(30, 40);
    
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
    
    [HelpFunction requestDataWithUrlString:kGengDuoChanPin andParames:nil andDelegate:self];
}
#pragma mark - 代理返回的数据
- (void)requestData:(HelpFunction *)request didFinishLoadingDtaArray:(NSMutableArray *)data {
    NSDictionary *dic = data[0];
//    NSLog(@"%@" , dic);
    
    self.array = [NSMutableArray array];
    self.addModelArray = [NSMutableArray array];
    if ([dic[@"data"] isKindOfClass:[NSArray class]]) {
        NSArray *arr = [NSArray arrayWithArray:dic[@"data"]];
        
        for (NSDictionary *dd in arr) {
            
            NSString *type = [dd[@"typeSn"] substringToIndex:2];
            NSString *subType = [self.devType substringToIndex:2];
            
            
            if ([subType isEqualToString:type]) {
                
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
        }
        
        [self.collectionView reloadData];
    }
    
}

- (void)requestData:(HelpFunction *)request didFailLoadData:(NSError *)error {
    NSLog(@"%@" , error);
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
        chanPinShuoMingVC.serviceModel = model;
        chanPinShuoMingVC.navigationItem.title = self.navigationItem.title;
        [self.navigationController pushViewController:chanPinShuoMingVC animated:YES];
    }
    
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake((kScreenW - kScreenW * 3 / 25) / 2, kScreenH / 4.6);
}

//定义每个UICollectionView 的 margin
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(kScreenW / 25, kScreenW / 25, 0, kScreenW / 25);
}


@end
