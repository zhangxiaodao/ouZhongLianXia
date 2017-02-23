//
//  BDImagePicker.h
//  AEFT冷风扇
//
//  Created by 杭州阿尔法特 on 16/3/17.
//  Copyright © 2016年 阿尔法特. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^BDImagePickerFinishAction)(UIImage *image);

@interface BDImagePicker : NSObject

//viewController 用于present  UIImagePickerController对象
//allowsEditing  是否允许用户编辑图片
+ (void)showImagePickerFromViewController:(UIViewController *)viewController allowsEditing:(BOOL)allowsEditing finishAtcion:(BDImagePickerFinishAction)finishAtcion;

@end
