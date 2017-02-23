//
//  AuthcodeView.h
//  AEFT冷风扇
//
//  Created by 杭州阿尔法特 on 16/3/17.
//  Copyright © 2016年 阿尔法特. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AuthcodeView : UIView

@property (nonatomic , retain) NSArray *dataArray;//字符素材数组
@property (nonatomic , retain) NSMutableString *authCodeStr;//验证码字符串

@end
