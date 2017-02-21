//
//  UITextField+textField.h
//  123
//
//  Created by 戎翠林 on 16/8/25.
//  Copyright © 2016年  戎翠林. All rights reserved.
//
#import <UIKit/UIKit.h>

@interface UITextField (textField)

#pragma ------------登录界面textField
+ (UITextField *)textLeftImage: (NSString *)leftImage placeholder: (NSString *)placeholder imageWidth: (CGFloat)imageWidth imageHeight: (CGFloat)imageHeight lineWidth: (CGFloat)lineWidth;
@end
