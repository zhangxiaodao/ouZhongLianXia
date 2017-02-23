//
//  DiZhiModel.h
//  AEFT冷风扇
//
//  Created by 杭州阿尔法特 on 16/4/11.
//  Copyright © 2016年 阿尔法特. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DiZhiModel : NSObject

@property (nonatomic , strong) NSString *receiverName;
@property (nonatomic , strong) NSString *addrProvince;
@property (nonatomic , strong) NSString *addrCity;
@property (nonatomic , strong) NSString *addrCounty;
@property (nonatomic , strong) NSString *addrDetail;

@property (nonatomic , strong) NSString *receiverPhone;
@property (nonatomic , strong) NSString *receiverTelCode;
@property (nonatomic , strong) NSString *receiverTelExt;
@property (nonatomic , strong) NSString *receiverTelNum;
//@property (nonatomic , assign) NSInteger state;
@property (nonatomic , assign) NSInteger idd;
@property (nonatomic , strong) NSString *postcode;
@end
