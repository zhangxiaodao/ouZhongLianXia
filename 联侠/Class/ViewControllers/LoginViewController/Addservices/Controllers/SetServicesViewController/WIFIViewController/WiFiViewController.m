
#import "WiFiViewController.h"
#import "SearchServicesViewController.h"
#import <SystemConfiguration/CaptiveNetwork.h>
#import "MineSerivesViewController.h"

#define HEIGHT_KEYBOARD 216
#define HEIGHT_TEXT_FIELD 30
#define HEIGHT_SPACE (6+HEIGHT_TEXT_FIELD)

@interface WiFiViewController ()<UITextFieldDelegate> {
    CFDictionaryRef dictRef;
}
@property (strong, nonatomic)  UITextField *_pwdTextView;
@property (strong, nonatomic)  UIButton *_confirmCancelBtn;
@property (strong, nonatomic)  UILabel *ssidLabel;
@property (strong, nonatomic) NSString *bssid;
@property (nonatomic , strong) NSString *bSSID;
@property (nonatomic , strong) UIView *xianHuaXian;
@end

@implementation WiFiViewController

#pragma mark - 按钮的点击事件
- (void)tapConfirmCancelBtn:(UIButton *)sender
{
    SearchServicesViewController *searVC = [[SearchServicesViewController alloc]init];
    searVC.apSsid = [NSString stringWithFormat:@"%@" , self.bssid];
    searVC.ssidText = [NSString stringWithFormat:@"%@" , self.ssidLabel.text];
    searVC.bssid = [NSString stringWithFormat:@"%@" , self._pwdTextView.text];
    searVC.navigationItem.title = @"添加设备";
//    searVC.addServiceModel = self.addServiceModel;
    [self.navigationController pushViewController:searVC animated:YES];
    
    
}


#pragma mark - 获取本地wifi名字
- (NSString *)getWifiName
{
    NSString *wifiName = nil;
    
    CFArrayRef wifiInterfaces = CNCopySupportedInterfaces();
    
    if (!wifiInterfaces) {
        return nil;
    }
    
    NSArray *interfaces = (__bridge NSArray *)wifiInterfaces;
    
    for (NSString *interfaceName in interfaces) {
        dictRef = CNCopyCurrentNetworkInfo((__bridge CFStringRef)(interfaceName));
        
        if (dictRef) {
            NSDictionary *networkInfo = (__bridge NSDictionary *)dictRef;
            NSLog(@"%@" , networkInfo);
            
            self.ssidLabel.text = networkInfo[@"SSID"];
            self.bssid = networkInfo[@"BSSID"];
            wifiName = [networkInfo objectForKey:(__bridge NSString *)kCNNetworkInfoKeySSID];
            
            CFRelease(dictRef);
        }
    }
    
    CFRelease(wifiInterfaces);
    return wifiName;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self setUI];

   
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    if (dictRef) {
       
        [UIAlertController creatRightAlertControllerWithHandle:nil andSuperViewController:self Title:@"请输入正确的WIFI密码，密码错误，设备无法绑定!"];
    } else {
        [UIAlertController creatRightAlertControllerWithHandle:^{
            [self.navigationController popViewControllerAnimated:YES];
        } andSuperViewController:kWindowRoot Title:@"您当前没有连接WIFI，设备无法添加"];
    }
}

#pragma mark - 设置UI
- (void)setUI {
    
    UIImageView *backImage = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"WIFIback"]];
    [self.view addSubview:backImage];
    [backImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kScreenW / 1.7, kScreenW / 1.7));
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.top.mas_equalTo(self.view.mas_top).offset(kScreenH / 11);
    }];
    
    
    UIView *xiaHuaXian = [[UIView alloc]init];
    [self.view addSubview:xiaHuaXian];
    xiaHuaXian.backgroundColor = [UIColor whiteColor];
    [xiaHuaXian mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kStandardW, 1));
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.bottom.mas_equalTo(backImage.mas_bottom).offset(kScreenH/5);
    }];
    

    
    UILabel *nameWiFi = [UILabel creatLableWithTitle:@"WIFI名字:" andSuperView:self.view andFont:k14 andTextAligment:NSTextAlignmentLeft];
    nameWiFi.layer.borderWidth = 0;
    [nameWiFi mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kScreenW / 5, kScreenW / 10));
        make.left.mas_equalTo(xiaHuaXian.mas_left);
        make.bottom.mas_equalTo(xiaHuaXian.mas_top);
    }];

    self.ssidLabel = [UILabel creatLableWithTitle:[NSString stringWithFormat:@"%@" , [self getWifiName]] andSuperView:self.view andFont:k14 andTextAligment:NSTextAlignmentLeft];
    self.ssidLabel.layer.borderWidth = 0;
    [self.ssidLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kScreenW * 2 / 3, kScreenW / 10));
        make.centerY.mas_equalTo(nameWiFi.mas_centerY);
        make.left.mas_equalTo(nameWiFi.mas_right).offset(kScreenW / 30);
    }];
    self.ssidLabel.textColor = [UIColor grayColor];

    
    
    UIView *xiaHuaXian2 = [[UIView alloc]init];
    [self.view addSubview:xiaHuaXian2];
    xiaHuaXian2.backgroundColor = [UIColor grayColor];
    [xiaHuaXian2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kStandardW, 1));
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.top.mas_equalTo(xiaHuaXian.mas_bottom).offset(kScreenH/13.875);
    }];

    
    UILabel *pwdWiFi = [UILabel creatLableWithTitle:@"WiFi密码:" andSuperView:self.view andFont:k14 andTextAligment:NSTextAlignmentLeft];
    pwdWiFi.layer.borderWidth = 0;
    [pwdWiFi mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kScreenW / 5, kScreenW / 10));
        make.left.mas_equalTo(xiaHuaXian2.mas_left);
        make.bottom.mas_equalTo(xiaHuaXian2.mas_top);
    }];
    
    self._pwdTextView = [UITextField creatTextfiledWithPlaceHolder:@"请输入WIFI密码" andSuperView:self.view];
    [self._pwdTextView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kScreenW * 2 / 3, kScreenW / 10));
        make.left.mas_equalTo(pwdWiFi.mas_right).offset(kScreenW / 30);
        make.centerY.mas_equalTo(pwdWiFi.mas_centerY);
    }];

    self._pwdTextView.delegate = self;
    self._pwdTextView.secureTextEntry = YES;
    self._pwdTextView.returnKeyType = UIReturnKeyDone;
    self._pwdTextView.keyboardType = UIKeyboardTypeDefault;
    
    self._confirmCancelBtn = [UIButton initWithTitle:@"搜索设备" andColor:kMainColor andSuperView:self.view];
    self._confirmCancelBtn.layer.cornerRadius = kScreenW / 18;

    [self._confirmCancelBtn addTarget:self action:@selector(tapConfirmCancelBtn:) forControlEvents:UIControlEventTouchUpInside];
    //注册按钮的约束
    [self._confirmCancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kStandardW, kScreenW / 8));
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.top.mas_equalTo(xiaHuaXian2.mas_bottom).offset(kScreenH / 22.2);
    }];
    
    _xianHuaXian = xiaHuaXian2;
    
}

#pragma mark - 点击空白处收回键盘
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

#pragma mark - textFiled的代理  键盘弹起时，textFiled上移
-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    
    _xianHuaXian.backgroundColor = kMainColor;
    
    CGRect frame = textField.frame;
    NSLog(@"%@" , NSStringFromCGRect(frame));
    int offset = frame.origin.y + frame.size.height - (kScreenH - (HEIGHT_KEYBOARD+HEIGHT_SPACE)) + kScreenW / 10;

    NSTimeInterval animationDuration = 0.30f;
    [UIView beginAnimations:@"ResizeForKeyboard" context:nil];
    [UIView setAnimationDuration:animationDuration];

    if(offset > 0)
    {
        self.view.frame = CGRectMake(0.0f, -offset, self.view.frame.size.width, self.view.frame.size.height);
    }

    [UIView commitAnimations];
}

-(void)textFieldDidEndEditing:(UITextField *)textField
{
    
    _xianHuaXian.backgroundColor = [UIColor grayColor];
    
    NSTimeInterval animationDuration = 0.30f;
    [UIView beginAnimations:@"ResizeForKeyboard" context:nil];
    [UIView setAnimationDuration:animationDuration];
    self.view.frame = CGRectMake(0, kHeight, kScreenW, self.view.frame.size.height);
    [UIView commitAnimations];
}

//- (void)setAddServiceModel:(AddServiceModel *)addServiceModel {
//    _addServiceModel = addServiceModel;
//}

@end


