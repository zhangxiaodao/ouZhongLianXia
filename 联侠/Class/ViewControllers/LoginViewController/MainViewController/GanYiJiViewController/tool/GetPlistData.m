//
//  GetPlistData.m
//  联侠
//
//  Created by 杭州阿尔法特 on 16/7/13.
//  Copyright © 2016年 张海昌. All rights reserved.
//

#import "GetPlistData.h"

@implementation GetPlistData


+ (GetPlistData *)sharePlistData {
    static GetPlistData *plist = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        plist = [[GetPlistData alloc]init];
    });
    return plist;
}

- (void)creatPlist {
    NSString *paths = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
    NSLog(@"%@" , paths);
    NSString *fileName = [paths stringByAppendingPathComponent:@"ganYiJiClothes.plist"];
    
    //读文件
    NSMutableArray *array = [NSMutableArray arrayWithContentsOfFile:fileName];
    NSLog(@"%@ , %@" , array , fileName);
    if (array == nil) {
        //创建一个plist文件
        NSFileManager *fm = [NSFileManager defaultManager];
        [fm createFileAtPath:fileName contents:nil attributes:nil];
    }
    
}

- (void)writeDataToPlist{
    //读取plist文件
//    NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"GanYiJiClothes" ofType:@"plist"];
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    
    NSMutableArray *nanShiDic = [NSMutableArray array];
    NSMutableArray *nvShiDic = [NSMutableArray array];
    [dic setObject:nanShiDic forKey:@"男士"];
    [dic setObject:nvShiDic forKey:@"女士"];
    
//    NSArray *manTitleArray = @[@"外套" , @"夹克", @"风衣" , @"羽绒服" , @"短袖" , @"短裤" , @"西装" , @"针织衫" , @"卫衣" , @"衬衫" , @"T恤" , @"裤子" , @"套装" , @"内衣" , @"居家服" , @"唐装"];
    NSArray *manDataArray = @[@{@"image" : @"男士外套.jpg" , @"name" : @"外套" , @"time" : @"5" , @"type" : @"春秋冬"} , @{@"image" : @"男士夹克.jpg" , @"name" : @"夹克" , @"time" : @"5" , @"type" : @"春秋"} , @{@"image" : @"男士风衣.jpg" , @"name" : @"风衣" , @"time" : @"7" , @"type" : @"春秋冬"} , @{@"image" : @"男士羽绒服.jpg" , @"name" : @"羽绒服" , @"time" : @"10" , @"type" : @"冬季"} , @{@"image" : @"男士短袖.jpg" , @"name" : @"短袖" , @"time" : @"3" , @"type" : @"夏季"} , @{@"image" : @"男士短裤.jpg" , @"name" : @"短裤" , @"time" : @"3" , @"type" : @"夏季"} , @{@"image" : @"男士西装.jpg" , @"name" : @"西装" , @"time" : @"5" , @"type" : @"春秋冬"} , @{@"image" : @"男士针织衫.jpg" , @"name" : @"针织衫" , @"time" : @"3" , @"type" : @"春秋冬"} , @{@"image" : @"男士卫衣.jpg" , @"name" : @"卫衣" , @"time" : @"5" , @"type" : @"春秋"} , @{@"image" : @"男士衬衫.jpg" , @"name" : @"衬衫" , @"time" : @"3" , @"type" : @"春秋冬夏"} , @{@"image" : @"男士T恤.jpg" , @"name" : @"T恤" , @"time" : @"3" , @"type" : @"夏季"} , @{@"image" : @"男士裤子.jpg" , @"name" : @"裤子" , @"time" : @"3" , @"type" : @"春秋冬夏"} , @{@"image" : @"男士套装.jpg" , @"name" : @"套装" , @"time" : @"5" , @"type" : @"春秋冬"} , @{@"image" : @"男士内衣.jpg" , @"name" : @"内衣" , @"time" : @"3" , @"type" : @"春秋冬夏"} , @{@"image" : @"男士居家服.jpg" , @"name" : @"运动服" , @"time" : @"5" , @"type" : @"春秋冬"}];
    
//    NSArray *womanTitleArray = @[@"外套" , @"风衣" , @"羽绒服" , @"短裤" , @"西装" , @"针织衫" , @"卫衣" , @"衬衫" , @"T恤" , @"裤子" , @"套装" , @"内衣" , @"居家服" , @"半身裙" , @"雪纺衫" , @"孕妇装" , @"连衣裙" , @"旗袍" ];
    NSArray *womanDataArray = @[@{@"image" : @"女士外套.jpg" , @"name" : @"外套" , @"time" : @"5" , @"type" : @"春秋冬"}  , @{@"image" : @"女士风衣.jpg" , @"name" : @"风衣" , @"time" : @"7" , @"type" : @"春秋冬"} , @{@"image" : @"女士羽绒服.jpg" , @"name" : @"羽绒服" , @"time" : @"10" , @"type" : @"冬季"} , @{@"image" : @"女士短裤.jpg" , @"name" : @"短裤" , @"time" : @"3" , @"type" : @"夏季"} , @{@"image" : @"女士西装.jpg" , @"name" : @"西装" , @"time" : @"5" , @"type" : @"春秋冬"} , @{@"image" : @"女士针织衫.jpg" , @"name" : @"针织衫" , @"time" : @"3" , @"type" : @"春秋冬"} , @{@"image" : @"女士卫衣.jpg" , @"name" : @"卫衣" , @"time" : @"5" , @"type" : @"春秋"} , @{@"image" : @"女士衬衫.jpg" , @"name" : @"衬衫" , @"time" : @"3" , @"type" : @"春秋冬夏"} , @{@"image" : @"女士T恤.jpg" , @"name" : @"T恤" , @"time" : @"3" , @"type" : @"夏季"} , @{@"image" : @"女士裤子.jpg" , @"name" : @"裤子" , @"time" : @"3" , @"type" : @"春秋冬夏"} , @{@"image" : @"女士套装.jpg" , @"name" : @"套装" , @"time" : @"5" , @"type" : @"春秋冬"} , @{@"image" : @"女士内衣.jpg" , @"name" : @"内衣" , @"time" : @"3" , @"type" : @"春秋冬夏"} , @{@"image" : @"女士居家服.jpg" , @"name" : @"居家服" , @"time" : @"5" , @"type" : @"春秋冬"} , @{@"image" : @"女士半身裙.jpg" , @"name" : @"半身裙" , @"time" : @"5" , @"type" : @"春秋冬夏"} , @{@"image" : @"女士雪纺衫.jpg" , @"name" : @"雪纺衫" , @"time" : @"5" , @"type" : @"春秋冬夏"} , @{@"image" : @"女士孕妇装.jpg" , @"name" : @"孕妇装" , @"time" : @"5" , @"type" : @"春秋冬夏"} , @{@"image" : @"女士连衣裙.jpg" , @"name" : @"连衣裙" , @"time" : @"5" , @"type" : @"春秋冬夏"}];
    
    
    for (int i = 0; i < manDataArray.count; i++) {        [nanShiDic addObject:manDataArray[i]];
    }
    
    for (int i = 0; i < womanDataArray.count; i++) {
        [nvShiDic addObject:womanDataArray[i]];
    }

    
    NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
    NSString *fileName = [path stringByAppendingPathComponent:@"ganYiJiClothes.plist"];
    [dic writeToFile:fileName atomically:YES];

}

- (NSMutableDictionary *)getPlistData {
    
    NSMutableDictionary *dic = nil;
    
    NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
    NSString *fileName = [path stringByAppendingPathComponent:@"ganYiJiClothes.plist"];
    dic = [NSMutableDictionary dictionaryWithContentsOfFile:fileName];
    
    return dic;
}

@end
