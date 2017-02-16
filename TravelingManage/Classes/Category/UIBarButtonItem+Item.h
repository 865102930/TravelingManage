//
//  UIBarButtonItem+Item.h
//  HXTrave
//
//  Copyright © 2015年 rongcuilin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (Item)
+ (UIBarButtonItem *)itemWithImage:(UIImage *)image highImage:(UIImage *)highImage title:(NSString *)title target:(id)target action:(SEL)action;

+ (UIBarButtonItem *)itemWithImage:(UIImage *)image selImage:(UIImage *)selImage title:(NSString *)title target:(id)target action:(SEL)action;

@end
