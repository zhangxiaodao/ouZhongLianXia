//
//  XinFengForthTableViewCell.m
//  联侠
//
//  Created by 杭州阿尔法特 on 16/10/11.
//  Copyright © 2016年 张海昌. All rights reserved.
//

#import "XinFengFifthTableViewCell.h"
#import "TimeModel.h"
#define kCircleW view.height * 2 / 3

@interface XinFengFifthTableViewCell ()<HelpFunctionDelegate>

@property (nonatomic , strong) NSMutableArray *timeArray;
@end

@implementation XinFengFifthTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        
        [self customUI];
    }
    return self;
}


//- (void)getXinFengKongJingTimeMessage:(NSNotification *)post {
//    NSString *messsage = post.userInfo[@"Message"];
//    NSString *hourTime = [NSString turnHexToInt:[messsage substringWithRange:NSMakeRange(46, 2)]];
//    NSString *minuteTime = [NSString turnHexToInt:[messsage substringWithRange:NSMakeRange(48, 2)]];
//    NSInteger sumTimr = hourTime.intValue * 60 + minuteTime.intValue;
//    
//    if (sumTimr == 0) {
//        _shuoMingLabel.text = [NSString stringWithFormat:@"暂无定时预约"];
//    } else {
//        _shuoMingLabel.text = [NSString stringWithFormat:@"本次任务将于%ld分钟结束" , sumTimr];
//    }
//}

- (void)customUI {
    
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenW, kScreenH / 7)];
    [self.contentView addSubview:view];
    view.backgroundColor = kACOLOR(28, 157, 247, 1.0);
    
    CAShapeLayer *circleLayer = [self drawCircleWithArcCenter:CGPointMake(kScreenW / 20 + kCircleW / 2, view.centerY) radius:kCircleW andStrokeColor:[UIColor whiteColor] andOpacity:0.3 andLineWidth:1.0];
    [view.layer addSublayer:circleLayer];
    
    UIImageView *timeImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"naoZhong"]];
    [UIImageView setImageViewColor:timeImageView andColor:[UIColor whiteColor]];
    [view addSubview:timeImageView];
    [timeImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kCircleW * 2 / 3, kCircleW * 2 / 3));
        make.centerY.mas_equalTo(view.mas_centerY);
        make.centerX.mas_equalTo(view.mas_left).offset(kScreenW / 20 + kCircleW / 2);
    }];
    
    UILabel *timeLable = [UILabel creatLableWithTitle:@"定时预约" andSuperView:view andFont:k20 andTextAligment:NSTextAlignmentLeft];
    [timeLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kScreenW / 4, kScreenW / 10));
        make.left.mas_equalTo(view.mas_left).offset(kScreenW / 10 + kCircleW);
        make.bottom.mas_equalTo(view.mas_centerY);
    }];
    timeLable.textColor = [UIColor whiteColor];
    timeLable.layer.borderWidth = 0;
    
    _openOrOffLable = [UILabel creatLableWithTitle:@"关闭" andSuperView:view andFont:k12 andTextAligment:NSTextAlignmentCenter];
    [_openOrOffLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kScreenW / 8, kScreenW / 18));
        make.left.mas_equalTo(timeLable.mas_right);
        make.centerY.mas_equalTo(timeLable.mas_centerY);
    }];
    _openOrOffLable.layer.borderWidth = 0;
    _openOrOffLable.textColor = [UIColor whiteColor];
    _openOrOffLable.layer.cornerRadius = kScreenW / 36;
    _openOrOffLable.backgroundColor = kACOLOR(86, 188, 252, 1.0);
    
    _shuoMingLabel = [UILabel creatLableWithTitle:nil andSuperView:view andFont:k17 andTextAligment:NSTextAlignmentLeft];
    [_shuoMingLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kScreenW * 2 / 3 , kScreenW / 10));
        make.top.mas_equalTo(view.mas_centerY);
        make.left.mas_equalTo(timeLable.mas_left);
    }];
    _shuoMingLabel.textColor = [UIColor whiteColor];
    _shuoMingLabel.layer.borderWidth = 0;
    _shuoMingLabel.text = @"暂无定时预约";
    
    UIImageView *jianTouImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"xiaJianTou"]];
    [UIImageView setImageViewColor:jianTouImageView andColor:[UIColor whiteColor]];
    [view addSubview:jianTouImageView];
    [jianTouImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kScreenW / 15, kScreenW / 15));
        make.right.mas_equalTo(view.mas_right).offset(-kScreenW / 20);
        make.centerY.mas_equalTo(view.mas_centerY);
    }];
    
   UIView *bottomView = [[UIView alloc]init];
    bottomView.backgroundColor = kFenGeXianYanSe;
    [view addSubview:bottomView];
    [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(view.mas_bottom);
        make.centerX.mas_equalTo(view.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(kScreenW, 5));
    }];
}



- (CAShapeLayer *)drawCircleWithArcCenter:(CGPoint)center radius:(CGFloat)radius andStrokeColor:(UIColor *)strokeColor andOpacity:(CGFloat)opacity andLineWidth:(CGFloat)lineWidth {
    
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:center radius:radius / 2 startAngle:degreesToRadians(0.f) endAngle:degreesToRadians(360.f) clockwise:YES];
    
    //底色
    //创建一个shapeLayer
    CAShapeLayer *layer = [CAShapeLayer layer];
    //闭环填充颜色
    layer.fillColor = [UIColor clearColor].CGColor;
    //边缘线颜色
    layer.strokeColor = strokeColor.CGColor;
    layer.opacity = opacity;
    //边缘线类型
    layer.lineCap = kCALineCapRound;
    //边缘线款度
    layer.lineWidth = lineWidth;
    //从贝塞尔曲线中获取形状
    layer.path = [path CGPath];
    
    return layer;
}

- (void)setServicModel:(ServicesModel *)servicModel {
    _servicModel = servicModel;
    NSLog(@"%@" , _servicModel);
    
    if (_servicModel.devSn) {
        [HelpFunction requestDataWithUrlString:kGetKongJingTiming andParames:@{@"devSn" : _servicModel.devSn , @"devTypeSn":_servicModel.devTypeSn } andDelegate:self];
    }

}

- (void)requestServicesTimeing:(NSDictionary *)dic {
    
//    NSLog(@"%@" , dic);
    
    NSString *time = nil;
    
    if ([dic[@"data"] isKindOfClass:[NSNull class]]) {
        return ;
    }
    
    NSDictionary *data = dic[@"data"];
    TimeModel *timeModel = [[TimeModel alloc]init];
    
    [timeModel setValuesForKeysWithDictionary:data];
    
    if ([timeModel.runWeek isEqualToString:@"1111111"]) {
        _openOrOffLable.text = @"每天";
    } else {
        _openOrOffLable.text = @"无重复";
    }
    
    if (timeModel.onJobTime == nil && timeModel.offJobTime == nil) {
        time = @"暂无定时预约";
    }
    
    if (timeModel.onJobTime != nil && timeModel.offJobTime != nil) {
        time = [NSString stringWithFormat:@"开启时间%@, 关闭时间%@" , timeModel.onJobTime , timeModel.offJobTime];
    }
    
    if (timeModel.onJobTime != nil && timeModel.offJobTime == nil) {
        time = [NSString stringWithFormat:@"开启时间%@" , timeModel.onJobTime];
    }
    
    if (timeModel.onJobTime == nil && timeModel.offJobTime != nil) {
        time = [NSString stringWithFormat:@"关闭时间%@" , timeModel.offJobTime];
    }
    
    _shuoMingLabel.text = time;
    
}

- (void)requestData:(HelpFunction *)request didFailLoadData:(NSError *)error {
    NSLog(@"%@" , error);
}

@end
