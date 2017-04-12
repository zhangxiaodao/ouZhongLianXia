//
//  CustomPickerView.h
//  联侠
//
//  Created by 杭州阿尔法特 on 2017/2/28.
//  Copyright © 2017年 张海昌. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CustomPickerView;
@protocol SendPickerViewSelectDataToParentView <NSObject>

- (void)sendPickerViewSelectedData:(NSArray *)dataArray;

@end

@interface CustomPickerView : UIView
@property (nonatomic , assign) id<SendPickerViewSelectDataToParentView> delegate;

- (CustomPickerView * __nullable)createPickerViewWithBackGroundColor:(UIColor * __nullable)backColor withFrame:(CGRect)frame andDelegate:(id<UIPickerViewDelegate>)delegate andDataSource:(id<UIPickerViewDataSource>)dataSource andEnsureDelegate:(nullable id)target andEnsureAtcion:(SEL)atcion andCancleTarget:(nullable id)cancleTarget andCancleAtcion:(SEL _Nullable )cancleAtcion andTapAtcion:(nullable SEL)tapAction;

@end
