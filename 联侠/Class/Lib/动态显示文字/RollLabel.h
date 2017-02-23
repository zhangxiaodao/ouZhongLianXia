//
//  RollLabel.h
//  ro
//
//  Created by xuliying on 15/12/25.
//  Copyright © 2015年 xly. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RollLabel : UIScrollView

-(instancetype)initWithFrame:(CGRect)frame text:(NSString *)text font:(UIFont *)font textColor:(UIColor *)color;
-(void)startRoll;
-(void)pauseRoll;
@property(nonatomic,assign) float rollSpeed;
@property(nonatomic,assign) NSTimeInterval timeInterval;
@end
