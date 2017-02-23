//
//  RollLabel.m
//  ro
//
//  Created by xuliying on 15/12/25.
//  Copyright © 2015年 xly. All rights reserved.
//

#import "RollLabel.h"

@implementation RollLabel{
    UILabel *_firstLabel;
    UILabel *_secondLabel;
    NSTimer *_timer;
    CGRect rect;
    BOOL _isCanRoll;
}
-(void)dealloc{
    [_timer invalidate];
    _timer = nil;
}
-(instancetype)initWithFrame:(CGRect)frame text:(NSString *)text font:(UIFont *)font textColor:(UIColor *)color{
    self = [super initWithFrame:frame];
    if (self) {
        CGSize size = [self getFontSize:font withSize:CGSizeMake(MAXFLOAT, 10) withStr:text];
        if (size.width > frame.size.width) {
            _isCanRoll = YES;
            _secondLabel = [[UILabel alloc] initWithFrame:CGRectMake(size.width, 0, size.width, frame.size.height)];
            
            if (text.length == 0) {
                text = @" ";
            } 
            
            _secondLabel.text = text;
            _secondLabel.textColor = color;
            _secondLabel.font = font;
            [self addSubview:_secondLabel];
            rect = _secondLabel.frame;
            _timer = [NSTimer scheduledTimerWithTimeInterval:_timeInterval <= 0 ? 0.01 : _timeInterval target:self selector:@selector(timerAction) userInfo:nil repeats:YES];
            [[NSRunLoop currentRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
            
            [_timer setFireDate:[NSDate distantFuture]];
        }else{
            size.width = frame.size.width;
        }
        _firstLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, size.width, frame.size.height)];
        _firstLabel.text = text;
        _firstLabel.textColor = color;
        _firstLabel.font = font;
        [self addSubview:_firstLabel];
    }
    return self;
}


-(void)timerAction{
    CGRect r = _firstLabel.frame;
    CGRect r1 = _secondLabel.frame;
    r.origin.x = r.origin.x - (_rollSpeed <= 0 ? 0.3:_rollSpeed);
    r1.origin.x = r1.origin.x - (_rollSpeed <= 0 ? 0.3:_rollSpeed);
    _firstLabel.frame = r;
    _secondLabel.frame = r1;
    if (-r1.origin.x > _secondLabel.frame.size.width) {
        _secondLabel.frame = rect;
    }
    if (-r.origin.x > _firstLabel.frame.size.width) {
        _firstLabel.frame = rect;
    }
}


-(void)pauseRoll{
    
    if (_isCanRoll && _timer && [_timer isValid]) {
        [_timer setFireDate:[NSDate distantFuture]];
    }
}
-(void)startRoll{
    if (_isCanRoll && _timer && [_timer isValid]) {
        [_timer setFireDate:[NSDate date]];
    }
}
-(CGSize)getFontSize:(UIFont *)font withSize:(CGSize)cgsize withStr:(NSString *)str
{
    if (![str isKindOfClass:[NSNull class]]) {
        CGRect textRect = [str boundingRectWithSize:cgsize
                                            options:NSStringDrawingUsesLineFragmentOrigin
                                         attributes:@{NSFontAttributeName:font}
                                            context:nil];
        CGSize size = textRect.size;
        return size;
    }
    return CGSizeZero;
}
@end
