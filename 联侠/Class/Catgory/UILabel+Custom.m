//
//  UILabel+Custom.m
//  AEFT冷风扇
//
//  Created by 杭州阿尔法特 on 16/3/8.
//  Copyright © 2016年 阿尔法特. All rights reserved.
//

#import "UILabel+Custom.h"

@implementation UILabel (Custom)

+ (UILabel *)initWithTitle:(NSString *)title andSuperView:(UIView *)view andFont:(NSInteger)value andtextAlignment:(NSTextAlignment)modle andMas_Left:(NSInteger)left{
    UILabel *lable = [[UILabel alloc]init];
    lable.textColor = [UIColor grayColor];
    lable.textAlignment = modle;
    lable.numberOfLines = 0;
    
    CGSize size1 = [title boundingRectWithSize:CGSizeMake(lable.frame.size.width, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:lable.font} context:nil].size;
    //根据计算结果重新设置UILabel的尺寸
    [lable setFrame:CGRectMake(0, 10, 200, size1.height)];
    lable.text = title;
    
    [view addSubview:lable];
    lable.font = [UIFont systemFontOfSize:value];
    [lable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(left);
    }];
    return lable;
}

+ (UILabel *)creatLableWithTitle:(NSString *)title andSuperView:(id)superView andFont:(NSInteger)value andTextAligment:(NSTextAlignment)modle{
    UILabel *lable = [[UILabel alloc]init];
    lable.textAlignment = modle;
   
    lable.text = title;
    [superView addSubview:lable];
    lable.font = [UIFont fontWithName:kFontWithName size:value];
    lable.layer.cornerRadius = 5;
    lable.layer.masksToBounds = YES;
    lable.textColor = [UIColor blackColor];
    lable.numberOfLines = 0;
    lable.font = [UIFont fontWithName:kFontWithName size:value];
    [lable sizeToFit];
    
    return lable;
}

- (CGSize)contentSize {
    NSMutableParagraphStyle * paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineBreakMode = self.lineBreakMode;
    paragraphStyle.alignment = self.textAlignment;
    
    NSDictionary * attributes = @{NSFontAttributeName : self.font, NSParagraphStyleAttributeName : paragraphStyle};
    
    CGSize contentSize = [self.text boundingRectWithSize:CGSizeMake(self.frame.size.width, MAXFLOAT) options:(NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading) attributes:attributes context:nil].size;
    return contentSize;
}

@end
