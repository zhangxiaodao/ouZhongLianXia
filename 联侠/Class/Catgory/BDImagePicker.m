//
//  BDImagePicker.m
//  AEFT冷风扇
//
//  Created by 杭州阿尔法特 on 16/3/17.
//  Copyright © 2016年 阿尔法特. All rights reserved.
//

#import "BDImagePicker.h"
#import <UIKit/UIKit.h>

@interface BDImagePicker ()<UIActionSheetDelegate , UIImagePickerControllerDelegate , UINavigationControllerDelegate>

@property (nonatomic , weak) UIViewController *viewController;
@property (nonatomic , copy) BDImagePickerFinishAction finishAtcion;
@property (nonatomic , assign) BOOL allowsEditing;

@end

static BDImagePicker *bdImagePickerInstance = nil;

@implementation BDImagePicker

+ (void)showImagePickerFromViewController:(UIViewController *)viewController allowsEditing:(BOOL)allowsEditing finishAtcion:(BDImagePickerFinishAction)finishAtcion{
    if (bdImagePickerInstance == nil) {
        bdImagePickerInstance = [[BDImagePicker alloc]init];
    }
    
    [bdImagePickerInstance showImagePickerFromViewController:viewController allowsEditing:allowsEditing finishAtcion:finishAtcion];
}

- (void)showImagePickerFromViewController:(UIViewController *)viewController allowsEditing:(BOOL)allowsEditing finishAtcion:(BDImagePickerFinishAction)finishAtcion {
    _viewController = viewController;
    _finishAtcion = finishAtcion;
    _allowsEditing = allowsEditing;
    

    UIAlertController *alertVC = nil;
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {

        alertVC = [UIAlertController creatSheetControllerWithFirstHandle:^{
            UIImagePickerController *picker = [[UIImagePickerController alloc]init];
            picker.delegate = self;
            picker.sourceType = UIImagePickerControllerSourceTypeCamera;
            picker.allowsEditing = _allowsEditing;
            [_viewController presentViewController:picker animated:YES completion:nil];
        } andFirstTitle:@"拍照" andSecondHandle:^{
            UIImagePickerController *picker = [[UIImagePickerController alloc]init];
            picker.delegate = self;
            picker.allowsEditing = YES;
            [_viewController presentViewController:picker animated:YES completion:nil];
        } andSecondTitle:@"从相册中选择" andThirtHandle:nil andThirtTitle:nil andForthHandle:nil andForthTitle:nil andSuperViewController:_viewController];


    } else {

        alertVC = [UIAlertController creatSheetControllerWithFirstHandle:^{
            UIImagePickerController *picker = [[UIImagePickerController alloc]init];
            picker.delegate = self;
            picker.allowsEditing = YES;
            [_viewController presentViewController:picker animated:YES completion:nil];
        } andFirstTitle:@"从相册中选择" andSecondHandle:nil andSecondTitle:nil andThirtHandle:nil andThirtTitle:nil andForthHandle:nil andForthTitle:nil andSuperViewController:_viewController];
    }
    
//    [_viewController presentViewController:alertVC animated:YES completion:nil];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    UIImage *image = info[UIImagePickerControllerEditedImage];
    
    
    if (image == nil) {
        image = info[UIImagePickerControllerOriginalImage];
    }
    if (_finishAtcion) {
        _finishAtcion(image);
    }
    
    [picker dismissViewControllerAnimated:YES completion:^{
        
    }];
    
    bdImagePickerInstance = nil;
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    if (_finishAtcion) {
        _finishAtcion(nil);
    }
    [picker dismissViewControllerAnimated:YES completion:^{
        
    }];
    bdImagePickerInstance = nil;
}

@end
