//
//  CCLocationManager.h
//  MMLocationManager
//
//  Created by WangZeKeJi on 14-12-10.
//  Copyright (c) 2014年 Chen Yaoqiang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>

#define  CCLastLongitude @"CCLastLongitude"
#define  CCLastLatitude  @"CCLastLatitude"
#define  CCLastCity      @"CCLastCity"
#define  CCLastAddress   @"CCLastAddress"

typedef void(^LocationBlock)(NSArray *address);

//@protocol CCLocationManagerZHCDelegate <NSObject>
//
//- (void)getCityNameAndProvience:(NSArray *)address;
//
//@end




@interface CCLocationManager : NSObject<CLLocationManagerDelegate>

//@property (nonatomic , assign) id<CCLocationManagerZHCDelegate> delegate;


+ (CCLocationManager *)shareLocation;

- (CCLocationManager *)getNowCityNameAndProvienceName:(LocationBlock)block;

@property (nonatomic , copy) LocationBlock block;

@end
