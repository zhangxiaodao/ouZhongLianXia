//
//  UserFeedBackViewController.m
//  wyh
//
//  Created by bobo on 16/1/5.
//  Copyright © 2016年 HW. All rights reserved.
//

#import "UserFeedBackViewController.h"
#import "PlaceholderTextView.h"
#import "PhotoCollectionViewCell.h"
#import "AFNetworking.h"


#define kTextBorderColor     RGBCOLOR(227,224,216)

#undef  RGBCOLOR
#define RGBCOLOR(r,g,b) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1]

@interface UserFeedBackViewController ()<UITextViewDelegate,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,UIImagePickerControllerDelegate,UINavigationControllerDelegate , HelpFunctionDelegate>


@property (nonatomic , strong) UIView *navView;

@property (nonatomic, strong) PlaceholderTextView * textView;

@property (nonatomic, strong) UIButton * sendButton;

@property (nonatomic, strong) UIView * aView;

@property (nonatomic, strong)UICollectionView *collectionV;
//上传图片的个数
@property (nonatomic, strong)NSMutableArray *photoArrayM;
//上传图片的button
@property (nonatomic, strong)UIButton *photoBtn;
//回收键盘
@property (nonatomic, strong)UITextField *textField;

//字数的限制
@property (nonatomic, strong)UILabel *wordCountLabel;
//邮箱
@property (nonatomic, assign)BOOL emailRight;
//手机
@property (nonatomic, assign)BOOL phoneRight;
//QQ
@property (nonatomic, assign)BOOL qqRight;
@end

@implementation UserFeedBackViewController

//懒加载数组
- (NSMutableArray *)photoArrayM{
    if (!_photoArrayM) {
        _photoArrayM = [NSMutableArray arrayWithCapacity:0];
    }
    return _photoArrayM;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
    
    self.view.backgroundColor = [UIColor colorWithRed:229.0/255 green:229.0/255 blue:229.0/255 alpha:1.0f];
    
    [self setUI];
    

}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    if (self.photoArrayM.count < 4) {
        
        [self.collectionV reloadData];
        _aView.frame = CGRectMake(20, 84, self.view.frame.size.width - 40, 180);
        self.photoBtn.frame = CGRectMake(10 * (self.photoArrayM.count + 1) + (self.aView.frame.size.width - 60) / 5 * self.photoArrayM.count, 154 - 5, (self.aView.frame.size.width - 60) / 5, (self.aView.frame.size.width - 60) / 5 + 5);
    }else{
        [self.collectionV reloadData];
        self.photoBtn.frame = CGRectMake(0, 0, 0, 0);
        
    }
    
}

- (void)viewDidDisappear:(BOOL)animated {

}

#pragma mark - 返回主界面
- (void)backTap:(UITapGestureRecognizer *)tap {
    
    
    
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - 设置UI
- (void)setUI{
    
    self.navView = [UIView creatNavView:self.view WithTarget:self action:@selector(backTap:) andTitle:@"用户反馈"];
    
    self.aView = [[UIView alloc]init];
    _aView.backgroundColor = [UIColor whiteColor];
    _aView.frame = CGRectMake(20, 84, self.view.frame.size.width - 40, kScreenW / 2);
    
    [self.view addSubview:_aView];
    
    
    
    self.wordCountLabel = [[UILabel alloc]initWithFrame:CGRectMake(self.textView.frame.origin.x + 20,  self.textView.frame.size.height + 84 - 1, [UIScreen mainScreen].bounds.size.width - 40, 20)];
    _wordCountLabel.font = [UIFont systemFontOfSize:14.f];
    _wordCountLabel.textColor = [UIColor lightGrayColor];
    self.wordCountLabel.text = @"0/300";
    self.wordCountLabel.backgroundColor = [UIColor whiteColor];
    self.wordCountLabel.textAlignment = NSTextAlignmentRight;
    UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(self.textView.frame.origin.x + 20,  self.textView.frame.size.height + 84 - 1 + 23, [UIScreen mainScreen].bounds.size.width - 40, 1)];
    lineView.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:lineView];
    
    [self.view addSubview:_wordCountLabel];
    [_aView addSubview:self.textView];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    //添加一个label(问题截图（选填）)
    [self addLabelText];
    
    //创建collectionView进行上传图片
    
    [self addCollectionViewPicture];
    
    //添加联系方式
    
    //    [self addContactInformation];
    //提交信息的button
    [self.view addSubview:self.sendButton];
    
    //上传图片的button
    self.photoBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.photoBtn.frame = CGRectMake(10 , 165, (self.aView.frame.size.width- 60) / 5, (self.aView.frame.size.width- 60) / 5);
    [_photoBtn setImage:[UIImage imageNamed:@"2.4意见反馈_03(1)"] forState:UIControlStateNormal];
    //[_photoBtn setBackgroundColor:[UIColor redColor]];
    
    [_photoBtn addTarget:self action:@selector(picureUpload:) forControlEvents:UIControlEventTouchUpInside];
    [self.aView addSubview:_photoBtn];
}

///图片上传
-(void)picureUpload:(UIButton *)sender{
    
    if (self.photoArrayM.count < 3) {
        UIImagePickerController *picker=[[UIImagePickerController alloc]init];
        picker.sourceType=UIImagePickerControllerSourceTypePhotoLibrary;
        picker.mediaTypes=[UIImagePickerController availableMediaTypesForSourceType:picker.sourceType];
        picker.allowsEditing=YES;
        picker.delegate=self;
        [self presentViewController:picker animated:YES completion:nil];
    } else {
        
        [UIAlertController creatRightAlertControllerWithHandle:nil andSuperViewController:self Title:@"最多只能上传三张图片"];
        
    }
    
    
    
    
}
//上传图片的协议与代理方法
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    UIImage *image=[info objectForKey:UIImagePickerControllerEditedImage];
    //    [self.btn setImage:image forState:UIControlStateNormal];
    [self.photoArrayM addObject:image];
    
    
    //选取完图片之后关闭视图
    [self dismissViewControllerAnimated:YES completion:nil];
}
///填写意见
-(void)addLabelText{
    UILabel * labelText = [[UILabel alloc] init];
    labelText.text = @"问题截图(选填)";
    labelText.frame = CGRectMake(10, 125,[UIScreen mainScreen].bounds.size.width - 20, 20);
    labelText.font = [UIFont systemFontOfSize:14.f];
    labelText.textColor = _textView.placeholderColor;
    [_aView addSubview:labelText];
    
    
}
#pragma mark 上传图片UIcollectionView

-(void)addCollectionViewPicture{
    //创建一种布局
    UICollectionViewFlowLayout *flowL = [[UICollectionViewFlowLayout alloc]init];
    //设置每一个item的大小
    flowL.itemSize = CGSizeMake((self.aView.frame.size.width - 60) / 5 , (self.aView.frame.size.width - 60) / 5 );
    flowL.sectionInset = UIEdgeInsetsMake(5, 10, 5, 10);
    //列
    flowL.minimumInteritemSpacing = 10;
    //行
    flowL.minimumLineSpacing = 10;
    //创建集合视图
    self.collectionV = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 145, self.aView.frame.size.width, ([UIScreen mainScreen].bounds.size.width - 60) / 5 + 10) collectionViewLayout:flowL];
    _collectionV.backgroundColor = [UIColor whiteColor];
    // NSLog(@"-----%f",([UIScreen mainScreen].bounds.size.width - 60) / 5);
    _collectionV.delegate = self;
    _collectionV.dataSource = self;
    //添加集合视图
    [self.aView addSubview:_collectionV];
    
    //注册对应的cell
    [_collectionV registerClass:[PhotoCollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
    
}

-(PlaceholderTextView *)textView{
    
    if (!_textView) {
        _textView = [[PlaceholderTextView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width - 40, 100)];
        _textField.keyboardType = UIKeyboardTypeDefault;
        _textView.backgroundColor = [UIColor whiteColor];
        _textView.delegate = self;
        _textView.font = [UIFont systemFontOfSize:14.f];
        _textView.textColor = [UIColor blackColor];
        _textView.textAlignment = NSTextAlignmentLeft;
        _textView.editable = YES;
        _textView.layer.cornerRadius = 4.0f;
        _textView.layer.borderColor = kTextBorderColor.CGColor;
        _textView.layer.borderWidth = 0.5;
        _textView.placeholderColor = RGBCOLOR(0x89, 0x89, 0x89);
        _textView.placeholder = @"写下你遇到的问题，或告诉我们你的宝贵意见~";
        
        
    }
    
    return _textView;
}

//把回车键当做退出键盘的响应键  textView退出键盘的操作
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    
    if ([@"\n" isEqualToString:text] == YES)
    {
        [textView resignFirstResponder];
        
        
        return NO;
    }
    
    return YES;
}

- (UIButton *)sendButton{
    
    if (!_sendButton) {
        _sendButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _sendButton.layer.cornerRadius = 2.0f;
        _sendButton.frame = CGRectMake(20, 364, self.view.frame.size.width - 40, 40);
        _sendButton.backgroundColor = [self colorWithRGBHex:0x60cdf8];
        [_sendButton setTitle:@"提交" forState:UIControlStateNormal];
        [_sendButton addTarget:self action:@selector(sendFeedBack) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _sendButton;
    
}

#pragma mark 提交意见反馈
- (void)sendFeedBack{
    if (self.textView.text.length == 0) {
        
        [UIAlertController creatRightAlertControllerWithHandle:nil andSuperViewController:self Title:@"你输入的信息为空，请重新输入"];
    }
    else{

//        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(gateData:) name:@"model" object:nil];

        NSLog(@"%@ , %@ , %@" , @(self.model.sn) , @(self.model.idd) , self.textView.text);
        
        NSDictionary *parames = @{@"feedback.userSn" : @(self.model.sn) , @"feedback.userId" : @(self.model.idd) , @"feedback.content" : self.textView.text};
        
        // 向服务器提交图片
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        manager.responseSerializer = [AFHTTPResponseSerializer serializer];
        
        [manager POST:kYongHuFanKui parameters:parames constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
            // 上传 多张图片
            for(NSInteger i = 0; i < self.photoArrayM.count; i++) {
                NSData * imageData = UIImageJPEGRepresentation([self.photoArrayM objectAtIndex: i], 0.5);
                // 上传的参数名
                //根据当前系统时间生成图片名称
                NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
                formatter.dateFormat = @"yyyyMMddHHmmss";
                NSLog(@"%@" , formatter);
                NSString *str = [formatter stringFromDate:[NSDate date]];
                NSString *fileName = [NSString stringWithFormat:@"%@_%ld.jpg", str , (long)i];
                [formData appendPartWithFileData:imageData name:@"files" fileName:fileName mimeType:@"image/jpg"];
            }
        } progress:^(NSProgress * _Nonnull uploadProgress) {
            nil;
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
            NSLog(@"%@" , dic);
            
            if ([dic[@"success"] integerValue] == 1) {
                [UIAlertController creatRightAlertControllerWithHandle:^{
                    [self.navigationController popViewControllerAnimated:YES];
                } andSuperViewController:self Title:@"亲您的建议我们已经收到，会尽快处理"];
                   
                
            }
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            NSLog(@"错误 %@", error.localizedDescription);
        }];
        
        
//        [manager POST:kYongHuFanKui parameters:parames constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
//            // 上传 多张图片
//            for(NSInteger i = 0; i < self.photoArrayM.count; i++) {
//                NSData * imageData = UIImageJPEGRepresentation([self.photoArrayM objectAtIndex: i], 0.5);
//                // 上传的参数名
//                //根据当前系统时间生成图片名称
//                NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
//                formatter.dateFormat = @"yyyyMMddHHmmss";
//                NSLog(@"%@" , formatter);
//                NSString *str = [formatter stringFromDate:[NSDate date]];
//                NSString *fileName = [NSString stringWithFormat:@"%@_%ld.jpg", str , (long)i];
//                [formData appendPartWithFileData:imageData name:@"files" fileName:fileName mimeType:@"image/jpg"];
//            }
//        } success:^(AFHTTPRequestOperation *operation, id responseObject)     {
//            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
//            NSLog(@"%@" , dic);
//            
//            if ([dic[@"success"] integerValue] == 1) {
//                [UIAlertController creatAlertControllerWithHandle:^{
//                    [self.navigationController popViewControllerAnimated:YES];                } andSuperViewController:self Title:@"亲您的建议我们已经收到，会尽快处理"];
//                
//            }
//            
//        } failure:^(AFHTTPRequestOperation *operation, NSError *error)     {
//            NSLog(@"错误 %@", error.localizedDescription);
//        }];
        
        
        
    }
}

#pragma mark - 获取主页通知的数据
//- (void)gateData:(NSNotification *)post {
//
//    NSLog(@"%@" , post.userInfo[@"model"]);
//    
//}

#pragma mark - 代理返回的数据
- (void)requestData:(HelpFunction *)request didSuccess:(NSDictionary *)dddd{
    NSLog(@"%@" , dddd);
}




- (UIColor *)colorWithRGBHex:(UInt32)hex
{
    int r = (hex >> 16) & 0xFF;
    int g = (hex >> 8) & 0xFF;
    int b = (hex) & 0xFF;
    
    return [UIColor colorWithRed:r / 255.0f
                           green:g / 255.0f
                            blue:b / 255.0f
                           alpha:1.0f];
}


#pragma mark CollectionView DataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if (_photoArrayM.count == 0) {
        return 0;
    }
    else{
        return self.photoArrayM.count;
    }
}

//返回每一个cell
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    PhotoCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    
    cell.photoV.image = self.photoArrayM[indexPath.item];
    return cell;
}

#pragma mark textField的字数限制

//在这个地方计算输入的字数
- (void)textViewDidChange:(UITextView *)textView
{
    NSInteger wordCount = textView.text.length;
    self.wordCountLabel.text = [NSString stringWithFormat:@"%ld/300",(long)wordCount];
    [self wordLimit:textView];
}
#pragma mark 超过300字不能输入
-(BOOL)wordLimit:(UITextView *)text{
    if (text.text.length < 300) {
        NSLog(@"%ld",(unsigned long)text.text.length);
        self.textView.editable = YES;
        
    }
    else{
        self.textView.editable = NO;
        
    }
    return nil;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [_textView resignFirstResponder];
    [_textField resignFirstResponder];
}

#pragma mark 判断邮箱，手机，QQ的格式
-(BOOL)isValidateEmail:(NSString *)email{
    
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    self.emailRight = [emailTest evaluateWithObject:email];
    return self.emailRight;
    
}

//验证手机号码的格式

- (BOOL)isMobileNumber:(NSString *)mobileNum
{
    /**
     * 手机号码
     * 移动：134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188
     * 联通：130,131,132,152,155,156,185,186
     * 电信：133,1349,153,180,189
     */
    NSString * MOBILE = @"^1(3[0-9]|5[0-35-9]|8[025-9])\\d{8}$";
    /**
     10         * 中国移动：China Mobile
     11         * 134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188
     12         */
    NSString * CM = @"^1(34[0-8]|(3[5-9]|5[017-9]|8[278])\\d)\\d{7}$";
    /**
     15         * 中国联通：China Unicom
     16         * 130,131,132,152,155,156,185,186
     17         */
    NSString * CU = @"^1(3[0-2]|5[256]|8[56])\\d{8}$";
    /**
     20         * 中国电信：China Telecom
     21         * 133,1349,153,180,189
     22         */
    NSString * CT = @"^1((33|53|8[09])[0-9]|349)\\d{7}$";
    /**
     25         * 大陆地区固话及小灵通
     26         * 区号：010,020,021,022,023,024,025,027,028,029
     27         * 号码：七位或八位
     28         */
    // NSString * PHS = @"^0(10|2[0-5789]|\\d{3})\\d{7,8}$";
    
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    NSPredicate *regextestcm = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM];
    NSPredicate *regextestcu = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU];
    NSPredicate *regextestct = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT];
    
    if (([regextestmobile evaluateWithObject:mobileNum] == YES)
        || ([regextestcm evaluateWithObject:mobileNum] == YES)
        || ([regextestct evaluateWithObject:mobileNum] == YES)
        || ([regextestcu evaluateWithObject:mobileNum] == YES))
    {
        self.phoneRight = 1;
        return YES;
    }
    else
    {
        self.phoneRight = 0;
        return NO;
    }
}


@end
