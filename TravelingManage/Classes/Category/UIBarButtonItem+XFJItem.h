//
//  UIBarButtonItem+XFJItem.h
//  01-BuDeJie
//
//  Created by 肖锋 on 16/4/2.
//  Copyright © 2016年 XFJ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (XFJItem)

+ (UIBarButtonItem *)itemWithImage:(UIImage *)image hightImage:(UIImage *)hightImage target:(id)target action:(SEL)action;
+ (UIBarButtonItem *)itemWithImage:(UIImage *)image selImage:(UIImage *)selImage target:(id)target action:(SEL)action;

@end
