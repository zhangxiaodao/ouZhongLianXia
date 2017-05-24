//
//  UserInfoCell.h
//  联侠
//
//  Created by 杭州阿尔法特 on 2017/4/13.
//  Copyright © 2017年 张海昌. All rights reserved.
//

#import "BaseTableViewCell.h"
#import "DiZhiModel.h"
@interface UserInfoCell : UITableViewCell
@property (nonatomic , strong) NSIndexPath *indexPath;
@property (nonatomic , strong) UserModel *userModel;
@property (nonatomic , strong) DiZhiModel *dizhiModel;
@property (nonatomic , strong) UILabel *lable;
@property (nonatomic , strong) UILabel *rightLabel;
@property (nonatomic , strong) UILabel *loginOutLabel;
@property (nonatomic , strong) UILabel *idLabel;
@property (nonatomic , strong) UITextField *contentFiled;
@property (nonatomic , strong) UITextField *detailFiled;
@property (nonatomic , strong) UIButton *chanceBtn;

@property (nonatomic , strong) UIImageView *headPortraitImageView;
@property (nonatomic , strong) UIImageView *jianTouImage;

@property (nonatomic , strong) UIView *view;
@property (nonatomic , strong) UIView *fenGeView;

@property (nonatomic , strong) UIImageView *selectedImage;

- (void)setTopCorner;
- (void)setBottomCorner;
- (void)changHeadPortraitAtcion;
- (void)chanceAddressAtcion;
- (void)textFieldDidEndEditing:(UITextField *)textField ;
@end
