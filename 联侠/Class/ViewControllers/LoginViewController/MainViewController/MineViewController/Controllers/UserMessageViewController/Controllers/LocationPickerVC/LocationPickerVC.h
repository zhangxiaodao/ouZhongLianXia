//
//  LocationPickerVC.h
//  YouZhi
//
//  Created by roroge on 15/4/9.
//  Copyright (c) 2015年 com.roroge. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DiZhiModel.h"

@protocol SendDiZhiDataToProvienceVCDelegate <NSObject>

- (void)sendDiZhiDataToProvienceVC:(NSString *)diZhiStr;

@end

@interface LocationPickerVC : UIViewController
@property (nonatomic , assign) id<SendDiZhiDataToProvienceVCDelegate> delegate;
@property (nonatomic  ,strong) DiZhiModel *diZhiModel;
@end
