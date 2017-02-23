//
//  AirPuritionTableViewCell.m
//  联侠
//
//  Created by 杭州阿尔法特 on 16/5/28.
//  Copyright © 2016年 张海昌. All rights reserved.
//

#import "AirPuritionTableViewCell.h"


#define kArrayCount _array.count
#define kArrayCountJiaYi (_array.count + 1)
#define kBtnW (((kScreenW - kScreenW / 8) / 4) - 5)
#define kContentViewHeight kBtnW * 2 + kBtnW * 2 / 3
@interface AirPuritionTableViewCell ()

@property (nonatomic , strong) NSArray *array;
@end


@implementation AirPuritionTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self customUI];
    }
    return self;
}

- (void)customUI {
    self.contentView.backgroundColor = [UIColor colorWithRed: 18/255.0  green: 65/255.0  blue: 119/255.0  alpha: 1.0];
    
//    //贝塞尔曲线,以下是4个角的位置，相对于_testView1
//    CGPoint point1= CGPointMake(0, kContentViewHeight - 1);
//    CGPoint point2= CGPointMake(0, kContentViewHeight );
//    CGPoint point3= CGPointMake(kScreenW, kContentViewHeight);
//    CGPoint point4= CGPointMake(kScreenW, kContentViewHeight - 1);
//    
//   UIBezierPath *_path=[UIBezierPath bezierPath];
//    [_path moveToPoint:point1];//移动到某个点，也就是起始点
//    [_path addLineToPoint:point2];
//    [_path addLineToPoint:point3];
//    [_path addLineToPoint:point4];
//    //controlPoint控制点，不等于曲线顶点
//    [_path addQuadCurveToPoint:point1 controlPoint:CGPointMake(kScreenW / 2, kContentViewHeight - kBtnW / 4)];
//    
//    
//    CAShapeLayer *shapeLayer=[CAShapeLayer layer];
//    shapeLayer.path=_path.CGPath;
//    shapeLayer.fillColor=[UIColor whiteColor].CGColor;//填充颜色
//    shapeLayer.strokeColor=[UIColor whiteColor].CGColor;//边框颜色
//    [self.contentView.layer addSublayer:shapeLayer];
    
    //动画
//    CABasicAnimation *pathAniamtion = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
//    pathAniamtion.duration = 3;
//    pathAniamtion.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
//    pathAniamtion.fromValue = [NSNumber numberWithFloat:0.0f];
//    pathAniamtion.toValue = [NSNumber numberWithFloat:1.0];
//    pathAniamtion.autoreverses = NO;
//    [shapeLayer addAnimation:pathAniamtion forKey:nil];
    
    
    
    NSArray *imageArray = @[@"ziDong" , @"shuiMian" , @"shaJun" , @"fuLiZi"];
    _array = [NSArray arrayWithObjects:@"自动" , @"睡眠", @"UV杀菌",  @"负离子", nil];
    
    for (int i = 0; i < kArrayCount; i++) {
        
        
        UIButton *btn = [UIButton creatBtnWithTitle:_array[i] andImage:[UIImage imageNamed:imageArray[i]] andWidth:kBtnW andHeight:kBtnW andSuperView:self.contentView WithTarget:self andDoneAtcion:@selector(doneAtcion:) andTag:i];
        //        btn.tag = i;
        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(kBtnW , kBtnW));
            make.top.mas_equalTo(self.contentView.mas_top).offset(kBtnW / 4);
            make.centerX.mas_equalTo(self.contentView.mas_left).offset(((kScreenW - kArrayCount * kBtnW) / kArrayCountJiaYi + kBtnW / 2) + i * ((kScreenW - kArrayCount * kBtnW) / kArrayCountJiaYi + kBtnW));
        }];
        
    }
    
    imageArray = @[@"diDang" , @"zhongDang" , @"gaoDang" , @"tongSuo"];
    _array = [NSArray arrayWithObjects:@"低档" , @"中档", @"高档",  @"童锁", nil];
    
    for (int i = 0; i < kArrayCount; i++) {
        
        
        UIButton *btn = [UIButton creatBtnWithTitle:_array[i] andImage:[UIImage imageNamed:imageArray[i]] andWidth:kBtnW andHeight:kBtnW andSuperView:self.contentView WithTarget:self andDoneAtcion:@selector(doneAtcion:) andTag:i + 4];
        //        btn.tag = i + 4;
        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(kBtnW , kBtnW));
            make.top.mas_equalTo(self.contentView.mas_top).offset(kBtnW + kBtnW / 2);
            make.centerX.mas_equalTo(self.contentView.mas_left).offset(((kScreenW - kArrayCount * kBtnW) / kArrayCountJiaYi + kBtnW / 2) + i * ((kScreenW - kArrayCount * kBtnW) / kArrayCountJiaYi + kBtnW));
        }];
        
    }
    
    
    
}

- (void)doneAtcion:(UIButton *)btn {
    NSLog(@"%ld" , btn.tag);
    switch (btn.tag) {
        case 0:
        {
            [self.contentView viewWithTag:btn.tag + 9].tintColor = kLvSe;
            break;
            
        }
        case 1:{
            
            [self.contentView viewWithTag:btn.tag + 9].tintColor = kLvSe;
            break;
        }
            
        case 2: {
            [self.contentView viewWithTag:btn.tag + 9].tintColor = kLvSe;
            break;
        }
            
        case 3:{
            [self.contentView viewWithTag:btn.tag + 9].tintColor = kLvSe;
            break;
        }
            
        case 4:{
            [self.contentView viewWithTag:btn.tag + 9].tintColor = kLvSe;
            break;
        }
            
        case 5:{
            [self.contentView viewWithTag:btn.tag + 9].tintColor = kLvSe;
            break;
        }
            
        case 6:{
            [self.contentView viewWithTag:btn.tag + 9].tintColor = kLvSe;
            break;
        }
            
        case 7:{
            [self.contentView viewWithTag:btn.tag + 9].tintColor = kLvSe;
            break;
        }
            
            
        default:
            break;
    }
    
    [btn removeTarget:nil action:nil forControlEvents:UIControlEventTouchUpInside];
    [btn addTarget:self action:@selector(againDoneAtcion:) forControlEvents:UIControlEventTouchUpInside];
    
}

- (void)againDoneAtcion:(UIButton *)btn {
    NSLog(@"%ld" , btn.tag);
    switch (btn.tag) {
        case 0:
        {
            [self.contentView viewWithTag:btn.tag + 9].tintColor = [UIColor whiteColor];
            break;
            
        }
        case 1:{
            [self.contentView viewWithTag:btn.tag + 9].tintColor = [UIColor whiteColor];
            break;
        }
            
        case 2: {
            [self.contentView viewWithTag:btn.tag + 9].tintColor = [UIColor whiteColor];
            break;
        }
            
        case 3:{
            
            [self.contentView viewWithTag:btn.tag + 9].tintColor = [UIColor whiteColor];
            break;
        }
            
        case 4:{
            [self.contentView viewWithTag:btn.tag + 9].tintColor = [UIColor whiteColor];
            break;
        }
            
        case 5:{
            [self.contentView viewWithTag:btn.tag + 9].tintColor = [UIColor whiteColor];
            break;
        }
            
        case 6:{
            [self.contentView viewWithTag:btn.tag + 9].tintColor = [UIColor whiteColor];
            break;
        }
            
        case 7:{
            [self.contentView viewWithTag:btn.tag + 9].tintColor = [UIColor whiteColor];
            break;
        }
            
            
        default:
            break;
    }
    
    [btn removeTarget:nil action:nil forControlEvents:UIControlEventTouchUpInside];
    [btn addTarget:self action:@selector(doneAtcion:) forControlEvents:UIControlEventTouchUpInside];
    
}
@end
