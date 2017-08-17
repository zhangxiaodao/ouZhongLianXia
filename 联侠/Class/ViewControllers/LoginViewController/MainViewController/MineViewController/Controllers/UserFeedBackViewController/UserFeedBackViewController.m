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
@property (nonatomic, strong) PlaceholderTextView * textView;

@property (nonatomic, strong) UIView * aView;
@property (nonatomic, strong)UICollectionView *collectionV;
//上传图片的个数
@property (nonatomic, strong)NSMutableArray *photoArrayM;
//上传图片的button
@property (nonatomic, strong)UIButton *photoBtn;

@property (nonatomic , strong) UIView *secondBackView;

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

- (void)setModel:(UserModel *)model {
    _model = model;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor colorWithHexString:@"f2f4fb"];
    
    [self setUI];
    

}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    if (self.photoArrayM.count < 4) {
        
        [self.collectionV reloadData];
        [self.photoBtn removeFromSuperview];
        [self.secondBackView addSubview:self.photoBtn];
        [self.photoBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(kScreenW / 6.8, kScreenW / 6.8));
            make.left.mas_equalTo(_secondBackView.mas_left).offset((kScreenW / 25) * (self.photoArrayM.count + 1) + (kScreenW / 6.8) * self.photoArrayM.count);
            make.centerY.mas_equalTo(self.collectionV.mas_centerY);
        }];
    }
    
}

#pragma mark - 设置UI
- (void)setUI{
    
    self.aView = [[UIView alloc]init];
    _aView.backgroundColor = [UIColor whiteColor];
    _aView.frame = CGRectMake(kScreenW / 25, kScreenW / 25, kScreenW - kScreenW * 2 / 25, kScreenH / 3.7);
    [self.view addSubview:_aView];
    _aView.layer.cornerRadius = 5;
    
    
    
    _textView = [[PlaceholderTextView alloc]initWithFrame:_aView.bounds];
    [_aView addSubview:_textView];
    _textView.keyboardType = UIKeyboardTypeDefault;
    _textView.delegate = self;
    _textView.font = [UIFont systemFontOfSize:14.f];
    _textView.textColor = [UIColor blackColor];
    _textView.textAlignment = NSTextAlignmentLeft;
    _textView.editable = YES;
    _textView.backgroundColor = [UIColor clearColor];
    _textView.placeholderColor = RGBCOLOR(0x89, 0x89, 0x89);
    _textView.placeholder = @"写下你遇到的问题，或告诉我们你的宝贵意见~";
    _textView.layer.borderWidth = 0;
    
    _wordCountLabel = [UILabel creatLableWithTitle:@"0/300" andSuperView:_aView andFont:k14 andTextAligment:NSTextAlignmentRight];
    [_wordCountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kScreenW - kScreenW * 4 / 25, kScreenW / 25));
        make.centerX.mas_equalTo(_aView.mas_centerX);
        make.bottom.mas_equalTo(_aView.mas_bottom).offset(-kScreenW / 25);
    }];
    _wordCountLabel.textColor = [UIColor lightGrayColor];
    _wordCountLabel.layer.borderWidth = 0;

    _secondBackView = [[UIView alloc]init];
    _secondBackView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_secondBackView];
    [_secondBackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(_aView.width, kScreenH / 5.32));
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.top.mas_equalTo(_aView.mas_bottom).offset(kScreenW / 23);
    }];
    _secondBackView.layer.cornerRadius = 5;
    
    
    
    UILabel * labelText = [UILabel creatLableWithTitle:@"问题截图(选填)" andSuperView:_secondBackView andFont:k14 andTextAligment:NSTextAlignmentLeft];
    
    [labelText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kScreenW - kScreenW * 4 / 25, kScreenW / 10.7));
        make.centerX.mas_equalTo(_secondBackView.mas_centerX);
        make.top.mas_equalTo(_secondBackView.mas_top);
    }];
    labelText.textColor = _textView.placeholderColor;
    
    UICollectionViewFlowLayout *flowL = [[UICollectionViewFlowLayout alloc]init];
    flowL.itemSize = CGSizeMake(kScreenW / 6.8 , kScreenW / 6.8 );
    flowL.sectionInset = UIEdgeInsetsMake(0, kScreenW / 25, 0, 0);
    flowL.minimumLineSpacing = 10;
    self.collectionV = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:flowL];
    [_secondBackView addSubview:_collectionV];
    [self.collectionV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kScreenW - kScreenW * 2 / 25, kScreenW / 6.8));
        make.centerX.mas_equalTo(_secondBackView.mas_centerX);
        make.bottom.mas_equalTo(_secondBackView.mas_bottom).offset(-kScreenW / 16.3);
    }];
    _collectionV.backgroundColor = [UIColor whiteColor];
    _collectionV.delegate = self;
    _collectionV.dataSource = self;
    
    [_collectionV registerClass:[PhotoCollectionViewCell class] forCellWithReuseIdentifier:@"cell"];

    //上传图片的button
    self.photoBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_secondBackView addSubview:_photoBtn];
    [self.photoBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kScreenW / 6.8, kScreenW / 6.8));
        make.left.mas_equalTo(_secondBackView.mas_left).offset(kScreenW / 25);
        make.centerY.mas_equalTo(self.collectionV.mas_centerY);
    }];
    [_photoBtn sizeToFit];
    [_photoBtn setImage:[UIImage imageNamed:@"2.4意见反馈_03(1)"] forState:UIControlStateNormal];
    [_photoBtn addTarget:self action:@selector(picureUpload:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *submitBtn = [UIButton creatBtnWithTitle:@"提交" withLabelFont:k15 withLabelTextColor:[UIColor whiteColor] andSuperView:self.view andBackGroundColor:kCOLOR(28, 164, 252) andHighlightedBackGroundColor:kKongJingHuangSe andwhtherNeendCornerRadius:@"YES" WithTarget:self andDoneAtcion:@selector(sendFeedBack)];
    [submitBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kScreenW / 2.8, kScreenW / 10));
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.top.mas_equalTo(_secondBackView.mas_bottom).offset(kScreenW / 10);
    }];
    
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

#pragma mark 提交意见反馈
- (void)sendFeedBack{
    if (self.textView.text.length == 0) {
        
        [UIAlertController creatRightAlertControllerWithHandle:nil andSuperViewController:self Title:@"你输入的信息为空，请重新输入"];
    }
    else{


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
                } andSuperViewController:self Title:@"亲，您的建议我们已经收到，会尽快处理"];
                   
                
            }
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            NSLog(@"错误 %@", error.localizedDescription);
        }];
        
 
        
        
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

- (void)requestData:(HelpFunction *)request didFailLoadData:(NSError *)error {
    NSLog(@"%@" , error);
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
}

@end
