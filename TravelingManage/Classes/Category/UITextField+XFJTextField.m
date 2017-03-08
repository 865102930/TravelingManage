//
//  UITextField+XFJTextField.m
//  TravelingManage
//
//  Created by 肖锋 on 2017/2/21.
//  Copyright © 2017年 xiaoFeng. All rights reserved.
//

#import "UITextField+XFJTextField.h"
#import "UITextField+Placeholder.h"
@implementation UITextField (XFJTextField)

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

+ (UITextField *)textBackGround_Image:(NSString *)imageName titleName:(NSString *)titleName rightImage:(NSString *)rightImage placeholder: (NSString *)placeholder
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

//- (CGRect)placeholderRectForBounds:(CGRect)bounds
//{
//    return CGRectMake(100, 3, 100, 38);
//}

@end
