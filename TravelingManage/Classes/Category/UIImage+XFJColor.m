//
//  UIImage+XFJColor.m
//  WeiLook
//
//  Created by 肖锋 on 16/12/5.
//  Copyright © 2016年 XFJ. All rights reserved.
//

#import "UIImage+XFJColor.h"

@implementation UIImage (XFJColor)

+ (UIImage *)createImageWithColor:(UIColor *)color
{
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}

@end
