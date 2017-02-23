//
//  GanYiJiDingShiCollectionViewController.m
//  联侠
//
//  Created by 杭州阿尔法特 on 16/6/30.
//  Copyright © 2016年 张海昌. All rights reserved.
//

#import "GanYiJiDingShiCollectionViewController.h"
#import "GanYiJiDingShiCollectionViewCell.h"
#import "GetPlistData.h"
#import "GanYiJIClothesModel.h"

@interface GanYiJiDingShiCollectionViewController ()<GanYiJiDingShiCollectionViewCellDelegate , HelpFunctionDelegate>{
    UIButton *doneBtn;
    UIButton *cancleBtn;
}

@property (nonatomic , strong) UIView *navView;
@property (nonatomic , strong) NSMutableDictionary *colothesData;
@property (nonatomic , strong) NSMutableDictionary *dataDic;
@property (nonatomic , strong) NSMutableArray *manDataArray;
@property (nonatomic , strong) NSMutableArray *womanDataArray;
@property (nonatomic , strong) NSMutableArray *tempArray;
@property (nonatomic , strong) NSMutableArray *timeArray;


@property (nonatomic , strong) NSMutableDictionary *clothesDic;

@end

@implementation GanYiJiDingShiCollectionViewController

static NSString * const reuseIdentifier = @"Cell";
- (NSMutableDictionary *)clothesDic {
    if (!_clothesDic) {
        _clothesDic = [NSMutableDictionary dictionary
                       ];
    }
    return _clothesDic;
}
- (instancetype)init {
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    layout.itemSize = CGSizeMake((kScreenW - 20) / 2, (kScreenW - 20) / 2 + ((kScreenW - 20) / 2) * 2 / 5);
    CGFloat inset = (kScreenW - 2 * layout.itemSize.width) / 4;

    layout.sectionInset = UIEdgeInsetsMake(inset, inset, inset, inset);
//    layout.minimumLineSpacing = inset;
    
    return [self initWithCollectionViewLayout:layout];
}


- (NSMutableDictionary *)colothesData {
   
    if (!_colothesData) {
        
//        [[GetPlistData sharePlistData] creatPlist];
//        [[GetPlistData sharePlistData] writeDataToPlist];
        
        if (![[GetPlistData sharePlistData] getPlistData]) {
            [[GetPlistData sharePlistData] creatPlist];
            [[GetPlistData sharePlistData] writeDataToPlist];
            
        }
        _colothesData = [[GetPlistData sharePlistData] getPlistData];
    }
    return _colothesData;
}

- (NSMutableArray *)manDataArray {
    if (!_manDataArray) {
        _manDataArray = [NSMutableArray array];
        
        NSMutableArray *tempArray1 = [NSMutableArray array];
        tempArray1 = _colothesData[@"男士"];
        for (NSDictionary *dic in tempArray1) {
            GanYiJIClothesModel *modle = [[GanYiJIClothesModel alloc]init];
            [modle setValuesForKeysWithDictionary:dic];
            [_manDataArray addObject:modle];
        }
        
    }
    return _manDataArray;
}

- (NSMutableArray *)womanDataArray {
    if (!_womanDataArray) {
        _womanDataArray = [NSMutableArray array];
        
        NSMutableArray *tempArray2 = [NSMutableArray array];
        tempArray2 = _colothesData[@"女士"];
        for (NSDictionary *dic in tempArray2) {
            GanYiJIClothesModel *modle = [[GanYiJIClothesModel alloc]init];
            [modle setValuesForKeysWithDictionary:dic];
            [_womanDataArray addObject:modle];
        }
        
    }
    return _womanDataArray;
}

- (void)creatData {
    [self colothesData];
    [self manDataArray];
    [self womanDataArray];
    _dataDic = [NSMutableDictionary dictionary];
    [_dataDic setObject:_manDataArray forKey:@"男士"];
    [_dataDic setObject:_womanDataArray forKey:@"女士"];
    _tempArray = [NSMutableArray array];
    
    NSMutableArray *sssss = [NSMutableArray arrayWithArray:_dataDic[@"男士"]];
    
    if ([self.fromWhich isEqualToString:@"first"]) {
        for (GanYiJIClothesModel *model in sssss) {
            if ([model.type containsString:@"春秋"]) {
                [_tempArray addObject:model];
            }
        }
    } else if ([self.fromWhich isEqualToString:@"second"]) {
        for (GanYiJIClothesModel *model in sssss) {
            if ([model.type containsString:@"夏"]) {
                [_tempArray addObject:model];
            }
        }
    } else if ([self.fromWhich isEqualToString:@"thirt"]) {
        for (GanYiJIClothesModel *model in sssss) {
            if ([model.type containsString:@"冬"]) {
                [_tempArray addObject:model];
            }
        }
    }
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self creatData];
    
    _timeArray = [NSMutableArray array];
    
    self.collectionView.backgroundColor = kFenGeXianYanSe;
    self.collectionView.contentInset = UIEdgeInsetsMake(kScreenH / 14, 0, 0, 0);
    self.collectionView.showsVerticalScrollIndicator = NO;
    self.collectionView.frame = CGRectMake(0, 0, kScreenW, kScreenH - 50);

    UIView *backView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenW, kScreenH / 14 + kScreenH / 16.70588)];
    [self.view addSubview:backView];
    backView.backgroundColor = [UIColor whiteColor];
    self.navView = [UIView creatNavView:self.view WithTarget:self action:@selector(backTap:) andTitle:[NSString stringWithFormat:@"%@" , _titleText]];
    
    [self.collectionView registerClass:[GanYiJiDingShiCollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    
    UILabel *lable = self.navView.subviews[2];
    lable.hidden = YES;
    
    UISegmentedControl *segment = [[UISegmentedControl alloc]initWithItems:@[@"男装" , @"女装"]];
    [self.navView addSubview:segment];
    [segment mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kScreenW * 2 / 3 , 40));
        make.left.mas_equalTo(kScreenW / 6);
        make.centerY.mas_equalTo(self.navView.mas_centerY);
    }];
    segment.selectedSegmentIndex = 0;
    [segment addTarget:self action:@selector(changeSegment:) forControlEvents:UIControlEventValueChanged];
    [segment setTintColor:kKongJingYanSe];
    
    UIView *bottomView = [[UIView alloc]init];
    bottomView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:bottomView];
    [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kScreenW, kScreenW / 9 + 10));
        make.bottom.mas_equalTo(self.view.mas_bottom);
        make.right.mas_equalTo(self.view.mas_right);
    }];
    
    doneBtn = [UIButton initWithTitle:@"确定" andColor:kKongJingYanSe andSuperView:bottomView];
    [doneBtn setBackgroundImage:[UIButton imageWithColor:[UIColor colorWithRed:215/255.0 green:132/255.0 blue:110/255.0 alpha:1.0]] forState:UIControlStateHighlighted];
    
    [doneBtn addTarget:self action:@selector(doneGanYiJiAtcion:) forControlEvents:UIControlEventTouchUpInside];
    //注册按钮的约束
    [doneBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake((kScreenW - kScreenW * 3 / 20) / 2, kScreenW / 9));
        make.right.mas_equalTo(self.view.mas_right).offset(-kScreenW / 20);
        make.centerY.mas_equalTo(bottomView.mas_centerY);
    }];
    
    
    cancleBtn = [UIButton initWithTitle:@"取消" andColor:kKongJingHuangSe andSuperView:bottomView];
    [cancleBtn addTarget:self action:@selector(cancleGanYiJiAtcion:) forControlEvents:UIControlEventTouchUpInside];
    [cancleBtn setBackgroundImage:[UIButton imageWithColor:[UIColor colorWithRed:218/255.0 green:235/255.0 blue:254/255.0 alpha:1.0]] forState:UIControlStateHighlighted];
    [cancleBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake((kScreenW - kScreenW * 3 / 20) / 2, kScreenW / 9));
        make.left.mas_equalTo(kScreenW / 20);
        make.centerY.mas_equalTo(bottomView.mas_centerY);
    }];
    
//    doneBtn.tag = 0;
//    cancleBtn.tag = 0;
    
}

- (void)changeSegment:(id)seg {
    
    NSInteger segmentSelectIndex = [seg selectedSegmentIndex];
    NSLog(@"%ld" , segmentSelectIndex);
    
    if (segmentSelectIndex == 0) {
        NSMutableArray *sssss = [NSMutableArray arrayWithArray:_dataDic[@"男士"]];
        [_tempArray removeAllObjects];
        if ([self.fromWhich isEqualToString:@"first"]) {
            for (GanYiJIClothesModel *model in sssss) {
                if ([model.type containsString:@"春秋"]) {
                    [_tempArray addObject:model];
                }
            }
        } else if ([self.fromWhich isEqualToString:@"second"]) {
            for (GanYiJIClothesModel *model in sssss) {
                if ([model.type containsString:@"夏"]) {
                    [_tempArray addObject:model];
                }
            }
        } else if ([self.fromWhich isEqualToString:@"thirt"]) {
            for (GanYiJIClothesModel *model in sssss) {
                if ([model.type containsString:@"冬"]) {
                    [_tempArray addObject:model];
                }
            }
        }

    } else if (segmentSelectIndex == 1) {
        NSMutableArray *sssss = [NSMutableArray arrayWithArray:_dataDic[@"女士"]];
        [_tempArray removeAllObjects];
        if ([self.fromWhich isEqualToString:@"first"]) {
            for (GanYiJIClothesModel *model in sssss) {
                if ([model.type containsString:@"春秋"]) {
                    [_tempArray addObject:model];
                }
            }
        } else if ([self.fromWhich isEqualToString:@"second"]) {
            for (GanYiJIClothesModel *model in sssss) {
                if ([model.type containsString:@"夏"]) {
                    [_tempArray addObject:model];
                }
            }
        } else if ([self.fromWhich isEqualToString:@"thirt"]) {
            for (GanYiJIClothesModel *model in sssss) {
                if ([model.type containsString:@"冬"]) {
                    [_tempArray addObject:model];
                }
            }
        }

    }
    [self.collectionView reloadData];
    
}

#pragma mark - 确定和取消按钮点击事件

- (void)doneGanYiJiAtcion:(UIButton *)btn {
    
    btn.selected = !btn.selected;
    
    NSInteger max = [[_timeArray valueForKeyPath:@"@max.intValue"] integerValue];
    
    NSDate *sendDate = [NSDate date];
    
    NSTimeInterval date2 = (max * 60 + (NSInteger)[sendDate timeIntervalSince1970]);
    NSDate *confirmTimeSp = [NSDate dateWithTimeIntervalSince1970:date2];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"HH:mm"];
    
    NSString *locationDate = [dateFormatter stringFromDate:sendDate];
    
    NSString *confirmTimeStr = [dateFormatter stringFromDate:confirmTimeSp];
    
    
    if (self.serviceModel.devSn) {
        NSDictionary *parames = @{@"devSn" : self.serviceModel.devSn , @"task.fSwitchOn" : @(doneBtn.selected) , @"task.fSwitchOff" : @(cancleBtn.selected) , @"task.onJobTime" : locationDate , @"task.offJobTime" : confirmTimeStr};
        
        NSLog(@"%@" , parames);
        [HelpFunction requestDataWithUrlString:kGanYiJiDeDingShiURL andParames:parames andDelegate:self];
        
    }
    
    NSArray *array = @[self.fromWhich , locationDate , confirmTimeStr , @(max) , self.clothesDic];
    
    if (![locationDate isEqualToString:confirmTimeStr]) {
        if (self.delegate && [self.delegate respondsToSelector:@selector(getGanYiJiDelegate:andDelegate:)]) {
            [self.delegate getGanYiJiDelegate:self andDelegate:array];
        }
        
        [kStanderDefault setObject:array forKey:@"GanYiJiDingShiData"];
    }
    
    
    
    
}

- (void)requestData:(HelpFunction *)request didSuccess:(NSDictionary *)dddd {
    NSLog(@"%@" , dddd);
}

- (void)cancleGanYiJiAtcion:(UIButton *)btn {
    
    btn.selected = !btn.selected;
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - 返回主界面
- (void)backTap:(UITapGestureRecognizer *)tap {
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark <UICollectionViewDataSource>
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _tempArray.count;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
   GanYiJiDingShiCollectionViewCell *cell =  [[GanYiJiDingShiCollectionViewCell alloc]initWithFrame:CGRectZero];
    cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    cell.delegate = self;
    
    cell.clothesDic = self.clothesDic;
    
    GanYiJIClothesModel *model = [[GanYiJIClothesModel alloc]init];
    model = _tempArray[indexPath.row];
    cell.model = model;
    
    return cell;
}

- (void)getClothesTimes:(GanYiJiDingShiCollectionViewCell *)cell didFinishTime:(NSArray *)array {
    self.clothesDic = array[0];
    NSString *time = array[1];
    [_timeArray addObject:time];
    
}

- (void)setServiceModel:(ServicesModel *)serviceModel {
    _serviceModel = serviceModel;
}

@end
