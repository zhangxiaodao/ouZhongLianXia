//
//  XinFengCaiDengHeaderView.h
//  联侠
//
//  Created by 杭州阿尔法特 on 2017/3/22.
//  Copyright © 2017年 张海昌. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XinFengCaiDengHeaderView : UIView
- (XinFengCaiDengHeaderView *)initWithFrame:(CGRect)frame;
    
@property (nonatomic , strong) ServicesModel *serviceModel;
@property (nonatomic , strong) StateModel *stateModel;
@end
