//
//  CustomPickerView.h
//  联侠
//
//  Created by 杭州阿尔法特 on 2017/2/28.
//  Copyright © 2017年 张海昌. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_OPTIONS(NSUInteger, UIPickerViewType) {
    UIPickerViewTypeOfTime = 1,
    UIPickerViewTypeOfSex,
    UIPickerViewTypeOfBirthday,
    UIPickerViewTypeOfAddress,
    UIPickerViewTypeOfCustom
};
@protocol CustomPickerViewDelegate <NSObject>
@optional
- (void)sendPickerViewToVC:(UIPickerView *_Nullable)picker;
- (void)sendDatePickerViewToVC:(UIDatePicker *_Nullable)datePicker;

@end

@interface CustomPickerView : UIView
@property (nonatomic , assign) id <CustomPickerViewDelegate> delegate;


#pragma mark - type表示PickerView的类型，1 倒计时事件类型，2  是性别选择类型，3 是生日选择类型，4 是地址信息类型

/**
 自定义pickerView init方法

 @param type type表示PickerView的类型，1 倒计时事件类型，2  是性别选择类型，3 是生日选择类型，4 是地址信息类型
 @param backColor backColor
 @return pickerView
 */
- (instancetype _Nullable)initWithPickerViewType:(UIPickerViewType)type andBackColor:(UIColor * _Nullable)backColor;

/**
 自定义pickerView init方法
 
 @param type type表示PickerView的类型，1 倒计时事件类型，2  是性别选择类型，3 是生日选择类型，4 是地址信息类型
 @param backColor backColor
 @return pickerView
 */
- (instancetype _Nullable)initWithPickerViewType:(UIPickerViewType)type data:(NSDictionary *_Nullable)dataDic andBackColor:(UIColor * _Nullable)backColor;

@end
