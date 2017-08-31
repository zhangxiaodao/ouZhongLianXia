//
//  CustomPickerView.h
//  联侠
//
//  Created by 杭州阿尔法特 on 2017/2/28.
//  Copyright © 2017年 张海昌. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol CustomPickerViewDelegate <NSObject>
@optional
- (void)sendPickerViewToVC:(UIPickerView *_Nullable)picker;
- (void)sendDatePickerViewToVC:(UIDatePicker *_Nullable)datePicker;

@end

@interface CustomPickerView : UIView
@property (nonatomic , assign) id <CustomPickerViewDelegate> delegate;


#pragma mark - type表示PickerView的类型，1 倒计时事件类型，2  是性别选择类型，3 是生日选择类型，4 是地址信息类型
- (instancetype _Nullable )initWithPickerViewType:(NSInteger)type andBackColor:(UIColor * _Nullable)backColor;

@end
