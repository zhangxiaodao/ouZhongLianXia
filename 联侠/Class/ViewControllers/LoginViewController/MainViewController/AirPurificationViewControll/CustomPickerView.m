//
//  CustomPickerView.m
//  联侠
//
//  Created by 杭州阿尔法特 on 2017/2/28.
//  Copyright © 2017年 张海昌. All rights reserved.
//

#import "CustomPickerView.h"

@interface CustomPickerView ()<UIPickerViewDelegate , UIPickerViewDataSource>
@property (nonatomic  ,strong) UIView *pickerBgView;
@property (nonatomic , strong) UIPickerView *myPicker;
@property (strong, nonatomic) UIView *maskView;

@property (nonatomic , strong) NSArray *firstArray;
@property (nonatomic , strong) NSArray *secondArray;
@property (nonatomic , strong) NSArray *thirtArray;
@property (nonatomic , strong) NSArray *forthArray;
@property (nonatomic , strong) NSMutableArray *pickerDataArray;
@end
static CustomPickerView *customPicker = nil;

@implementation CustomPickerView

+ (CustomPickerView *)shareCustomPickerView {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        customPicker = [[CustomPickerView alloc]init];
    });
    return customPicker;
}


//- (void)setPickerDataArray:(NSMutableArray *)pickerDataArray {
//    self.pickerDataArray = pickerDataArray;
//    if (self.pickerDataArray) {
//        if (self.pickerDataArray.count == 0) {
//            return ;
//        } else if (self.pickerDataArray.count == 1) {
//            self.firstArray = self.pickerDataArray[0];
//            
//        } else if (self.pickerDataArray.count == 2) {
//            self.firstArray = self.pickerDataArray[0];
//            self.secondArray = self.pickerDataArray[1];
//            
//        } else if (self.pickerDataArray.count == 3) {
//            self.firstArray = self.pickerDataArray[0];
//            self.secondArray = self.pickerDataArray[1];
//            self.thirtArray = self.pickerDataArray[2];
//            
//        } else if (self.pickerDataArray.count == 4) {
//            self.firstArray = self.pickerDataArray[0];
//            self.secondArray = self.pickerDataArray[1];
//            self.thirtArray = self.pickerDataArray[2];
//            self.forthArray = self.pickerDataArray[3];
//            
//        }
//    }
//    
//}

- (void)setDataArray:(NSArray *)dataArray {
    _dataArray = dataArray;
    
    self.pickerDataArray = [NSMutableArray arrayWithArray:_dataArray];
    
    if (self.pickerDataArray) {
        if (self.pickerDataArray.count == 0) {
            return ;
        } else if (self.pickerDataArray.count == 1) {
            self.firstArray = self.pickerDataArray[0];
            
        } else if (self.pickerDataArray.count == 2) {
            self.firstArray = self.pickerDataArray[0];
            self.secondArray = self.pickerDataArray[1];
            
        } else if (self.pickerDataArray.count == 3) {
            self.firstArray = self.pickerDataArray[0];
            self.secondArray = self.pickerDataArray[1];
            self.thirtArray = self.pickerDataArray[2];
            
        } else if (self.pickerDataArray.count == 4) {
            self.firstArray = self.pickerDataArray[0];
            self.secondArray = self.pickerDataArray[1];
            self.thirtArray = self.pickerDataArray[2];
            self.forthArray = self.pickerDataArray[3];
            
        }
    }
    NSLog(@"%@" , self.dataArray);
}

- (void)initPickerDataWithDataArray:(NSArray *)dataArray {

    NSLog(@"%@" , dataArray);
//    self.pickerDataArray = [NSArray arrayWithArray:dataArray];
    NSLog(@"%@" , self.pickerDataArray);
}

- (instancetype)initWithBackGroundColor:(UIColor *)backColor withFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        NSLog(@"%@" , self.pickerDataArray);
        
//        [self initPickerDataWithDataArray:self.dataArray];
        
        self.maskView = [[UIView alloc] initWithFrame:kScreenFrame];
        self.maskView.backgroundColor = [UIColor clearColor];
        //    self.maskView.alpha = 0;
        self.maskView.userInteractionEnabled = YES;
        //    [self.view addSubview:self.maskView];
        [self.maskView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideMyPicker)]];
        
        
        self.pickerBgView = [[UIView alloc]initWithFrame:CGRectMake(0, kScreenH - kScreenH / 2.61568, kScreenW, kScreenH / 2.61568)];
        
        self.pickerBgView.backgroundColor = [UIColor whiteColor];
        
        self.myPicker = [[UIPickerView alloc]init];
        [self.pickerBgView addSubview:self.myPicker];
        [self.myPicker mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(kScreenW, kScreenH / 3.08796));
            make.left.mas_equalTo(0);
            make.top.mas_equalTo(kScreenH / 17.1025);
        }];
        self.myPicker.tag = 1;
        self.myPicker.delegate = self;
        self.myPicker.dataSource = self;
        
        [UIView animateWithDuration:0.3 animations:^{
            self.pickerBgView.alpha = 1.0;
        }];
        
        
        UIView *view  =[[UIView alloc]init];
        view.backgroundColor = backColor;
        [self.pickerBgView addSubview:view];
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(kScreenW, kScreenH / 17.1025));
            make.left.mas_equalTo(0);
            make.top.mas_equalTo(0);
        }];
        
        UIButton *cancleBtn = [UIButton initWithTitle:@"取消" andColor:[UIColor clearColor] andSuperView:view]
        ;
        [cancleBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [cancleBtn addTarget:self action:@selector(cancel:) forControlEvents:UIControlEventTouchUpInside];
        [cancleBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(0);
            make.size.mas_equalTo(CGSizeMake(kScreenW / 4, kScreenH / 17.1025));
            make.top.mas_equalTo(0);
        }];
        
        UIButton *sureBtn = [UIButton initWithTitle:@"确定" andColor:[UIColor clearColor] andSuperView:view]
        ;
        [sureBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [sureBtn addTarget:self action:@selector(ensure:) forControlEvents:UIControlEventTouchUpInside];
        [sureBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(0);
            make.size.mas_equalTo(CGSizeMake(kScreenW / 4, kScreenH / 17.1025));
            make.top.mas_equalTo(0);
        }];
        
        [self addSubview:self.maskView];
        [self addSubview:self.pickerBgView];
        self.pickerBgView.top = self.height;
        
        [UIView animateWithDuration:0.3 animations:^{
            self.myPicker.alpha = 1.0;
            self.pickerBgView.bottom = self.height;
        }];
        
        self.backGroundColor = [UIColor redColor];
    }
    
    return self;
}

- (void)ensure:(UIButton *)btn {
    if (self.pickerDataArray.count == 0) {
        return ;
    }
    NSArray *pickerDataArray = nil;
    if (self.pickerDataArray.count == 1) {
        pickerDataArray = [NSArray arrayWithObject:self.firstArray[[self.myPicker selectedRowInComponent:0]]];
        
    } else if (self.pickerDataArray.count == 2) {
        pickerDataArray = [NSArray arrayWithObjects:self.firstArray[[self.myPicker selectedRowInComponent:0]] , self.secondArray[[self.myPicker selectedRowInComponent:1]] , nil];
    } else if (self.pickerDataArray.count == 3) {
        pickerDataArray = [NSArray arrayWithObjects:self.firstArray[[self.myPicker selectedRowInComponent:0]] , self.secondArray[[self.myPicker selectedRowInComponent:1]] , self.thirtArray[[self.myPicker selectedRowInComponent:2]] , nil];
    } else if (self.pickerDataArray.count == 4) {
        pickerDataArray = [NSArray arrayWithObjects:self.firstArray[[self.myPicker selectedRowInComponent:0]] , self.secondArray[[self.myPicker selectedRowInComponent:1]] , self.thirtArray[[self.myPicker selectedRowInComponent:2]] , self.forthArray[[self.myPicker selectedRowInComponent:3]] ,nil];
    }
    
    if (pickerDataArray) {
        if (_delegate && [self.pickerDataArray respondsToSelector:@selector(sendPickerViewSelectedData:)]) {
            [_delegate sendPickerViewSelectedData:pickerDataArray];
        }
    }
    
}


- (void)cancel:(UIButton *)btn {
    [self hideMyPicker];
}

#pragma mark - 隐藏UIPickView
- (void)hideMyPicker {
    [UIView animateWithDuration:0.3 animations:^{
        self.maskView.alpha = 0;
        self.pickerBgView.top = kWindowRoot.view.height;
        self.top = kWindowRoot.view.height;
    } completion:^(BOOL finished) {
        [self.maskView removeFromSuperview];
        [self.pickerBgView removeFromSuperview];
        [self removeFromSuperview];
    }];
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    
    return self.pickerDataArray.count;
}


- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    
//    return self.firstArray.count;
    
    if (self.pickerDataArray.count == 0) {
        return 0;
    } else if (self.pickerDataArray.count == 1) {
        return self.firstArray.count;
    } else if (self.pickerDataArray.count == 2) {
        if (component == 0) {
            return self.firstArray.count;
        } else {
            return self.secondArray.count;
        }
    } else if (self.pickerDataArray.count == 3) {
        if (component == 0) {
            return self.firstArray.count;
        } else if (component == 1){
            return self.secondArray.count;
        } else {
            return self.thirtArray.count;
        }
    } else {
        if (component == 0) {
            return self.firstArray.count;
        } else if (component == 1){
            return self.secondArray.count;
        } else if (component == 2){
            return self.thirtArray.count;
        } else {
            return self.forthArray.count;
        }
    }
    
}
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    
//    return [self.firstArray objectAtIndex:row];
    
    if (self.pickerDataArray.count == 0) {
        return nil;
    } else if (self.pickerDataArray.count == 1) {
        return [self.firstArray objectAtIndex:row];
    } else if (self.pickerDataArray.count == 2) {
        if (component == 0) {
            return [self.firstArray objectAtIndex:row];
        } else {
            return [self.secondArray objectAtIndex:row];
        }
    } else if (self.pickerDataArray.count == 3) {
        if (component == 0) {
            return [self.firstArray objectAtIndex:row];
        } else if (component == 1){
            return [self.secondArray objectAtIndex:row];
        } else {
            return [self.thirtArray objectAtIndex:row];
        }
    } else {
        if (component == 0) {
            return [self.firstArray objectAtIndex:row];
        } else if (component == 1){
            return [self.secondArray objectAtIndex:row];
        } else if (component == 2){
            return [self.thirtArray objectAtIndex:row];
        } else {
            return [self.forthArray objectAtIndex:row];
        }
    }
    
}


@end
