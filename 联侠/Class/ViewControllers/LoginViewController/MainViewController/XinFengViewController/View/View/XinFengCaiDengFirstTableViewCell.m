//
//  XinFengCaiDengFirstTableViewCell.m
//  联侠
//
//  Created by 杭州阿尔法特 on 2017/3/22.
//  Copyright © 2017年 张海昌. All rights reserved.
//

#import "XinFengCaiDengFirstTableViewCell.h"

@interface XinFengCaiDengFirstTableViewCell ()
@property (nonatomic , strong) UILabel *nameLabel;
@property (nonatomic , strong) UISwitch *rightSwitch;
@end

@implementation XinFengCaiDengFirstTableViewCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        [self customUI];
    }
    return self;
}


- (void)customUI {
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getXinFengCaiDengCellAtcion:) name:@"4232" object:nil];
    
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenW, kScreenW / 8)];
    view.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:view];
    UILabel *titleLabel = [UILabel creatLableWithTitle:@"" andSuperView:view andFont:k14 andTextAligment:NSTextAlignmentCenter];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kScreenW / 3, view.height * 2 / 3));
        make.left.mas_equalTo(view.mas_left).offset(kScreenW / 20);
        make.centerY.mas_equalTo(view.mas_centerY);
    }];
    titleLabel.layer.borderWidth = 0;
    self.nameLabel = titleLabel;
    
    UISwitch *rightSwitch = [[UISwitch alloc]init];
    [view addSubview:rightSwitch];
    [rightSwitch mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(titleLabel.mas_centerY);
        make.right.mas_equalTo(view.mas_right).offset(-kScreenW / 20);
    }];
    [rightSwitch addTarget:self action:@selector(rightSwitchAtcion:) forControlEvents:UIControlEventValueChanged];
    self.rightSwitch = rightSwitch;
    
    [UIView creatBottomFenGeView:view andBackGroundColor:kFenGeXianYanSe isOrNotAllLenth:@"YES"];
    
    
}

- (void)rightSwitchAtcion:(UISwitch *)switchValue {
    
    switchValue.on = NO;
    
    
    NSInteger indexaa=  self.tag;
    
    NSString *toHex = [[NSString ToHex:indexaa] substringFromIndex:2];
    
    toHex = toHex.lowercaseString;
    NSLog(@"%@" , toHex);
    if (_serviceModel) {
        [kSocketTCP sendDataToHost:[NSString stringWithFormat:@"HMFFA%@%@w0000%@0000000000000000000000%@%@0000000000000000#" , _serviceModel.devTypeSn , _serviceModel.devSn ,  toHex, [[NSString sendXinFengNowTime] firstObject] , [[NSString sendXinFengNowTime] lastObject]] andType:kZhiLing andIsNewOrOld:kNew];
        }
    
    
    
}


- (void)getXinFengCaiDengCellAtcion:(NSNotification *)post {
    NSString *mingLing = post.userInfo[@"Message"];
    NSString *caiDeng = [mingLing substringWithRange:NSMakeRange(32, 2)];
    NSString *indexCaiDeng = [NSString turnHexToInt:caiDeng];
    NSLog(@"彩灯回传命令%@ , %@ , %ld" , caiDeng , indexCaiDeng , self.tag);
    
    self.rightSwitch.on = NO;
    NSInteger index = indexCaiDeng.intValue;
    
    if (index == self.tag) {
        self.rightSwitch.on = YES;
    }
}
    
- (void)setTitleString:(NSString *)titleString {
    _titleString = titleString;
    
    if (_titleString) {
        self.nameLabel.text = _titleString;
    }
}
    
- (void)setServiceModel:(ServicesModel *)serviceModel {
    _serviceModel = serviceModel;
}
    
- (void)setStateModel:(StateModel *)stateModel {
    _stateModel = stateModel;
    
    if (_stateModel.light == self.tag) {
        self.rightSwitch.on = YES;
    }
}

//- (void)setIndexPath:(NSIndexPath *)indexPath {
//    _indexPath = indexPath;
//}

@end
