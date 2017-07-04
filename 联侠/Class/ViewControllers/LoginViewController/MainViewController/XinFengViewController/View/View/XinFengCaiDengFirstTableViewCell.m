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
//@property (nonatomic , strong) UISwitch *rightSwitch;
@property (nonatomic , strong) UIButton *rightBtn;
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

//    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    UIButton *rightBtn = [UIButton initWithTitle:@"" andColor:[UIColor clearColor] andSuperView:view];
    [rightBtn setImage:[UIImage imageNamed:@"dingshiguanbi"] forState:UIControlStateNormal];
    [rightBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(view.mas_right).offset(-kScreenW / 20);
        make.centerY.mas_equalTo(titleLabel.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(kScreenW / 10, kScreenW / 10));
    }];
    [rightBtn addTarget:self action:@selector(rightBtnAtcion:) forControlEvents:UIControlEventTouchUpInside];
    self.rightBtn = rightBtn;
    
    [UIView creatBottomFenGeView:view andBackGroundColor:kFenGeXianYanSe isOrNotAllLenth:@"YES"];
    
    
}

- (void)rightBtnAtcion:(UIButton *)btn {
    
//    btn.selected = 1;
    
    NSInteger indexaa = self.tag;
    
    NSString *toHex = [[NSString ToHex:indexaa] substringFromIndex:2];
    
    toHex = toHex.lowercaseString;
    NSLog(@"点击的彩灯%@" , toHex);
    if (_serviceModel) {
        [kSocketTCP sendDataToHost:[NSString stringWithFormat:@"HMFFA%@%@w0000%@0000000000000000000000%@%@0000000000000000#" , _serviceModel.devTypeSn , _serviceModel.devSn ,  toHex, [[NSString sendXinFengNowTime] firstObject] , [[NSString sendXinFengNowTime] lastObject]] andType:kZhiLing andIsNewOrOld:kNew];
    }
}

- (void)getXinFengCaiDengCellAtcion:(NSNotification *)post {
    NSString *mingLing = post.userInfo[@"Message"];
    NSString *caiDeng = [mingLing substringWithRange:NSMakeRange(32, 2)];
    NSString *indexCaiDeng = [NSString turnHexToInt:caiDeng];
    NSLog(@"彩灯回传命令%@ , %@ , %ld" , caiDeng , indexCaiDeng , self.tag);

    NSInteger index = indexCaiDeng.intValue;
    
    if (index == 0) {
        return ;
    }
    
    [self.rightBtn setImage:[UIImage imageNamed:@"dingshiguanbi"] forState:UIControlStateNormal];
    if (index == self.tag) {
//        if (self.rightBtn.selected == 1) {
//            [self.rightBtn setImage:[UIImage imageNamed:@"dingshikaiqi"] forState:UIControlStateNormal];
//        }
        
        [self.rightBtn setImage:[UIImage imageNamed:@"dingshikaiqi"] forState:UIControlStateNormal];
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
        [self.rightBtn setImage:[UIImage imageNamed:@"dingshikaiqi"] forState:UIControlStateNormal];
    }
}

//- (void)setIndexPath:(NSIndexPath *)indexPath {
//    _indexPath = indexPath;
//}

@end
