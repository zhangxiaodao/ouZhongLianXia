//
//  MineViewController.m
//  AEFT冷风扇
//
//  Created by 杭州阿尔法特 on 16/3/12.
//  Copyright © 2016年 阿尔法特. All rights reserved.
//

#import "MineViewController.h"
#import "MineFirstView.h"
#import "MessageTableViewCell.h"
#import "UserFeedBackViewController.h"
#import "UserMessageViewController.h"

#import "SumMessageViewController.h"
#import "SystemMessageModel.h"

#import "AboutOusTableViewController.h"
#import "UMSocial.h"

#import "MineYouHuiQuanViewController.h"
#import "ChanPinShuoMingViewController.h"
#import "MineSerivesViewController.h"
#import "AddSViewController.h"
#import "AllServicesViewController.h"
#import "AboutProductViewController.h"
#import "MainViewController.h"
#import "SetServicesViewController.h"

@interface MineViewController ()<UITableViewDataSource , UITableViewDelegate ,  HelpFunctionDelegate>

@property (nonatomic , copy) NSString *systemMessageIsShowPrompt;
@property (nonatomic , strong) UIView *firstView;
@property (nonatomic , strong) UITableView *tableVIew;
@property (nonatomic , strong) UIView *navView;
@property (nonatomic , strong) UILabel *nameLable;

@end

@implementation MineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];

    
    self.navView = [UIView creatNavView:self.view WithTarget:self action:@selector(backTap:) andTitle:@"个人中心"];
    
    if (![_fromMainVC isEqualToString:@"YES"]) {
        
        UIView *iii = [self.navView.subviews objectAtIndex:0];
        UIImageView *jjj = [iii.subviews objectAtIndex:1];
        jjj.image = [UIImage new];

        
        NSDictionary *parames = @{@"loginName" : [kStanderDefault objectForKey:@"phone"] , @"password" : [kStanderDefault objectForKey:@"password"] , @"ua.clientId" : [kStanderDefault objectForKey:@"GeTuiClientId"], @"ua.phoneType" : @(2)};
        [HelpFunction requestDataWithUrlString:kLogin andParames:parames andDelegate:self];
        
    }
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getHeadImage:) name:@"headImage" object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getNiCheng:) name:@"niCheng" object:nil];
    
    NSDictionary *parames = @{@"page" : @(1) , @"rows" : @10};
    [HelpFunction requestDataWithUrlString:kSystemMessageJieKou andParames:parames andDelegate:self];
    
    [self setUI];
    
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = NO;
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    MineViewController *mineServiceVC = [[MineViewController alloc]init];
    mineServiceVC.tabBarController.tabBar.hidden = YES;
}

- (void)requestData:(HelpFunction *)request didSuccess:(NSDictionary *)dddd {
    NSLog(@"%@" , dddd);
    
    if ([dddd[@"total"] isKindOfClass:[NSNull class]]) {
        return ;
    }
    
    NSInteger total = [dddd[@"total"] integerValue];
    if (total > 0) {
        
        NSArray *data = dddd[@"rows"];
        
        if (data.count > 0) {
            NSMutableArray *dataArray = [NSMutableArray array];
            [data enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                SystemMessageModel *model = [[SystemMessageModel alloc]init];
                [model setValuesForKeysWithDictionary:obj];
                [dataArray addObject:model];
            }];
            
            SystemMessageModel *model = [[SystemMessageModel alloc]init];
            model = [dataArray firstObject];
            
            
            if (![[kStanderDefault objectForKey:@"SystemMessageTime"] isKindOfClass:[NSNull class]]) {
                NSString *messageTime = [kStanderDefault objectForKey:@"SystemMessageTime"];
                if ([messageTime compare:model.addTime]) {
                    self.systemMessageIsShowPrompt = @"YES";
                } else {
                    self.systemMessageIsShowPrompt = @"NO";
                }
            } else {
                self.systemMessageIsShowPrompt = @"YES";
            }
            
            
        }
    }
    
    NSIndexPath *indexPath=[NSIndexPath indexPathForRow:1 inSection:0];
    [self.tableVIew reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath,nil] withRowAnimation:UITableViewRowAnimationNone];
}


#pragma mark - 获取代理的数据
- (void)requestData:(HelpFunction *)request didFinishLoadingDtaArray:(NSMutableArray *)data {
    NSDictionary *dic = data[0];
    
    if ([dic[@"state"] integerValue] == 0) {
        
        NSDictionary *user = dic[@"data"];
        
        [kStanderDefault setObject:user[@"sn"] forKey:@"userSn"];
        [kStanderDefault setObject:user[@"id"] forKey:@"userId"];
        
        self.userModel = [[UserModel alloc]init];
        for (NSString *key in [user allKeys]) {
            [self.userModel setValue:user[key] forKey:key];
        }
        
        if (![self.userModel.headImageUrl isKindOfClass:[NSNull class]]) {
            [self.headImageView sd_setImageWithURL:[NSURL URLWithString:self.userModel.headImageUrl] placeholderImage:[UIImage new]];
            if (self.headImageView.image.size.width == 0) {
                self.headImageView.image = [UIImage imageNamed:@"iconfont-touxiang"];
            }
            self.headImage = self.headImageView.image;
        } else {
            self.headImageView.image = [UIImage imageNamed:@"iconfont-touxiang"];
            self.headImage = self.headImageView.image;
        }
        
        
        if (![self.userModel.nickname isKindOfClass:[NSNull class]]) {
            self.nameLable.text = self.userModel.nickname;
        } else {
            self.nameLable.text = @"昵称";
        }
        
        
    }
}



#pragma mark - 获取头像
- (void)getHeadImage:(NSNotification *)post {
    self.headImageView.image = post.userInfo[@"headImage"];
}

- (void)getNiCheng:(NSNotification *)post {
    self.nameLable.text = post.userInfo[@"niCheng"];
}

#pragma mark - 返回上一节面
- (void)backTap:(UITapGestureRecognizer *)tap {

    [self.navigationController popViewControllerAnimated:YES];

}

#pragma mark - 设置UI界面
- (void)setUI{

    
    if ([self.userModel.nickname isKindOfClass:[NSNull class]]) {
        self.userModel.nickname = @"昵称";
    }
    
    self.firstView =  [MineFirstView creatViewWithHead:self.headImage andUserName:self.userModel.nickname andSuperView:self.view];
    self.headImageView = [self.firstView viewWithTag:2];
    self.nameLable = [self.firstView.subviews objectAtIndex:2];
    
    if (self.userModel.nickname.length > 0) {
        self.nameLable.text = self.userModel.nickname;
    } else {
        self.nameLable.text = @"昵称";
    }
    
    UITapGestureRecognizer *iDTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(mineAtcion:)];
    [self.firstView addGestureRecognizer:iDTap];
    
    UIButton *fenXiangBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    [self.view addSubview:fenXiangBtn];
    
    [fenXiangBtn setBackgroundImage:[UIImage imageNamed:@"fengxiang"] forState:UIControlStateNormal];
    [fenXiangBtn addTarget:self action:@selector(fenXiangAtcion:) forControlEvents:UIControlEventTouchUpInside];
    [fenXiangBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kScreenW / 15, kScreenW / 15));
        make.centerY.mas_equalTo(self.firstView.mas_centerY);
        make.right.mas_equalTo(- 20);
    }];
    

    self.tableVIew = [[UITableView alloc]init];
    [self.view addSubview:self.tableVIew];
    [self.tableVIew mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kScreenW, 7 * kScreenH / 14.2 + 2));
        make.left.mas_equalTo(0);
        make.top.mas_equalTo(self.firstView.mas_bottom);
    }];
    self.tableVIew.scrollEnabled = NO;
    self.tableVIew.delegate = self;
    self.tableVIew.dataSource = self;
    self.tableVIew.separatorStyle = UITableViewCellSeparatorStyleNone;
}

- (void)fenXiangAtcion:(UIButton *)btn {
    //注意：分享到微信好友、微信朋友圈、微信收藏、QQ空间、QQ好友、来往好友、来往朋友圈、易信好友、易信朋友圈、Facebook、Twitter、Instagram等平台需要参考各自的集成方法
    [UMSocialSnsService presentSnsIconSheetView:self
                                         appKey:kUMAppKey
                                      shareText:@"http://www.ouzhongiot.com"
                                     shareImage:[UIImage imageNamed:@"logo"]
                                shareToSnsNames:[NSArray arrayWithObjects:UMShareToSina,UMShareToTencent,UMShareToWechatSession,UMShareToWechatTimeline,nil]
                                       delegate:nil];
}

#pragma mark - 头像点击事件
- (void)mineAtcion:(UITapGestureRecognizer *)tap {
    UserMessageViewController *userVC = [[UserMessageViewController alloc]init];

    userVC.userModel = self.userModel;
    userVC.headImage = self.headImageView.image;
    
    [self.navigationController pushViewController:userVC animated:YES];
    self.tabBarController.tabBar.hidden = YES;
}

#pragma mark - TableView的点击事件
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *cellId = @"id";
    MessageTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (cell == nil) {
        cell = [[MessageTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId
                ];
    }
    
    if (indexPath.row == 0) {
        cell.imageViw.image = [UIImage imageNamed:@"tianjiashebei"];
        cell.lable.text = @"添加设备";
    } else if (indexPath.row == 1) {
        cell.imageViw.image = [UIImage imageNamed:@"xiaoxitongzhi"];
        cell.lable.text = @"消息通知";
        
        cell.isShowPromptImageView = self.systemMessageIsShowPrompt;
    } else if (indexPath.row == 2) {
        
        cell.imageViw.image = [UIImage imageNamed:@"youhuiquan"];
        cell.lable.text = @"优惠券";
    } else if (indexPath.row == 3) {
        cell.imageViw.image = [UIImage imageNamed:@"guanyuchanpin"];
        cell.lable.text = @"关于产品";
    } else if (indexPath.row == 4) {
        cell.imageViw.image = [UIImage imageNamed:@"aboutous"];
        cell.lable.text = @"关于我们";
    } else if (indexPath.row == 5) {
        cell.imageViw.image = [UIImage imageNamed:@"clear"];
        cell.lable.text = @"清除缓存";
        cell.clearLabel.text = [NSString stringWithFormat:@"当前缓存 : %@" , [self getBufferSize]];
    }
    
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //取消选中
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    
    self.tabBarController.tabBar.hidden = YES;
    if (indexPath.row == 0) {
        SetServicesViewController *serServiceVC = [[SetServicesViewController alloc]init];
        [self.navigationController pushViewController:serServiceVC animated:YES];
    } else if (indexPath.row == 1) {
        
        SumMessageViewController *sumMessageVC = [[SumMessageViewController alloc]init];
        sumMessageVC.systemMessageIsShowPrompt = self.systemMessageIsShowPrompt;
        [self.navigationController pushViewController:sumMessageVC animated:YES];
        
        self.systemMessageIsShowPrompt = @"NO";
        NSIndexPath *indexPath=[NSIndexPath indexPathForRow:1 inSection:0];
        [tableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath,nil] withRowAnimation:UITableViewRowAnimationNone];
        
    } else if (indexPath.row == 2) {
        MineYouHuiQuanViewController *youHuiQuanVC = [[MineYouHuiQuanViewController alloc]init];
        youHuiQuanVC.fromMineVC = @"YES";
        [self.navigationController pushViewController:youHuiQuanVC animated:YES];
    } else if (indexPath.row == 3) {
        AboutProductViewController *aboutVC = [[AboutProductViewController alloc]init];
        aboutVC.model = [[UserModel alloc]init];
        aboutVC.model = self.userModel;
        [self.navigationController pushViewController:aboutVC animated:YES];
    } else if (indexPath.row == 4) {
        AboutOusTableViewController *connectVC = [[AboutOusTableViewController alloc]init];
        [self.navigationController pushViewController:connectVC animated:YES];
    } else if (indexPath.row == 5) {
        self.tabBarController.tabBar.hidden = NO;
        MessageTableViewCell *cell = [_tableVIew cellForRowAtIndexPath:indexPath];
        
        [UIAlertController creatRightAlertControllerWithHandle:^{
            [[SDImageCache sharedImageCache] clearDiskOnCompletion:^{
                cell.clearLabel.text = [NSString stringWithFormat:@"当前缓存 : %@" , [self getBufferSize]];
            }];
        } andSuperViewController:kWindowRoot Title:@"清除缓存"];
    }
  
}


//清除缓存按钮的点击事件
- (NSString *)getBufferSize{
    CGFloat size = [SDImageCache sharedImageCache].getSize;
    
    NSString *message = nil;

    if (size >= pow(10, 9)) {
        message = [NSString stringWithFormat:@"%.2fGB", size / pow(10, 9)];
    }else if (size >= pow(10, 6)) {
        message = [NSString stringWithFormat:@"%.2fMB", size / pow(10, 6)];
    }else if (size >= pow(10, 3)) {
        message = [NSString stringWithFormat:@"%.2fKB", size / pow(10, 3)];
    }else {
        message = [NSString stringWithFormat:@"%zdB", size];
    }
    
    return message;
    
}

//弹出列表方法presentSnsIconSheetView需要设置delegate为self
-(BOOL)isDirectShareInIconActionSheet
{
    return YES;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return kScreenH / 14.2;
}

#pragma mark - rows的个数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 6;
}

@end
