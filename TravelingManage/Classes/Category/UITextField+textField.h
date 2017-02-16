//
//  UITextField+textField.h
//  123
//
//  Created by 戎翠林 on 16/8/25.
//  Copyright © 2016年  戎翠林. All rights reserved.
//
#import <UIKit/UIKit.h>

@interface UITextField (textField)
/*  返回一个处理好的输入框
 *  imageName       输入框的背景图片
 *  titleName       输入框标题文字
 *  rightImage      输入框右侧图片
 *  placeholder     输入框占位文字
 */
+ (UITextField *)textBackGroundImage:(NSString *)imageName titleName:(NSString *)titleName rightImage:(NSString *)rightImage placeholder: (NSString *)placeholder;

#pragma ------------登录界面textField
+ (UITextField *)textLeftImage: (NSString *)leftImage placeholder: (NSString *)placeholder imageWidth: (CGFloat)imageWidth imageHeight: (CGFloat)imageHeight lineWidth: (CGFloat)lineWidth;
@end
