//
//  DiZhiModel.h
//  AEFT冷风扇
//
//  Created by 杭州阿尔法特 on 16/4/11.
//  Copyright © 2016年 阿尔法特. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DiZhiModel : NSObject

@property (nonatomic , copy) NSString *receiverName;
@property (nonatomic , copy) NSString *addrProvince;
@property (nonatomic , copy) NSString *addrCity;
@property (nonatomic , copy) NSString *addrCounty;
@property (nonatomic , copy) NSString *addrDetail;

@property (nonatomic , copy) NSString *receiverPhone;
@property (nonatomic , copy) NSString *receiverTelCode;
@property (nonatomic , copy) NSString *receiverTelExt;
@property (nonatomic , copy) NSString *receiverTelNum;
//@property (nonatomic , assign) NSInteger state;
@property (nonatomic , assign) NSInteger idd;
@property (nonatomic , copy) NSString *postcode;
@end
