//
//  UIButton+button.h
//  elevator
//
//  Created by 戎翠林 on 16/8/25.
//  Copyright © 2016年 郑子煜. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (button)
//登录按钮
//+ (UIButton *)buttonWithImage:(NSString *)imageName title: (NSString *)title fontOfSize: (CGFloat)size target:(id)target action:(SEL)action;
//发送验证码按钮
+ (UIButton *)buttonWithTitle: (NSString *)title fontOfSize: (CGFloat)size target:(id)target action:(SEL)action;

@end

