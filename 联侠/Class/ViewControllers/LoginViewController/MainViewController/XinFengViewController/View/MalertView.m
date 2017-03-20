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
#define kBtnW ((kScreenW - kMargin * 5) / 4)
#define kMargin (kScreenW / 20)

#define distance (kScreenH / 2 + 2 * kBtnW)

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
        _clolorArray = @[kCOLOR(38, 4, 74) , kCOLOR(137, 7, 75) ,  kCOLOR(90, 24, 100) , kCOLOR(40, 42, 123) , kCOLOR(11, 84, 161) , kCOLOR(24, 152, 183) ,   kCOLOR(130, 141, 153) , kCOLOR(251, 13, 27) ,kCOLOR(41, 253, 47) , kCOLOR(35, 57, 250) , kCOLOR(255, 253, 56) , kCOLOR(66, 255, 254) , kCOLOR(252, 61, 251) , kCOLOR(255, 255, 255) ,kCOLOR(110, 135, 169) , kFenGeXianYanSe];
        for (int i = 0; i < imgArr.count; i++) {
            
            UIButton *btn = [UIButton creatBtnWithTitle:imgArr[i] withLabelFont:k14 withLabelTextColor:[UIColor blackColor] andSuperView:_contentViewLeft andBackGroundColor:[UIColor clearColor] andHighlightedBackGroundColor:[UIColor clearColor] andwhtherNeendCornerRadius:YES WithTarget:self andDoneAtcion:@selector(colorBtnAtcion:)];
            [btn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.size.mas_equalTo(CGSizeMake(kBtnW , kBtnW));
                if (i < 4) {
                    make.left.mas_equalTo(self.mas_left).offset((kMargin) * (i + 1) + i * kBtnW);
                    make.bottom.mas_equalTo(self.mas_centerY).offset(- kBtnW - kMargin * 3 / 2 + distance);
                } else if (i >= 4 && i < 8) {
                    make.left.mas_equalTo(self.mas_left).offset(kMargin * (i + 1 - 4) + (i - 4) * kBtnW);
                    make.bottom.mas_equalTo(self.mas_centerY).offset(- kMargin / 2 + distance);
                } else if (i >= 8 && i < 12) {
                    make.left.mas_equalTo(self.mas_left).offset(kMargin * (i + 1 - 8) + (i - 8) * kBtnW);
                    make.top.mas_equalTo(self.mas_centerY).offset(kMargin / 2 + distance);
                } else {
                    make.left.mas_equalTo(self.mas_left).offset(kMargin * (i + 1 - 12) + (i - 12) * kBtnW);
                    make.top.mas_equalTo(self.mas_centerY).offset(kBtnW + kMargin * 3 / 2 + distance);
                }
            }];
            btn.layer.cornerRadius = kBtnW / 2;
            btn.layer.borderWidth = 2;
            btn.layer.borderColor = [_clolorArray[i] CGColor];
            
            if (i < 14) {
                btn.tag = 102 + i;
            } else if (i == 14) {
                btn.tag = 116;
            } else if (i == 15) {
                btn.tag = 101;
            }
            
//            switch (i) {
//                case 0:
//                    btn.tag = 102;
//                    break;
//                case 1:
//                    btn.tag = 103;
//                    break;
//                case 2:
//                    btn.tag = 103;
//                    break;
//                case 3:
//                    btn.tag = 105;
//                    break;
//                case 4:
//                    btn.tag = 106;
//                    break;
//                case 5:
//                    btn.tag = 107;
//                    break;
//                case 6:
//                    btn.tag = 108;
//                    break;
//                case 7:
//                    btn.tag = 109;
//                    break;
//                case 8:
//                    btn.tag = 110;
//                    break;
//                case 9:
//                    btn.tag = 111;
//                    break;
//                case 10:
//                    btn.tag = 112;
//                    break;
//                case 11:
//                    btn.tag = 113;
//                    break;
//                case 12:
//                    btn.tag = 114;
//                    break;
//                case 13:
//                    btn.tag = 115;
//                    break;
//                case 14:
//                    btn.tag = 101;
//                    break;
//                case 15:
//                    btn.tag = 116;
//                    break;
//                    
//                default:
//                    break;
//            }
            
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
    
//        NSLog(@"%@" , dddd);
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
            UIButton *btn = [self.btnArray lastObject];
            btn.backgroundColor = [self.clolorArray lastObject];
        } else if (index == 16) {
            UIButton *btn = self.btnArray[14];
            btn.backgroundColor = self.clolorArray[14];
        } else {
            UIButton *btn = self.btnArray[index - 2];
            btn.backgroundColor = self.clolorArray[index - 2];
        }
        
    }
}

- (void)getXinFengCaiDengAtcion:(NSNotification *)post {
    NSString *mingLing = post.userInfo[@"Message"];
    NSString *caiDeng = [mingLing substringWithRange:NSMakeRange(32, 2)];
    NSString *indexCaiDeng = [NSString turnHexToInt:caiDeng];
    NSLog(@"彩灯回传命令%@ , %@" , caiDeng , indexCaiDeng);
    
    for (UIButton *btn in self.btnArray) {
        btn.backgroundColor = [UIColor clearColor];
    }
    
    NSInteger index = indexCaiDeng.intValue;
    
    if (index > 0) {
        
        if (index == 1) {
            UIButton *btn = [self.btnArray lastObject];
            btn.backgroundColor = [self.clolorArray lastObject];
        } else if (index == 16) {
            UIButton *btn = self.btnArray[14];
            btn.backgroundColor = self.clolorArray[14];
        } else {
            UIButton *btn = self.btnArray[index - 2];
            btn.backgroundColor = self.clolorArray[index - 2];
        }
        
    }
    
    
}

- (void)colorBtnAtcion:(UIButton *)btn {
    if (_delegate && [_delegate respondsToSelector:@selector(malertItemSelect:)]) {
        [_delegate malertItemSelect:btn.tag];
    }
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
                NSInteger tag = MAXFLOAT;
                if (i < 14) {
                    tag = 102 + i;
                } else if (i == 14) {
                    tag = 116;
                } else if (i == 15) {
                    tag = 101;
                }
                
                UIButton *itemView = [_contentViewLeft viewWithTag:tag];
                
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
        
        NSInteger tag = MAXFLOAT;
        if (i < 14) {
            tag = 102 + i;
        } else if (i == 14) {
            tag = 116;
        } else if (i == 15) {
            tag = 101;
        }
        
        UIButton *itemView = nil;
        itemView = [_contentViewLeft viewWithTag:tag];
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
