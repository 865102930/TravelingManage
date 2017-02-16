//
//  UIBarButtonItem+XFJItem.m
//  01-BuDeJie
//
//  Created by 肖锋 on 16/4/2.
//  Copyright © 2016年 XFJ. All rights reserved.
//

#import "UIBarButtonItem+XFJItem.h"

@implementation UIBarButtonItem (XFJItem)

+ (UIBarButtonItem *)itemWithImage:(UIImage *)image hightImage:(UIImage *)hightImage target:(id)target action:(SEL)action
{
    //创建按钮
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    //设置图片(平常状态按钮)
    [btn setImage:image forState:UIControlStateNormal];
    //设置图片(高亮状态按钮)
    [btn setImage:hightImage forState:UIControlStateHighlighted];
    
    //设置尺寸
//    [btn sizeToFit];
    btn.frame = CGRectMake(0, 0, 30, 35);
    
    //监听按钮
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    //包装按钮
    UIView *btnView = [[UIView alloc] initWithFrame:btn.bounds];
    //添加按钮到view中
    [btnView addSubview:btn];
    //返回一个UIBarButtonItem
    
    return [[UIBarButtonItem alloc] initWithCustomView:btnView];
    
    
}


+ (UIBarButtonItem *)itemWithImage:(UIImage *)image selImage:(UIImage *)selImage target:(id)target action:(SEL)action
{
    //创建按钮
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    //设置图片(平常状态按钮)
    [btn setImage:image forState:UIControlStateNormal];
    //设置图片(高亮状态按钮)
    [btn setImage:selImage forState:UIControlStateHighlighted];
    
    //设置尺寸
    [btn sizeToFit];
    
    //监听按钮
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    //包装按钮
    UIView *btnView = [[UIView alloc] initWithFrame:btn.bounds];
    //添加按钮
    [btnView addSubview:btn];
    //返回一个UIBarButtonItem
    
    return [[UIBarButtonItem alloc] initWithCustomView:btnView];
    
    
}

@end
