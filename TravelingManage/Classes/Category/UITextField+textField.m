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
+ (UITextField *)textBackGroundImage:(NSString *)imageName titleName:(NSString *)titleName rightImage:(NSString *)rightImage placeholder: (NSString *)placeholder
{
    UITextField *textField = [[UITextField alloc] init];
    textField.background = [UIImage imageNamed:imageName];
    //textfeild右边取消输入
    textField.clearButtonMode = UITextFieldViewModeAlways;
    //键盘样式(数字键盘和用户名输入)
    textField.keyboardType = UIKeyboardTypeNamePhonePad;
    //左边文字
    UILabel *title_label = [[UILabel alloc] initWithFrame:CGRectMake(15, 13, 90, 13)];
    title_label.text = [NSString stringWithFormat:@"%@",titleName];
    title_label.font = [UIFont systemFontOfSize:13.0];
    title_label.textColor = kColor2f2f;
    //右边图片
    UIImageView *rightImageView = [[UIImageView alloc] initWithFrame:CGRectMake(80, 13, 5, 5)];
    rightImageView.image = [UIImage imageNamed:rightImage];
    //占位文字的位置
    UIView * leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 100, 38)];
    [leftView addSubview:title_label];
    [leftView addSubview:rightImageView];
    textField.leftView = leftView;
    textField.leftViewMode = UITextFieldViewModeAlways;
    textField.placeholder = placeholder;
    textField.tintColor = kColorBCBC;
    //设置占位文字的字体大小
    [textField setValue:[UIFont boldSystemFontOfSize:14] forKeyPath:@"_placeholderLabel.font"];
    textField.placeholderColor = kColorBCBC;
    textField.autocapitalizationType = UITextAutocapitalizationTypeNone;
    [textField addSubview:leftView];
    
    return textField;
}

- (CGRect)placeholderRectForBounds:(CGRect)bounds
{
    return CGRectMake(100, 3, 100, 38);
}

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
