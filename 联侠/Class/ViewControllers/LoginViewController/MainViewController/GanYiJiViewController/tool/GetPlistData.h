//
//  GetPlistData.h
//  联侠
//
//  Created by 杭州阿尔法特 on 16/7/13.
//  Copyright © 2016年 张海昌. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GetPlistData : NSObject

+ (GetPlistData *)sharePlistData;

- (void)writeDataToPlist;

- (NSMutableDictionary *)getPlistData;

- (void)creatPlist;

@end
