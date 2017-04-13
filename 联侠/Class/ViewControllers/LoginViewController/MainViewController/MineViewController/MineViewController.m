//
//  MineViewController.m
//  AEFT冷风扇
//
//  Created by 杭州阿尔法特 on 16/3/12.
//  Copyright © 2016年 阿尔法特. All rights reserved.
//

#import "MineViewController.h"
#import <UShareUI/UShareUI.h>

#import "HeadPortraitView.h"
#import "MineTableViewCell.h"
#import "UserFeedBackViewController.h"
#import "UserMessageViewController.h"

#import "SumMessageViewController.h"
#import "SystemMessageModel.h"

#import "AboutOusTableViewController.h"


#import "MineYouHuiQuanViewController.h"
#import "ChanPinShuoMingViewController.h"
#import "MineSerivesViewController.h"
#import "AllServicesViewController.h"
#import "AboutProductViewController.h"
#import "MainViewController.h"
#import "SetServicesViewController.h"

@interface MineViewController ()<UITableViewDataSource , UITableViewDelegate ,  HelpFunctionDelegate>
@property (nonatomic , copy) NSString *systemMessageIsShowPrompt;
@property (nonatomic , strong) UITableView *tableVIew;
@property (nonatomic , strong) UILabel *nameLable;
@property (nonatomic , strong) UserModel *userModel;
@property (nonatomic , strong) UIImage *headImage;
@property (nonatomic , strong) UIImageView *headImageView;
@property (nonatomic , strong) UIImageView *headBackImageView;

@property (nonatomic , strong) HeadPortraitView *headPortraitView;
@end

@implementation MineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithHexString:@"f2f4fb"];
    NSDictionary *parames = nil;
    if ([kStanderDefault objectForKey:@"GeTuiClientId"]) {
        parames = @{@"loginName" : [kStanderDefault objectForKey:@"phone"] , @"password" : [kStanderDefault objectForKey:@"password"] , @"ua.clientId" : [kStanderDefault objectForKey:@"GeTuiClientId"], @"ua.phoneType" : @(2)};
    } else {
        parames = @{@"loginName" : [kStanderDefault objectForKey:@"phone"] , @"password" : [kStanderDefault objectForKey:@"password"] , @"ua.phoneType" : @(2)};
    }
    
    [HelpFunction requestDataWithUrlString:kLogin andParames:parames andDelegate:self];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getHeadImage:) name:@"headImage" object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getNiCheng:) name:@"niCheng" object:nil];
    
    parames = @{@"page" : @(1) , @"rows" : @10};
    [HelpFunction requestDataWithUrlString:kSystemMessageJieKou andParames:parames andDelegate:self];
    
    [self setNav];
    
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
//    NSLog(@"%@" , dddd);
    
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
//    NSLog(@"%@" , dic);
    if ([dic[@"state"] integerValue] == 0) {
        
        NSDictionary *user = dic[@"data"];
        
        [kStanderDefault setObject:user[@"sn"] forKey:@"userSn"];
        [kStanderDefault setObject:user[@"id"] forKey:@"userId"];
        
        self.userModel = [[UserModel alloc]init];
        for (NSString *key in [user allKeys]) {
            [self.userModel setValue:user[key] forKey:key];
        }
        _headPortraitView.userModel = self.userModel;
        
    }
}

- (void)requestData:(HelpFunction *)request didFailLoadData:(NSError *)error {
    NSLog(@"%@" , error);
}

#pragma mark - 获取头像
- (void)getHeadImage:(NSNotification *)post {
    
    if (post.userInfo[@"headImage"]) {
        self.headBackImageView.image = post.userInfo[@"headImage"];
        self.headImageView.image = post.userInfo[@"headImage"];
    }
    
    
}

- (void)getNiCheng:(NSNotification *)post {

    if ([post.userInfo[@"niCheng"] length] != 0) {
        self.nameLable.text = post.userInfo[@"niCheng"];
    }
}

- (void)setNav {
    self.navigationItem.title = @"个人中心";
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithTarget:self action:@selector(fenXiangAtcion) image:@"share" highImage:nil];
    
}

#pragma mark - 设置UI界面
- (void)setUI{

    _headPortraitView = [[HeadPortraitView alloc]initWithFrame:CGRectMake(0, 0, kScreenW, kScreenH / 3.7) Target:self action:@selector(mineAtcion)];
    [self.view addSubview:_headPortraitView];
    self.headBackImageView = _headPortraitView.subviews[0];
    self.headImageView = _headPortraitView.subviews[1];
    self.nameLable = [_headPortraitView.subviews objectAtIndex:2];
    
    self.tableVIew = [[UITableView alloc]init];
    [self.view addSubview:self.tableVIew];
    self.tableVIew.backgroundColor = [UIColor clearColor];
    [self.tableVIew mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kScreenW, 7 * kScreenH / 14.2 + 2));
        make.left.mas_equalTo(0);
        make.top.mas_equalTo(_headPortraitView.mas_bottom);
    }];
    self.tableVIew.scrollEnabled = NO;
    self.tableVIew.delegate = self;
    self.tableVIew.dataSource = self;
    self.tableVIew.separatorStyle = UITableViewCellSeparatorStyleNone;
}

- (void)shareWebPageToPlatformType:(UMSocialPlatformType)platformType
{

    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
    UMShareWebpageObject *shareObject = [UMShareWebpageObject shareObjectWithTitle:@"欧众联侠-中国物联网的龙头企业" descr:@"杭州欧众物联网科技有限公司" thumImage:[UIImage imageNamed:@"logo"]];
    shareObject.webpageUrl = @"http://www.ouzhongiot.com";
    messageObject.shareObject = shareObject;
    [[UMSocialManager defaultManager] shareToPlatform:platformType messageObject:messageObject currentViewController:self completion:^(id data, NSError *error) {
        if (error) {
            UMSocialLogInfo(@"************Share fail with error %@*********",error);
        }else{
            if ([data isKindOfClass:[UMSocialShareResponse class]]) {
                UMSocialShareResponse *resp = data;                UMSocialLogInfo(@"response message is %@",resp.message);
                UMSocialLogInfo(@"response originalResponse data is %@",resp.originalResponse);
                
            }else{
                UMSocialLogInfo(@"response data is %@",data);
            }
        }
    }];
}

- (void)fenXiangAtcion {
    
    [UMSocialUIManager showShareMenuViewInWindowWithPlatformSelectionBlock:^(UMSocialPlatformType platformType, NSDictionary *userInfo) {
        [self shareWebPageToPlatformType:platformType];
    }];
    
}

#pragma mark - 头像点击事件
- (void)mineAtcion {
    UserMessageViewController *userVC = [[UserMessageViewController alloc]init];

    userVC.userModel = self.userModel;
    userVC.headImage = self.headImageView.image;
    userVC.navigationItem.title = @"用户信息";
    [self.navigationController pushViewController:userVC animated:YES];
    self.tabBarController.tabBar.hidden = YES;
}

#pragma mark - TableView的点击事件
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *cellId = @"id";
    MineTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (cell == nil) {
        cell = [[MineTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId
                ];
    }
    
    cell.indexpath = indexPath;
    cell.backgroundColor = [UIColor colorWithHexString:@"f2f4fb"];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //取消选中
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    
    self.tabBarController.tabBar.hidden = YES;
    if (indexPath.row == 0 && indexPath.section == 0) {
        
        [self mineAtcion];
    } else if (indexPath.row == 1 && indexPath.section == 0) {
        
        SumMessageViewController *sumMessageVC = [[SumMessageViewController alloc]init];
        sumMessageVC.systemMessageIsShowPrompt = self.systemMessageIsShowPrompt;
        sumMessageVC.navigationItem.title = @"消息中心";
        [self.navigationController pushViewController:sumMessageVC animated:YES];
        
        self.systemMessageIsShowPrompt = @"NO";
        NSIndexPath *indexPath=[NSIndexPath indexPathForRow:1 inSection:0];
        [tableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath,nil] withRowAnimation:UITableViewRowAnimationNone];
        
    } else if (indexPath.row == 0 && indexPath.section == 1) {
        AboutProductViewController *aboutVC = [[AboutProductViewController alloc]init];
        aboutVC.model = [[UserModel alloc]init];
        aboutVC.model = self.userModel;
        aboutVC.navigationItem.title = @"关于产品";
        [self.navigationController pushViewController:aboutVC animated:YES];
    } else if (indexPath.row == 1 && indexPath.section == 1) {
        AboutOusTableViewController *aboutOusVC = [[AboutOusTableViewController alloc]init];
        aboutOusVC.navigationItem.title = @"关于我们";
        [self.navigationController pushViewController:aboutOusVC animated:YES];
    } else  {
        self.tabBarController.tabBar.hidden = NO;
        MineTableViewCell *cell = [_tableVIew cellForRowAtIndexPath:indexPath];
        
        [UIAlertController creatCancleAndRightAlertControllerWithHandle:^{
            [[SDImageCache sharedImageCache] clearDiskOnCompletion:^{
                cell.clearLabel.text = [NSString stringWithFormat:@"当前缓存 : %@" , [cell getBufferSize]];
            }];
        } andSuperViewController:kWindowRoot Title:@"清除缓存"];
        
    }
  
}


- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    cell.contentView.backgroundColor = [UIColor clearColor];
}


//弹出列表方法presentSnsIconSheetView需要设置delegate为self
-(BOOL)isDirectShareInIconActionSheet
{
    return YES;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return kScreenH / 14.46;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return kScreenW / 27;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    UIView *view = [[UIView alloc]init];
    view.backgroundColor = [UIColor clearColor];
    return view;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (section == 0) {
        return 2;
    } else if (section == 1) {
        return 2;
    } else {
        return 1;
    }
}


@end
