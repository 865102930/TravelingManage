//
//  UIButton+button.m
//  elevator
//
//  Created by 戎翠林 on 16/8/25.
//  Copyright © 2016年 郑子煜. All rights reserved.
//

#import "UIButton+button.h"

@implementation UIButton (button)

//登录界面登录按钮/提交密码按钮
//+ (UIButton *)buttonWithImage:(NSString *)imageName title: (NSString *)title fontOfSize: (CGFloat)size target:(id)target action:(SEL)action
//{
//    UIButton *button =  [[UIButton alloc] init];
//    [button setBackgroundImage: [UIImage imageNamed:imageName] forState:UIControlStateNormal];
//    [button setTitle:title forState:UIControlStateNormal];
//    button.titleLabel.font = [UIFont fontWithName:PingFang size:size];
//    [button setTintColor:[UIColor colorWithHexString:@"#FFFFFF"]];
//    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
//    return button;
//}
//发送验证码按钮
+ (UIButton *)buttonWithTitle: (NSString *)title fontOfSize: (CGFloat)size target:(id)target action:(SEL)action
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [button setTitleColor:RedColor forState:UIControlStateNormal];
    [button setTitle:title forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont fontWithName:PingFang size:size];
    button.frame = CGRectMake(10, 30, 300, 30);
    [button.layer setMasksToBounds:YES];
    [button.layer setBorderColor:[UIColor redColor].CGColor];
    [button.layer setBorderWidth:1];
    [button.layer setMasksToBounds:YES];
    button.clipsToBounds = YES;
    button.layer.cornerRadius = 4;
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    return button;
}

- (void)setHighlighted:(BOOL)highlighted
{
    
}

@end
