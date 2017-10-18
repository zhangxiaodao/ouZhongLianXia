//
//  LengFengShanMainBaseCell.h
//  联侠
//
//  Created by 杭州阿尔法特 on 2017/10/13.
//  Copyright © 2017年 张海昌. All rights reserved.
//

#import <UIKit/UIKit.h>

//struct CellType {
//    int bingJing;
//    int LvWang;
//    int shuiWei;
//}CellType;

typedef NS_OPTIONS(NSUInteger, CellType) {
    CellTypeBingJing = 0,
    CellTypeLvWang,
    CellTypeShuiWei
};

@interface LengFengShanMainBaseCell : UITableViewCell
@property (nonatomic , copy) NSString *isKongJing;
@property (nonatomic , strong) ServicesModel *serviceModel;
@property (nonatomic , strong) UIViewController *alertVC;
@property (nonatomic , assign) CGFloat nowUserTime;
@property (nonatomic , assign) CGFloat userWaterData;
@property (nonatomic , assign) CGFloat totalTime;
@property (nonatomic , assign) CellType cellType;

@end
