//
//  UITextField+textField.h
//  123
//
//  Created by 戎翠林 on 16/8/25.
//  Copyright © 2016年  戎翠林. All rights reserved.
//
#import "UITextField+textField.h"
#import "UITextField+Placeholder.h"
@implementation UITextField (textField)

#pragma ------------登录界面textField
+ (UITextField *)textLeftImage: (NSString *)leftImage placeholder: (NSString *)placeholder imageWidth: (CGFloat)imageWidth imageHeight: (CGFloat)imageHeight lineWidth: (CGFloat)lineWidth
{
    UITextField *textField = [[UITextField alloc] init];
    textField.clearButtonMode = UITextFieldViewModeAlways;//textfeild右边取消输入
    textField.keyboardType = UIKeyboardTypeNamePhonePad;//键盘样式
    UIImageView * leftIma = [[UIImageView alloc]  initWithFrame:CGRectMake(11, 11, imageWidth, imageHeight)];
    leftIma.image = [UIImage imageNamed:leftImage];
    UIView * leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 40, 42)];
    [leftView addSubview:leftIma];
    textField.leftView = leftView;
    leftIma.contentMode  = UIViewContentModeCenter;
    textField.leftViewMode = UITextFieldViewModeAlways;
    
    textField.placeholder = placeholder;
    textField.font =[UIFont fontWithName:PingFang size:15];
    textField.placeholderColor = [UIColor colorWithHexString:@"A2A1A0"];
    textField.textColor = [UIColor colorWithHexString:@"4f4f4f"];
    textField.tintColor = [UIColor colorWithHexString:@"656565"];
    textField.autocapitalizationType = UITextAutocapitalizationTypeNone;
    [textField addSubview:leftView];
    
    UIView *lineView = [[UIView alloc] init];
    lineView.backgroundColor = RedColor;
    lineView.frame = CGRectMake(0,41,lineWidth, 1);
    [textField addSubview:lineView];
    return textField;
}




@end
