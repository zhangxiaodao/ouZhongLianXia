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

@interface MalertView ()<HelpFunctionDelegate>
@property (nonatomic , strong) NSArray *array;
@property (nonatomic , strong) NSMutableArray *btnArray;
@property (nonatomic , strong) NSArray *clolorArray;
@property (nonatomic , strong) ServicesModel *serviceModel;
@property (nonatomic , strong) StateModel *stateModel;
@end

@implementation MalertView

- (NSMutableArray *)btnArray {
    if (!_btnArray) {
        _btnArray = [NSMutableArray array];
    }
    return _btnArray;
}

- (instancetype)initWithImageArrOfButton:(NSArray *)imgArr  andDataArray:(NSArray *)dataArray {
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
        
        UILabel *titleLabel = [UILabel creatLableWithTitle:@"智能彩灯" andSuperView:_contentViewLeft andFont:k20 andTextAligment:NSTextAlignmentCenter];
        titleLabel.layer.borderWidth = 0;
        [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(kStandardW, kScreenW / 10));
            make.centerX.mas_equalTo(_contentViewLeft.mas_centerX);
            make.top.mas_equalTo(_contentViewLeft.mas_top).offset(kScreenW / 5);
        }];
        
        self.array = imgArr;
        _clolorArray = @[kCOLOR(251, 13, 27) , kCOLOR(11, 36, 250) ,  kCOLOR(219, 175, 40) , kCOLOR(251, 157, 176) , kCOLOR(196, 126, 251) ,   kCOLOR(157, 123, 250) , kCOLOR(125, 99, 250) ,kCOLOR(212, 212, 212) , kFenGeXianYanSe ];
        for (int i = 0; i < imgArr.count; i++) {
            
            UIButton *btn = [UIButton creatBtnWithTitle:imgArr[i] withLabelFont:k14 withLabelTextColor:[UIColor blackColor] andSuperView:_contentViewLeft andBackGroundColor:[UIColor clearColor] andHighlightedBackGroundColor:[UIColor clearColor] andwhtherNeendCornerRadius:YES WithTarget:self andDoneAtcion:@selector(colorBtnAtcion:)];
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
        
        if ([kStanderDefault objectForKey:@"offBtn"]) {
            
            NSLog(@"%@" , [kStanderDefault objectForKey:@"offBtn"]);
            
            NSNumber *bottomSelected = [kStanderDefault objectForKey:@"offBtn"];
            if (bottomSelected.integerValue == 0) {
                for (int i = 0; i < _contentViewLeft.subviews.count; i++) {
                    UIView *view = _contentViewLeft.subviews[i];
                    view.userInteractionEnabled = NO;
                }
            } else if (bottomSelected.integerValue == 1) {
                for (int i = 0; i < _contentViewLeft.subviews.count; i++) {
                    UIView *view = _contentViewLeft.subviews[i];
                    view.userInteractionEnabled = YES;
                }
                
            }
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
        
        self.serviceModel = [[ServicesModel alloc]init];
        self.serviceModel = [dataArray firstObject];
        
        [self requestServiceState];
        
//        NSLog(@"%@" , dataArray);
//        [self setLightColors];
        
        
        
    }
    return self;
}

- (void)requestServiceState {
    NSDictionary *parames = @{@"devSn" : self.serviceModel.devSn , @"devTypeSn" : self.serviceModel.devTypeSn};
    [HelpFunction requestDataWithUrlString:kChaXunKongJingDangQianZhuangTai andParames:parames andDelegate:self];
}

- (void)requestData:(HelpFunction *)request didSuccess:(NSDictionary *)dddd {
    
        NSLog(@"%@" , dddd);
    if ([dddd[@"data"] isKindOfClass:[NSDictionary class]]) {
        NSDictionary *dataDic = dddd[@"data"];
        
        self.stateModel = [[StateModel alloc]init];
        
        for (NSString *key in [dataDic allKeys]) {
            [self.stateModel setValue:dataDic[key] forKey:key];
        }
        
        [self setLightColors];
    }
}

- (void)setLightColors {
    for (UIButton *btn in self.btnArray) {
        btn.backgroundColor = [UIColor clearColor];
    }
    
    NSInteger index = self.stateModel.light;
    
    if (index > 0) {
        
        if (index == 1) {
            UIButton *btn = self.btnArray[7];
            btn.backgroundColor = self.clolorArray[7];
        } else if (index == 2) {
            UIButton *btn = self.btnArray[8];
            btn.backgroundColor = self.clolorArray[8];
        } else if (index == 8) {
            UIButton *btn = self.btnArray[0];
            btn.backgroundColor = self.clolorArray[0];
        } else if (index == 9) {
            UIButton *btn = self.btnArray[1];
            btn.backgroundColor = self.clolorArray[1];
        } else {
            UIButton *btn = self.btnArray[index - 1];
            btn.backgroundColor = self.clolorArray[index - 1];
        }
        
    }
}

- (void)getXinFengCaiDengAtcion:(NSNotification *)post {
    NSString *mingLing = post.userInfo[@"Message"];
    NSString *caiDeng = [mingLing substringWithRange:NSMakeRange(32, 2)];
//    NSLog(@"彩灯回传命令%@ , %ld , %@" , caiDeng , caiDeng.integerValue , mingLing);
    
    for (UIButton *btn in self.btnArray) {
        btn.backgroundColor = [UIColor clearColor];
    }
    
    NSInteger index = caiDeng.intValue;
    
    if (index > 0) {
        NSInteger index = caiDeng.intValue;
        
        
        if (index == 1) {
            UIButton *btn = self.btnArray[7];
            btn.backgroundColor = self.clolorArray[7];
        } else if (index == 2) {
            UIButton *btn = self.btnArray[8];
            btn.backgroundColor = self.clolorArray[8];
        } else if (index == 8) {
            UIButton *btn = self.btnArray[0];
            btn.backgroundColor = self.clolorArray[0];
        } else if (index == 9) {
            UIButton *btn = self.btnArray[1];
            btn.backgroundColor = self.clolorArray[1];
        } else {
            UIButton *btn = self.btnArray[index - 1];
            btn.backgroundColor = self.clolorArray[index - 1];
        }
        
    }
    
    
}

- (void)colorBtnAtcion:(UIButton *)btn {
    if (_delegate && [_delegate respondsToSelector:@selector(malertItemSelect:)]) {
        [_delegate malertItemSelect:btn.tag];
    }
    
//    for (UIButton *colorbtn in self.btnArray) {
//        colorbtn.backgroundColor = [UIColor clearColor];
//    }
//    
//    btn.backgroundColor = self.clolorArray[btn.tag - 100];
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
                
                [UIView animateWithDuration:(0.25 + i * 0.05) animations:^{
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
                    [UIView animateWithDuration:(0.65 - i * 0.05) animations:^{
                        itemView.transform = CGAffineTransformIdentity;
                    }];
                });
            });
        } else {
            [UIView animateWithDuration:0.65 animations:^{
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
