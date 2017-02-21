//
//  UITextField+XFJTextField.h
//  TravelingManage
//
//  Created by 肖锋 on 2017/2/21.
//  Copyright © 2017年 xiaoFeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITextField (XFJTextField)

/*  返回一个处理好的输入框
 *  imageName       输入框的背景图片
 *  titleName       输入框标题文字
 *  rightImage      输入框右侧图片
 *  placeholder     输入框占位文字
 */
+ (UITextField *)textBackGroundImage:(NSString *)imageName titleName:(NSString *)titleName rightImage:(NSString *)rightImage placeholder: (NSString *)placeholder;

@end
