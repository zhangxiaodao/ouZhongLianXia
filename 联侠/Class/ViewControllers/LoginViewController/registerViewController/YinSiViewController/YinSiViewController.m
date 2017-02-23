//
//  YinSiViewController.m
//  AEFT冷风扇
//
//  Created by 杭州阿尔法特 on 16/3/8.
//  Copyright © 2016年 阿尔法特. All rights reserved.
//

#import "YinSiViewController.h"
#import "TableViewCell.h"
@interface YinSiViewController ()<UITableViewDataSource , UITableViewDelegate>
@property (nonatomic , assign) CGSize expectSize;
@property (nonatomic , strong) UILabel *textLabel;
@property (nonatomic , strong) UIView *navView;
@end

@implementation YinSiViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.navView = [UIView creatNavView:self.view WithTarget:self action:@selector(backTap:) andTitle:@"隐私政策"];
    [self setUI];
}

#pragma mark - 返回主界面
- (void)backTap:(UITapGestureRecognizer *)tap {
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - 设置UI
- (void)setUI{
    NSString *str = @"欧众智能家庭系列产品 隐私政策\n您可以通过多种不同的方式使用我们的服务，例如登录欧众官网购买欧众智能硬件产品、在不同的终端上使用欧众智能家庭软件、服务等。如果您与我们分享信息 （例如，通过创建一个欧众帐户），我们就能为您提供更好的服务，如显示相关程度更高的产品更新和广告、帮助您与他人联系或者更轻松快捷地与他人分享内容等。基于此目的，我们将向您解释我们对信息的收集和使用方式，以及您可采用什 么方式来保护自己的隐私权。\n我们的隐私政策包括了以下几个方面的问题：\n我们收集哪些信息。\n我们如何收集和使用信息。\n您如何选择性提供这些信息，以及如何访问和更新这些信息。\n信息的分享、安全以及隐私政策的适用范围和修订\n\n我们收集的信息\n我们收集您的两种信息：个人信息（个人信息是可用于唯一地识别或联系某人的数据）和非个人信息（即不会与任何特定个人直接相关联的数据）。如果我们将非个人信息与个人信息合并在一起，在保持合并的期间内，此类信息将被视为个人信息。\n我们如何收集和利用的信息\n\n个人信息的收集和使用\n您与欧众物联网科技有限公司（以下简称“欧众”或“我们”）及其关联公司进行互动时，您可能会被要求提供您同意使用我们基本产品服务所必需的某些个人信息。该个人信息可能与其他信息合并在一起，被用于改进我们的产品或服务等。\n下文是欧众可能收集的个人信息的类型以及我们如何使用该信息的一些示例。\n\n个人信息的收集\n当您创建欧众账户、下载及更新欧众软件、在欧众手机在线零售店注册、参加在线调查或者参加其他与欧众公司的互动时，我们会要求您提供个人信息，包括但不限于您的姓名、电话号码、电子邮件地址、邮寄地址等。\n当您购买欧众产品和服务时，我们会收集有关个人信息，包括但不限于：交货详情、银行帐号、信用卡详情、账单地址、信用核查以及其他财务信息、联系及交流的记录等。\n当您使用欧众产品与家人和朋友分享您的内容、发送信息和产品或者在欧众论坛上邀请其他人时，欧众会收集您提供的与上述人士有关的个人信息，如姓名、邮寄地址、电子邮件地址及电话号码等。\n当您首次使用并激活欧众移动设备时，您的移动用户识别信息、移动设备唯一识别码以及您设备的大概地理位置信息将被发送给欧众。上述信息的收集也可能适用于您更新系统或软件、恢复出厂设置等情况。\n个人信息的使用\n欧众将严格遵守本隐私政策及其更新所载明的内容来使用您的个人信息。您的个人信息将仅用于收集时即已确定并且经过您同意的目的，如有除此之外的任何其他用途，我们都会提前征得您的同意。\n我们收集的个人信息将被用于向您提供欧众的产品和服务、处理您的订单或履行您与欧众之间的合同，以确保我们产品和服务的功能和安全、验证您的身份、防止并追究欺诈或其他不当使用的情形。\n我们收集的个人信息将被用于我们的产品和服务开发，尽管一般情况下，我们为此目的仅使用综合信息和统计性信息。\n我们收集的个人信息将被用于与您进行交流，例如，在欧众产品或服务更新、发布的第一时间向您发出通知。\n我们所收集的个人信息将被用于进行产品的个性化设计，并向您提供更为贴身的服务，例如：在我们的服务中进行推荐、展示专为您打造的内容和广告或者用于调研。\n如果您参与欧众举办的抽奖、竞赛或类似推广活动，我们会将您提供的个人信息用于管理此类活动。\n您的移动用户识别信息、移动设备唯一识别码和地理位置信息可被用来激活您的保修服务和特定的软件许可，并可能邀请您参加调查。我们也会使用此等信息用于改善我们的产品和分析我们业务运营的效率。但我们不会用此等信息来追踪您的位置情况。\n非个人信息的收集和使用\n同时，为了运营和改善欧众的技术和服务，欧众将会自行收集使用您的非个人信息，这将有助于欧众向您提供更好的用户体验和提高欧众的服务质量。\n非个人信息的收集\n当您创建欧众账户、下载欧众软件及其更新、参加在线调查或者参加其他与欧众公司的互动时，我们会收集您诸如职业、语言、邮编、 区号以及使用欧众产品所在的时区等信息。\n使用习惯和发现问题相关的信息——当您在使用欧众智能家庭的应用时，我们会根据需要，匿名统计一部分您对网络使用的情况从而为您提供更好的上网体验。此外， 当欧众智能家庭系统发生非正常状态或崩溃时，我们将可能会收集一些便于诊断问题的环境信息如设备ID、互联网协议地址、路由数据包等。\nCookies和其他技术收集的信息——欧众的网站、在线服务、互动应用软件、电子邮件消息和广告宣传可能会使用cookies以及如像素标签和网站信标的其他技术来收集和存储您的非个人信息。\n日志信息——当您访问欧众智能家庭时，我们的服务器会自动记录某些日志信息。这类服务器日志信息可能包含如下信息：IP 地址、浏览器类型、浏览器语言、 refer来源页、操作系统、日期/时间标记和点击流数据。\n非个人信息的使用\n我们收集的诸如职业、语言、邮编、区号以及使用欧众产品所在的时区等非个人信息，可以帮助我们更好地了解用户行为，改进我们的产品、服务和广告宣传。\n我们可以通过分析欧众“用户体验改进计划”获取的统计数据来持续不断地提升产品和服务的操作体验、运行性能、修复问题、改善功能设计等。\n我们通过使用 cookies 和其他技术（例如像素标签）收集到的信息，为您带来更好的用户体验，并提高我们的总体服务品质。例如，通过保存您的语言偏好设置， 我们可以用您的首选语言显示我们的服务。我们可以通过使用像素标签向用户发送可阅读格式的电子邮件，并告知我们邮件是否被打开。我们可将此等信息用于减少向用户发送电子邮件或者不向用户发送电子邮件。\n用户如何选择性提供信息\n每个人对于隐私权的关注各有侧重，基于此，我们将明确指出我们收集信息的方式，以便您选择接受信息的提供方式。\n您可以自由设定是否加入“用户体验改进计划”，即可以通过关闭“用户体验改进计划”项的开关从而退出该计划。\n您可以从设备设置上修改您设备的定位设置，例如：变更或禁用定位方法或定位服务器，或修改您位置信息的准确性，从而改变向欧众提供的位置信息。\n您可以根据自己的需要来修改浏览器的设置以拒绝或接受 cookies，也可以随时从您存储设备中将其删除，或者在写入cookies时通知您。\n个人信息的访问和更新\n通过登录你的账户，您能够访问并更新自己的个人信息，您也可以删除部分个人信息或者要求我们删除您的个人账户，除非我们出于法律方面的原因而必须保留这些信息。\n无论您在何时使用我们的服务，我们都力求让您能够访问自己的个人信息。如果这些信息有误，我们会努力通过各种方式让您快速更新信息或删除信息（除非我们出于合法业务或法律方面的原因而必须保留这些信息）。在更新您的个人信息时，我们可能会要求您先验证自己的身份，然后再处理您的请求。\n对于那些无端重复、需要过多技术投入、对他人隐私权造成风险或者非常不切实际的请求，我们可能予以拒绝。\n只要我们能够让您访问和修改信息，而且其不需要过多投入，则我们会免费提供。 我们力求对服务进行完善的维护，以保护信息免遭意外或恶意的破坏。因此，当您从我们的服务中删除信息后，我们可能不会立即从在用的服务器中删除这些信息的残留副本，也可能不会从备份系统中删除相应的信息。\n和第三方分享信息\n除非本隐私政策载明的有限共享，我们会严格保密您的个人信息并不会向第三方共 享您的个人信息。\n您于此授权，以下情形我们将会向第三方共享您的个人信息而无需通过您的同意：\n我们因法律调查、诉讼、强制执行或其它法律强制性规定或要求，而同第三方共享这些个人信息。\n我们将个人信息提供给我们的子公司、关联公司或其他可信赖的企业或个人，以便其代表我们处理个人信息。我们要求上述各方同意按照我们的规定、本隐私权政策以及其他任何适用的保密和安全措施来处理这些个人信息。\n如果我们发生重组、合并或出售，则我们在将我们收集的一切个人信息进行转让之前，继续按照现行的隐私政策约束来保证其秘密性并会通知所有受到影响的用户。\n我们可能会基于经营或保护用户的需要，如为了展示我们产品或服务的整体使用趋势，同公众以及合作伙伴合理地分享汇总的非个人信息。\n信息安全\n我们努力为欧众的用户提供保护，以免我们保存的信息在未经授权的情况下被访问、篡改、披露或破坏。为此，我们特别采取了以下措施：\n我们使用 SSL 对许多服务进行加密。\n我们会审查信息收集、存储和处理方面的做法（包括物理性安全措施），以避免各种系统遭到未经授权的访问。\n我们只允许那些为了帮我们处理个人信息而需要知晓这些信息的欧众员工、授权代为处理服务公司的人员访问个人信息，而且他们需要履行严格的合同保密义务，如果其未能履行这些义务，就可能会被追究法律责任或被终止其与欧众的关系。\n对我们来说，您的信息的安全非常重要。因此，我们将不断努力保障您的个人信息安全，并实施存储和传输全程安全加密等保障手段，以免您的信息在未经授权的情况下被访问、使用或披露。同时某些加密数据的具体内容，除了用户自己，其他人都无权访问。\n隐私政策的适用范围\n我们的隐私政策不适用于第三方产品和/或服务。欧众智能家庭系列产品和服务中可能含有第三方产品和服务。当您使用第三方产品或接收第三方服务时，他们可能获取您的信息，因此，我们在此提醒您注意阅读第三方的隐私政策。\n同时，本隐私政策不适用于在您点击链接后的外部网站收集数据的行为。\n对儿童个人信息的收集和使用\n我们建议13周岁以下的儿童在其法定监护人的许可和指导下使用欧众产品或服务。\n欧众不会在明知对方为儿童的情况下收集其个人信息，也不会向任何第三方透露其个人信息，监护人有权拒绝欧众及其关联公司进一步收集被监护人的个人信息，或要求欧众及其关联公司删除该被监护人个人信息。如果我们发现我们收集了年龄不满13周岁的儿童的个人信息，我们将采取措施尽快地删除此等信息。\n本隐私政策的修订\n本隐私政策容许调整，未经您明示同意，我们不会削弱您按照本隐私权政策所应享有的权利，除非通过您提供的电子邮件地址向您发送通知或发布网站公告。";
    self.textLabel = [[UILabel alloc] init];
    self.textLabel.font = [UIFont systemFontOfSize:16];
    self.textLabel.text = str;
    self.textLabel.backgroundColor = [UIColor whiteColor];
    self.textLabel.numberOfLines = 0;//根据最大行数需求来设置
    self.textLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    CGSize maximumLabelSize = CGSizeMake(kScreenW, 9999999);//labelsize的最大值
    //关键语句
    self.expectSize = [self.textLabel sizeThatFits:maximumLabelSize];
    //别忘了把frame给回label，如果用xib加了约束的话可以只改一个约束的值
    self.textLabel.frame = CGRectMake(0, 0, self.expectSize.width, self.expectSize.height);
    
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, kHeight, kScreenW, kScreenH - kHeight) style:UITableViewStyleGrouped];
    [self.view addSubview:tableView];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.backgroundColor = [UIColor clearColor];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *celled = @"celled";
    TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:celled];
    if (!cell) {
        cell = [[TableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:celled];
    }
    
    [cell addSubview:self.textLabel];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return self.expectSize.height;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
