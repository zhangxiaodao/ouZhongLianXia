//
//  MalertView.m
//  GsAnimation
//
//  Created by MX007 on 16/7/18.
//  Copyright © 2016年 zhangfaxing. All rights reserved.
//

#import "MalertView.h"

#define kArrayCount _array.count
#define kArrayCountJiaYi (_array.count + 1)
#define kBtnW ((kScreenW - kScreenW / 2.5) / 3)

#define marginX 30 //左右边距
#define marginY 30 //上下间距
#define Row     40 //水平间距

#define itemY   Height/2-50  //最上面item的y坐标
#define distance (kScreenH / 2 + 2 * kBtnW)
#define ksections 3

@interface MalertView ()
@property (nonatomic , strong) NSArray *array;
@property (nonatomic , strong) NSMutableArray *btnArray;
@property (nonatomic , strong) NSArray *clolorArray;
@end

@implementation MalertView

- (NSMutableArray *)btnArray {
    if (!_btnArray) {
        _btnArray = [NSMutableArray array];
    }
    return _btnArray;
}

- (instancetype)initWithImageArrOfButton:(NSArray *)imgArr
{
    self = [super initWithFrame:CGRectMake(0, 0, kScreenW, kScreenH)];
    
    if (self) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getXinFengCaiDengAtcion:) name:@"4232" object:nil];
        
        //模糊效果
        UIBlurEffect *light = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
        _bgView = [[UIVisualEffectView alloc]initWithEffect:light];
        _bgView.frame = self.bounds;
        [self addSubview:_bgView];
        
        //左边的view
        _contentViewLeft = [[UIView alloc] initWithFrame:self.frame];
        [_bgView addSubview:_contentViewLeft];
        
        self.array = imgArr;
        _clolorArray = @[kCOLOR(251, 13, 27) ,kCOLOR(41, 252, 48) , kCOLOR(11, 36, 250) , kCOLOR(254, 254, 56) , kCOLOR(251, 40, 246) , kCOLOR(44, 252, 254) , kCOLOR(212, 212, 212) , kCOLOR(116, 137, 157) , kCOLOR(116, 137, 157)];
        for (int i = 0; i < imgArr.count; i++) {
            
            UIButton *btn = [UIButton creatBtnWithTitle:imgArr[i] withLabelFont:k14 withLabelTextColor:[UIColor blackColor] andSuperView:_contentViewLeft andBackGroundColor:[UIColor clearColor] andHighlightedBackGroundColor:_clolorArray[i] andwhtherNeendCornerRadius:YES WithTarget:self andDoneAtcion:@selector(colorBtnAtcion:)];
            [btn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.size.mas_equalTo(CGSizeMake(kBtnW , kBtnW));
                if (i < 3) {
                    make.left.mas_equalTo(self.mas_left).offset((kScreenW / 10 ) * (i + 1) + i * kBtnW);
                    make.centerY.mas_equalTo(self.mas_centerY).offset(- kBtnW - kScreenW / 10 + distance);
                } else if (i >= 3 && i < 6) {
                    make.left.mas_equalTo(self.mas_left).offset((kScreenW / 10) * (i + 1 - 3) + (i - 3) * kBtnW);
                    make.centerY.mas_equalTo(self.mas_centerY).offset(distance);
                } else {
                    make.left.mas_equalTo(self.mas_left).offset((kScreenW / 10) * (i + 1 - 6) + (i - 6) * kBtnW);
                    make.centerY.mas_equalTo(self.mas_centerY).offset(kBtnW + kScreenW / 10 + distance);
                }
            }];
            btn.layer.cornerRadius = kBtnW / 2;
            btn.layer.borderWidth = 2;
            btn.layer.borderColor = [_clolorArray[i] CGColor];
            btn.tag = 100 + i;
            [self.btnArray addObject:btn];
            
        }
        
        _bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, kScreenH-49, kScreenW, 49)];
        _bottomView.backgroundColor = [UIColor whiteColor];
        [_bgView addSubview:_bottomView];
        
        
        _exitImgvi = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"exit"]];
        _exitImgvi.frame = CGRectMake(kScreenW/2-29/2.0, 10, 29, 29);
        [_bottomView addSubview:_exitImgvi];
        
        
        _bottomBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _bottomBtn.frame = _bottomView.bounds;
        [_bottomBtn addTarget:self action:@selector(alertDismiss) forControlEvents:UIControlEventTouchUpInside];
        [_bottomView addSubview:_bottomBtn];
    }
    return self;
}

- (void)getXinFengCaiDengAtcion:(NSNotification *)post {
    NSString *mingLing = post.userInfo[@"Message"];
    NSString *caiDeng = [mingLing substringWithRange:NSMakeRange(32, 2)];
    NSLog(@"%@ , %ld" , caiDeng , caiDeng.integerValue);
    
    for (UIButton *btn in self.btnArray) {
        btn.backgroundColor = [UIColor clearColor];
    }
    
    NSInteger index = caiDeng.intValue - 1;
    UIButton *btn = self.btnArray[index];
    btn.backgroundColor = self.clolorArray[index];
    
    
}

- (void)colorBtnAtcion:(UIButton *)btn {
    if (_delegate && [_delegate respondsToSelector:@selector(malertItemSelect:)]) {
        [_delegate malertItemSelect:btn.tag];
    }
    
    for (UIButton *colorbtn in self.btnArray) {
        colorbtn.backgroundColor = [UIColor clearColor];
    }
    
    btn.backgroundColor = self.clolorArray[btn.tag - 100];
}

- (void)showAlert
{
    
    dispatch_queue_t queue = dispatch_get_global_queue(0, 0);
    
    dispatch_async(queue, ^{
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            
            [UIView animateWithDuration:0.2 animations:^{
                
                _bgView.alpha = 1;
                _exitImgvi.transform = CGAffineTransformRotate(_exitImgvi.transform, M_PI_4);
                
            } completion:nil];
        });
    });
    
    
    for (int i=0; i<_array.count; i++) {
        
        dispatch_async(queue, ^{
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                UIButton *itemView = [_contentViewLeft viewWithTag:i + 100];
                
                [UIView animateWithDuration:(i + 0.5) / 5 animations:^{
                    itemView.transform = CGAffineTransformTranslate(itemView.transform, 0, -distance);
                    
                }completion:nil];
                
            });
        });
    }
    
}

- (void)alertDismiss
{
    dispatch_queue_t queue1 = dispatch_get_global_queue(0, 0);
    
    dispatch_async(queue1, ^{
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [UIView animateWithDuration:0.2 animations:^{
                _exitImgvi.transform = CGAffineTransformIdentity;
                
            }];
        });
    });
    
    for (int i=(int)(_array.count - 1); i >= 0; i--) {
        UIButton *itemView = nil;
        itemView = [_contentViewLeft viewWithTag:i + 100];
        if (i != 0) {
            dispatch_async(queue1, ^{
                dispatch_async(dispatch_get_main_queue(), ^{
                    [UIView animateWithDuration:(1.3 - (i - 0.5) / 5) animations:^{
                        itemView.transform = CGAffineTransformIdentity;
                    }];
                });
            });
        } else {
            [UIView animateWithDuration:1.3 animations:^{
                itemView.transform = CGAffineTransformIdentity;
            } completion:^(BOOL finished) {
                [UIView animateWithDuration:0.2 animations:^{
                    self.alpha = 0;
                } completion:^(BOOL finished) {
                    self.hidden = YES;
                }];
            }];
        }
    }
}

@end
