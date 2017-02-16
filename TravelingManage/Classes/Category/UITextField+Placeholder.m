//
//  UITextField+Placeholder.m
//  123
//
//  Created by 戎翠林 on 16/8/25.
//  Copyright © 2016年  戎翠林. All rights reserved.
//
#import "UITextField+Placeholder.h"

#import <objc/message.h>

@implementation UITextField (Placeholder)
+ (void)load
{
    Method setPlaceholderMethod = class_getInstanceMethod(self, @selector(setPlaceholder:));
    
    Method setRPlaceholderMethod = class_getInstanceMethod(self, @selector(setR_Placeholder:));
    
    method_exchangeImplementations(setPlaceholderMethod, setRPlaceholderMethod);
}

// 设置占位文字,并且设置占位文字颜色
- (void)setR_Placeholder:(NSString *)placeholder
{
    // 设置占位文字
    [self setR_Placeholder:placeholder];
    // 设置占位文字颜色
    [self setPlaceholderColor:self.placeholderColor];
}
// 设置占位文字颜色
- (void)setPlaceholderColor:(UIColor *)placeholderColor
{
    // 把占位文字颜色先保存
    objc_setAssociatedObject(self, @"placeholderColor", placeholderColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    // 获取占位文字控件
    UILabel *placeholderLabel = [self valueForKey:@"placeholderLabel"];
    // 拿到控件去设置颜色
    placeholderLabel.textColor = placeholderColor;

}

// 返回占位文字颜色
- (UIColor *)placeholderColor
{
    return objc_getAssociatedObject(self, @"placeholderColor");
}
@end
