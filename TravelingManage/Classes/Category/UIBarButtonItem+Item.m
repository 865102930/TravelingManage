//
//  UIBarButtonItem+Item.m
//  HXTrave
//
//  Copyright © 2015年 rongcuilin. All rights reserved.
//

#import "UIBarButtonItem+Item.h"

@implementation UIBarButtonItem (Item)

+ (UIBarButtonItem *)itemWithImage:(UIImage *)image highImage:(UIImage *)highImage title:(NSString *)title target:(id)target action:(SEL)action
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setImage:image forState:UIControlStateNormal];
    [btn setImage:highImage forState:UIControlStateHighlighted];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn setFrame:CGRectMake(-50, 0, 100, 30)];
    
    // 监听按钮点击
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    
    UIView *btnView = [[UIView alloc] initWithFrame:btn.bounds];
    [btnView addSubview:btn];
    
    return [[UIBarButtonItem alloc] initWithCustomView:btnView];

}

//+ (UIBarButtonItem *)itemWithImage:(UIImage *)image selImage:(UIImage *)selImage title:(NSString *)title target:(id)target action:(SEL)action
//{
//    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
//    [btn setImage:image forState:UIControlStateNormal];
//    [btn setImage:selImage forState:UIControlStateSelected];
//    [btn setTitle:title forState:UIControlStateNormal];
//    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//    //设置button字体大小
//    btn.titleLabel.font = [UIFont systemFontOfSize: 14];
//    [btn sizeToFit];
//    // 监听按钮点击
//    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
//    
//    // 解决导航条按钮 点击范围过大的问题
//    UIView *btnView = [[UIView alloc] initWithFrame:btn.bounds];
//    [btnView addSubview:btn];
//    
//    
//    return [[UIBarButtonItem alloc] initWithCustomView:btnView];
//}

+ (UIBarButtonItem *)itemWithImage:(UIImage *)image selImage:(UIImage *)selImage title:(NSString *)title target:(id)target action:(SEL)action
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(100, 100, 100, 40);
    [button setImage:image forState:UIControlStateNormal];
    [button setImage:image forState:UIControlStateSelected];
    //button图片的偏移量，距上左下右
    button.imageEdgeInsets = UIEdgeInsetsMake(10, 80, 10, 0);
    [button setTitle:title forState:UIControlStateNormal];
    //button标题的偏移量，这个偏移量是相对于图片的
    button.titleEdgeInsets = UIEdgeInsetsMake(0, -5, 0, 20);
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:14];
    
    // 监听按钮点击
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];

    
    return [[UIBarButtonItem alloc] initWithCustomView:button];
    }
@end
